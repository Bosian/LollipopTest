//
//  GalleryViewController.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit
import NSObject_Rx

final class GalleryViewController: UIViewController, Viewer {

    @IBOutlet weak var tableView: UITableView!

    typealias ViewModelType = GalleryViewModel
    var viewModel: ViewModelType! {
        didSet {
            viewModel.cellViewModels
                .asDriver()
                .drive { [weak self] _ in
                    self?.tableView.reloadData()
                }
                .disposed(by: rx.disposeBag)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModelType()
    }
}

extension GalleryViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let id: String = "cell"
        let cell: (UITableViewCell & DataContextProtocol) = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! (UITableViewCell & DataContextProtocol)
        cell.dataContext = viewModel.cellViewModels.value[indexPath.row]
        
        return cell
    }
}
