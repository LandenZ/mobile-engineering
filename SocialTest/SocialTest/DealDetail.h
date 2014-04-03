//
//  DealDetail.h
//  SocialTest
//
//  Created by Landen Zackery on 4/3/14.
//  Copyright (c) 2014 A Guy and A Computer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealDetail : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, strong) UIImage *dealPic;
@property (nonatomic, strong) UIImage *userPic;

//converts a single NSDictionary entry to a DealDetail object and returns it
+ (DealDetail *)getDealFromDictionaryEntry:(NSDictionary *)entry;

//takes the original images that come from the webservice and converts there size
//to the thumbnail size of UIImageView on the custom uitableview cell where they
//will be displayed.  This conversion is less complex than just letting ios convert
//the image size by default and preserves the aspect ratio.
+ (UIImage *)convertImageToThumbnailwithWidth:(double)width andHeight:(double)height andImage:(UIImage *)image;

@end
