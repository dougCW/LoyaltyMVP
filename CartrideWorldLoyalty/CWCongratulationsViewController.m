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
