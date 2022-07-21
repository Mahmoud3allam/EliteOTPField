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
        builder.setSingleNumberBackground(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        builder.setSlotCount(count: 6)
        builder.setBorder(isEnabled: true)
        builder.setSingleNumberCornerRaduis(raduis: 8)
        builder.setFieldPlaceHolder(placeHolder: "_")
        builder.setTextColor(color: .white)
        builder.setBorderColor(emptyStateColor: .clear, filledStateColor: .black)
//        builder.translatesAutoresizingMaskIntoConstraints = true
        builder.setBorderWidth(emptyStateWidth: 1, filledStateWidth: 3)
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
//        NSLayoutConstraint.activate([
//            self.otpField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            self.otpField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            self.otpField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -64),
//            self.otpField.heightAnchor.constraint(equalToConstant: 80)
//        ])
        self.otpField.frame = CGRect(x: 32, y: self.view.frame.midY - 30, width: self.view.frame.width - 64, height: 60)
    }
}

