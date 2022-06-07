//
//  AllGasStationsViewController.swift
//  TicketOil
//
//  Created by Nursat on 07.06.2022.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class AllGasStationsViewController: ViewController, View {
    // MARK: - Variables
    
    var viewModel: AllGasStationsViewModelProtocol!
    var disposeBag = DisposeBag()
    private let navigationBarConfigurator: NavigationBarConfigurator
    
    // MARK: - Outlets
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.tableFooterView = UIView()
        view.rowHeight = UITableView.automaticDimension
        view.showsVerticalScrollIndicator = false
        view.estimatedRowHeight = 300
        view.contentInsetAdjustmentBehavior = .always
        view.backgroundColor = UIColor(hex: "#D61616")
        view.delegate = self
        view.dataSource = self
        view.register(cellType: GasStationListItemTableCell.self)
        
        return view
    }()
    
    // MARK: - Actions
    
    // MARK: - Lifecycle
    
    init(navigationBarConfigurator: NavigationBarConfigurator) {
        self.navigationBarConfigurator = navigationBarConfigurator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        markup()
        subscribe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar()
    }
    
    // MARK: - Configurations
    
    private func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        
        navigationBarConfigurator.configure(
            navigationBar: navigationBar,
            with: .default(prefersLargeTitles: true, needsToDisplayShadow: false)
        )
        navigationItem.title = "Все заправки"
    }
    
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

extension AllGasStationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GasStationListItemTableCell.self)
        cell.viewModel = viewModel.cellViewModels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.chooseGasStation(index: indexPath.row)
    }
}
