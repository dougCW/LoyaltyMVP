//
//  CWAddPrinterViewController.m
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import "CWAddPrinterViewController.h"

@interface CWAddPrinterViewController ()
{
    NSMutableArray *brandArray;
}

@end

@implementation CWAddPrinterViewController
@synthesize pickerView, myPrintersArray, delegate;

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
    
    //hide labels
    brandSelectedLabel.hidden = YES;
    
    //add the pickerview elements
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.opaque = NO;
    
    //set up array
    brandArray = [[NSMutableArray alloc] initWithObjects:@"Brother", @"Canon", @"Dell", @"Epson", @"HP", @"Kodak", @"Konica Minolta", @"Lexmark", @"Oki", @"Panasonic", @"Samsung", @"Sharp", @"Xerox", @"Other", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Picker Elements
//return 1 column
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//return amount of items in array
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return brandArray.count;
}

//put items in the right place
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [brandArray objectAtIndex:row];
}

//user selects row
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *brandSelected = [brandArray objectAtIndex:row];
    
    //unhide label and set to text
    brandSelectedLabel.text = brandSelected;
    brandSelectedLabel.hidden = NO;
    
}
#pragma mark Actions

- (IBAction)addPrinterBtn:(UIButton *)sender
{
    CWPrinters *printerToAdd = [[CWPrinters alloc] init];
    printerToAdd.name = nameTextField.text;
    printerToAdd.model = modelTextField.text;
    printerToAdd.brand = brandSelectedLabel.text;    
    [self.delegate addPrinterToListPrinters:printerToAdd];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [modelTextField resignFirstResponder];
    [nameTextField resignFirstResponder];
}
@end
