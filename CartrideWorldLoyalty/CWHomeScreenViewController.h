//
//  CWHomeScreenViewController.h
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWHomeScreenViewController : UIViewController
{
    __weak IBOutlet UIView *viewWithBtns;
    __weak IBOutlet UIButton *freqFillerBtn;
    __weak IBOutlet UIButton *myPrintersBtn;
    __weak IBOutlet UIButton *websiteBtn;
}
- (IBAction)freqFillerCardBtn:(UIButton *)sender;
- (IBAction)myPrintersBtn:(UIButton *)sender;
- (IBAction)websiteBtn:(UIButton *)sender;

@end
