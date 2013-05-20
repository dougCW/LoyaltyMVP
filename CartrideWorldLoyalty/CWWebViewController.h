//
//  CWWebViewController.h
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWHomeScreenViewController.h"


@interface CWWebViewController : UIViewController
{
        __weak IBOutlet UIWebView *webViewOutlet;
}
- (IBAction)backBtn:(UIButton *)sender;


@end
