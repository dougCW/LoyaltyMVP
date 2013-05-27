//
//  CWAddPrinterViewController.h
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//
/* no longer needed with CoreData
@class CWPrinters;
@protocol CWAddPrinterViewControllerDelegate <NSObject>

- (void)addPrinterToListPrinters:(CWPrinters *)printer;

@end
*/
#import <UIKit/UIKit.h>
#import "CWPrinterListViewController.h"

@interface CWAddPrinterViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>
{
    __weak IBOutlet UIButton *addPrinterBtn;
    __weak IBOutlet UITextField *nameTextField;
    __weak IBOutlet UITextField *brandTextField;
    __weak IBOutlet UITextField *modelTextField;
}
- (IBAction)addPrinterBtn:(UIButton *)sender;
@property (strong, nonatomic) NSMutableArray *myPrintersArray;
//@property (nonatomic, weak) id <CWAddPrinterViewControllerDelegate> delegate;
@property (nonatomic,strong) NSManagedObjectContext* myManagedObjectContext;



@end
