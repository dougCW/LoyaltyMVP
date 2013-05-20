//
//  CWWebViewController.m
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import "CWWebViewController.h"

@interface CWWebViewController ()
{
  
}

@end

@implementation CWWebViewController


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
    
    //add url
    NSString *mobileURL = @"http://m.cartridgeworld.com";
    NSURL *url = [NSURL URLWithString:mobileURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webViewOutlet loadRequest:urlRequest];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
