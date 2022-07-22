//
//  ViewController.swift
//  EliteOTPField
//
//  Created by Mahmoud3allam on 07/21/2022.
//  Copyright (c) 2022 Mahmoud3allam. All rights reserved.
//

import UIKit
import EliteOTPField
class ViewController: UIViewController {
    lazy var otpField: EliteOTPField = {
        let builder = EliteOTPFieldBuilder()
        builder.setSlotCount(count: 4)
        builder.setSpacing(spacing: 10)
        builder.setSlotCornerRaduis(raduis: 10)
        if let font = UIFont(name: "Roboto-Bold", size: 40) {
            builder.setSlotFontType(font: font)
            builder.setSlotPlaceholderFontType(font: font)
        }

        builder.setFilledSlotTextColor(color: .white)
        builder.setEmptySlotTextColor(color: .black)
        builder.setSlotPlaceHolder(placeHolder:"__")
        builder.setEmptySlotBackgroundColor(color: #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9725490196, alpha: 1))
        builder.setFilledSlotBackgroundColor(color: #colorLiteral(red: 0.262745098, green: 0.2823529412, blue: 0.5333333333, alpha: 1))
        builder.setBorder(isEnabled: true)
        builder.setSlotBorderWidth(emptyStateWidth: 0.5, filledStateWidth: 3)
        builder.setSlotBorderColor(emptyStateColor: #colorLiteral(red: 0.262745098, green: 0.2823529412, blue: 0.5333333333, alpha: 1), filledStateColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        builder.setVibration(isEnabled: true)
        builder.setLastDigitAnimation(isEnabled: true)
        builder.setAnimationType(type: .rotate)
        return builder.build()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        self.setupOtpField()
        self.otpField.didEnteredLastDigit = { [weak self] digits in
            guard let self = self else {
                return
            }
            print(digits)
            print(self.otpField.isFieldVerified)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupOtpField() {
        self.view.addSubview(self.otpField)
        self.addOtpField(by: .Frame)

    }
    
    private func addOtpField(by type: EliteOTPLayoutType) {
        switch type {
        case .Frame:
            self.otpField.frame = CGRect(x: 16, y: self.view.frame.midY - 30, width: self.view.frame.width - 32, height: 70)
        case .NSLayoutConstrains:
            self.otpField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.otpField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                self.otpField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.otpField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32),
                self.otpField.heightAnchor.constraint(equalToConstant: 70)
            ])
        }

    }
}


enum EliteOTPLayoutType {
    case NSLayoutConstrains
    case Frame
}
