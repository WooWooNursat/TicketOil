//
//  GasolineSelectViewController.swift
//  TicketOil
//
//  Created by Nursat on 28.05.2022.
//

import Foundation
import UIKit
import SnapKit

final class GasolineSelectViewController: ViewController, View {
    // MARK: - Variables
    
    var viewModel: GasolineSelectViewModelProtocol!
    private let navigationBarConfigurator: NavigationBarConfigurator
    
    // MARK: - Outlets
    
    lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 112 / 2
        return view
    }()
    
    lazy var stationNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var columnNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.text = "Номер колонки"
        return label
    }()
    
    lazy var columnNumberTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Выберите"
        textField.inputView = columnNumberPicker
        return textField
    }()
    
    lazy var columnNumberPicker: UIPickerView = {
        let view = UIPickerView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    lazy var gasolineTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.text = "Марка бензина"
        return label
    }()
    
    lazy var gasolineTypeTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "Выберите"
        textField.inputView = gasolineTypePicker
        return textField
    }()
    
    lazy var gasolineTypePicker: UIPickerView = {
        let view = UIPickerView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    lazy var litresNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    lazy var fullTankLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.text = "Полный бак"
        return label
    }()
    
    lazy var switchView: UISwitch = {
        let view = UISwitch()
        view.onTintColor = .white
        return view
    }()
    
    lazy var sliderView: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.isContinuous = false
        return slider
    }()
    
    lazy var continueButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("Продолжить", for: .normal)
        return button
    }()
    
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
            with: .default(prefersLargeTitles: true, needsToDisplayShadow: false)
        )
        navigationItem.title = "Выбор бензина"
    }
    
    private func subscribe() {
        
    }
    
    // MARK: - Markup
    
    private func markup() {
        view.backgroundColor = UIColor(hex: "#D61616")
        [
            logoImageView,
            stationNameLabel,
            columnNumberLabel,
            columnNumberTextField,
            gasolineTypeLabel,
            gasolineTypeTextField,
            litresNumberLabel,
            fullTankLabel,
            switchView,
            sliderView,
            continueButton
        ].forEach {
            view.addSubview($0)
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(112)
        }
        stationNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(logoImageView.snp.centerY)
            make.leading.equalTo(logoImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-16)
        }
        columnNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        columnNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(columnNumberLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        gasolineTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(columnNumberTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        gasolineTypeTextField.snp.makeConstraints { make in
            make.top.equalTo(gasolineTypeLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        litresNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(gasolineTypeTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        fullTankLabel.snp.makeConstraints { make in
            make.top.equalTo(litresNumberLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        switchView.snp.makeConstraints { make in
            make.centerY.equalTo(fullTankLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalTo(fullTankLabel.snp.trailing).offset(8)
        }
        sliderView.snp.makeConstraints { make in
            make.top.equalTo(fullTankLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        continueButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

extension GasolineSelectViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case columnNumberPicker:
            return 3
        case gasolineTypePicker:
            return 4
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case columnNumberPicker:
            return ["Колонка 1", "Колонка 2", "Колонка 3"][row]
        case gasolineTypePicker:
            return ["Дизельное топливо", "АИ-92", "АИ-95", "АИ-98"][row]
        default:
            return nil
        }
    }
}
