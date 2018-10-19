//
//  UIImage+Orientation.m
//  RNImageToBase64
//
//  Created by Selma on 19/10/2018.
//  Copyright © 2018 xfumihiro. All rights reserved.
//

#import "RNImageToBase64.h"
#import "UIImage+Orientation.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@implementation RNImageToBase64

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(getBase64String:(NSString *)input callback:(RCTResponseSenderBlock)callback)
{
    @try {
        NSURL *url = [NSURL fileURLWithPath:input];
        NSError *err = nil;
        NSData *imageData = [NSData dataWithContentsOfURL:url options: NSDataReadingUncached error: &err];
        if (err != nil) {
            callback(@[@"Not found image"]);
            return;
        }
        UIImage *image = [UIImage imageWithData: imageData];
        UIImage *portraitImage = [image normalizedImage];
        NSData *imgData = UIImageJPEGRepresentation(portraitImage, 1.0);
        NSString *base64 = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        callback(@[[NSNull null], base64]);
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        callback(@[exception.reason]);
    }
}

@end
