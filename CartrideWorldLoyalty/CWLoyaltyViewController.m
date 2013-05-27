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

    //set up yellow/grey images
    yellowImage = [UIImage imageNamed:@"couponYello.jpg"];
    greyImage = [UIImage imageNamed:@"coupongrey.jpg"];
    couponImage.alpha = .8;
    couponImage.image = greyImage;
    
    //hide coupon btn
    couponBtn.hidden = YES;
    
    //TESTING PURPOSES ONLY MAKE SURE TO CHANGE
    //
    //scanNumber = 7;
    //
    //
    //CHANGE CHANGW CHANGE/
    
    //set up logos
    [self checkLogos];
    
    //notification check
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(makeCounterZero:) name:@"redeemCoupon"
                                               object:nil];
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
    //zbar stuff
    //Create the reader.
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    //Setup a delegate to receive the results
    reader.readerDelegate = self;
    //turn off flash
    reader.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    //support only portrait orientations...
    reader.supportedOrientationsMask = ZBarOrientationMask(UIInterfaceOrientationPortrait);
    //dont support video
    reader.enableCache = NO;
    //set up scanner
    ZBarImageScanner *scanner = reader.scanner;
    //Configure the reader.
    [scanner setSymbology: ZBAR_QRCODE
                   config: ZBAR_CFG_ENABLE
                       to: 1];
    reader.readerView.zoom = 1;
    //add overlay
    reader.cameraOverlayView.backgroundColor = [UIColor redColor];
    reader.scanCrop = CGRectMake(0, 0, 1, 1);
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
    //process the results
    ZBarSymbol *symbol = nil;
    NSString *result;
    for(symbol in results)
    {
        result = symbol.data;
        break;
    }
    if ([result isEqualToString:@"cartridge bought!"])
    {
        //add all the punches stuff.
        //update number of punches
        scanNumber++;
        NSLog(@"punches:%i", scanNumber);
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid QR Code" message:@"sorry try again" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }

    //Dismiss the reader
    [self dismissViewControllerAnimated:YES completion:NO];
    //add punch
    [self checkLogos];
    [self updatePunches:punchSaved withInt:scanNumber];
}

- (void) readerControllerDidFailToRead:(ZBarReaderController *)reader withRetry:(BOOL)retry
{
    NSLog(@"epic fail");
}

#pragma mark Other Actions

- (IBAction)infoBtn:(UIButton *)sender
{
    //sends to info vc
}

- (IBAction)couponBtn:(UIButton *)sender
{
    //sends to redeem vc
}

#pragma mark Core Data
//Save
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

#pragma mark NSNotification
-(void)makeCounterZero:(NSNotification *)notification
{
    scanNumber = 0;
    //check logos and stuff
    [self checkLogos];
}

@end
