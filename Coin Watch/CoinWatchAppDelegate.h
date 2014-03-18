//
//  CoinWatchAppDelegate.h
//  Coin Watch
//
//  Created by Shubhro Saha on 1/30/14.
//  Copyright (c) 2014 Shubhro Saha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoinWatchViewController.h"

@interface CoinWatchAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) CoinWatchViewController *myViewController;

@end
