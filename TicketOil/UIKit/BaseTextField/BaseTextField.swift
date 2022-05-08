//
//  BaseTextField.swift
//  TicketOil
//
//  Created by Nursat on 19.04.2022.
//

import UIKit

class BaseTextField: UITextField {
    public enum Size {
        case medium
        case large
    }
    
    override public var intrinsicContentSize: CGSize {
        makeIntrinsicSize(for: size)
    }
    
    override public var placeholder: String? {
        didSet {
            guard oldValue != placeholder else {
                return
            }
            
            updatePlaceholder()
        }
    }
    
    public let size: Size
    
    public init(size: Size = .medium) {
        self.size = size
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        nil
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    override public func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(
            origin: .zero,
            size: CGSize(width: 16, height: bounds.height)
        )
    }
    
    override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(
            origin: CGPoint(x: bounds.width - 16, y: 0),
            size: CGSize(width: 16, height: bounds.height)
        )
    }
    
    @objc
    private func baseTextFieldEditingDidBegin() {
        layer.borderWidth = 2
    }
    
    @objc
    private func baseTextFieldEditingDidEnd() {
        layer.borderWidth = 0.5
    }
    
    private func configureColors() {
        backgroundColor = .white
        textColor = .black
        updatePlaceholder()
    }
    
    private func updatePlaceholder() {
        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                    .foregroundColor: UIColor(hex: "#C4C4C4")!
                ]
            )
        } else {
            attributedPlaceholder = nil
        }
    }
    
    private func setup() {
        addTarget(self, action: #selector(baseTextFieldEditingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(baseTextFieldEditingDidEnd), for: .editingDidEnd)
        clipsToBounds = true
        font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        layer.cornerRadius = 12
        layer.borderWidth = 0.5
        leftView = UIView()
        leftViewMode = .always
        rightView = UIView()
        rightViewMode = .always
        textAlignment = .left
        configureColors()
    }
    
    private func makeIntrinsicSize(for size: Size) -> CGSize {
        switch size {
        case .medium:
            return CGSize(width: super.intrinsicContentSize.width, height: 48)
        case .large:
            return CGSize(width: super.intrinsicContentSize.width, height: 56)
        }
    }
}
