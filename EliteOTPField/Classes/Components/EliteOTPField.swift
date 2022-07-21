//
//  OTPField.swift
//  WINCH
//
//  Created by Alchemist on 7/20/20.
//  Copyright © 2020 Lodex-Solutions. All rights reserved.
//

import UIKit
final public class EliteOTPField : UITextField {
    
    internal var spacing:CGFloat = 6
    internal var singleNumberBackground: UIColor = .gray
    internal var singleNumberViewCornerRaduis: CGFloat = 10
    internal var fontType: UIFont = UIFont.systemFont(ofSize: 30)
    internal var placeHolderFontType: UIFont = UIFont.systemFont(ofSize: 40)
    internal var fieldTextColor: UIColor = .black
    internal var fieldFilledBackgroundColor: UIColor = .clear

    internal var fieldPlaceHolder = "_"
    internal var isBorderEnabled: Bool = false
    internal var borderColorFilledState: CGColor = UIColor.black.cgColor
    internal var borderColorEmptyState: CGColor = UIColor.black.cgColor
    internal var borderWidthInEmptyState: CGFloat = 0
    internal var borderWidthInFilledState: CGFloat = 1
    internal var slotCount:Int = 6
    internal var isVibrateEnabled: Bool = true
    internal var isAnimationEnabledOnLastDigit: Bool = false
    internal var animationType: EliteOTPAnimationTypes = .none
    internal var currentText = ""

    internal var isConfigured = false
    internal var digitsLabels = [UILabel]()
    private lazy var tapRecognizer : UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    public var clearAllDigits : Bool = false {
        didSet {
            guard clearAllDigits == true else {return}
            guard self.text != nil || self.text!.count > 0 else {return}
            self.text = nil
            self.sendActions(for: .editingChanged)
            clearAllDigits.toggle()
        }
    }
    public var isFieldVerified:Bool = false
    
    internal var editingStatus : ((_ status:OTPEditingStatus)->())?
    public var didEnteredLastDigit : ((String)->())?

    internal func configure() {
        guard isConfigured == false else {return}
        self.isConfigured.toggle()
        self.configureTextField()
        let labelsStackView = self.createLabelsStackView(with: self.slotCount)
        addSubview(labelsStackView)
        addGestureRecognizer(self.tapRecognizer)
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: self.topAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }
    
    private func configureTextField() {
        tintColor = .clear
        textColor = .clear
        self.backgroundColor = .clear
        keyboardType = .numberPad
        if #available(iOS 12.0, *) {
            textContentType = .oneTimeCode
        } else {
            // Fallback on earlier versions
            textContentType = .telephoneNumber
        }
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }
    
    private func createLabelsStackView(with count:Int)-> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = self.spacing
        for _ in 1 ... count {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = self.placeHolderFontType
            label.backgroundColor = singleNumberBackground
            label.layer.cornerRadius = singleNumberViewCornerRaduis
            label.clipsToBounds = true
            label.isUserInteractionEnabled = true
            label.textColor = self.fieldTextColor
            label.text = self.fieldPlaceHolder
            
            if self.isBorderEnabled {
                label.layer.borderWidth = self.borderWidthInEmptyState
                label.layer.borderColor = self.borderColorEmptyState
                label.layer.borderColor = self.borderColorEmptyState
            }
            
            stackView.addArrangedSubview(label)
            self.digitsLabels.append(label)
        }
        return stackView
    }
    
    @objc private func textDidChange(){
        guard let text = self.text , text.count <= digitsLabels.count else {
            if isVibrateEnabled {
                Vibration.error.vibrate()
            }
            return
        }
        
        let index = text.count - 1 <= 0 ? 0 : text.count - 1
        let labelToAnimate =  digitsLabels[index]
        if text.count > self.currentText.count {
            switch self.animationType {
            case .flip:
                UIView.transition(with: labelToAnimate, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            case .flash:
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut) {
                    labelToAnimate.alpha = 0
                } completion: { done in
                    UIView.animate(withDuration: 0.1) {
                        labelToAnimate.alpha = 1
                    }
                }
            default:
                break
            }
        }
        self.currentText = self.text ?? ""

        for i in 0 ..< digitsLabels.count {
            let currentLabel = digitsLabels[i]
            if isVibrateEnabled {
                Vibration.medium.vibrate()
            }
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                if self.isBorderEnabled {
                    currentLabel.layer.borderWidth = self.borderWidthInFilledState
                    currentLabel.layer.borderColor = self.borderColorFilledState
                }
                currentLabel.backgroundColor = self.fieldFilledBackgroundColor
                currentLabel.font = self.fontType
                currentLabel.text = String(text[index])
            }else{
                if self.isBorderEnabled {
                    currentLabel.layer.borderWidth = self.borderWidthInEmptyState
                    currentLabel.layer.borderColor = self.borderColorEmptyState
                }
                currentLabel.backgroundColor = self.singleNumberBackground
                currentLabel.font = self.placeHolderFontType
                currentLabel.text = self.fieldPlaceHolder
            }
        }
        if text.count == digitsLabels.count {
            isFieldVerified = true
            if isAnimationEnabledOnLastDigit {
                for i in 0 ..< digitsLabels.count {
                    let currentLabel = digitsLabels[i]
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else {
                            return
                        }
                        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut) {
                            currentLabel.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                        } completion: { done in
                            UIView.animate(withDuration: 0.3) {
                                currentLabel.transform = .identity
                            }
                        }
                    }
                }
            }
            isFieldVerified = true
            self.didEnteredLastDigit?(text)
        }else{
            isFieldVerified = false
        }
    }
}

public enum EliteOTPAnimationTypes {
    case flip
    case flash
    case none
}
