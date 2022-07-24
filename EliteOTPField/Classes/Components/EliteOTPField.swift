//
//  OTPField.swift
//  WINCH
//
//  Created by Alchemist on 7/20/20.
//  Copyright © 2020 Lodex-Solutions. All rights reserved.
//

import UIKit
final public class EliteOTPField : UITextField {
    //MARK:- Basic
    public var spacing:CGFloat = 10
    public var slotCount:UInt = 4
    public var slotCornerRaduis: CGFloat = 12
    public var slotPlaceHolder = ""
    //  MARK:- Fonts
    public var slotFontType: UIFont = UIFont.boldSystemFont(ofSize: 40)
    public var slotPlaceHolderFontType: UIFont = UIFont.boldSystemFont(ofSize: 40)
    //  MARK:- Coloring
    public var filledSlotTextColor: UIColor = .white
    public var emptySlotTextColor: UIColor = .black
    public var emptySlotBackgroundColor: UIColor = #colorLiteral(red: 0.9284994602, green: 0.9486981034, blue: 0.9633803964, alpha: 1)
    public var filledSlotBackgroundColor: UIColor = #colorLiteral(red: 0.8820366263, green: 0.2677072883, blue: 0.3189357519, alpha: 1)
    // MARK:- Border
    public var isBorderEnabled: Bool = false
    public var filledSlotBorderWidth: CGFloat = 1
    public var filledSlotBorderColor: CGColor = UIColor.black.cgColor
    public var emptySlotBorderWidth: CGFloat = 0
    public var emptySlotBorderColor: CGColor = UIColor.black.cgColor
    //MARK:- Vibration
    public var isVibrateEnabled: Bool = true
    //MARK:- Animation
    public var isAnimationEnabledOnLastDigit: Bool = false
    public var animationType: EliteOTPAnimationTypes = .none
    //MARK:- UnderlineViews
    public var enableUnderLineViews: Bool = false
    public var underlineViewWidthMultiplier:CGFloat = 0.7
    public var underlineViewHeight:CGFloat = 0.7
    public var underlineViewBottomSpace:CGFloat = 5
    //MARK:- Field Verified
    public var isFieldVerified:Bool = false
    //MARK:- Call Back
    public weak var otpDelegete: EliteOTPFieldDelegete?
    //MARK:- Internal
    internal var currentText = ""
    internal var isConfigured = false
    internal var digitsLabels = [UILabel]()
    internal var underLineViews = [UIView]()

    private lazy var tapRecognizer : UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    internal var editingStatus : ((_ status:OTPEditingStatus)->())?
 


    private var stackView: UIStackView?
    
    public func build() {
        guard isConfigured == false else {return}
        guard self.slotCount <= 6 else {
            print("EliteOTPField can't work with more than 6 slots.")
            return
        }
        self.isConfigured.toggle()
        self.configureTextField()
        let labelsStackView = self.createLabelsStackView(with: self.slotCount)
        self.stackView = labelsStackView
        addSubview(labelsStackView)
        addGestureRecognizer(self.tapRecognizer)
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: self.topAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
        self.addUnderlineViews()
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
    
    private func createLabelsStackView(with count:UInt)-> UIStackView {
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
            label.font = self.slotPlaceHolderFontType
            label.backgroundColor = emptySlotBackgroundColor
            label.layer.cornerRadius = slotCornerRaduis
            label.clipsToBounds = true
            label.isUserInteractionEnabled = true
            label.textColor = self.emptySlotTextColor
            label.text = self.slotPlaceHolder
            
            if self.isBorderEnabled {
                label.layer.borderWidth = self.emptySlotBorderWidth
                label.layer.borderColor = self.emptySlotBorderColor
                label.layer.borderColor = self.emptySlotBorderColor
            }
            stackView.addArrangedSubview(label)

            self.digitsLabels.append(label)
        }
        return stackView
    }
    public override func layoutSubviews() {
        super.layoutSubviews()


       
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
        self.handleAnimations(text: text, labelToAnimate: labelToAnimate, index: index)
        self.currentText = self.text ?? ""
        

        for i in 0 ..< digitsLabels.count {
            let currentLabel = digitsLabels[i]
            if isVibrateEnabled {
                Vibration.medium.vibrate()
            }
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                if self.isBorderEnabled {
                    currentLabel.layer.borderWidth = self.filledSlotBorderWidth
                    currentLabel.layer.borderColor = self.filledSlotBorderColor
                }
                currentLabel.backgroundColor = self.filledSlotBackgroundColor
                currentLabel.font = self.slotFontType
                currentLabel.textColor = self.filledSlotTextColor
                currentLabel.text = String(text[index])
            }else{
                if self.isBorderEnabled {
                    currentLabel.layer.borderWidth = self.emptySlotBorderWidth
                    currentLabel.layer.borderColor = self.emptySlotBorderColor
                }
                currentLabel.textColor = emptySlotTextColor
                currentLabel.backgroundColor = self.emptySlotBackgroundColor
                currentLabel.font = self.slotPlaceHolderFontType
                currentLabel.text = self.slotPlaceHolder
            }
        }
        if text.count == digitsLabels.count {
            isFieldVerified = true
            if isAnimationEnabledOnLastDigit {
                for i in 0 ..< digitsLabels.count {
                    let currentLabel = digitsLabels[i]
                    DispatchQueue.main.async { [weak self] in
                        guard self != nil else {
                            return
                        }
                        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut) {
                            currentLabel.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                        } completion: { done in
                            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut) {
                                currentLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                            } completion: { done in
                                UIView.animate(withDuration: 0.1) {
                                    currentLabel.transform = .identity
                                }
                            }
                        }
                    }
                }
            }
            isFieldVerified = true
            self.otpDelegete?.didEnterLastDigit(otp: text)
        }else{
            isFieldVerified = false
        }
    }
    
    public func clearAllSlotDigits() {
        guard self.text != nil || self.text!.count > 0 else {return}
        self.text = nil
        self.sendActions(for: .editingChanged)
    }
    
    private func addUnderlineViews() {
        if enableUnderLineViews {
            for label in digitsLabels {
                let underLineView = UIView()
                underLineView.backgroundColor = .black
                underLineView.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(underLineView)
                NSLayoutConstraint.activate([
                    underLineView.centerXAnchor.constraint(equalTo: label.centerXAnchor),
                    underLineView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: -underlineViewBottomSpace),
                    underLineView.widthAnchor.constraint(equalTo: label.widthAnchor, multiplier: underlineViewWidthMultiplier),
                    underLineView.heightAnchor.constraint(equalToConstant: 4)
                ])
                self.underLineViews.append(underLineView)
            }
        }
    }
}


public protocol EliteOTPFieldDelegete: AnyObject {
    func didEnterLastDigit(otp: String)
}


//public var clearAllDigits : Bool = false {
//    didSet {
//        guard clearAllDigits == true else {return}
//        guard self.text != nil || self.text!.count > 0 else {return}
//        self.text = nil
//        self.sendActions(for: .editingChanged)
//        clearAllDigits.toggle()
//    }
//}
