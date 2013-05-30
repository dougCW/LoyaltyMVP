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
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>

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
    couponImage.image = greyImage;
    
    //hide coupon btn
    couponBtn.hidden = YES;
    
    //set up logos
    [self checkLogos];
    
    //notification check
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(makeCounterZero:) name:@"redeemCoupon"
                                               object:nil];
    //set up rounded corners on btn
    [punchBtn.layer setCornerRadius:8.0f];
    [punchBtn.layer setMasksToBounds:YES];
}

- (void) checkLogos
{
    
    if (scanNumber <= 10)
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
    } else if (scanNumber > 10 && scanNumber  < 21) {
        logoImage1.alpha = (scanNumber - 10 >= 1) ? 1 : .4;
        logoImage2.alpha = (scanNumber - 10 >= 2) ? 1 : .4;
        logoImage3.alpha = (scanNumber - 10 >= 3) ? 1 : .4;
        logoImage4.alpha = (scanNumber - 10 >= 4) ? 1 : .4;
        logoImage5.alpha = (scanNumber - 10 >= 5) ? 1 : .4;
        logoImage6.alpha = (scanNumber - 10 >= 6) ? 1 : .4;
        logoImage7.alpha = (scanNumber - 10 >= 7) ? 1 : .4;
        logoImage8.alpha = (scanNumber - 10 >= 8) ? 1 : .4;
        logoImage9.alpha = (scanNumber - 10 >= 9) ? 1 : .4;
        logoImage10.alpha = (scanNumber - 10 >= 10) ? 1 : .4;
    } else if (scanNumber > 20 && scanNumber  < 31) {
        logoImage1.alpha = (scanNumber - 20 >= 1) ? 1 : .4;
        logoImage2.alpha = (scanNumber - 20 >= 2) ? 1 : .4;
        logoImage3.alpha = (scanNumber - 20 >= 3) ? 1 : .4;
        logoImage4.alpha = (scanNumber - 20 >= 4) ? 1 : .4;
        logoImage5.alpha = (scanNumber - 20 >= 5) ? 1 : .4;
        logoImage6.alpha = (scanNumber - 20 >= 6) ? 1 : .4;
        logoImage7.alpha = (scanNumber - 20 >= 7) ? 1 : .4;
        logoImage8.alpha = (scanNumber - 20 >= 8) ? 1 : .4;
        logoImage9.alpha = (scanNumber - 20 >= 9) ? 1 : .4;
        logoImage10.alpha = (scanNumber - 20 >= 10) ? 1 : .4;
    } else if (scanNumber > 30 && scanNumber  < 41) {
        logoImage1.alpha = (scanNumber - 30 >= 1) ? 1 : .4;
        logoImage2.alpha = (scanNumber - 30 >= 2) ? 1 : .4;
        logoImage3.alpha = (scanNumber - 30 >= 3) ? 1 : .4;
        logoImage4.alpha = (scanNumber - 30 >= 4) ? 1 : .4;
        logoImage5.alpha = (scanNumber - 30 >= 5) ? 1 : .4;
        logoImage6.alpha = (scanNumber - 30 >= 6) ? 1 : .4;
        logoImage7.alpha = (scanNumber - 30 >= 7) ? 1 : .4;
        logoImage8.alpha = (scanNumber - 30 >= 8) ? 1 : .4;
        logoImage9.alpha = (scanNumber - 30 >= 9) ? 1 : .4;
        logoImage10.alpha = (scanNumber - 30 >= 10) ? 1 : .4;
    }else if (scanNumber > 40 && scanNumber  < 51) {
        logoImage1.alpha = (scanNumber - 40 >= 1) ? 1 : .4;
        logoImage2.alpha = (scanNumber - 40 >= 2) ? 1 : .4;
        logoImage3.alpha = (scanNumber - 40 >= 3) ? 1 : .4;
        logoImage4.alpha = (scanNumber - 40 >= 4) ? 1 : .4;
        logoImage5.alpha = (scanNumber - 40 >= 5) ? 1 : .4;
        logoImage6.alpha = (scanNumber - 40 >= 6) ? 1 : .4;
        logoImage7.alpha = (scanNumber - 40 >= 7) ? 1 : .4;
        logoImage8.alpha = (scanNumber - 40 >= 8) ? 1 : .4;
        logoImage9.alpha = (scanNumber - 40 >= 9) ? 1 : .4;
        logoImage10.alpha = (scanNumber - 40 >= 10) ? 1 : .4;
    }

    //change coupon image to yellow one if ten scans
    couponImage.image = (scanNumber >= 10) ? yellowImage : greyImage;    
    //unhide button if ten scans
    couponBtn.hidden = (scanNumber >= 10) ? NO : YES;
    
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
    //rectangle
    reader.tracksSymbols = YES;
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

    //check if qr code matches and change scannumber accordingly
    scanNumber = ([result isEqualToString:@"1 cartridge bought!"]) ? scanNumber + 1 :scanNumber;
    scanNumber = ([result isEqualToString:@"2 cartridge bought!"]) ? scanNumber + 2 :scanNumber;
    scanNumber = ([result isEqualToString:@"3 cartridge bought!"]) ? scanNumber + 3 :scanNumber;
    scanNumber = ([result isEqualToString:@"4 cartridge bought!"]) ? scanNumber + 4 :scanNumber;
    scanNumber = ([result isEqualToString:@"5 cartridge bought!"]) ? scanNumber + 5 :scanNumber;
    scanNumber = ([result isEqualToString:@"6 cartridge bought!"]) ? scanNumber + 6 :scanNumber;
    scanNumber = ([result isEqualToString:@"7 cartridge bought!"]) ? scanNumber + 7 :scanNumber;
    scanNumber = ([result isEqualToString:@"8 cartridge bought!"]) ? scanNumber + 8 :scanNumber;
    scanNumber = ([result isEqualToString:@"9 cartridge bought!"]) ? scanNumber + 9 :scanNumber;
    scanNumber = ([result isEqualToString:@"10 cartridge bought!"]) ? scanNumber + 10 :scanNumber;
    BOOL validQR;
    validQR = NO;
    for (int i = 1; i <= 10; i++)
    {
        NSString *alertString = [NSString stringWithFormat:@"%i cartridge bought!", i];
        if ([result isEqualToString: alertString])
        {
            validQR = YES;
        }
    }
    if (validQR == NO)
    {
        //play sound
        NSString *effectTitle = @"buzzer";
        SystemSoundID soundID;
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:effectTitle ofType:@"mp3"];
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
        
        AudioServicesCreateSystemSoundID ((CFURLRef)CFBridgingRetain(soundURL), &soundID);
        AudioServicesPlaySystemSound(soundID);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid QR Code" message:@"sorry try again" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    } else if (validQR == YES) {
        //play sound
        NSString *effectTitle = @"holePunch";
        SystemSoundID soundID;
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:effectTitle ofType:@"mp3"];
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
        
        AudioServicesCreateSystemSoundID ((CFURLRef)CFBridgingRetain(soundURL), &soundID);
        AudioServicesPlaySystemSound(soundID);
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
    scanNumber = scanNumber - 10;
    //check logos and stuff
    [self checkLogos];
    [self updatePunches:punchSaved withInt:scanNumber];
}

@end
