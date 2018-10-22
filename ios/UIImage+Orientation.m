//
//  UIImage+Orientation.m
//  RNImageToBase64
//
//  Created by Selma on 19/10/2018.
//  Copyright © 2018 xfumihiro. All rights reserved.
//

#import "UIImage+Orientation.h"

@implementation UIImage (Orientation)

- (UIImage *)normalizedImage {
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:(CGRect){0, 0, self.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

@end
