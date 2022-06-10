//
//  MakePaymentViewController.swift
//  TicketOil
//
//  Created by Nursat on 09.06.2022.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MakePaymentViewController: ViewController, View {
    // MARK: - Variables
    
    var viewModel: MakePaymentViewModelProtocol!
    private var disposeBag = DisposeBag()
    private let navigationBarConfigurator: NavigationBarConfigurator
    
    // MARK: - Outlets
    
    lazy var infoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var gasStationNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    lazy var columnNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "Номер колонки: "
        return label
    }()
    
    lazy var gasolineTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "Марка бензина: "
        return label
    }()
    
    lazy var litresNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "Количество литров: "
        return label
    }()
    
    lazy var useBalanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.text = "Использовать баланс"
        return label
    }()
    
    lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.text = "Накоплено: "
        return label
    }()
    
    lazy var useBalanceSwitch: UISwitch = {
        let view = UISwitch()
        return view
    }()
    
    lazy var paymentInfoStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [priceView, cashbackView, cardView])
        view.axis = .vertical
        return view
    }()
    
    lazy var priceView: PaymentInfoView = {
        let view = PaymentInfoView()
        view.titleLabel.text = "К оплате"
        return view
    }()
    
    lazy var cashbackView: PaymentInfoView = {
        let view = PaymentInfoView()
        view.titleLabel.text = "Кэшбек "
        view.valueLabel.textColor = UIColor(hex: "#3CB91D")
        return view
    }()
    
    lazy var cardView: PaymentInfoView = {
        let view = PaymentInfoView()
        view.titleLabel.text = "Карта "
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(cardViewDidTap))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var payButton: BaseButton = {
        let button = BaseButton()
        button.setTitle("Оплатить", for: .normal)
        button.addTarget(self, action: #selector(payButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    
    @objc private func cardViewDidTap() {
        viewModel.chooseCard()
    }
    
    @objc private func payButtonDidTap() {
        viewModel.openPaymentSuccess()
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
            with: .default(prefersLargeTitles: false, needsToDisplayShadow: false)
        )
        navigationItem.title = "Оплата"
    }
    
    private func subscribe() {
        viewModel.product.bind { [weak self] product in
            guard let self = self else { return }
            
            self.gasStationNameLabel.text = product.gasStation.name
            self.columnNumberLabel.text = "Номер колонки: \(product.columnNumber)"
            self.gasolineTypeLabel.text = "Марка бензина: \(product.gasolineType)"
            let litresNumberText = product.isFullTank ? "полный бак" : "\(product.litresNumber)"
            self.litresNumberLabel.text = "Количество литров: \(litresNumberText)"
        }.disposed(by: disposeBag)
        
        viewModel.preferredCard.bind { [weak self] card in
            guard let self = self else { return }
            guard let card = card else {
                self.cardView.titleLabel.text = "Выбрать карту"
                return
            }
            
            self.cardView.titleLabel.text = "Карта ...\(card.number.suffix(4))"
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Markup
    
    private func markup() {
        view.backgroundColor = UIColor(hex: "#D61616")
        [infoContainerView, useBalanceLabel, balanceLabel, useBalanceSwitch, paymentInfoStackView, payButton].forEach { view.addSubview($0) }
        [gasStationNameLabel, columnNumberLabel, gasolineTypeLabel, litresNumberLabel].forEach { infoContainerView.addSubview($0) }
        infoContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        gasStationNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        columnNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(gasStationNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        gasolineTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(columnNumberLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        litresNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(gasolineTypeLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-12)
        }
        useBalanceLabel.snp.makeConstraints { make in
            make.top.equalTo(infoContainerView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(useBalanceSwitch.snp.leading).offset(-8)
        }
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(useBalanceLabel.snp.bottom)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(useBalanceSwitch.snp.leading).offset(-8)
        }
        useBalanceSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(useBalanceLabel.snp.bottom)
            make.trailing.equalToSuperview().offset(-16)
        }
        paymentInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        payButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
        }
    }
}
