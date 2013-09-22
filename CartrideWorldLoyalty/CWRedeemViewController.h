//
//  CWRedeemViewController.h
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/24/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Punches.h"


@interface CWRedeemViewController : UIViewController <UITextFieldDelegate>
{
    __weak IBOutlet UIButton *redeemPrinterBtn;
    __weak IBOutlet UITextField *codeTextField;
    Punches *punchesSaved;
    int punchesBeforeRedeem;
}
- (IBAction)redeemBtn:(UIButton *)sender;

@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;


@end
