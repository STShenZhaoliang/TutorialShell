# STKitSwift

<p align="center">
<img src="Resources/Banner.png" alt="STKitSwift Banner">
</p>

[![Platform](https://img.shields.io/cocoapods/p/STKitSwift.svg?style=flat)](https://github.com/STShenZhaoliang/STKitSwift)
![Version](https://img.shields.io/cocoapods/v/STKitSwift.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Language](https://img.shields.io/badge/language-Swift%205.0-orange.svg)](https://swift.org/)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/STShenZhaoliang/STKitSwift/blob/master/LICENSE)


STKitSwift is a collection of useful classes, structs and extensions to **develop Apps faster**.

Installing and Usage
====================

```ruby

    platform :ios, '10.0'
    xcodeproj 'Project.xcodeproj'
    use_frameworks!
    pod 'STKitSwift'
    
```

Effect Picture
====================
<img src="Resources/STAlertView01.png" width="25%" height="25%"><img src="Resources/STAlertView02.png" width="25%" height="25%"><img src="Resources/STGradientButton01.png" width="25%" height="25%"><img src="Resources/STGradientView01.png" width="25%" height="25%"><img src="Resources/STHUD01.png" width="25%" height="25%"><img src="Resources/STHUD02.png" width="25%" height="25%"><img src="Resources/STMoveButton01.png" width="25%" height="25%"><img src="Resources/STPhoneTextField01.png" width="25%" height="25%"><img src="Resources/STProgressView01.png" width="25%" height="25%"><img src="Resources/STSegmentedControl01.png" width="25%" height="25%"><img src="Resources/STTimerButton01.png" width="25%" height="25%"><img src="Resources/STAreaPickerView01.png" width="25%" height="25%"><img src="Resources/STDatePickerView01.png" width="25%" height="25%">


Changelog
====================

## 1.1


| 名称 | 功能描述 | 状态 |
| --- | --- | --- |
| [STAlertView](#STAlertView) | UIAlertController在alert风格下的封装 | 新增 |
| [STGradientButton](#STGradientButton) | 支持渐变色功能的按钮 | 新增 |
| [STGradientView](#STGradientView) | IB支持渐变色、阴影功能的视图 | 新增 |
| [STHUD](#STHUD) | 弱提示框 | 新增 |
| [STMoveButton](#STMoveButton) | 可移动按钮 | 新增 |
| [STPhoneTextField](#STPhoneTextField) | 指定文本显示样式与文本正则的手机号输入框 | 新增 |
| [STProgressView](#STProgressView) | 支持渐变色功能的进度框 | 新增 |
| [STSegmentedControl](#STSegmentedControl) | 根据内容偏移的分段选择器 | 新增 |


## 1.2

| 名称 | 功能描述 | 状态 |
| --- | --- | --- |
| [STTimerButton](#STTimerButton) | 支持计时与倒计时的按钮 | 新增 |
| [STAreaPickerView](#STAreaPickerView) | 省市区选择器 | 新增 |
| [STDatePickerView](#STDatePickerView) | 年月日选择器 | 新增 |

## 1.3
| 名称 | 功能描述 | 状态 |
| --- | --- | --- |
| [STHUD](#STHUD) | 支持图片与文本提示 | 更新 |

## STAlertView

### Installing

```ruby
pod 'STKitSwift/STAlertView'
```

### Example

```swift
let title = "Flutter 与 iOS 原生 WebView 对比"
STAlertView.show(title: title, message: nil, cancelTitle: "取消", otherTitle: "确定") { (item) in
    print(item)
}
```

## STGradientButton

### Installing

``` ruby
pod 'STKitSwift/STGradientButton'
```

### Example

```swift
    private lazy var gradientButton: STGradientButton = {
        let gradientButton = STGradientButton()
        gradientButton.startColor = UIColor.init(red: 255.0/255, green: 76.0/255, blue: 21.0/255, alpha: 1)
        gradientButton.endColor =  UIColor.init(red: 255.0/255, green: 156.0/255, blue: 121.0/255, alpha: 1)
        gradientButton.setTitle("使用layer", for: .normal)
        gradientButton.layer.cornerRadius = 22
        gradientButton.layer.masksToBounds = true
        view.addSubview(gradientButton)
        return gradientButton
    }()
```

## STGradientView

### Installing and Usage

```
pod 'STKitSwift/STGradientView'
```

## STHUD

### Installing and Usage

```
pod 'STKitSwift/STHUD'
```

### Example

```swift
STHUD.show("Hello World")
```

## STMoveButton

### Installing and Usage

```
pod 'STKitSwift/STMoveButton'
```

### Example

```swift
private lazy var moveButton: STMoveButton = {
    let moveButton = STMoveButton()
    moveButton.setImage(UIImage.init(named: "icon_wheel"), for: .normal)
    view.addSubview(moveButton)
    return moveButton
    }()
```

## STPhoneTextField

### Installing and Usage

```
pod 'STKitSwift/STPhoneTextField'
```

### Example

```swift
let tf3 = STPhoneTextField()
tf3.config.defaultConfig = STPhoneFormat.init(defaultPhoneFormat: "(####) #######")
tf3.prefix = "+86 "
tf3.placeholder = "format:+86 (####) #######"
```

## STProgressView

### Installing and Usage

```
pod 'STKitSwift/STProgressView'
```

## STSegmentedControl

### Installing and Usage

```
pod 'STKitSwift/STSegmentedControl'

```

### Example

```swift
let titles = ["关注", "推荐", "国际", "娱乐", "视频", "科技", "军事", "设计", "体育", "读书"]
let segmentedControl = STSegmentedControl()
segmentedControl.titles = titles
segmentedControl.selectBlock = { (item) in
            print(item)
        }
segmentedControl.currentIndex = 3
```

## STTimerButton

### Installing and Usage

```
pod 'STKitSwift/STTimerButton'

```

### Example

```swift
buttonCode.startCountDown(duration: 10) { (button, type, time)  in
print("button = \(button) type = \(type) time = \(time)")
    switch type {
    case .start:
        button.isEnabled = false
        button.setTitle(time.description + "s", for: .normal)
        button.backgroundColor = .gray
    case .ongoing:
        button.isEnabled = false
        button.setTitle(time.description + "s", for: .normal)
        button.backgroundColor = .gray
    case .finish:
        button.isEnabled = true
        button.setTitle("重新发送", for: .normal)
        button.backgroundColor = .red
    default:
        button.isEnabled = true
    }
}
```
## STAreaPickerView

### Installing and Usage

```
pod 'STKitSwift/STAreaPickerView'

```

### Example

```swift
STAreaPickerView.show(inView: view) { [weak self](provinceName, provinceCode, cityName, cityCode, areaName, areaCode) in

}
```

## STDatePickerView

### Installing and Usage

```
pod 'STKitSwift/STDatePickerView'

```

### Example

```swift
STDatePickerView.show(minimumDateStr: "1900-01-01",
                              maximumDateStr: "3000-01-01",
                              currentDateStr: "2019-06-04")
        { (year, month, day)in
            print("year = \(year)  month = \(month)  day = \(day)")
        }
```
