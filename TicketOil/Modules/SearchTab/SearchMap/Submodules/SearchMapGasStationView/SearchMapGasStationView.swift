//
//  SearchMapGasStationView.swift
//  TicketOil
//
//  Created by Nursat on 11.06.2022.
//

import Foundation
import SnapKit
import UIKit

protocol SearchMapGasStationViewDelegate: AnyObject {
    func didTapChooseButton()
}

final class SearchMapGasStationView: UIView {
    var gasStation: GasStation? {
        didSet {
            UIView.animate(withDuration: 0.25, animations: {
                self.transform = .identity
            })
            nameLabel.text = gasStation?.name
            addressLabel.text = gasStation?.location.address
        }
    }
    weak var delegate: SearchMapGasStationViewDelegate?
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black.withAlphaComponent(0.4)
        button.layer.cornerRadius = 18
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(hex: "#C4C4C4")
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
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
    
    lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var chooseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выбрать", for: .normal)
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        return button
    }()
    
    @objc private func closeButtonDidTap() {
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = .init(translationX: 0, y: 400)
        })
    }
    
    @objc private func buttonDidTap() {
        delegate?.didTapChooseButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        markup()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func markup() {
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 12
        transform = CGAffineTransform(translationX: 0, y: 400)
        [imageView, nameLabel, addressLabel, dividerView, closeButton, chooseButton].forEach { addSubview($0) }
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.size.equalTo(36)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        chooseButton.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
