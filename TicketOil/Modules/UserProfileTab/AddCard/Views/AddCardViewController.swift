//
//  AddCardViewController.swift
//  TicketOil
//
//  Created by Nursat on 11.05.2022.
//

import Foundation
import UIKit
import SnapKit

final class AddCardViewController: ViewController, View {
    // MARK: - Variables
    
    var viewModel: AddCardViewModelProtocol!
    private let navigationBarConfigurator: NavigationBarConfigurator
    
    // MARK: - Outlets
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#C4C4C4")
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Укажите данные карты любого банка"
        return label
    }()
    
    lazy var cardNumberTextField: BaseTextField = {
        let textField = BaseTextField(size: .large)
        textField.placeholder = "Номер карты"
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingDidBegin)
        return textField
    }()
    
    lazy var nameTextField: BaseTextField = {
        let textField = BaseTextField(size: .large)
        textField.placeholder = "Имя и фамилия"
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingDidBegin)
        return textField
    }()
    
    lazy var expirationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.text = "Срок действия"
        label.textAlignment = .center
        return label
    }()
    
    lazy var expirationTextField: BaseTextField = {
        let textField = BaseTextField(size: .medium)
        textField.placeholder = "ММ/ГГ"
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingDidBegin)
        return textField
    }()
    
    lazy var cvvLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.text = "CVV"
        label.textAlignment = .center
        return label
    }()
    
    lazy var cvvTextField: BaseTextField = {
        let textField = BaseTextField(size: .medium)
        textField.keyboardType = .numberPad
        textField.isSecureTextEntry = true
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingDidBegin)
        return textField
    }()
    
    lazy var addButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("Добавить", for: .normal)
        button.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    
    @objc private func textFieldDidChanged(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        switch textField {
        case cardNumberTextField:
            textField.text = formatCardNumber(string: text)
        case nameTextField:
            textField.text = text.uppercased()
        case expirationTextField:
            textField.text = formatExpirationString(string: text)
        case cvvTextField:
            textField.text = String(text.components(separatedBy: .decimalDigits.inverted).joined().prefix(3))
        default:
            return
        }
    }
    
    @objc private func addButtonDidTap() {
        guard let number = cardNumberTextField.text?.components(separatedBy: .decimalDigits.inverted).joined(),
              let name = nameTextField.text?.uppercased(),
              let expiration = expirationTextField.text?.split(separator: "/"),
              let month = expiration.first,
              let year = expiration.last,
              let cvv = cvvTextField.text
        else {
            return
        }
        
        viewModel.addCard(number: number, name: name, expirationMonth: String(month), expirationYear: String(year), cvv: cvv)
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
        
        navigationBarConfigurator.configure(
            navigationBar: navigationBar,
            with: .default(
                prefersLargeTitles: false,
                needsToDisplayShadow: false
            )
        )
        navigationItem.title = "Добавить карту"
    }
    
    private func subscribe() {
        
    }
    
    // MARK: - Markup
    
    private func markup() {
        view.backgroundColor = UIColor(hex: "#D61616")
        [containerView, addButton].forEach { view.addSubview($0) }
        [
            descriptionLabel,
            cardNumberTextField,
            nameTextField,
            expirationLabel,
            cvvLabel,
            expirationTextField,
            cvvTextField
        ].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(28)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        cardNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(cardNumberTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        expirationLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(12)
        }
        
        cvvLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalTo(expirationLabel.snp.width)
        }
        
        expirationTextField.snp.makeConstraints { make in
            make.top.equalTo(expirationLabel.snp.bottom).offset(16)
            make.centerX.equalTo(expirationLabel.snp.centerX)
            make.width.equalTo(96)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        cvvTextField.snp.makeConstraints { make in
            make.top.equalTo(cvvLabel.snp.bottom).offset(16)
            make.centerX.equalTo(cvvLabel.snp.centerX)
            make.width.equalTo(64)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

// MARK: - Formatters

extension AddCardViewController {
    private func formatCardNumber(string: String) -> String {
        var digits = string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        digits.resize(newSize: 16)
        let mask = "____ ____ ____ ____"
        var result = ""
        
        for ch in mask {
            guard let number = digits.first else {
                break
            }
            
            guard ch == "_" else {
                result.append(ch)
                continue
            }
            
            result.append(number)
            digits.removeFirst()
        }
        
        return result
    }
    
    private func formatExpirationString(string: String) -> String {
        var digits = string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        digits.resize(newSize: 4)
        let mask = "__/__"
        var result = ""
        
        for ch in mask {
            guard let number = digits.first else {
                break
            }
            
            guard ch == "_" else {
                result.append(ch)
                continue
            }
            
            result.append(number)
            digits.removeFirst()
        }
        
        return result
    }
}
