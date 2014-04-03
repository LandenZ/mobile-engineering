//
//  MasterViewController.h
//  SocialTest
//
//  Created by Landen Zackery on 4/3/14.
//  Copyright (c) 2014 A Guy and A Computer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealDetail.h"
#import "DealDetailCell.h"

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) UIView *loadingView;

//gets the json feed from the address listed in spec,
//**** address is hard coded here, if changes are made to address
//of web services change here
- (void)fetchFeed;

//convert the NSDictionary that is returned from the json webservice
//to a more workable NSArray of DealDetail Objects. So this method
//both converts each entry to a DealDetail item and adds it to
//private NSArray used for the table and detail views
- (void)convertFeedToDealDetails:(NSDictionary *)jsonDictionary;
@end
