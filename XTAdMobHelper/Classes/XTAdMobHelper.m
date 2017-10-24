//
//  XTAdMobHelper.m
//  XTAdMobHelper
//
//  Created by Ronnie Chen on 2017/10/19.
//

#import "XTAdMobHelper.h"

@interface XTAdMobHelper()
@property (nonatomic,strong) GADInterstitial *interstitial;

///Set target parameters
@property (nonatomic,assign) GADGender gender;
@property (nonatomic,assign) BirthDate *birthDate;
@property (nonatomic,assign) Location *location;
@property (nonatomic,assign) ChildTreatmentStyle childDirectedTreatment;
@property (nonatomic,copy) NSArray *keywords;
@property (nonatomic,copy) NSString *contentURL;
@property (nonatomic,copy) NSString *requestAgent;
@property (nonatomic,assign) BOOL isNeedAccuracyTarget;

///Intersitial's temprorary val
@property (nonatomic,strong) NSString *tempAdUnitId;
@property (nonatomic,assign) BOOL tempIsOn;
@property (nonatomic,strong) NSString *tempDeviceId;

///Intersitial's handle block
@property (nonatomic,copy) void (^intersitialAdDidReceiveHandle)(void);
@property (nonatomic,copy) void (^intersitialAdDidOpenHandle)(void);
@property (nonatomic,copy) void (^intersitialAdDidCloseHandle)(void);

///Reward video's handle block
@property (nonatomic,copy) void (^rewardVideoAdDidReceiveHandle)(void);
@property (nonatomic,copy) void (^rewardVideoAdDidOpenHandle)(void);
@property (nonatomic,copy) void (^rewardVideoAdDidCloseHandle)(void);
@property (nonatomic,copy) void (^rewardVideoAdDidRewardUserHandle)(GADAdReward *reward);
@property (nonatomic,copy) void (^rewardVideoAdDidFailedHandle)(NSError *error);

@end

@implementation XTAdMobHelper

-(instancetype)init
{
	self = [super init];
	
	if (self) {
		self.isNeedAccuracyTarget = NO;
	}
	
	return self;
}

+(instancetype)sharedAdMobHelper
{
	static XTAdMobHelper *adHelper = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		adHelper = [[XTAdMobHelper alloc] init];
	});
	
	return adHelper;
}

-(void)configWithApplicationId:(NSString*)appId
{
	[GADMobileAds configureWithApplicationID:appId];
}
#pragma mark - Accuracy Target
-(void)startAccuracyTartgetWithGender:(GADGender)gender birthDate:(BirthDate)birthDate location:(Location)location keywords:(NSArray *)keywords contentUrl:(NSString *)contentUrl requestAgent:(NSString *)requestAgent childDirectedTreatment:(ChildTreatmentStyle)childDirectedTreatment
{
	if (self.birthDate == NULL) {
		self.birthDate = malloc(sizeof(BirthDate));
	}
	if (self.location == NULL) {
		self.location = malloc(sizeof(location));
	}

	self.gender = (gender == kGADGenderMale || gender == kGADGenderFemale)?gender:kGADGenderUnknown;
	NSLog(@"%ld",sizeof(birthDate));
	if (birthDate.year >0 && birthDate.month>0 && birthDate.day>0) {
		self.birthDate->year = birthDate.year;
		self.birthDate->month = birthDate.month;
		self.birthDate->day = birthDate.day;
	}else{
		NSLog(@"Birth date set error");
		free(self.birthDate);
		self.birthDate = NULL;
	}
	
	if (location.latitude >0 && location.longitude>0 && location.accuracyInMeters>0) {
		self.location->latitude = birthDate.year;
		self.location->longitude = birthDate.month;
		self.location->accuracyInMeters = birthDate.day;
	}else{
		NSLog(@"Location set error");
		free(self.location);
		self.location = NULL;
	}
	
	self.keywords = keywords;
	self.contentURL = contentUrl;
	self.requestAgent = requestAgent;
	self.childDirectedTreatment = childDirectedTreatment;
	self.isNeedAccuracyTarget = YES;
}

-(void)stopAccuracyTarget
{
	self.isNeedAccuracyTarget = NO;
	free(self.birthDate);
	free(self.location);
	self.birthDate = NULL;
	self.location = NULL;
	self.keywords = nil;
	self.contentURL = nil;
	self.requestAgent = nil;
	self.gender = kGADGenderUnknown;
	self.childDirectedTreatment = NO;
}

