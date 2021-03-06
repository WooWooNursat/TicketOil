//
//  MyCardsViewController.swift
//  TicketOil
//
//  Created by Nursat on 10.05.2022.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MyCardsViewController: ViewController, View {
    // MARK: - Variables
    
    var viewModel: MyCardsViewModelProtocol!
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
        view.register(cellType: MyCardTableCell.self)
        
        return view
    }()
    
    // MARK: - Actions
    
    @objc private func rightBarButtonDidTap() {
        viewModel.addCard()
    }
    
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
        viewModel.updateCards()
    }
    
    // MARK: - Configurations
    
    private func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        
        navigationBarConfigurator.configure(
            navigationBar: navigationBar,
            with: .default(
                prefersLargeTitles: true,
                needsToDisplayShadow: false
            )
        )
        navigationItem.title = "???????????????????? ??????????"
        navigationItem.rightBarButtonItem = .init(title: "????????????????", style: .plain, target: self, action: #selector(rightBarButtonDidTap))
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

extension MyCardsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MyCardTableCell.self)
        cell.viewModel = viewModel.cellViewModels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCard(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "??????????????", handler: { [weak self] _,_,_ in
            guard let self = self else { return }
            
            self.viewModel.deleteCard(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        })
        return UISwipeActionsConfiguration(actions: [action])
    }
}
