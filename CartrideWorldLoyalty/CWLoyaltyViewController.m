//
//  CWLoyaltyViewController.m
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import "CWLoyaltyViewController.h"
#import "CWAppDelegate.h"
#import "Punches.h"

@interface CWLoyaltyViewController ()
{
    int scanNumber;
    UIImage *yellowImage;
    UIImage *greyImage;
    Punches *punchSaved;
}

@end

@implementation CWLoyaltyViewController
@synthesize managedObjectContext;

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
    
    //pass the context
    CWAppDelegate *appDelegate = (CWAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    
    //get numbr of punches
    scanNumber = [self getNumberOfPunches];
    NSLog(@"punches:%i", scanNumber);
    
    //set up logos
    [self checkLogos];
    
    //set up yellow/grey images
    yellowImage = [UIImage imageNamed:@"couponYello.jpg"];
    greyImage = [UIImage imageNamed:@"coupongrey.jpg"];
    couponImage.alpha = .8;
    couponImage.image = greyImage;
    
    //hide coupon btn
    couponBtn.hidden = YES;
}

- (void) checkLogos
{
    //set up the ten logos
    logoImage1.alpha = (scanNumber >= 1) ? 1 : .4;
    logoImage2.alpha = (scanNumber >= 2) ? 1 : .4;
    logoImage3.alpha = (scanNumber >= 3) ? 1 : .4;
    logoImage4.alpha = (scanNumber >= 4) ? 1 : .4;
    logoImage5.alpha = (scanNumber >= 5) ? 1 : .4;
    logoImage6.alpha = (scanNumber >= 6) ? 1 : .4;
    logoImage7.alpha = (scanNumber >= 7) ? 1 : .4;
    logoImage8.alpha = (scanNumber >= 8) ? 1 : .4;
    logoImage9.alpha = (scanNumber >= 9) ? 1 : .4;
    logoImage10.alpha = (scanNumber >= 10) ? 1 : .4;
    
    //change coupon image to yellow one if ten scans
    couponImage.image = (scanNumber == 10) ? yellowImage : greyImage;
    couponImage.alpha = 1.f;
    
    //unhide button if ten scans
    couponBtn.hidden = (scanNumber == 10) ? NO : YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark QR SCAN

- (IBAction)punchBtn:(UIButton *)sender
{
    //update number of punches
    scanNumber++;
    NSLog(@"punches:%i", scanNumber);
    [self updatePunches:punchSaved withInt:scanNumber];
    
    [self checkLogos];
    
    //zbar stuff
    //Create the reader.
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    //Setup a delegate to receive the results
    reader.readerDelegate = self;
    //Configure the reader.
    [reader.scanner setSymbology: ZBAR_QRCODE
                          config: ZBAR_CFG_ENABLE
                              to: 0];
    reader.readerView.zoom = 1;
    //add overlay
    reader.cameraOverlayView.backgroundColor = [UIColor redColor];
    //Present the reader to the user
    [self presentViewController:reader animated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    //Process the results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    NSLog(@"results are: %@", results);
    //UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    //Dismiss the reader
    [self dismissViewControllerAnimated:YES completion:NO];
}

- (void) readerControllerDidFailToRead:(ZBarReaderController *)reader withRetry:(BOOL)retry
{
    NSLog(@"epic fail");
}

#pragma mark Actions

- (IBAction)infoBtn:(UIButton *)sender
{
    //sends to info vc
}

- (IBAction)couponBtn:(UIButton *)sender
{
    //sends to redeem vc
}


#pragma mark Core Data
//SAVE!!!
-(void)saveData
{
    NSError *error;
    if (![managedObjectContext save:&error])
    {
        NSLog(@"failed to save error: %@", [error userInfo]);
    }
}

//create punchesNumber
-(Punches *) createPunchWithInt: (int)integer
{
    Punches *punchToCreate = [NSEntityDescription insertNewObjectForEntityForName:@"Punches" inManagedObjectContext:managedObjectContext];
    
    punchToCreate.punchNumber = [NSNumber numberWithInt:integer];
    
    [self saveData];
    return punchToCreate;
}

//UPDATE!!!
-(void)updatePunches:(Punches *)punch withInt: (int)newNumberOfPunches
{
    [punch setPunchNumber:[NSNumber numberWithInt:newNumberOfPunches]];

    [self saveData];
}


-(int) getNumberOfPunches
{
    //setting up the fetch
    NSError *error;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Punches"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    //if no number has been saved start one at zero otherwise grab the number of punches
    if (fetchedObjects.count == 0)
    {
        punchSaved =[self createPunchWithInt:0];
    } else {
        punchSaved = [fetchedObjects objectAtIndex:0];
    }
    int numberOfPunches = [punchSaved.punchNumber intValue];
    
    return numberOfPunches;
}

@end
