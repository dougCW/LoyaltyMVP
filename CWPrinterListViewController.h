//
//  CWPrinterListViewController.h
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWAddPrinterViewController.h"

/*CWAddPrinterViewControllerDelegate  <--taken out of delegates before*/

@interface CWPrinterListViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
        __weak IBOutlet UIBarButtonItem *addButton;
}

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;


@end
