//
//  EliteOTPFieldBuilder.swift
//  EliteOTPField
//
//  Created by Alchemist on 21/07/2022.
//

import Foundation
public class EliteOTPFieldBuilder {
    private var spacing:CGFloat = 6
    private var singleNumberBackground: UIColor = .gray
    private var singleNumberViewCornerRaduis: CGFloat = 10
    private var fontType: UIFont = UIFont.systemFont(ofSize: 30)
    private var placeHolderFontType: UIFont = UIFont.systemFont(ofSize: 40)
    private var fieldTextColor: UIColor = .black
    private var fieldPlaceHolder = "_"
    private var isBorderEnabled: Bool = false
    private var filledStateBorderColor: CGColor = UIColor.black.cgColor
    private var slotCount: Int = 6
    private var borderWidthInEmptyState: CGFloat = 0
    private var borderWidthInFilledState: CGFloat = 1
    private var emptyStateBorderColor: CGColor = UIColor.black.cgColor
    private var isVibrateEnabled: Bool = true
    private var fieldFilledBackgroundColor: UIColor = .clear
    private var isAnimationEnabledOnLastDigit: Bool = false
    private var animationType: EliteOTPAnimationTypes = .none
    
    public var translatesAutoresizingMaskIntoConstraints: Bool = true
    

    public init() {
    }
    
    private func setSpacing(spacing: CGFloat) {
        self.spacing = spacing
    }

    public func setSingleNumberBackground(color: UIColor) {
        self.singleNumberBackground = color
    }

    public func setSingleNumberCornerRaduis(raduis: CGFloat) {
        self.singleNumberViewCornerRaduis = raduis
    }

    public func setFontType(font: UIFont) {
        self.fontType = font
    }

    public func setPlaceHolderFontType(font: UIFont) {
        self.placeHolderFontType = font
    }

    public func setTextColor(color: UIColor) {
        self.fieldTextColor = color
    }

    public func setFieldPlaceHolder(placeHolder: String) {
        self.fieldPlaceHolder = placeHolder
    }

    public func setBorder(isEnabled: Bool) {
        self.isBorderEnabled = isEnabled
    }

    public func setBorderColor(emptyStateColor: UIColor, filledStateColor: UIColor) {
        self.filledStateBorderColor = filledStateColor.cgColor
        self.emptyStateBorderColor = emptyStateColor.cgColor
    }
    
    public func setSlotCount(count: Int) {
        self.slotCount = count
    }
    
    public func setBorderWidth(emptyStateWidth: CGFloat, filledStateWidth: CGFloat) {
        self.borderWidthInEmptyState = emptyStateWidth
        self.borderWidthInFilledState = filledStateWidth
    }

    public func setVibration(isEnabled: Bool) {
        self.isVibrateEnabled = isEnabled
    }
    
    public func setFieldBackground(color: UIColor) {
        self.fieldFilledBackgroundColor = color
    }
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
        field.singleNumberBackground = self.singleNumberBackground
        field.singleNumberViewCornerRaduis = self.singleNumberViewCornerRaduis
        field.fontType = self.fontType
        field.placeHolderFontType = self.placeHolderFontType
        field.fieldTextColor = self.fieldTextColor
        field.fieldPlaceHolder = self.fieldPlaceHolder
        field.isBorderEnabled = self.isBorderEnabled
        field.borderColorFilledState = self.filledStateBorderColor
        field.borderColorEmptyState = self.emptyStateBorderColor
        field.slotCount = self.slotCount
        field.borderWidthInEmptyState = self.borderWidthInEmptyState
        field.borderWidthInFilledState = self.borderWidthInFilledState
        field.isVibrateEnabled = self.isVibrateEnabled
        field.fieldFilledBackgroundColor = self.fieldFilledBackgroundColor
        field.isAnimationEnabledOnLastDigit = self.isAnimationEnabledOnLastDigit
        field.animationType = animationType
        field.configure()
        return field
    }
}
