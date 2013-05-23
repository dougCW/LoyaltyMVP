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
#import "CWAppDelegate.h"

@interface CWPrinterListViewController ()
{
    NSArray *myPrinterArray;
    CWAddPrinterViewController *vc;
}

@end

@implementation CWPrinterListViewController
@synthesize managedObjectContext;

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
    
    //pass the context
    CWAppDelegate *appDelegate = (CWAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    //add saved data to array
    myPrinterArray = [self getSavedPrinters];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //update our tableview array of data to reflect the new change
    myPrinterArray = [self getSavedPrinters];
    
    //reload tableview
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
//CRUDS IS BELOW
//
#pragma mark Core Data (CRUDS)
//SAVE!!!
-(void)saveData
{
    NSError *error;
    if (![managedObjectContext save:&error])
    {
        NSLog(@"failed to save error: %@", [error userInfo]);
    }
}

//DELETE!!!
-(void)deletePrinter: (CWPrinters*)printer
{
    [self.managedObjectContext deleteObject:printer];
    
    [self saveData];
}

-(NSArray *) getSavedPrinters
{
    //setting up the fetch
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"CWPrinters"
                                                         inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSFetchedResultsController *fetchResultsController;
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects: nil];
    NSError *sadnessError;
    
    //actually setting up the fetch
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setEntity:entityDescription];
    fetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                 managedObjectContext:managedObjectContext
                                                                   sectionNameKeyPath:nil
                                                                            cacheName:nil];
    [fetchResultsController performFetch:&sadnessError];
    
    return fetchResultsController.fetchedObjects;
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
    modelLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:10];
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
        //get the object that will be deleted
        CWPrinters *printer = [myPrinterArray objectAtIndex:[indexPath row]];
        
        //delete it from the database
        [self deletePrinter:printer];
        
        //update our tableview array of data to reflect the new change
        myPrinterArray = [self getSavedPrinters];
        
        //remove the cell from view
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //reload tableview
        [tableView reloadData];
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
/* NOT NEEDED ANYMORE (no more delegate)
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
    //create/save new printer
    //[self createPrinterWithData:printer];

    //update our tableview array of data to reflect the new change
    myPrinterArray = [self getSavedPrinters];
    
    //reload tableview
    [self.tableView reloadData];
}
*/
@end
