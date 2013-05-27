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
    //[[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:.8 green:.7 blue:.5 alpha:.3]];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:.8 green:.7 blue:.5 alpha:.02]];

    
    //add cartirdgeworld blue color to buttons
    UIColor *cartBlue = [UIColor colorWithRed:50/255.0f green:75/255.0f blue:136/255.0f alpha:1];
    freqFillerBtn.backgroundColor = cartBlue;
    myPrintersBtn.backgroundColor = cartBlue;
    websitebtn.backgroundColor = cartBlue;
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
