//
//  CWLoyaltyViewController.h
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface CWLoyaltyViewController : UIViewController <ZBarReaderDelegate>
{
    __weak IBOutlet UIView *viewToHideCpnBtn;
    IBOutlet UIView *couponButton;
    __weak IBOutlet UIView *viewWithElements;
    __weak IBOutlet UILabel *viewThirdLabel;
    __weak IBOutlet UILabel *viewSecondLabel;
    __weak IBOutlet UILabel *viewTopLabel;
    __weak IBOutlet UIButton *punchBtn;
    __weak IBOutlet UIButton *couponBtn;
    __weak IBOutlet UIImageView *logoImage1;
    __weak IBOutlet UIImageView *logoImage2;
    __weak IBOutlet UIImageView *logoImage3;
    __weak IBOutlet UIImageView *logoImage4;
    __weak IBOutlet UIImageView *logoImage5;
    __weak IBOutlet UIImageView *logoImage6;
    __weak IBOutlet UIImageView *logoImage7;
    __weak IBOutlet UIImageView *logoImage8;
    __weak IBOutlet UIImageView *logoImage9;
    __weak IBOutlet UIImageView *logoImage10;
}
- (IBAction)punchBtn:(UIButton *)sender;
- (IBAction)infoBtn:(UIButton *)sender;

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;


@end
