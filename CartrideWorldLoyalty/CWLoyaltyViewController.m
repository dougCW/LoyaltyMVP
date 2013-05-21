//
//  CWLoyaltyViewController.m
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import "CWLoyaltyViewController.h"

@interface CWLoyaltyViewController ()
{
    int scanNumber;
    UIImage *yellowImage;
    UIImage *greyImage;
}

@end

@implementation CWLoyaltyViewController

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
    
    //start scan number at zero
    scanNumber = 0;
    
    //set up logos
    [self checkLogos];
    
    //set up yellow/grey images
    yellowImage = [UIImage imageNamed:@"couponYello.jpg"];
    greyImage = [UIImage imageNamed:@"coupongrey.jpg"];
    
    couponImage.alpha = .8;
    couponImage.image = greyImage;

}

- (void) checkLogos
{
    //set up the ten logos
    logoImage1.alpha = (scanNumber >= 1) ? 1 : .4;
    logoImage2.alpha = (scanNumber >= 2) ? 1 : .4;
    logoImage3.alpha = (scanNumber >= 3) ? 1 : .4;
    logoImage4.alpha = (scanNumber >= 4) ? 1 : .4;
    logoImage5.alpha = (scanNumber >= 5) ? 1 : .4;
    logoImage6.alpha = (scanNumber >= 6) ? 1 : .4;
    logoImage7.alpha = (scanNumber >= 7) ? 1 : .4;
    logoImage8.alpha = (scanNumber >= 8) ? 1 : .4;
    logoImage9.alpha = (scanNumber >= 9) ? 1 : .4;
    logoImage10.alpha = (scanNumber >= 10) ? 1 : .4;
    
    couponImage.image = (scanNumber == 10) ? yellowImage : greyImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)punchBtn:(UIButton *)sender
{
    scanNumber++;
    [self checkLogos];
}

- (IBAction)infoBtn:(UIButton *)sender {
}
@end
