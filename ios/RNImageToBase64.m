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

RCT_EXPORT_METHOD(getBase64String:(NSString *)input resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    @try {
        NSURL *url = [NSURL fileURLWithPath:input];
        NSError *err = nil;
        NSData *imageData = [NSData dataWithContentsOfURL:url options: NSDataReadingUncached error: &err];
        if (err != nil) {
            return reject(@"ENOENT", [NSString stringWithFormat:@"No such file '%@'", input], nil);
        }
        UIImage *image = [UIImage imageWithData: imageData];
        UIImage *portraitImage = [image normalizedImage];
        NSData *imgData = UIImageJPEGRepresentation(portraitImage, 1.0);
        NSString *base64 = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        return resolve(base64);
    }
    @catch (NSException *e) {
        NSLog(@"%@", e.reason);
        return reject(@"EUNSPECIFIED", [e reason], nil);
    }
}

@end
