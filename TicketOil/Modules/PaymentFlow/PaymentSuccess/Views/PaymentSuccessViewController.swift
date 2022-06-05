//
//  PaymentSuccessViewController.swift
//  TicketOil
//
//  Created by Nursat on 04.06.2022.
//

import Foundation
import UIKit
import SnapKit

final class PaymentSuccessViewController: ViewController, View {
    // MARK: - Variables
    
    var viewModel: PaymentSuccessViewModelProtocol!
    
    // MARK: - Outlets
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Спасибо за покупку!"
        return label
    }()
    
    lazy var actionButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("На главную", for: .normal)
        return button
    }()
    
    lazy var titleTopLayoutGuide = UILayoutGuide()
    lazy var titleBottomLayoutGuide = UILayoutGuide()
    
    // MARK: - Actions
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        markup()
        subscribe()
    }
    
    // MARK: - Configurations
    
    private func subscribe() {
        
    }
    
    // MARK: - Markup
    
    private func markup() {
        [titleLabel, actionButton].forEach { view.addSubview($0) }
        [titleTopLayoutGuide, titleBottomLayoutGuide].forEach { view.addLayoutGuide($0) }
        
        titleTopLayoutGuide.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTopLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        titleBottomLayoutGuide.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(titleTopLayoutGuide)
        }
        
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(titleBottomLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-8)
        }
    }
}
