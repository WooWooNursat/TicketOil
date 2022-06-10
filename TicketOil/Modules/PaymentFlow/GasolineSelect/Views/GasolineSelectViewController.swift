//
//  GasolineSelectViewController.swift
//  TicketOil
//
//  Created by Nursat on 28.05.2022.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

final class GasolineSelectViewController: ViewController, View {
    // MARK: - Variables
    
    var viewModel: GasolineSelectViewModelProtocol!
    private var disposeBag = DisposeBag()
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
        textField.addTarget(self, action: #selector(columnNumberTextFieldDidTouchDown), for: .touchDown)
        textField.alpha = viewModel.isEnabledColumnNumber ? 1 : 0.6
        textField.isUserInteractionEnabled = viewModel.isEnabledColumnNumber
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
        textField.addTarget(self, action: #selector(gasolineTypeTextFieldDidTouchDown), for: .touchDown)
        return textField
    }()
    
    lazy var gasolineTypePicker: UIPickerView = {
        let view = UIPickerView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    lazy var litresNumberTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.text = "Количество литров"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    lazy var litresNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.text = L10n.Litres.count(1)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.textAlignment = .right
        return label
    }()
    
    lazy var sliderView: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(sliderViewDidChange), for: .valueChanged)
        return slider
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
        view.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
        return view
    }()
    
    lazy var continueButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("Продолжить", for: .normal)
        button.addTarget(self, action: #selector(continueButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    
    @objc private func sliderViewDidChange() {
        let value = Int(sliderView.value)
        litresNumberLabel.text = L10n.Litres.count(value)
        viewModel.setLitresNumber(value)
    }
    
    @objc private func switchDidChange() {
        viewModel.setChosenFullTank(switchView.isOn)
    }
    
    @objc private func columnNumberTextFieldDidTouchDown() {
        let selectedRow = columnNumberPicker.selectedRow(inComponent: 0)
        viewModel.setSelectedColumnNumber(index: selectedRow)
        columnNumberTextField.text = viewModel.columnNumbers[selectedRow]
    }
    
    @objc private func gasolineTypeTextFieldDidTouchDown() {
        let selectedRow = gasolineTypePicker.selectedRow(inComponent: 0)
        viewModel.setSelectedGasolineType(index: selectedRow)
        gasolineTypeTextField.text = viewModel.gasolineTypes[selectedRow]
    }
    
    @objc private func continueButtonDidTap() {
        viewModel.makePayment()
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
            with: .default(prefersLargeTitles: true, needsToDisplayShadow: false)
        )
        navigationItem.title = "Выбор бензина"
    }
    
    private func subscribe() {
        viewModel.gasStation.bind { [weak self] gasStation in
            guard let self = self else { return }
            
            KF.url(gasStation.image).set(to: self.logoImageView)
            self.stationNameLabel.text = gasStation.name
        }.disposed(by: disposeBag)
        
        viewModel.isContinueButtonEnabled.bind { [weak self] isEnabled in
            guard let self = self else { return }
            
            self.continueButton.isEnabled = isEnabled
        }.disposed(by: disposeBag)
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
            litresNumberTitleLabel,
            litresNumberLabel,
            sliderView,
            fullTankLabel,
            switchView,
            continueButton
        ].forEach { view.addSubview($0) }
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
        litresNumberTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(gasolineTypeTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
        }
        litresNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(gasolineTypeTextField.snp.bottom).offset(12)
            make.leading.equalTo(litresNumberTitleLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
        sliderView.snp.makeConstraints { make in
            make.top.equalTo(litresNumberTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        fullTankLabel.snp.makeConstraints { make in
            make.top.equalTo(sliderView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
        }
        switchView.snp.makeConstraints { make in
            make.centerY.equalTo(fullTankLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalTo(fullTankLabel.snp.trailing).offset(8)
        }
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-(tabBarController?.tabBar.frame.height ?? 0) - 12)
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
            return viewModel.columnNumbers[row]
        case gasolineTypePicker:
            return viewModel.gasolineTypes[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case columnNumberPicker:
            columnNumberTextField.text = viewModel.columnNumbers[row]
            viewModel.setSelectedColumnNumber(index: row)
        case gasolineTypePicker:
            gasolineTypeTextField.text = viewModel.gasolineTypes[row]
            viewModel.setSelectedGasolineType(index: row)
        default:
            return
        }
    }
}
