//
//  MyCardsViewController.swift
//  TicketOil
//
//  Created by Nursat on 10.05.2022.
//

import Foundation
import UIKit
import SnapKit

final class MyCardsViewController: ViewController, View {
    // MARK: - Variables
    
    var viewModel: MyCardsViewModelProtocol!
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
        navigationItem.title = "Банковские карты"
        navigationItem.rightBarButtonItem = .init(title: "Добавить", style: .plain, target: self, action: #selector(rightBarButtonDidTap))
    }
    
    private func subscribe() {
        
    }
    
    // MARK: - Markup
    
    private func markup() {
        view = tableView
    }
}

extension MyCardsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MyCardTableCell.self)
        return cell
    }
}
