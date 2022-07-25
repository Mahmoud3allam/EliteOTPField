

<p align="center">
    <img src="https://user-images.githubusercontent.com/42733811/180634208-cc59775a-9c04-4385-97ac-0a12a9ade4e6.png" width="480” max-width="90%" alt="SwiftyMenu" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Swift-language-orange" />
    <a href="">
    <img src="http://img.shields.io/badge/Cocoapods-available-green.svg?style=flat" alt="Cocoapod" />
    </a>
    <a href="https://github.com/Mahmoud3allam/EliteOTPField/blob/main/LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-70a1fb.svg?style=flat" alt="MIT License" />
    </a>
    <br>
    <a href="https://www.linkedin.com/in/mahmoud-allam-913183169/">
        <img src="https://img.shields.io/badge/linkedIn-%40MahmoudAllam-blue.svg?style=flat" alt="LinkedIn: @MahmoudAllam" />
    </a>
    <br>
</p>


## Objectives 🎯
 Easy and simple way to bring an OTP view into your iOS application with many customizations in color , animations , fonts etc..
 
 
## Table of Contents ⚓ 

- [Overview & ScreenShots 👀](#headers) 
- [Sample Project](#headers) 
- [Integration 💻](#headers)  
- [Usage 🧑‍💻](#headers)  
- [Customization 🎨](#headers)  
- [Animations 🦋](#headers)  
                                                                                                                          
- [References 🔙](#headers)  
- [Author](#headers)  
- [License](#headers)  

## Overview & ScreenShots 👀
You can achive many layouts with many animations based on your needs  
<table>
  <tr>
    <td>Background Changes </td>
     <td>Bordercolor Changes</td>
     <td>Flexable slot count Up to 6x </td>
     <td>Changing placeHolder</td>

  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/42733811/180697631-a0588d86-e1b2-44e4-b010-1c29e623b859.gif" width="200" height="400" width=270 height=480></td>
    <td><img src="https://user-images.githubusercontent.com/42733811/180698316-fa0f90e8-e2d0-4cb7-8ea8-36520bb50d6c.gif" width="200" height="400" width=270 height=480></td>
        <td><img src="https://user-images.githubusercontent.com/42733811/180699116-b8225fe5-5c5e-4b49-a715-f574c7c6c5f3.gif" width="200" height="400" width=270 height=480></td>
                <td><img src="https://user-images.githubusercontent.com/42733811/180699508-529b98c2-d267-4787-9658-4637ad34ab59.gif" width="200" height="400" width=270 height=480></td>
  </tr>
 </table>

<table>
  <tr>
    <td>Underline View</td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/42733811/180699818-e33267e2-bf50-4774-9511-dc6386806730.gif" width="200" height="400" width=270 height=480></td>

  </tr>
 </table>

## Sample Project
To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Integration 💻

EliteOTPField is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EliteOTPField'
```
 Then run this command in your terminal to fetch the latest version:
```ruby
pod repo update
```

## Usage 🧑‍💻
EliteOtpField is available to use with Code, however storyboard option will be added at the next version :-
<br>
#### Importing EliteOTPField
```ruby
import EliteOTPField
```
#### Initializing the component 

```ruby
    lazy var otpField: EliteOTPField = {
        let field = EliteOTPField()
        field.slotCount = 4
        field.animationType = .flipFromLeft
        field.slotPlaceHolder = ""
        field.enableUnderLineViews = true
        field.filledSlotBackgroundColor = .clear
        field.slotCornerRaduis = 8
        field.filledSlotTextColor = .black
        field.isBorderEnabled = false
        field.emptySlotBorderWidth = 1
        field.filledSlotBorderWidth = 3
        field.filledSlotBorderColor = UIColor.black.cgColor
        field.build()
        return field
    }()
```
Don't forget to call build() method after finishing your customizations.
#### add the component as a subView
        self.view.addSubview(self.otpField)
#### layouting With NSLayoutConstraints


```ruby
 self.otpField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.otpField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.otpField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.otpField.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32),
            self.otpField.heightAnchor.constraint(equalToConstant: 70)
        ])
```
#### or with frame

```ruby
   self.otpField.frame = CGRect(x: 16, y: self.view.frame.midY - 30, width: self.view.frame.width - 32, height: 70)
```
#### getting the digits by delegetion pattern in our case EliteOTPFieldDelegete

in your ViewDidLoad
```ruby
 self.otpField.otpDelegete = self
```
Then
```ruby
 extension ViewController : EliteOTPFieldDelegete {
    func didEnterLastDigit(otp: String) {
        print(otp) // Here's the Digits
    }
}
```

## Customization
```ruby

 //MARK:- Basic
    public var spacing:CGFloat 
    public var slotCount:UInt 
    public var slotCornerRaduis: CGFloat 
    public var slotPlaceHolder  
    
  //MARK:- Fonts
    public var slotFontType: UIFont 
    public var slotPlaceHolderFontType: UIFont  
    
  //MARK:- Coloring
    public var filledSlotTextColor: UIColor
    public var emptySlotTextColor: UIColor 
    public var emptySlotBackgroundColor
    public var filledSlotBackgroundColor
    
  //MARK:- Border
    public var isBorderEnabled: Bool 
    public var filledSlotBorderWidth: CGFloat 
    public var filledSlotBorderColor: CGColor 
    public var emptySlotBorderWidth: CGFloat 
    public var emptySlotBorderColor: CGColor 
    
  //MARK:- Vibration
    public var isVibrateEnabled: Bool 
    
  //MARK:- Animation
    public var isAnimationEnabledOnLastDigit: Bool 
    public var animationType: EliteOTPAnimationTypes = .none
    
  //MARK:- UnderlineViews
    public var enableUnderLineViews: Bool
    public var underlineViewWidthMultiplier:CGFloat 
    public var underlineViewHeight:CGFloat 
    public var underlineViewBottomSpace:CGFloat 
    
  //MARK:- Field Verified
    public var isFieldVerified:Bool 
```
## Animations 🦋
You can change the animation like this
```ruby
  field.animationType = .flipFromLeft
```
EliteOTPAnimationTypes enum got many animation types :-
```ruby
 public enum EliteOTPAnimationTypes {
    case flipFromRight
    case flipFromLeft
    case flash
    case shake
    case rotate
    case expand
    case crossDissolve
    case curlDown
    case curlUp
    case none  
}
```
Below GIFS reflecting each type of EliteOTPAnimationTypes Enum :- 

<table>
  <tr>
     <td>flipFromRight</td>
     <td>flipFromLeft</td>
     <td>flash</td>
     <td>shake</td>

  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/42733811/180704313-3918df8c-92d9-4319-828b-63459ab00e0f.gif" width="200" height="400" width=270 height=480></td>
    <td><img src="https://user-images.githubusercontent.com/42733811/180704137-d819215e-692b-49e5-b60d-f5687353f3de.gif" width="200" height="400" width=270 height=480></td>
     <td><img src="https://user-images.githubusercontent.com/42733811/180704407-3e0207dc-77ae-4d51-9d42-d9249452559f.gif" width="200" height="400" width=270 height=480></td>
      <td><img src="https://user-images.githubusercontent.com/42733811/180704572-1d13197a-31cb-42e0-9ec3-922cfeb23b16.gif" width="200" height="400" width=270 height=480></td>
  </tr>
 </table>
                                                                                                                                                   
 <table>
  <tr>
     <td>rotate</td>
     <td>expand</td>
     <td>crossDissolve</td>
     <td>curlDown</td>

  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/42733811/180705040-fe006dde-f9c8-4acb-8cf2-aa9ba155287c.gif" width="200" height="400" width=270 height=480></td>
    <td><img src="https://user-images.githubusercontent.com/42733811/180705132-80a05e43-d241-40ab-9bc8-d66eb992c879.gif" width="200" height="400" width=270 height=480></td>
     <td><img src="https://user-images.githubusercontent.com/42733811/180705223-01ba015a-a3ef-4061-9d6c-45e0f2c4a0e0.gif" width="200" height="400" width=270 height=480></td>
      <td><img src="https://user-images.githubusercontent.com/42733811/180705312-9a6e6456-bed2-41c2-a03c-a0bf42073cb5.gif" width="200" height="400" width=270 height=480></td>
  </tr>
 </table>
                                                                                                                                                    <table>
  <tr>
     <td>curlUp</td>
     <td>none</td>

  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/42733811/180705568-a3f6f7c7-5985-45c6-beba-ea9c286ea8f7.gif" width="200" height="400" width=270 height=480></td>
    <td><img src="https://user-images.githubusercontent.com/42733811/180705725-320a79d0-45d6-4e08-ad9d-ae6017be1619.gif" width="200" height="400" width=270 height=480></td>
  </tr>
 </table>
                                                                                                                                                 
   You can also enable animation on the last digit 
<table>
  <tr>
     <td>lastDigit Animation</td>

  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/42733811/180706092-e1a43705-e73b-4c6f-aee0-59d5ee6d01d5.gif" width="200" height="400" width=270 height=480></td>
  </tr>
 </table>
    
 ## References 🔙

https://www.youtube.com/watch?v=mHxAvSs914g&t=749s&ab_channel=KiloLoco                                                                                                                               
## Author

Mahmoud3allam, https://github.com/Mahmoud3allam , mahmoudallam@circlepay.ai

## License

EliteOTPField is available under the MIT license. See the LICENSE file for more info.
