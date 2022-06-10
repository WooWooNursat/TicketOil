//
//  BaseButton.swift
//  TicketOil
//
//  Created by Nursat on 19.04.2022.
//

import UIKit

final class BaseButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            guard oldValue != isEnabled else {
                return
            }
            
            isUserInteractionEnabled = isEnabled
            alpha = isEnabled ? 1 : 0.6
        }
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: super.intrinsicContentSize.width, height: 48)
    }
    
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 12
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        setTitleColor(.black, for: .normal)
    }
}
