//
//  FavoriteViewController.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit
import NSObject_Rx

final class FavoriteViewController: UIViewController, Viewer {

    @IBOutlet weak var tableView: UITableView!

    typealias ViewModelType = FavoriteViewModel
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

        let cellNib = UINib(nibName: "\(DetailCell.self)", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "\(DetailCellViewModel.self)")

        viewModel = ViewModelType()
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.cellViewModels.value.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.value[section].row.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellViewModel = viewModel.cellViewModels.value[indexPath.section].row[indexPath.row]
        let id: String = "\(type(of: cellViewModel))"
        let cell: (UITableViewCell & DataContextProtocol) = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! (UITableViewCell & DataContextProtocol)
        cell.dataContext = cellViewModel
        
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.cellViewModels.value[section].section
    }
}
