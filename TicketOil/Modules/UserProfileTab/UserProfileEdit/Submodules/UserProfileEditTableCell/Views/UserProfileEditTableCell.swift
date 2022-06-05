//
//  UserProfileEditTableCell.swift
//  TicketOil
//
//  Created by Nursat on 04.06.2022.
//

import Foundation
import Reusable
import RxCocoa
import RxSwift
import UIKit
import SnapKit

final class UserProfileEditTableCell: UITableViewCell, View, Reusable {
    // MARK: - Constants
    
    // MARK: - Variables
    
    var viewModel: UserProfileEditTableCellViewModelProtocol! {
        didSet {
            subscribe()
        }
    }
    
    var disposeBag = DisposeBag()
    
    // MARK: - Outlets
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var textField: BaseTextField = {
        let field = BaseTextField(size: .large)
        return field
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
        viewModel.row.bind { [weak self] row in
            guard let self = self else { return }
            
            switch row {
            case .name:
                self.titleLabel.text = "Имя"
            case .surname:
                self.titleLabel.text = "Фамилия"
            case .carNumber:
                self.titleLabel.text = "Номер машины"
            case .gasoline:
                self.titleLabel.text = "Марка бензина"
            }
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Markup
    
    private func markup() {
        [titleLabel, textField].forEach { contentView.addSubview($0) }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
}

