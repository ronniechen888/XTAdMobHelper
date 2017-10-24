# XTAdMobHelper

[![CI Status](http://img.shields.io/travis/ronniechen888/XTAdMobHelper.svg?style=flat)](https://travis-ci.org/ronniechen888/XTAdMobHelper)
[![Version](https://img.shields.io/cocoapods/v/XTAdMobHelper.svg?style=flat)](http://cocoapods.org/pods/XTAdMobHelper)
[![License](https://img.shields.io/cocoapods/l/XTAdMobHelper.svg?style=flat)](http://cocoapods.org/pods/XTAdMobHelper)
[![Platform](https://img.shields.io/cocoapods/p/XTAdMobHelper.svg?style=flat)](http://cocoapods.org/pods/XTAdMobHelper)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Target: iOS 7.0+ device

## Installation

XTAdMobHelper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XTAdMobHelper'
```

## Usage
### To create Admob banner,you just need to write one line code:
```objective-c
[[XTAdMobHelper sharedAdMobHelper] showNewBannerWithAdSize:kGADAdSizeBanner 
origin:CGPointMake((SCREEN_SIZE.width-kGADAdSizeBanner.size.width)*0.5, SCREEN_SIZE.height-kGADAdSizeBanner.size.height) 
adUnitID:@"ca-app-pub-3940256099942544/2934735716" 
rootViewController:self 
onView:self.view 
testMode:NO 
testDeviceId:@"e7204ccc3c166fcc5cec7ac8bd3c7c8e"];
```

## Author

ronniechen888, 576892817@qq.com

## License

XTAdMobHelper is available under the MIT license. See the LICENSE file for more info.
