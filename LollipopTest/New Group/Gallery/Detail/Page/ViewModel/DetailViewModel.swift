//
//  DetailViewModel.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import Foundation
import RxCocoa

final class DetailViewModel {
    let cellViewModels: BehaviorRelay<[DetailCellViewModel]> = BehaviorRelay<[DetailCellViewModel]>(value: [])
    
    private var model: [HotModel] = []
    
    typealias NavigationParameterType = DetailNavigationParameter
    let navigationParameter: NavigationParameterType
    
    var isUpdate: Bool = false
    var isDataLoaded: Bool = false
    
    init(navigationParameter: NavigationParameterType) {
        self.navigationParameter = navigationParameter
        refresh()
    }
    
    private func refresh() {
        
        isDataLoaded = false
        
        self.model.removeAll()
        
        Task {
            try await loadMore(count: 0, after: "")
            self.isDataLoaded = true
        }
    }
    
    func loadMoreIfNeeded() async throws {
        
        guard isDataLoaded else {
            return
        }
        
        guard !isUpdate else {
            return
        }
        
        let count: Int = self.model.last?.data.dist ?? 0
        let after: String = self.model.last?.data.after ?? ""
        
        print("count: \(count)")
        print("after: \(after)")

        try await loadMore(count: count, after: after)
    }

    private func loadMore(count: Int, after: String) async throws {
        
        isUpdate = true
        
        let parameter = HotParameter(subreddit: navigationParameter.model.display_name, count: count, limit: 10, after: after)
        let model = try await callHotWebAPI(parameter: parameter)
        
        isUpdate = false
        
        self.model.append(model)
        
        updateCell(model: model)
    }
    
    private func updateCell(model: HotModel) {
        var cellViewModels = self.cellViewModels.value
        let news = model.data.children.map { model in
            return DetailCellViewModel(model: model.data)
        }
        cellViewModels.append(contentsOf: news)
        self.cellViewModels.accept(cellViewModels)
    }
    
    private func callHotWebAPI(parameter: HotParameter) async throws -> HotModel {
        return try await HotWebAPI().invokeAsync(parameter)
    }
}
