//
//  DetailViewController.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit
import NSObject_Rx

final class DetailViewController: UIViewController, Viewer, Navigatable {

    @IBOutlet weak var tableView: UITableView!

    typealias ViewModelType = DetailViewModel
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

    typealias NavigationParameterType = DetailNavigationParameter
    var navigationParameter: NavigationParameterType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = navigationParameter.model.display_name
        
        let cellNib = UINib(nibName: "\(DetailCell.self)", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "\(DetailCellViewModel.self)")

        viewModel = ViewModelType(navigationParameter: navigationParameter)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellViewModel = viewModel.cellViewModels.value[indexPath.row]
        let id: String = "\(type(of: cellViewModel))"
        let cell: (UITableViewCell & DataContextProtocol) = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! (UITableViewCell & DataContextProtocol)
        cell.dataContext = cellViewModel
        
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard indexPath.row > viewModel.cellViewModels.value.count - 2 else {
            return
        }

        Task {
            try await viewModel.loadMoreIfNeeded()
        }
    }
}
