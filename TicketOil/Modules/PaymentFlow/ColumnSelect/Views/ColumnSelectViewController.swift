//
//  ColumnSelectViewController.swift
//  TicketOil
//
//  Created by Nursat on 28.05.2022.
//

import Foundation
import UIKit
import SnapKit

final class ColumnSelectViewController: ViewController, View {
    // MARK: - Variables
    
    var viewModel: ColumnSelectViewModelProtocol!
    
    // MARK: - Outlets
    
    lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    lazy var stationNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(stackView)
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let buttons: [UIButton] = (1...3).map {
            let button = UIButton()
            button.setTitleColor(.white, for: .normal)
            button.setTitle("Колонка \($0)", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
            return button
        }
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .vertical
        stackView.spacing = 48
        return stackView
    }()
    
    // MARK: - Actions
    
    // MARK: - Lifecycle
    
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
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = false
        navigationController?.view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.standardAppearance.configureWithOpaqueBackground()
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.shadowImage = nil
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        }
        navigationItem.title = "Номер колонки"
    }
    
    private func subscribe() {
        
    }
    
    // MARK: - Markup
    
    private func markup() {
        [logoImageView, stationNameLabel, scrollView].forEach {
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
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
