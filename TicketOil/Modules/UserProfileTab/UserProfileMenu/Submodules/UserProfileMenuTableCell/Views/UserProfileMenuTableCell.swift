//
//  UserProfileMenuTableCell.swift
//  TicketOil
//
//  Created by Nursat on 23.04.2022.
//

import Foundation
import Reusable
import RxCocoa
import RxSwift
import UIKit
import SnapKit

final class UserProfileMenuTableCell: UITableViewCell, View, Reusable {
    // MARK: - Constants
    
    // MARK: - Variables
    
    var viewModel: UserProfileMenuTableCellViewModelProtocol! {
        didSet {
            subscribe()
        }
    }
    
    var disposeBag = DisposeBag()
    
    // MARK: - Outlets
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        markup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    // MARK: - Configurations
    
    private func subscribe() {
        viewModel.type.bind { [weak self] type in
            guard let self = self else { return }
            
            switch type {
            case .myCards: self.titleLabel.text = "Мои карты"
            case .inviteFriend: self.titleLabel.text = "Пригласить друга"
            case .transactionsHistory: self.titleLabel.text = "История транзакций"
            case .contactUs: self.titleLabel.text = "Связаться с нами"
            case .logOut: self.titleLabel.text = "Выйти"
            }
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Markup
    
    private func markup() {
        accessoryType = .disclosureIndicator
        tintColor = .white
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