-(void)setTargetToRequest:(GADRequest *)request
{
	if (_isNeedAccuracyTarget) {
		request.gender = self.gender;
		
		if (self.keywords) {
			if ([self.keywords count]>0) {
				request.keywords = self.keywords;
			}
			
		}
		
		if (self.contentURL.length > 0) {
			request.contentURL = self.contentURL;
		}
		
		if (self.requestAgent.length > 0) {
			request.requestAgent = self.requestAgent;
		}
		
		if (self.childDirectedTreatment == ChildTreatmentStyleYES) {
			[request tagForChildDirectedTreatment:YES];
		}else if (self.childDirectedTreatment == ChildTreatmentStyleNO){
			[request tagForChildDirectedTreatment:NO];
		}else{
		}
		
		if (self.location != NULL) {
			[request setLocationWithLatitude:self.location->latitude longitude:self.location->longitude accuracy:self.location->accuracyInMeters];
		}
		
		if (self.birthDate != NULL) {
			NSDateComponents *components = [[NSDateComponents alloc] init];
			components.month = self.birthDate->month;
			components.day = self.birthDate->day;
			components.year = self.birthDate->year;
			request.birthday = [[NSCalendar currentCalendar] dateFromComponents:components];
		}
	}
}



#pragma mark - Banner

-(void)showNewBannerWithAdSize:(GADAdSize)adSize origin:(CGPoint)origin adUnitID:(NSString *)adUnitID rootViewController:(UIViewController *)rootViewController onView:(UIView *)targetView testMode:(BOOL)isOn testDeviceId:(NSString *)deviceId
{
	
	GADBannerView *bannerView = [[GADBannerView alloc] initWithAdSize:adSize origin:origin];
	bannerView.adUnitID = adUnitID;
	bannerView.rootViewController = rootViewController;
	bannerView.delegate = self;
	bannerView.alpha = 0;
	[targetView addSubview:bannerView];
	
	GADRequest *request = [GADRequest request];
	// Requests test ads on devices you specify. Your test device ID is printed to the console when
	// an ad request is made. GADBannerView automatically returns test ads when running on a
	// simulator.
	if (isOn) {
		if (deviceId.length > 0) {
			request.testDevices = @[
									kGADSimulatorID,deviceId  // Eric's iPod Touch
									];
		}else{
			request.testDevices = @[
									kGADSimulatorID
									];
		}
		
	}
	[self setTargetToRequest:request];
	[bannerView loadRequest:request];
	
}
#pragma mark - Intersitial
-(void)preloadNewIntersitialWithAdUnitId:(NSString *)adUnitID testMode:(BOOL)isOn testDeviceId:(NSString *)deviceId receiveHandle:(void (^)(void))receiveHandle openHandle:(void (^)(void))openHandle closeHandle:(void (^)(void))closeHandle
{
	self.intersitialAdDidReceiveHandle = receiveHandle;
	self.intersitialAdDidOpenHandle = openHandle;
	self.intersitialAdDidCloseHandle = closeHandle;
	
	self.tempAdUnitId = adUnitID;
	self.tempIsOn = isOn;
	self.tempDeviceId = deviceId;
	self.interstitial = [self createAndLoadInterstitialWithAdUnitId:adUnitID testMode:isOn testDeviceId:deviceId];
}

-(void)presentIntersitialImediatelyInRootViewController:(UIViewController *)rootViewController
{
	if (self.interstitial.isReady) {
		[self.interstitial presentFromRootViewController:rootViewController];
	} else {
		NSLog(@"Ad No Ready");
		//		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//			while (1) {
//				if (self.interstitial.isReady) {
//					dispatch_async(dispatch_get_main_queue(), ^{
//						[self.interstitial presentFromRootViewController:rootViewController];
//					});
//				}
//			}
//		});
	}
}

- (GADInterstitial *)createAndLoadInterstitialWithAdUnitId:(NSString *)adUnitID testMode:(BOOL)isOn testDeviceId:(NSString *)deviceId {
	GADInterstitial *nInterstial = [[GADInterstitial alloc] initWithAdUnitID:adUnitID];
	nInterstial.delegate = self;
	
	GADRequest *request = [GADRequest request];
	// Request test ads on devices you specify. Your test device ID is printed to the console when
	// an ad request is made.
	if (isOn) {
		if (deviceId.length > 0) {
			request.testDevices = @[
									kGADSimulatorID,deviceId  // Eric's iPod Touch
									];
		}else{
			request.testDevices = @[
									kGADSimulatorID
									];
		}
		
	}
	
	[self setTargetToRequest:request];
	[nInterstial loadRequest:request];
	return nInterstial;
}

