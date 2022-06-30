//
//  DetailCell.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit
import Kingfisher

final class DetailCell: UITableViewCell, Viewer {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var favoriteButon: UIButton!

    typealias ViewModelType = DetailCellViewModel
    var viewModel: ViewModelType! {
        didSet {
            icon.kf.setImage(with: URL(string: viewModel.model.thumbnail))
            label.text = viewModel.model.title
            favoriteButon.setImage(viewModel.favoriteIcon, for: UIControl.State.normal)
        }
    }

    @IBAction func onFavoriteTapped(_ sender: UIButton) {
        FavoriteManager.shared.toggleFavorite(model: viewModel.model)
        favoriteButon.setImage(viewModel.favoriteIcon, for: UIControl.State.normal)
    }
}
