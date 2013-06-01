//
//  CWEditCellViewController.m
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 6/1/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import "CWEditCellViewController.h"
#import "CWAppDelegate.h"
#import "CWPrinters.h"
#import <QuartzCore/QuartzCore.h>

@interface CWEditCellViewController ()
{
    NSMutableArray *brandArray;
    NSMutableArray *printersSavedArray;
    CWPrinters *printerToEdit;
}

@end

@implementation CWEditCellViewController
@synthesize printerIndex;

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
    notesTextField.delegate = self;
    
    //pass the context
    CWAppDelegate *appDelegate = (CWAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.myManagedObjectContext = [appDelegate managedObjectContext];
    
    //add cartirdgeworld blue color to buttons
    UIColor *cartBlue = [UIColor colorWithRed:50/255.0f green:75/255.0f blue:136/255.0f alpha:1];
    addPrinterBtn.backgroundColor = cartBlue;
    
    //set up rounded corners on btn
    [addPrinterBtn.layer setCornerRadius:8.0f];
    [addPrinterBtn.layer setMasksToBounds:YES];
    
    //get printer to edit
    printerToEdit = [self getPrinterToEdit];
    modelTextField.text = printerToEdit.model;
    brandTextField.text = printerToEdit.brand;
    notesTextField.text = printerToEdit.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Actions
- (IBAction)addPrinterBtn:(id)sender
{
    NSManagedObjectContext *context = [self myManagedObjectContext];

    // Update existing device
    [printerToEdit setValue:notesTextField.text forKey:@"name"];
    [printerToEdit setValue:modelTextField.text forKey:@"model"];
    [printerToEdit setValue:brandTextField.text forKey:@"brand"];
    
    //save it
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    //go back to list
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [modelTextField resignFirstResponder];
    [notesTextField resignFirstResponder];
    [brandTextField resignFirstResponder];
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

#pragma mark Textfield stuff

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    // [nameTextField resignFirstResponder];
    return YES;
}

#pragma mark Fetch
-(CWPrinters *) getPrinterToEdit
{
    //setting up the fetch
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"CWPrinters"
                                                         inManagedObjectContext:self.myManagedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSFetchedResultsController *fetchResultsController;
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: nil];
    NSError *sadnessError;
    
    //actually setting up the fetch
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setEntity:entityDescription];
    fetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                 managedObjectContext:self.myManagedObjectContext
                                                                   sectionNameKeyPath:nil
                                                                            cacheName:nil];
    [fetchResultsController performFetch:&sadnessError];
    
    return [fetchResultsController.fetchedObjects objectAtIndex:printerIndex];
}


@end
