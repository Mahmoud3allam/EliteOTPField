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
        let field = EliteOTPField()
        field.slotCount = 6
        field.animationType = .flipFromLeft
        field.slotPlaceHolder = "_"
        field.enableUnderLineViews = false
        field.filledSlotBackgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        field.slotCornerRaduis = 8
        field.build()
        return field
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        self.otpField.otpDelegete = self
        self.setupOtpField()
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
            self.addOtpWithFrame()
        case .NSLayoutConstrains:
            self.addOtpWithNSLayoutConstraints()
        }
    }
    
    private func addOtpWithFrame() {
        self.otpField.frame = CGRect(x: 16, y: self.view.frame.midY - 30, width: self.view.frame.width - 32, height: 70)
    }
    
    private func addOtpWithNSLayoutConstraints() {
        self.otpField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.otpField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.otpField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.otpField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32),
            self.otpField.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}

extension ViewController : EliteOTPFieldDelegete {
    func didEnterLastDigit(otp: String) {
        print(otp)
        print(self.otpField.isFieldVerified)
    }
}


enum EliteOTPLayoutType {
    case NSLayoutConstrains
    case Frame
}
