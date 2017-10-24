//
//  XTAdMobHelper.h
//  XTAdMobHelper
//
//  Created by Ronnie Chen on 2017/10/19.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

typedef struct {
	NSInteger year;
	NSInteger month;
	NSInteger day;
} BirthDate;

typedef struct{
	CGFloat latitude;
	CGFloat longitude;
	CGFloat accuracyInMeters;
} Location;

typedef enum{
	ChildTreatmentStyleYES,
	ChildTreatmentStyleNO,
	ChildTreatmentStyleNone
} ChildTreatmentStyle;

@interface XTAdMobHelper : NSObject<GADBannerViewDelegate,GADInterstitialDelegate,GADRewardBasedVideoAdDelegate>

///XTAdMobHelper's singleton instance
+(instancetype)sharedAdMobHelper;

///Config application id
-(void)configWithApplicationId:(NSString*)appId;

/// Set accuracy target
/// gender: Provide the user's gender to increase ad relevancy.
/// birthDate: Provide the user's birthday to increase ad relevancy.
/// location: The user's current location may be used to deliver more relevant ads. However do not use Core Location just for advertising, make sure it is used for more beneficial reasons as well. It is both a good idea and part of Apple's guidelines.
/// keywords: Array of keyword strings. Keywords are words or phrases describing the current user activitysuch as @"Sports Scores" or @"Football". Set this property to nil to clear the keywords.
/// contentURL: URL string for a webpage whose content matches the app content. This webpage content is used for targeting purposes.
/// requestAgent: String that identifies the ad request's origin. Third party libraries that reference the Mobile Ads SDK should set this property to denote the platform from which the ad request originated.For example, a third party ad network called "CoolAds network" that is mediating requests to the Mobile Ads SDK should set this property as "CoolAds".
/// childDirectedTreatment: If you set this value with ChildTreatmentStyleYES, you are indicating that your app should be treated as child-directed for purposes of the Children’s Online Privacy Protection Act (COPPA). If you set this value with ChildTreatmentStyleNO, you are indicating that your app should not be treated as child-directed for purposes of the Children’s Online Privacy Protection Act (COPPA). If you set this value with ChildTreatmentStyleNone, ad requests will include no indication of how you would like your app treated with respect to COPPA.
-(void)startAccuracyTartgetWithGender:(GADGender)gender 
							birthDate:(BirthDate)birthDate 
							 location:(Location)location 
							 keywords:(NSArray *)keywords 
						   contentUrl:(NSString *)contentUrl 
						 requestAgent:(NSString *)requestAgent 
		       childDirectedTreatment:(ChildTreatmentStyle)childDirectedTreatment;

///Clear the target settings
-(void)stopAccuracyTarget;

///Show bannner ad
-(void)showNewBannerWithAdSize:(GADAdSize)adSize 
						origin:(CGPoint)origin 
					  adUnitID:(NSString *)adUnitID 
			rootViewController:(UIViewController *)rootViewController 
						onView:(UIView *)targetView 
					  testMode:(BOOL)isOn 
				  testDeviceId:(NSString *)deviceId;

///Preload intersitial ad
-(void)preloadNewIntersitialWithAdUnitId:(NSString *)adUnitID 
								testMode:(BOOL)isOn 
							testDeviceId:(NSString *)deviceId
						   receiveHandle:(void (^)(void))receiveHandle
							  openHandle:(void (^)(void))openHandle 
							 closeHandle:(void (^)(void))closeHandle;

///Present intersitial ad
-(void)presentIntersitialImediatelyInRootViewController:(UIViewController *)rootViewController;

///Preload reward video ad
-(void)preloadRewardVideoWithAdUnitId:(NSString *)adUnitID
							 testMode:(BOOL)isOn 
						 testDeviceId:(NSString *)deviceId 
						receiveHandle:(void (^)(void))receiveHandle
						   openHandle:(void (^)(void))openHandle 
						  closeHandle:(void (^)(void))closeHandle 
						 rewardHandle:(void (^)(GADAdReward *reward))rewardHandle
						 failedHandle:(void (^)(NSError *error))failedHandle;

///Present reward video ad
-(void)presentRewardVideoImediatelyInRootViewController:(UIViewController *)rootViewController;

///Remove all banners
-(void)removeAllBanners;

@end