#pragma mark - Reward Video
-(void)preloadRewardVideoWithAdUnitId:(NSString *)adUnitID testMode:(BOOL)isOn testDeviceId:(NSString *)deviceId receiveHandle:(void (^)(void))receiveHandle openHandle:(void (^)(void))openHandle closeHandle:(void (^)(void))closeHandle rewardHandle:(void (^)(GADAdReward *))rewardHandle failedHandle:(void (^)(NSError *))failedHandle
{
	self.rewardVideoAdDidReceiveHandle = receiveHandle;
	self.rewardVideoAdDidOpenHandle = openHandle;
	self.rewardVideoAdDidCloseHandle = closeHandle;
	self.rewardVideoAdDidRewardUserHandle = rewardHandle;
	self.rewardVideoAdDidFailedHandle = failedHandle;
	
	[GADRewardBasedVideoAd sharedInstance].delegate = self;
	
	GADRequest *request = [GADRequest request];
	if (isOn) {
		if (deviceId.length > 0) {
			request.testDevices = @[
									kGADSimulatorID,deviceId  // Eric's iPod Touch
									];
		}else{
			request.testDevices = @[
									kGADSimulatorID
									];
		}
		
	}
	[self setTargetToRequest:request];
	[[GADRewardBasedVideoAd sharedInstance] loadRequest:request
										   withAdUnitID:adUnitID];
}

-(void)presentRewardVideoImediatelyInRootViewController:(UIViewController *)rootViewController
{
	if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
		[[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:rootViewController];
	} else {
		NSLog(@"Ad No Ready");
	}
}

#pragma mark - GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView{
	
	[UIView animateWithDuration:1.0 animations:^{
		bannerView.alpha = 1;
	}];
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error{
	NSLog(@"banner view load failed:%@",error.localizedDescription);
}

#pragma mark - GADInterstitialDelegate
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
	if (self.intersitialAdDidReceiveHandle) {
		self.intersitialAdDidReceiveHandle();
	}
	NSLog(@"interstitial load succeed!");
}
- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{
	NSLog(@"interstitial load failed:%@",error.localizedDescription);
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad{
	if (self.intersitialAdDidOpenHandle) {
		self.intersitialAdDidOpenHandle();
	}
}


-(void)interstitialDidDismissScreen:(GADInterstitial *)ad
{
	if (self.intersitialAdDidCloseHandle) {
		self.intersitialAdDidCloseHandle();
	}
	[self preloadNewIntersitialWithAdUnitId:_tempAdUnitId testMode:_tempIsOn testDeviceId:_tempDeviceId receiveHandle:self.intersitialAdDidReceiveHandle openHandle:self.intersitialAdDidOpenHandle closeHandle:self.intersitialAdDidCloseHandle];
}

#pragma mark - GADRewardBasedVideoAdDelegate
- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
	NSLog(@"Reward based video ad is received.");
	if (self.rewardVideoAdDidReceiveHandle) {
		self.rewardVideoAdDidReceiveHandle();
	}
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
	NSLog(@"Opened reward based video ad.");
	if (self.rewardVideoAdDidOpenHandle) {
		self.rewardVideoAdDidOpenHandle();
	}
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
	NSLog(@"Reward based video ad started playing.");
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
	NSLog(@"Reward based video ad is closed.");
//	self.showVideoButton.hidden = YES;
	if (self.rewardVideoAdDidCloseHandle) {
		self.rewardVideoAdDidCloseHandle();
	}
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
	
	if (self.rewardVideoAdDidRewardUserHandle) {
		self.rewardVideoAdDidRewardUserHandle(reward);
	}
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
	NSLog(@"Reward based video ad will leave application.");
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
	didFailToLoadWithError:(NSError *)error {
	if (self.rewardVideoAdDidFailedHandle) {
		self.rewardVideoAdDidFailedHandle(error);
	}
	NSLog(@"Reward ad load failed:%@",error.localizedDescription);
}

@end
