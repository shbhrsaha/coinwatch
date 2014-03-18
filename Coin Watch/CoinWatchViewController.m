//
//  CoinWatchViewController.m
//  Coin Watch
//
//  Created by Shubhro Saha on 1/30/14.
//  Copyright (c) 2014 Shubhro Saha. All rights reserved.
//

#import "CoinWatchViewController.h"
#import "CoinWatchAppDelegate.h"

@interface CoinWatchViewController ()
- (IBAction)pickOne:(id)sender;
- (IBAction)targetPriceBeginEditing:(id)sender;
- (IBAction)targetPriceEndEditing:(id)sender;
//@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UITextField *targetPrice;
@end

@implementation CoinWatchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CoinWatchAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.myViewController = self;
    
    _theWatch = [[Watch alloc] init];
    _theWatch.direction = @"greater than";
    _theWatch.triggered = false;
    
    _targetPrice.delegate = self;
    
    // load the current BitCoin price into the interface
    float price = [self fetchPrice];
    [_currentPrice performSelectorOnMainThread:@selector(setText : ) withObject:[NSString stringWithFormat:@"%.2F", price] waitUntilDone:YES];
    [_targetPrice performSelectorOnMainThread:@selector(setText : ) withObject:[NSString stringWithFormat:@"%.2F", price] waitUntilDone:YES];
    
}

- (float)fetchPrice {
    
    NSURL *url = [NSURL URLWithString:@"https://coinbase.com/api/v1/currencies/exchange_rates"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0];
    
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    return [[jsonDictionary objectForKey:@"btc_to_usd"] floatValue];
    
}

- (IBAction)pickOne:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSString *selectedValue = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    
    _theWatch.direction = selectedValue;
    _theWatch.triggered = false;
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 160; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (IBAction)targetPriceBeginEditing:(id)sender {
    UITextField *textField = (UITextField *)sender;
    [self animateTextField:textField up:YES];
}

- (IBAction)targetPriceEndEditing:(id)sender {
    UITextField *textField = (UITextField *)sender;
    [self animateTextField:textField up:NO];
    
    UITextField *targetPriceField = (UITextField *)sender;
    _theWatch.targetPrice = [targetPriceField.text floatValue];
    _theWatch.triggered = false;
}

/* 
    to hide the keyboard
 */
- (BOOL)textFieldShouldReturn:(UITextField *)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}

@end
