//
//  DealDetailCell.h
//  SocialTest
//
//  Created by Landen Zackery on 4/3/14.
//  Copyright (c) 2014 A Guy and A Computer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dealImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@end
