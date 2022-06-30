//
//  HotModel.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import Foundation

struct HotModel: Decodable {
    let data: Data
}

extension HotModel {
    struct Data: Decodable {
        
        /// e.g. "t5_2qqjc"
        let after: String
        
        /// e.g. 25
        let dist: Int

        let children: [Children]
    }
}

extension HotModel.Data {
    struct Children: Decodable {
        struct Data: Decodable, Equatable {
            
            /// e.g. "Gaming"
            let subreddit: String

            /// e.g. "Geese enjoying a harmonica performance at Daan Forest Park in Taipei"
            let title: String
            
            /// e.g. "https://b.thumbs.redditmedia.com/viz_BReZL1pcaz4FdKQGePoiOEIB5LKVd_6XMjPSXxI.jpg"
            let thumbnail: String
            
            /// e.g. "vl2uf9"
            let id: String
        }

        let data: Data
    }
}


