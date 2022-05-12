//
//  UserRegisterViewController.swift
//  TicketOil
//
//  Created by Nursat on 20.04.2022.
//

import Foundation
import UIKit
import SnapKit

final class UserRegisterViewController: ViewController, View {
    // MARK: - Variables
    
    var viewModel: UserRegisterViewModelProtocol!
    private let navigationBarConfigurator: NavigationBarConfigurator
    
    // MARK: - Outlets
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 60, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Ticketoil"
        return label
    }()
    
    lazy var textFieldsContainerView = UIView()
    
    lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.text = "Номер телефона"
        return label
    }()
    
    lazy var phoneNumberTextField: BaseTextField = {
        let textField = BaseTextField(size: .medium)
        textField.placeholder = "Введите номер телефона"
        textField.keyboardType = .phonePad
        return textField
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.text = "Пароль"
        return label
    }()
    
    lazy var passwordTextField: BaseTextField = {
        let textField = BaseTextField(size: .medium)
        textField.textContentType = .newPassword
        textField.isSecureTextEntry = true
        textField.placeholder = "Введите пароль"
        return textField
    }()
    
    lazy var repeatPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    lazy var repeatPasswordTextField: BaseTextField = {
        let textField = BaseTextField(size: .medium)
        textField.placeholder = "Снова введите пароль"
        textField.isSecureTextEntry = true
        textField.textContentType = .newPassword
        return textField
    }()
    
    lazy var registerButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        return button
    }()
    
    lazy var titleLayoutGuide = UILayoutGuide()
    lazy var buttonLayoutGuide = UILayoutGuide()
    
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
            with: .default(
                prefersLargeTitles: false,
                needsToDisplayShadow: false
            )
        )
        navigationItem.title = "Регистрация"
    }
    
    private func subscribe() {
        
    }
    
    // MARK: - Markup
    
    private func markup() {
        view.backgroundColor = UIColor(hex: "#D61616")
        [titleLabel, textFieldsContainerView, registerButton]
            .forEach { view.addSubview($0) }
        [
            phoneNumberLabel,
            phoneNumberTextField,
            passwordLabel,
            passwordTextField,
            repeatPasswordLabel,
            repeatPasswordTextField
        ].forEach { textFieldsContainerView.addSubview($0) }
        [titleLayoutGuide, buttonLayoutGuide].forEach { view.addLayoutGuide($0) }
        
        titleLayoutGuide.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLayoutGuide.snp.centerY)
            make.centerX.equalToSuperview()
        }
        
        textFieldsContainerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(titleLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        repeatPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        
        buttonLayoutGuide.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textFieldsContainerView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        registerButton.snp.makeConstraints { make in
            make.centerY.equalTo(buttonLayoutGuide.snp.centerY)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
