//
//  UserProfileEditViewController.swift
//  TicketOil
//
//  Created by Nursat on 04.06.2022.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class UserProfileEditViewController: ViewController, View {
    // MARK: - Variables
    
    var viewModel: UserProfileEditViewModelProtocol!
    var disposeBag = DisposeBag()
    private let navigationBarConfigurator: NavigationBarConfigurator
    
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
        view.separatorStyle = .none
        view.backgroundColor = UIColor(hex: "#D61616")
        view.register(cellType: UserProfileEditTableCell.self)
        
        return view
    }()
    
    lazy var saveButton: BaseButton = {
        let button = BaseButton()
        button.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
        button.setTitle("Сохранить", for: .normal)
        return button
    }()
    
    // MARK: - Actions
    
    @objc private func saveButtonDidTap() {
        viewModel.save()
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
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationBarConfigurator.configure(
            navigationBar: navigationBar,
            with: .default(prefersLargeTitles: false, needsToDisplayShadow: false)
        )
        navigationItem.title = "Редактировать"
    }
    
    private func subscribe() {
        viewModel.isEnabledSaveButton.bind { [weak self] isEnabled in
            guard let self = self else { return }
            
            self.saveButton.isUserInteractionEnabled = isEnabled
            self.saveButton.alpha = isEnabled ? 1 : 0.6
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Markup
    
    private func markup() {
        view.backgroundColor = UIColor(hex: "#D61616")
        [tableView, saveButton].forEach { view.addSubview($0) }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(saveButton.snp.top).offset(-8)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

extension UserProfileEditViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UserProfileEditTableCell.self)
        let viewModel = viewModel.cellViewModels[indexPath.row]
        cell.viewModel = viewModel
        cell.delegate = self
        switch viewModel.row.value {
        case .name:
            cell.textField.text = self.viewModel.name
        case .surname:
            cell.textField.text = self.viewModel.surname
        case .carNumber:
            cell.textField.text = self.viewModel.carNumber
        case .gasoline:
            cell.textField.text = self.viewModel.gasolineType
        }
        return cell
    }
}

extension UserProfileEditViewController: UserProfileEditTableCellDelegate {
    func userProfileEditTableCell(_ cell: UserProfileEditTableCell) {
        let value = cell.textField.text ?? ""
        switch cell.viewModel.row.value {
        case .name:
            viewModel.name = value
        case .surname:
            viewModel.surname = value
        case .carNumber:
            viewModel.carNumber = value
        case .gasoline:
            viewModel.gasolineType = value
        }
        viewModel.isEnabledSaveButton.accept(!viewModel.name.isEmpty && !viewModel.surname.isEmpty && !viewModel.carNumber.isEmpty)
    }
}
