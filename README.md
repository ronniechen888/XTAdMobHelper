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
### To create Admob banner,you just need to write one line code.
```objective-c
[[XTAdMobHelper sharedAdMobHelper] showNewBannerWithAdSize:kGADAdSizeBanner origin:CGPointMake((SCREEN_SIZE.width-kGADAdSizeBanner.size.width)*0.5, SCREEN_SIZE.height-kGADAdSizeBanner.size.height) adUnitID:@"ca-app-pub-3940256099942544/2934735716" rootViewController:self onView:self.view testMode:NO testDeviceId:@"e7204ccc3c166fcc5cec7ac8bd3c7c8e"];
```
### To create Admob intersitial,you just need to write two line codes.
First, you need to preload this intersitial ad:
```objective-c
[[XTAdMobHelper sharedAdMobHelper] preloadNewIntersitialWithAdUnitId:@"ca-app-pub-3940256099942544/4411468910" testMode:YES testDeviceId:@"e7204ccc3c166fcc5cec7ac8bd3c7c8e" receiveHandle:nil openHandle:nil closeHandle:nil];
```
Second, you need to present this ad at the right time:
```objective-c
[[XTAdMobHelper sharedAdMobHelper] preloadNewIntersitialWithAdUnitId:@"ca-app-pub-3940256099942544/4411468910" testMode:YES testDeviceId:@"e7204ccc3c166fcc5cec7ac8bd3c7c8e" receiveHandle:nil openHandle:nil closeHandle:nil];
```
### To create Admob reward video,you just need to write two line codes.
First, you need to preload this reward video ad:
```objective-c
[[XTAdMobHelper sharedAdMobHelper] preloadRewardVideoWithAdUnitId:@"ca-app-pub-2089092182326765/9979233626" testMode:YES testDeviceId:@"e7204ccc3c166fcc5cec7ac8bd3c7c8e" receiveHandle:^(){
} openHandle:nil closeHandle:nil rewardHandle:^(GADAdReward *reward) {
      NSString *rewardMessage = [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf", reward.type,[reward.amount doubleValue]];
      NSLog(@"%@", rewardMessage);
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Reward" message:rewardMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
      [alertView show];
} failedHandle:nil];
```
Second, you need to present this ad in right event action:
```objective-c
[[XTAdMobHelper sharedAdMobHelper] presentRewardVideoImediatelyInRootViewController:self];
```
Another way,if you want to present the ad immediately after receive action.You can also just write only one line code as below:
```objective-c
[[XTAdMobHelper sharedAdMobHelper] preloadRewardVideoWithAdUnitId:@"ca-app-pub-2089092182326765/9979233626" testMode:YES testDeviceId:@"e7204ccc3c166fcc5cec7ac8bd3c7c8e" receiveHandle:^(){
		[[XTAdMobHelper sharedAdMobHelper] presentRewardVideoImediatelyInRootViewController:self];
} openHandle:nil closeHandle:nil rewardHandle:^(GADAdReward *reward) {
        NSString *rewardMessage = [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf",    reward.type,[reward.amount doubleValue]];
        NSLog(@"%@", rewardMessage);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Reward" message:rewardMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
} failedHandle:nil];
```
### Maybe you want your ad sent right content to user.So you should set accuracy target parameters.
Start to set target:
```objective-c
[[XTAdMobHelper sharedAdMobHelper] startAccuracyTartgetWithGender:kGADGenderUnknown birthDate:(BirthDate){1970,2,11} location:(Location){} keywords:nil contentUrl:nil requestAgent:nil childDirectedTreatment:ChildTreatmentStyleNone];
```
Stop the target settings:
```objective-c
[[XTAdMobHelper sharedAdMobHelper] stopAccuracyTarget];
```

### For detail information,you can read this guide from Google.
[AdMob for iOS](https://developers.google.com/admob/ios/quick-start) 

## Author

ronniechen888, 576892817@qq.com

## License

XTAdMobHelper is available under the MIT license. See the LICENSE file for more info.
