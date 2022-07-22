//
//  EliteOTPField + Animations.swift
//  EliteOTPField
//
//  Created by Alchemist on 21/07/2022.
//

import Foundation
extension EliteOTPField {
    func handleAnimations (text: String, labelToAnimate: UILabel,index: Int) {
        if text.count > self.currentText.count {
            switch self.animationType {
            case .crossDissolve:
                labelToAnimate.crossDissolve(duration: 0.3)
            case .flipFromRight:
                labelToAnimate.flipFromRight(duration: 0.3)
            case .flipFromLeft:
                labelToAnimate.flipFromLeft(duration: 0.3)
            case .curlUp:
                labelToAnimate.curlUp(duration: 0.3)
            case .curlDown:
                labelToAnimate.curlDown(duration: 0.3)
            case .flash:
                labelToAnimate.flash(duration: 0.3)
            case .shake:
                labelToAnimate.shake()
            case .rotate:
                labelToAnimate.rotate()
            case .expand:
                for (i, label) in self.digitsLabels.enumerated() {
                    if i != index {
                        UIView.animate(withDuration: 0.3) {
                            label.isHidden = true
                        } completion: { _ in
                            for (_, label) in self.digitsLabels.enumerated() {
                                UIView.animate(withDuration: 0.3) {
                                    label.isHidden = false
                                }
                            }
                        }
                    }
                }
            default:
                break
            }
        }
    }
}



extension UIView {
   func shake(count : Float = 2,for duration : TimeInterval = 0.1,withTranslation translation : Float = 2) {
       let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
       animation.repeatCount = count
       animation.duration = duration/TimeInterval(animation.repeatCount)
       animation.autoreverses = true
       animation.values = [translation, -translation]
       layer.add(animation, forKey: "shake")
   }
    
    func flipFromRight(duration:TimeInterval){
        UIView.transition(with: self, duration: duration, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    func flipFromLeft(duration:TimeInterval){
        UIView.transition(with: self, duration: duration, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    func crossDissolve(duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func curlDown(duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: .transitionCurlDown, animations: nil, completion: nil)
    }
    
    func curlUp(duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: .transitionCurlUp, animations: nil, completion: nil)
    }
    
    func flash(duration:TimeInterval) {
        UIView.animate(withDuration: duration - 1, delay: 0.0, options: .curveEaseInOut) {
            self.alpha = 0
        } completion: { done in
            UIView.animate(withDuration: 0.1) {
                self.alpha = 1
            }
        }
    }
    
    func rotate() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut) {
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        } completion: { done in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut) {
                self.transform = CGAffineTransform(rotationAngle: .pi)
            } completion: { done in
                UIView.animate(withDuration: 0.1) {
                    self.transform = .identity
                }
            }
        }
    }
}
