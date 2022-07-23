//
//  EliteOTPFieldBuilder.swift
//  EliteOTPField
//
//  Created by Alchemist on 21/07/2022.
//


import Foundation
import UIKit
public class EliteOTPFieldBuilder {
    //MARK:- Basic
    private var slotCount: Int = 6
    private var spacing:CGFloat = 6
    private var slotCornerRaduis: CGFloat = 10
    private var slotPlaceholder = "_"
    //  MARK:- Fonts
    private var slotFontType: UIFont = UIFont.systemFont(ofSize: 30)
    private var slotPlaceHolderFontType: UIFont = UIFont.systemFont(ofSize: 40)
    //  MARK:- Coloring
    private var filledSlotTextColor: UIColor = .black
    private var emptySlotTextColor: UIColor = .black
    private var emptySlotBackgroundColor: UIColor = .gray
    private var filledSlotBackgroundColor: UIColor = .clear
    // MARK:- Border
    private var isBorderEnabled: Bool = false
    private var filledSlotBorderWidth: CGFloat = 1
    private var filledSlotBorderColor: CGColor = UIColor.black.cgColor
    private var emptySlotBorderWidth: CGFloat = 0
    private var emptySlotBorderColor: CGColor = UIColor.black.cgColor
    //MARK:- Vibration
    private var isVibrateEnabled: Bool = true
    //MARK:- Animation
    private var isAnimationEnabledOnLastDigit: Bool = false
    private var animationType: EliteOTPAnimationTypes = .none
    //MARK:- NSLayoutConstraints / Frame
    public var translatesAutoresizingMaskIntoConstraints: Bool = true
    
    public init() {
    }
    
    //MARK:- Basic
    public func setSpacing(spacing: CGFloat) {
        self.spacing = spacing
    }
    
    public func setSlotCount(count: Int) {
        self.slotCount = count
    }
    
    public func setSlotCornerRaduis(raduis: CGFloat) {
        self.slotCornerRaduis = raduis
    }
    
    public func setSlotPlaceHolder(placeHolder: String) {
        self.slotPlaceholder = placeHolder
    }
    
    //  MARK:- Fonts
    
    public func setSlotFontType(font: UIFont) {
        self.slotFontType = font
    }
    
    public func setSlotPlaceholderFontType(font: UIFont) {
        self.slotPlaceHolderFontType = font
    }
    
    
    //  MARK:- Coloring
    
    public func setFilledSlotTextColor(color: UIColor) {
        self.filledSlotTextColor = color
    }
    
    public func setEmptySlotBackgroundColor(color: UIColor) {
        self.emptySlotBackgroundColor = color
    }
    
    public func setFilledSlotBackgroundColor(color: UIColor) {
        self.filledSlotBackgroundColor = color
    }
    
    public func setEmptySlotTextColor(color:UIColor) {
        self.emptySlotTextColor = color
    }
    
    // MARK:- Border
    public func setBorder(isEnabled: Bool) {
        self.isBorderEnabled = isEnabled
    }
    
    public func setSlotBorderWidth(emptyStateWidth: CGFloat, filledStateWidth: CGFloat) {
        self.emptySlotBorderWidth = emptyStateWidth
        self.filledSlotBorderWidth = filledStateWidth
    }
    
    public func setSlotBorderColor(emptyStateColor: UIColor, filledStateColor: UIColor) {
        self.filledSlotBorderColor = filledStateColor.cgColor
        self.emptySlotBorderColor = emptyStateColor.cgColor
    }
    
    //MARK:- Vibration
    public func setVibration(isEnabled: Bool) {
        self.isVibrateEnabled = isEnabled
    }
    //MARK:- Animation
    public func setAnimationType(type:EliteOTPAnimationTypes) {
        self.animationType = type
    }
    
    public func setLastDigitAnimation(isEnabled: Bool) {
        self.isAnimationEnabledOnLastDigit = isEnabled
    }
    
    
    public func build() -> EliteOTPField {
        let field = EliteOTPField()
        field.translatesAutoresizingMaskIntoConstraints = self.translatesAutoresizingMaskIntoConstraints
        field.spacing = self.spacing
        field.emptySlotBackgroundColor = self.emptySlotBackgroundColor
        field.slotCornerRaduis = self.slotCornerRaduis
        field.slotFontType = self.slotFontType
        field.slotPlaceHolderFontType = self.slotPlaceHolderFontType
        field.filledSlotTextColor = self.filledSlotTextColor
        field.slotPlaceHolder = self.slotPlaceholder
        field.isBorderEnabled = self.isBorderEnabled
        field.filledSlotBorderColor = self.filledSlotBorderColor
        field.emptySlotBorderColor = self.emptySlotBorderColor
        field.slotCount = self.slotCount
        field.emptySlotBorderWidth = self.emptySlotBorderWidth
        field.filledSlotBorderWidth = self.filledSlotBorderWidth
        field.isVibrateEnabled = self.isVibrateEnabled
        field.filledSlotBackgroundColor = self.filledSlotBackgroundColor
        field.isAnimationEnabledOnLastDigit = self.isAnimationEnabledOnLastDigit
        field.animationType = animationType
        field.emptySlotTextColor = self.emptySlotTextColor
        field.configure()
        return field
    }
}
