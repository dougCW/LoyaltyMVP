//
//  CWLoyaltyViewController.m
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import "CWLoyaltyViewController.h"

@interface CWLoyaltyViewController ()
{
    int scanNumber;
    UIImage *yellowImage;
    UIImage *greyImage;
}

@end

@implementation CWLoyaltyViewController

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
    
    //start scan number at zero
    scanNumber = 0;
    
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
    scanNumber++;
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

#pragma mark Info Btn

- (IBAction)infoBtn:(UIButton *)sender
{
    //sends to info vc
}

- (IBAction)couponBtn:(UIButton *)sender {
}
@end
