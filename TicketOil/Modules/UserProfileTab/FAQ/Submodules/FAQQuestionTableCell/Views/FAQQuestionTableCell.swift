//
//  FAQQuestionTableCell.swift
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

final class FAQQuestionTableCell: UITableViewCell, View, Reusable {
    // MARK: - Constants
    
    // MARK: - Variables
    
    var viewModel: FAQQuestionTableCellViewModelProtocol! {
        didSet {
            subscribe()
        }
    }
    
    var disposeBag = DisposeBag()
    
    // MARK: - Outlets
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    var disclousureImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.image = Assets.limitChevron.image
        
        return view
    }()
    
    var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
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
        viewModel.question.subscribe(onNext: { [weak self] question in
            guard let self = self else { return }
            
            self.titleLabel.text = question
        }).disposed(by: disposeBag)
        
        viewModel.isOpen.subscribe(onNext: { [weak self] isOpen in
            guard let self = self else { return }
            
            UIView.animate(withDuration: 0.25) {
                self.disclousureImageView.transform = .init(rotationAngle: isOpen ? .pi : 0)
            }
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Markup
    
    private func markup() {
        backgroundColor = .clear
        selectionStyle = .none
        [titleLabel, disclousureImageView, separatorView].forEach { contentView.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.left.equalToSuperview().offset(16)
        }
        
        disclousureImageView.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.right).offset(8)
            $0.size.equalTo(CGSize(width: 14, height: 14))
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
    }
}

