#import "RNImageToBase64.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@implementation RNImageToBase64

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(getBase64String:(NSString *)input callback:(RCTResponseSenderBlock)callback)
{
  NSURL *url = [[NSURL alloc] initWithString:input];
  ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
  [library assetForURL:url resultBlock:^(ALAsset *asset) {
    CGImageRef imageRef = [self rotatePortraitImageFromAsset:asset];

    NSData *imageData = UIImagePNGRepresentation([UIImage imageWithCGImage:imageRef]);
    NSString *base64Encoded = [imageData base64EncodedStringWithOptions:0];
    callback(@[[NSNull null], base64Encoded]);

  } failureBlock:^(NSError *error) {
    NSLog(@"that didn't work %@", error);
    callback(@[error]);
  }];
}

-(CGImageRef) rotatePortraitImageFromAsset:(ALAsset*) asset {
    ALAssetRepresentation *rep = [asset defaultRepresentation];

    if ([rep orientation] == ALAssetOrientationUp){
        return [rep fullScreenImage];
    } else {
        CGImageRef ref = [rep fullScreenImage];
        UIImage* testImage = [UIImage imageWithCGImage:ref];

        UIGraphicsBeginImageContextWithOptions(testImage.size, NO, testImage.scale);
        [testImage drawInRect:(CGRect){0, 0, testImage.size}];
        UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return [testImage CGImage];
    }
}

@end
