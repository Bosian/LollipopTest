//
//  DetailCellViewModel.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit

struct DetailCellViewModel {
    let favoriteModel: FavoriteModel?
    let model: HotModel.Data.Children.Data
    
    var favoriteIcon: UIImage {
        let image: UIImage = FavoriteManager.shared.isFavorite(model: model) ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!
        return image
    }
    
    init(favoriteModel: FavoriteModel) {
        self.favoriteModel = favoriteModel
        self.model = favoriteModel.model
    }
        
    init(model: HotModel.Data.Children.Data) {
        self.favoriteModel = nil
        self.model = model
    }
}
