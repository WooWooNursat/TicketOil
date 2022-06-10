//
//  FAQViewController.swift
//  TicketOil
//
//  Created by Nursat on 10.06.2022.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class FAQViewController: ViewController, View {
    // MARK: - Variables
    
    var viewModel: FAQViewModelProtocol!
    private var disposeBag = DisposeBag()
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
        view.register(cellType: FAQQuestionTableCell.self)
        view.register(cellType: FAQAnswerTableCell.self)
        
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
            with: .default(prefersLargeTitles: true, needsToDisplayShadow: true)
        )
        navigationItem.title = "Вопросы и ответы"
    }
    
    private func subscribe() {
        
    }
    
    // MARK: - Markup
    
    private func markup() {
        view = tableView
    }
}

extension FAQViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.faqViewModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard
            let sectionViewModel = viewModel.faqViewModels.get(index: section)?.first as? FAQQuestionTableCellViewModelProtocol
        else { return viewModel.faqViewModels.count }
        
        switch sectionViewModel.isOpen.value {
        case true:
            return viewModel.faqViewModels[section].count
        case false:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        switch viewModel.faqViewModels[section][row] {
        case let viewModel as FAQQuestionTableCellViewModelProtocol:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FAQQuestionTableCell.self)
            cell.viewModel = viewModel
            
            return cell
        case let viewModel as FAQAnswerTableCellViewModelProtocol:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FAQAnswerTableCell.self)
            cell.viewModel = viewModel
            
            return cell
        default: return .init()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        guard
            let sectionViewModel = viewModel.faqViewModels.get(index: section)?.first as? FAQQuestionTableCellViewModelProtocol,
            indexPath.row == 0
        else { return }
        
        sectionViewModel.isOpen.accept(!sectionViewModel.isOpen.value)
        tableView.reloadSections([indexPath.section], with: .fade)
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
}
