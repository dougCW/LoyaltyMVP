//
//  CWCongratulationsViewController.m
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/29/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import "CWCongratulationsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CWCongratulationsViewController ()

@end

@implementation CWCongratulationsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    //center
    int navbarHeight;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0)) {
        // Retina display
        navbarHeight = 88;
    } else {
        // non-Retina display
        navbarHeight = 44;
    }
    viewWithElements.center = CGPointMake(self.view.bounds.size.width/2, (self.view.bounds.size.height - navbarHeight)/2);
    
    //set up rounded corners on btn
    [redeemBtn.layer setCornerRadius:8.0f];
    [redeemBtn.layer setMasksToBounds:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
