//
//  DealDetail.m
//  SocialTest
//
//  Created by Landen Zackery on 4/3/14.
//  Copyright (c) 2014 A Guy and A Computer. All rights reserved.
//

#import "DealDetail.h"

@implementation DealDetail

+ (DealDetail*)getDealFromDictionaryEntry:(NSDictionary *)entry
{
    DealDetail *returnDeal = [[DealDetail alloc]init];
    
    returnDeal.title = entry[@"attrib"];
    returnDeal.location = entry[@"desc"];
    returnDeal.urlString = entry[@"href"];
    returnDeal.userName = entry[@"user"][@"username"];
    
    UIImage *dealImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:entry[@"src"]]]];
    
    //have to get width and height from nib
    returnDeal.dealPic = [DealDetail convertImageToThumbnailwithWidth:105.0 andHeight:79.0 andImage:dealImage];
    
    UIImage *userImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:entry[@"user"][@"avatar"][@"src"]]]];
    
    //have to get width and height from nib
    returnDeal.userPic = [DealDetail convertImageToThumbnailwithWidth:40.0 andHeight:40.0 andImage:userImage];
    
    
    return returnDeal;
}

+(UIImage *)convertImageToThumbnailwithWidth:(double)width andHeight:(double)height andImage:(UIImage *)image
{
    CGSize originalSize = image.size;
    
    //the rectange of the thumbnail
    CGRect newRect = CGRectMake(0, 0, width, height);
    
    //figure out a scaling ratio to make sure we maintain the same aspect ratio
    float ratio = MAX(newRect.size.width / originalSize.width, newRect.size.height / originalSize.height);
    
    //create a transparent bitmap context with a scaling factor equal to that of the screen
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    //create a path that is a rounded rectange
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    
    //make all subsequent drawing clip to this rounded rectangle
    [path addClip];
    
    //center the image in the thumbnail rextangle
    CGRect projectRect;
    projectRect.size.width = ratio * originalSize.width;
    projectRect.size.height = ratio * originalSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
    
    //draw the image
    [image drawInRect:projectRect];
    
    //get image from the image context
    return UIGraphicsGetImageFromCurrentImageContext();
}

@end
