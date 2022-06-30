//
//  FavoriteViewModel.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import Foundation
import RxSwift
import RxCocoa

final class FavoriteViewModel {

    typealias Tuple = (section: String, row: [DetailCellViewModel])
    let cellViewModels: BehaviorRelay<[Tuple]> = BehaviorRelay<[Tuple]>(value: [])
    private var disposeBag: DisposeBag = DisposeBag()
    
    init() {
        refresh()
    }
    
    private func refresh() {

        disposeBag = DisposeBag()

        FavoriteManager.shared.favorites
            .asDriver()
            .drive { [weak self] (models: [FavoriteModel]) in
                self?.updateCell(models: models)
            }
            .disposed(by: disposeBag)
    }
    
    private func updateCell(models: [FavoriteModel]) {

        let dictionary = Dictionary(grouping: models, by: \.model.subreddit)
        
        var tuples: [Tuple] = dictionary.map { (key: String, value: [FavoriteModel]) -> Tuple in

            // Update time 由大到小
            let value = value.sorted(by: >)
            
            let rows: [DetailCellViewModel] = value.map { (item: FavoriteModel) in
                return DetailCellViewModel(favoriteModel: item)
            }
            
            return Tuple(section: key, row: rows)
        }

        // Sort section by first sorted updateTime
        tuples.sort { left, right in

            guard let left = left.row.first?.favoriteModel,
                  let right = right.row.first?.favoriteModel else {

                return false
            }
            
            return left > right
        }
        
        self.cellViewModels.accept(tuples)
    }
}
