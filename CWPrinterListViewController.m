//
//  CWPrinterListViewController.m
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import "CWPrinterListViewController.h"
#import "CWPrinters.h"
#import "CWAddPrinterViewController.h"

@interface CWPrinterListViewController ()
{
    NSMutableArray *myPrinterArray;
    CWAddPrinterViewController *vc;
}

@end

@implementation CWPrinterListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //add array for data
    myPrinterArray = [[NSMutableArray alloc] init];
    //add dummy data to array
    CWPrinters *testPrinter1 = [[CWPrinters alloc]init];
    testPrinter1.model = @"test Model";
    testPrinter1.brand = @"brand";
    testPrinter1.name = @"printer 1";
    CWPrinters *testPrinter2 = [[CWPrinters alloc]init];
    testPrinter2.model = @"test Model2";
    testPrinter2.brand = @"brand2";
    testPrinter2.name = @"printer 2";
    [myPrinterArray addObject:testPrinter1];
    [myPrinterArray addObject:testPrinter2];
    
    //instntiate the delegators vc
    CWAddPrinterViewController *addPrintersVC = [[CWAddPrinterViewController alloc]init];
    addPrintersVC.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return myPrinterArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    //get the printer for the row
    CWPrinters *cellPrinter = [myPrinterArray objectAtIndex:indexPath.row];
    
    //Populate all cells with data
    UIView *viewForBrandLabel = [cell viewWithTag:100];
    UILabel *brandLabel = (UILabel *) viewForBrandLabel;
    brandLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:12];
    brandLabel.text = cellPrinter.name;
    
    UIView *viewForModelLabel = [cell viewWithTag:101];
    UILabel *modelLabel = (UILabel *)viewForModelLabel;
    modelLabel.text = [NSString stringWithFormat:@"%@, %@", cellPrinter.brand, cellPrinter.model];

    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [myPrinterArray removeObjectAtIndex:indexPath.row];

        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Segue stuff

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ListToAdd"])
    {
        vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

#pragma mark delegate action

- (void) addPrinterToListPrinters:(CWPrinters *)printer
{
    [myPrinterArray addObject:printer];
    [self.tableView reloadData];
}

@end
