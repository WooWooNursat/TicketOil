//
//  FAQAnswerTableCell.swift
//  TicketOil
//
//  Created by Nursat on 10.06.2022.
//

import Foundation
import Reusable
import RxCocoa
import RxSwift
import UIKit
import SnapKit

final class FAQAnswerTableCell: UITableViewCell, View, Reusable {
    // MARK: - Constants
    
    // MARK: - Variables
    
    var viewModel: FAQAnswerTableCellViewModelProtocol! {
        didSet {
            subscribe()
        }
    }
    
    var disposeBag = DisposeBag()
    
    // MARK: - Outlets
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
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
        viewModel.answer.subscribe(onNext: { [weak self] answer in
            guard let self = self else { return }
            
            self.descriptionLabel.text = answer
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Markup
    
    private func markup() {
        selectionStyle = .none
        backgroundColor = .white.withAlphaComponent(0.2)
        contentView.clipsToBounds = true
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(16)
            $0.right.bottom.equalToSuperview().offset(-16)
        }
    }
}

