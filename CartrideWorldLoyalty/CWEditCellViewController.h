//
//  CWEditCellViewController.h
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 6/1/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWPrinterListViewController.h"

@interface CWEditCellViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>
{
    
    __weak IBOutlet UIButton *addPrinterBtn;
    __weak IBOutlet UITextField *notesTextField;
    __weak IBOutlet UITextField *modelTextField;
    __weak IBOutlet UITextField *brandTextField;
}
- (IBAction)addPrinterBtn:(id)sender;

@property (nonatomic,strong) NSManagedObjectContext* myManagedObjectContext;
@property (nonatomic) int printerIndex;


@end
