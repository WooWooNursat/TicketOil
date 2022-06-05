//
//  UserProfileEditViewController.swift
//  TicketOil
//
//  Created by Nursat on 04.06.2022.
//

import Foundation
import UIKit
import SnapKit

final class UserProfileEditViewController: ViewController, View {
    // MARK: - Variables
    
    var viewModel: UserProfileEditViewModelProtocol!
    
    // MARK: - Outlets
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.tableFooterView = UIView()
        view.rowHeight = UITableView.automaticDimension
        view.showsVerticalScrollIndicator = false
        view.estimatedRowHeight = 300
        view.contentInsetAdjustmentBehavior = .never
        view.delegate = self
        view.dataSource = self
        view.register(cellType: UserProfileEditTableCell.self)
        
        return view
    }()
    
    // MARK: - Actions
    
    // MARK: - Lifecycle
    
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
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = false
        navigationController?.view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.standardAppearance.configureWithOpaqueBackground()
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.shadowImage = nil
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        }
        
        navigationItem.title = "Редактировать"
    }
    
    private func subscribe() {
        
    }
    
    // MARK: - Markup
    
    private func markup() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension UserProfileEditViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UserProfileEditTableCell.self)
        cell.viewModel = viewModel.cellViewModels[indexPath.row]
        return cell
    }
}
