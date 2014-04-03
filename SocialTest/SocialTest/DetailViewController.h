//
//  DetailViewController.h
//  SocialTest
//
//  Created by Landen Zackery on 4/3/14.
//  Copyright (c) 2014 A Guy and A Computer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealDetail.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
