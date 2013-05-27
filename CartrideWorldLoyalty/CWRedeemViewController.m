//
//  CWRedeemViewController.m
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/24/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import "CWRedeemViewController.h"
#import "CWLoyaltyViewController.h"

@interface CWRedeemViewController ()

@end

@implementation CWRedeemViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Textfield stuff
// Use this code to dismiss a Number Pad when the user touches the background
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [codeTextField resignFirstResponder];
}

//allow only 5 numbers to be typed - NOT HITTING!!!!
-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.text.length >= 5 && range.length == 0)
    {
        return NO;
    }
    return YES;
}

#pragma mark Actions
- (IBAction)redeemBtn:(UIButton *)sender
{
    if ([codeTextField.text isEqualToString:@"1234"])
    {
        //post notification to guess counter in VC to change coupon stuff
        [[NSNotificationCenter defaultCenter] postNotificationName:@"redeemCoupon"
                                                            object:nil];
        //go back to coupon vc
        NSArray *array = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong code"
                                                        message:@"try again"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}
@end
