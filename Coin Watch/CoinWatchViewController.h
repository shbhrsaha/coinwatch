//
//  CoinWatchViewController.h
//  Coin Watch
//
//  Created by Shubhro Saha on 1/30/14.
//  Copyright (c) 2014 Shubhro Saha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Watch.h"

@interface CoinWatchViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) Watch *theWatch;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
- (float)fetchPrice;
@end
