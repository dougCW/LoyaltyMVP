//
//  CWPrinterListViewController.h
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWPrinterListViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
        __weak IBOutlet UIBarButtonItem *addButton;
}

@end
