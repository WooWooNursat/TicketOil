//
//  AuthHomeViewController.swift
//  TicketOil
//
//  Created by Nursat on 19.04.2022.
//

import UIKit
import SnapKit

final class AuthHomeViewController: UIViewController, View {
    // MARK: - Variables
    
    var viewModel: AuthHomeViewModelProtocol!
    private let navigationBarConfigurator: NavigationBarConfigurator
    
    // MARK: - Outlets
    
    lazy var textFieldContainerView = UIView()
    
    lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.text = "Номер телефона"
        return label
    }()
    
    lazy var phoneNumberTextField: BaseTextField = {
        let textField = BaseTextField(size: .medium)
        textField.placeholder = "Введите номер телефона"
        return textField
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.text = "Пароль"
        return label
    }()
    
    lazy var passwordTextField: BaseTextField = {
        let textField = BaseTextField(size: .medium)
        textField.placeholder = "Введите пароль"
        return textField
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 60, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Ticketoil"
        return label
    }()
    
    lazy var loginButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("Войти", for: .normal)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitle("Еще не зарегистрировались?", for: .normal)
        button.addTarget(self, action: #selector(registerButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    lazy var titleTopLayoutGuide = UILayoutGuide()
    lazy var titleBottomLayoutGuide = UILayoutGuide()
    
    lazy var buttonsTopLayoutGuide = UILayoutGuide()
    lazy var buttonsBottomLayoutGuide = UILayoutGuide()
    
    // MARK: - Actions
    
    @objc private func registerButtonDidTap() {
        viewModel.registration()
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
            with: .transparent
        )
    }
    
    private func subscribe() {
        
    }
    
    // MARK: - Markup
    
    private func markup() {
        view.backgroundColor = UIColor(hex: "#D61616")
        [titleLabel, textFieldContainerView, loginButton, registerButton]
            .forEach { view.addSubview($0) }
        [phoneNumberLabel, phoneNumberTextField, passwordLabel, passwordTextField]
            .forEach { textFieldContainerView.addSubview($0) }
        [titleTopLayoutGuide, titleBottomLayoutGuide, buttonsTopLayoutGuide, buttonsBottomLayoutGuide]
            .forEach { view.addLayoutGuide($0) }
        
        textFieldContainerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        phoneNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        phoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
        }
        
        titleTopLayoutGuide.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(titleTopLayoutGuide.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        titleBottomLayoutGuide.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.bottom.equalTo(textFieldContainerView.snp.top)
            $0.height.equalTo(titleTopLayoutGuide.snp.height)
        }
        
        buttonsTopLayoutGuide.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textFieldContainerView.snp.bottom)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(buttonsTopLayoutGuide.snp.bottom)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        buttonsBottomLayoutGuide.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(registerButton.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(buttonsTopLayoutGuide.snp.height)
        }
    }
}
