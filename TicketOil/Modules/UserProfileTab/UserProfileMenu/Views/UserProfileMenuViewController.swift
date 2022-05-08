//
//  UserProfileMenuViewContrroller.swift
//  TicketOil
//
//  Created by Nursat on 22.04.2022.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class UserProfileMenuViewController: UIViewController, View {
    // MARK: - Variables
    
    var viewModel: UserProfileMenuViewModelProtocol!
    var disposeBag = DisposeBag()
    
    private let navigationBarConfiguration: NavigationBarConfigurator
    
    // MARK: - Outlets
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor(hex: "#C4C4C4")
        view.layer.cornerRadius = 52
        return view
    }()
    
    lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Редактировать профиль", for: .normal)
        return button
    }()
    
    lazy var gearButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.gear.image, for: .normal)
        return button
    }()
    
    lazy var faqButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.faq.image, for: .normal)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.tableFooterView = UIView()
        view.rowHeight = UITableView.automaticDimension
        view.showsVerticalScrollIndicator = false
        view.estimatedRowHeight = 54
        view.contentInsetAdjustmentBehavior = .never
        view.delegate = self
        view.dataSource = self
        view.register(cellType: UserProfileMenuTableCell.self)
        
        return view
    }()
    
    // MARK: - Actions
    
    // MARK: - Lifecycle
    
    init(navigationBarConfiguration: NavigationBarConfigurator) {
        self.navigationBarConfiguration = navigationBarConfiguration
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
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
        
        navigationBarConfiguration.configure(
            navigationBar: navigationBar,
            with: .transparent
        )
    }
    
    private func subscribe() {
        viewModel.update.bind { [weak self] in
            guard let self = self else { return }
            
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Markup
    
    private func markup() {
        [imageView, editProfileButton, gearButton, faqButton, tableView]
            .forEach { view.addSubview($0) }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(CGSize(width: 104, height: 104))
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top)
            make.leading.equalTo(imageView.snp.trailing).offset(12)
            make.trailing.equalTo(gearButton.snp.leading).offset(-12)
            make.bottom.equalTo(imageView.snp.centerY)
        }
        
        gearButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        faqButton.snp.makeConstraints { make in
            make.top.equalTo(gearButton.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension UserProfileMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UserProfileMenuTableCell.self)
        cell.viewModel = viewModel.cellViewModels[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        20
    }
}
