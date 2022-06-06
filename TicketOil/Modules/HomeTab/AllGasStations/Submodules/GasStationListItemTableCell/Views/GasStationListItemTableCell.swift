//
//  GasStationListItemTableCell.swift
//  TicketOil
//
//  Created by Nursat on 07.06.2022.
//

import Foundation
import Reusable
import RxCocoa
import RxSwift
import UIKit
import SnapKit
import Kingfisher

final class GasStationListItemTableCell: UITableViewCell, View, Reusable {
    // MARK: - Constants
    
    // MARK: - Variables
    
    var viewModel: GasStationListItemTableCellViewModelProtocol! {
        didSet {
            subscribe()
        }
    }
    
    var disposeBag = DisposeBag()
    
    // MARK: - Outlets
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
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
        viewModel.gasStation.bind { [weak self] gasStation in
            guard let self = self else { return }
            
            self.nameLabel.text = gasStation.name
            self.addressLabel.text = gasStation.location.address
            KF.url(gasStation.image).set(to: self.previewImageView)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Markup
    
    private func markup() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(containerView)
        [previewImageView, nameLabel, addressLabel].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        previewImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(previewImageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
}

