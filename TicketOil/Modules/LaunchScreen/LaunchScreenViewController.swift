//
//  LaunchScreenViewControlleer.swift
//  TicketOil
//
//  Created by Nursat on 17.04.2022.
//

import SnapKit
import UIKit

final class LaunchScreenViewController: UIViewController {
    // MARK: - Outlets
    
    lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ticketoil"
        label.font = .systemFont(ofSize: 64, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        markup()
    }
    
    // MARK: - Markup
    
    private func markup() {
        view.backgroundColor = UIColor(hex: "#D61616")
        view.addSubview(appNameLabel)
        
        appNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-28)
        }
    }
}
