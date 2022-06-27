//
//  GalleryCell.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit

final class GalleryCell: UITableViewCell, Viewer {

    @IBOutlet weak var label: UILabel!

    typealias ViewModelType = GalleryCellViewModel
    var viewModel: ViewModelType! {
        didSet {
            label.text = viewModel.model.display_name
        }
    }
}
