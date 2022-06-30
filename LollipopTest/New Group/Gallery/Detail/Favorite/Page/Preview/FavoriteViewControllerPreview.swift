//
//  FavoriteViewControllerPreview.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit
import SwiftUI

struct FavoriteViewControllerPreview: UIViewRepresentable {

    private static func getModel(json: String) -> HotModel.Data.Children.Data? {
        return HotModel(json: json)?.data.children.first?.data
    }
    
    let viewController: UIViewController
    
    init() {
        let storyboard = UIStoryboard(name: "FavoriteStoryboard", bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController()!
        self.viewController = viewController

        let model1 = Self.getModel(json: #"""
         {
           "data": {
             "after": "t3_vmbecj",
             "dist": 26,
             "children": [
               {
                 "data": {
                   "subreddit": "taiwan",
                   "title": "aaa",
                   "thumbnail": "https://b.thumbs.redditmedia.com/viz_BReZL1pcaz4FdKQGePoiOEIB5LKVd_6XMjPSXxI.jpg",
                   "id": "1"
                 }
               }
             ]
           }
         }
         """#)
        
        let model2 = Self.getModel(json: #"""
         {
           "data": {
             "after": "t3_vmbecj",
             "dist": 26,
             "children": [
               {
                 "data": {
                   "subreddit": "gaming",
                   "title": "bbb",
                   "thumbnail": "https://b.thumbs.redditmedia.com/viz_BReZL1pcaz4FdKQGePoiOEIB5LKVd_6XMjPSXxI.jpg",
                   "id": "2"
                 }
               }
             ]
           }
         }
         """#)
        
        let model3 = Self.getModel(json: #"""
         {
           "data": {
             "after": "t3_vmbecj",
             "dist": 26,
             "children": [
               {
                 "data": {
                   "subreddit": "gaming",
                   "title": "ccc",
                   "thumbnail": "https://b.thumbs.redditmedia.com/viz_BReZL1pcaz4FdKQGePoiOEIB5LKVd_6XMjPSXxI.jpg",
                   "id": "3"
                 }
               }
             ]
           }
         }
         """#)

        FavoriteManager.shared.toggleFavorite(model: model1)
        FavoriteManager.shared.toggleFavorite(model: model3)
        FavoriteManager.shared.toggleFavorite(model: model2)
    }
    
    func makeUIView(context: Context) -> some UIView {
        return viewController.view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}

struct FavoriteViewController_Preview: PreviewProvider {
    static var previews: some View {
        FavoriteViewControllerPreview()
    }
}
