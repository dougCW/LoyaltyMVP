//
//  CWAddPrinterViewController.h
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

@class CWPrinters;
@protocol CWAddPrinterViewControllerDelegate <NSObject>

- (void)addPrinterToListPrinters:(CWPrinters *)printer;

@end

#import <UIKit/UIKit.h>
#import "CWPrinterListViewController.h"
#import "CWPrinters.h"

@interface CWAddPrinterViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>
{
    __weak IBOutlet UILabel *brandSelectedLabel;
    __weak IBOutlet UITextField *nameTextField;
    __weak IBOutlet UITextField *modelTextField;
}
- (IBAction)addPrinterBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) NSMutableArray *myPrintersArray;
@property (nonatomic, weak) id <CWAddPrinterViewControllerDelegate> delegate;


@end
