//
//  Watch.h
//  Coin Watch
//
//  Created by Shubhro Saha on 1/30/14.
//  Copyright (c) 2014 Shubhro Saha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Watch : NSObject
@property (copy, nonatomic) NSString *direction;
@property (nonatomic) float targetPrice;
@property BOOL triggered;
@end
