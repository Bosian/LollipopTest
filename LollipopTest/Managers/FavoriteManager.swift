//
//  FavoriteManager.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/29.
//

import Foundation
import RxSwift
import RxCocoa

final class FavoriteManager {
    
    static let shared: FavoriteManager = FavoriteManager()
    
    let favorites: BehaviorRelay<[FavoriteModel]> = BehaviorRelay<[FavoriteModel]>(value: [])
    
    /// 避免 一開始被寫入 empty array
    private var isDataLoaded: Bool = false

    /// 避免 SwiftUI preview 無法將Item加入最愛
    private let userDefault: UserDefaults? = UserDefaults(suiteName: "group.lolipopTest")

    private let key: String = "favorites"
    private let disposeBag: DisposeBag = DisposeBag()
    
    private init() {
        load()
        
        // Register save
        favorites
            .asDriver()
            .drive { [weak self] (models: [FavoriteModel]) in
                
                guard let weakSelf = self else {
                    return
                }

                /// 避免 一開始被寫入 empty array
                guard weakSelf.isDataLoaded else {
                    return
                }
                
                weakSelf.save(models: models)
            }
            .disposed(by: disposeBag)
    }
    
    func toggleFavorite(model: HotModel.Data.Children.Data?) {

        guard let model = model else {
            return
        }

        if isFavorite(model: model) {
            
            // Remove
            var value = favorites.value
            
            value.removeAll { (item: FavoriteModel) in
                return item.model.id == model.id
            }
            
            favorites.accept(value)
            
        } else {
            // Add
            var value = favorites.value
            let model = FavoriteModel(model: model)
            value.insert(model, at: 0)
            favorites.accept(value)
        }
    }
    
    func isFavorite(model: HotModel.Data.Children.Data) -> Bool {
        return favorites.value.contains { (item: FavoriteModel) in
            return item.model.id == model.id
        }
    }
    
    private func save(models: [FavoriteModel]) {
        guard let data: Data = try? models.toData() else {
            assert(false)
            return
        }
        
        userDefault?.set(data, forKey: key)
    }
    
    private func load() {

        defer {
            /// 設為已讀取，避免 一開始被寫入 empty array
            isDataLoaded = true
        }

        guard let data: Data = userDefault?.data(forKey: key) else {
            return
        }
        
        let models: [FavoriteModel] = {
            guard let models: [FavoriteModel] = try? [FavoriteModel](data: data) else {
                return []
            }
            
            return models
        }()
        
        favorites.accept(models)
    }
}
