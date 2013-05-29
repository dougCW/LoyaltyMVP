//
//  CWAddPrinterViewController.m
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import "CWAddPrinterViewController.h"
#import "CWAppDelegate.h"
#import "CWPrinters.h"


@interface CWAddPrinterViewController ()
{
    NSMutableArray *brandArray;
}

@end

@implementation CWAddPrinterViewController
@synthesize myPrintersArray, myManagedObjectContext;

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

    //add the pickerview elements
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.opaque = NO;
    
    //add the picker to the textfield
    brandTextField.inputView = pickerView;
    
    //set up array
    brandArray = [[NSMutableArray alloc] initWithObjects:@"", @"Brother", @"Canon", @"Dell", @"Epson", @"HP", @"Kodak", @"Konica Minolta", @"Lexmark", @"Oki", @"Panasonic", @"Samsung", @"Sharp", @"Xerox", @"Other", nil];
   
    //set delegates
    modelTextField.delegate = self;
    nameTextField.delegate = self;
    
    //pass the context
    CWAppDelegate *appDelegate = (CWAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.myManagedObjectContext = [appDelegate managedObjectContext];
    
    //add cartirdgeworld blue color to buttons
    UIColor *cartBlue = [UIColor colorWithRed:50/255.0f green:75/255.0f blue:136/255.0f alpha:1];
    addPrinterBtn.backgroundColor = cartBlue;

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
    brandTextField.text = brandSelected;
    brandTextField.hidden = NO;
}
#pragma mark Actions

- (IBAction)addPrinterBtn:(UIButton *)sender
{
    NSManagedObjectContext *context = [self myManagedObjectContext];
    CWPrinters *printerToAdd = [NSEntityDescription
                                      insertNewObjectForEntityForName:@"CWPrinters"
                                      inManagedObjectContext:context];
    printerToAdd.name = nameTextField.text;
    printerToAdd.model = modelTextField.text;
    printerToAdd.brand = brandTextField.text;
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    //not needed anymore that we use core data
    //[self.delegate addPrinterToListPrinters:printerToAdd];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [modelTextField resignFirstResponder];
    [nameTextField resignFirstResponder];
    [brandTextField resignFirstResponder];
}

#pragma mark Textfield stuff

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
   // [nameTextField resignFirstResponder];
    return YES;
}
@end
