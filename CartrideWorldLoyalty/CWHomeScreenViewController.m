//
//  CWHomeScreenViewController.m
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import "CWHomeScreenViewController.h"

@interface CWHomeScreenViewController ()

@end

@implementation CWHomeScreenViewController

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
    
    
    //change navbar button colors
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:.8 green:.7 blue:.5 alpha:.3]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)freqFillerCardBtn:(UIButton *)sender {
}

- (IBAction)myPrintersBtn:(UIButton *)sender {
}

- (IBAction)websiteBtn:(UIButton *)sender {
}
@end
