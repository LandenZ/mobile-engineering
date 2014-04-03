//
//  DetailViewController.m
//  SocialTest
//
//  Created by Landen Zackery on 4/3/14.
//  Copyright (c) 2014 A Guy and A Computer. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.webView.scalesPageToFit = YES;
        NSURL *url = [NSURL URLWithString:((DealDetail *)self.detailItem).urlString];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:req];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
