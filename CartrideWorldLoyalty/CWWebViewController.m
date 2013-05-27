//
//  CWWebViewController.m
//  CartrideWorldLoyalty
//
//  Created by Nathan Levine on 5/17/13.
//  Copyright (c) 2013 BankBox. All rights reserved.
//

#import "CWWebViewController.h"

@interface CWWebViewController ()
{
  
}

@end

@implementation CWWebViewController


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
    
    //set up greyed out version of webpage
    backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CWWebPage.png"]];
    backgroundView.alpha = .3f;

    
    //set up webview delegate
    webViewOutlet.delegate = self;
    
    //add url
    NSString *mobileURL = @"http://m.cartridgeworld.com";
    NSURL *url = [NSURL URLWithString:mobileURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webViewOutlet loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Webview methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //start indicator in background
    [activityIndicator startAnimating];
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //start indicator in background
    [activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //stop/hide indicator in background
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;
    
    //bring webview to front
    [self.view bringSubviewToFront:webViewOutlet];
    [self.view bringSubviewToFront:backButtonOutlet];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //stop/hide indicator in background
    [activityIndicator stopAnimating];
    activityIndicator.hidden = YES;

    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to load webpage"
                                                    message:@"try again after connecting wi-fi"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}
@end
