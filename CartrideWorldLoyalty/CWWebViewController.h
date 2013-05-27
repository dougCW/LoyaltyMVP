//
//  CWWebViewController.h
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWHomeScreenViewController.h"


@interface CWWebViewController : UIViewController <UIWebViewDelegate>
{
    __weak IBOutlet UIView *backgroundView;
    __weak IBOutlet UIActivityIndicatorView *activityIndicator;
        __weak IBOutlet UIWebView *webViewOutlet;
    __weak IBOutlet UIButton *backButtonOutlet;
}
- (IBAction)backBtn:(UIButton *)sender;


@end
