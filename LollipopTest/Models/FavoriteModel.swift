//
//  FavoriteModel.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/30.
//

import Foundation
import RealmSwift

class FavoriteModel: Object, Comparable {
    
    /// 加入時間，排序用
    @Persisted var updateTime: Double = 0.0

    /// e.g. "Gaming"
    @Persisted var subreddit: String = ""
    
    /// e.g. "Geese enjoying a harmonica performance at Daan Forest Park in Taipei"
    @Persisted var title: String = ""
    
    /// e.g. "https://b.thumbs.redditmedia.com/viz_BReZL1pcaz4FdKQGePoiOEIB5LKVd_6XMjPSXxI.jpg"
    @Persisted var thumbnail: String = ""
    
    /// e.g. "vl2uf9"
    @Persisted var id: String = ""
    
    var model: HotModel.Data.Children.Data {
        return HotModel.Data.Children.Data(subreddit: subreddit, title: title, thumbnail: thumbnail, id: id)
    }

    /// 沒override會crash
    override init() {
        super.init()
    }
    
    convenience init(model: HotModel.Data.Children.Data) {
        self.init()
        
        self.updateTime = Date().timeIntervalSince1970

        self.subreddit = model.subreddit
        self.title = model.title
        self.thumbnail = model.thumbnail
        self.id = model.id
    }

    static func < (lhs: FavoriteModel, rhs: FavoriteModel) -> Bool {
        return lhs.updateTime < rhs.updateTime
    }
}
