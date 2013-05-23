//
//  CWPrinters.h
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/23/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CWPrinters : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * brand;

@end
