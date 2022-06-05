//
//  GasStationSearchController.swift
//  TicketOil
//
//  Created by Nursat on 05.06.2022.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class GasStationSearchController: UISearchController, View {
    // MARK: - Variables
    
    var viewModel: GasStationSearchViewModelProtocol!
    var disposeBag = DisposeBag()
    
    // MARK: - Outlets
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.tableFooterView = UIView()
        view.rowHeight = UITableView.automaticDimension
        view.showsVerticalScrollIndicator = false
        view.estimatedRowHeight = 300
        view.contentInsetAdjustmentBehavior = .always
        view.delegate = self
        view.dataSource = self
        view.register(cellType: GasStationSearchTableCell.self)
        
        return view
    }()
    
    // MARK: - Actions
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        markup()
        subscribe()
    }
    
    // MARK: - Configurations
    
    private func subscribe() {
        viewModel.update.bind { [weak self] in
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Markup
    
    private func markup() {
        view = tableView
    }
}

extension GasStationSearchController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GasStationSearchTableCell.self)
        cell.viewModel = viewModel.cellViewModels[indexPath.row]
        return cell
    }
}
