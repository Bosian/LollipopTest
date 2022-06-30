//
//  FavoriteModel.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/30.
//

import Foundation

struct FavoriteModel: Codable, Comparable {
    
    /// 加入時間，排序用
    let updateTime: Double
    
    let model: HotModel.Data.Children.Data
    
    init(model: HotModel.Data.Children.Data) {
        self.updateTime = Date().timeIntervalSince1970
        self.model = model
    }

    static func < (lhs: FavoriteModel, rhs: FavoriteModel) -> Bool {
        return lhs.updateTime < rhs.updateTime
    }
}
