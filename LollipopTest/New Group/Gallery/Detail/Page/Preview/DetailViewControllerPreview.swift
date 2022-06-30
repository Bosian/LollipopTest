//
//  DetailViewControllerPreview.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit
import SwiftUI

struct DetailViewControllerPreview: UIViewRepresentable {

    let viewController: UIViewController
    
    init() {
        let storyboard = UIStoryboard(name: "DetailStoryboard", bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController() as! (ParameterDelegate & UIViewController)
        
        let json: String = #"""
         {
          "data": {
            "children": [
              {
                "data": {
                  "display_name": "gadgets"
                }
              }
            ]
          }
         }
         """#
        
        let model = SubredditsModel(json: json)
        
        guard let subModel = model?.data.children.first?.data else {
            let viewController = UIViewController()
            viewController.view.backgroundColor = UIColor.orange
            self.viewController = viewController
            return
        }
        
        let navigationParameter = DetailNavigationParameter(model: subModel)
        viewController.setParameter(navigationParameter)
        
        self.viewController = viewController
    }
    
    func makeUIView(context: Context) -> some UIView {
        return viewController.view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}

struct DetailViewController_Preview: PreviewProvider {
    static var previews: some View {
        DetailViewControllerPreview()
    }
}
