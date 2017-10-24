//
//  XTViewController.m
//  XTAdMobHelper
//
//  Created by ronniechen888 on 10/18/2017.
//  Copyright (c) 2017 ronniechen888. All rights reserved.
//

#import "XTViewController.h"
#import "XTAdMobHelper.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface XTViewController ()

@end

@implementation XTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[[XTAdMobHelper sharedAdMobHelper] startAccuracyTartgetWithGender:kGADGenderUnknown birthDate:(BirthDate){1970,2,11} location:(Location){} keywords:nil contentUrl:nil requestAgent:nil childDirectedTreatment:ChildTreatmentStyleNone];
	
	[[XTAdMobHelper sharedAdMobHelper] showNewBannerWithAdSize:kGADAdSizeBanner origin:CGPointMake((SCREEN_SIZE.width-kGADAdSizeBanner.size.width)*0.5, SCREEN_SIZE.height-kGADAdSizeBanner.size.height) adUnitID:@"ca-app-pub-3940256099942544/2934735716" rootViewController:self onView:self.view testMode:NO testDeviceId:@"e7204ccc3c166fcc5cec7ac8bd3c7c8e"];
	
	[[XTAdMobHelper sharedAdMobHelper] showNewBannerWithAdSize:kGADAdSizeBanner origin:CGPointMake((SCREEN_SIZE.width-kGADAdSizeBanner.size.width)*0.5, 30) adUnitID:@"ca-app-pub-3940256099942544/2934735716" rootViewController:self onView:self.view testMode:YES testDeviceId:@"e7204ccc3c166fcc5cec7ac8bd3c7c8e"];
	
	
	[[XTAdMobHelper sharedAdMobHelper] stopAccuracyTarget];
}

-(void)preloadIntersitialAction:(id)sender
{
	[[XTAdMobHelper sharedAdMobHelper] preloadNewIntersitialWithAdUnitId:@"ca-app-pub-3940256099942544/4411468910" testMode:YES testDeviceId:@"e7204ccc3c166fcc5cec7ac8bd3c7c8e" receiveHandle:nil openHandle:nil closeHandle:nil];
}

-(void)showIntersitialAction:(id)sender
{
	
	[[XTAdMobHelper sharedAdMobHelper] presentIntersitialImediatelyInRootViewController:self];
}

-(IBAction)preloadRewardAdAction:(id)sender{
	[[XTAdMobHelper sharedAdMobHelper] preloadRewardVideoWithAdUnitId:@"ca-app-pub-2089092182326765/9979233626" testMode:YES testDeviceId:@"e7204ccc3c166fcc5cec7ac8bd3c7c8e" receiveHandle:^(){
//		[[XTAdMobHelper sharedAdMobHelper] presentRewardVideoImediatelyInRootViewController:self];
	} openHandle:nil closeHandle:nil rewardHandle:^(GADAdReward *reward) {
		NSString *rewardMessage =
		[NSString stringWithFormat:@"Reward received with currency %@ , amount %lf", reward.type,
		 [reward.amount doubleValue]];
		NSLog(@"%@", rewardMessage);
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Reward" message:rewardMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alertView show];
	} failedHandle:nil];
}
-(IBAction)showRewardAdAction:(id)sender{
	[[XTAdMobHelper sharedAdMobHelper] presentRewardVideoImediatelyInRootViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
