//
//  GalleryViewModel.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import Foundation
import RxCocoa

final class GalleryViewModel {
    let cellViewModels: BehaviorRelay<[GalleryCellViewModel]> = BehaviorRelay<[GalleryCellViewModel]>(value: [])

    private var model: SubredditsModel? {
        didSet {

            guard let model = model else {
                return
            }

            let cellViewModels = model.data.children.map { model in
                return GalleryCellViewModel(model: model.data)
            }
            
            self.cellViewModels.accept(cellViewModels)
        }
    }
    
    init() {
        refresh()
    }
    
    private func refresh() {
        Task {
            do {
                let model = try await callWebAPI()
                self.model = model
            } catch {
                
            }
        }
        
    }
    
    private func callWebAPI() async throws -> SubredditsModel {
        return try await SubredditsWebAPI().invokeAsync(SubredditsParameter())
    }
}
