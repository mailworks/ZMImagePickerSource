//
//  ZMImagePickerSource.h
//  HarierAirCondition
//
//  Created by Lion on 13-7-9.
//  Copyright (c) 2013年 Lion. All rights reserved.
//

#import <Foundation/Foundation.h>

#if !__has_feature(objc_arc)
#error This is ARC only. Either turn on ARC for the project or use -fobjc-arc flag
#endif

typedef void (^ImagePickerBackBlock) (UIImage *image,  NSDictionary *pickingMediainfo, BOOL *dismiss);

@interface ZMImagePickerSource : NSObject

+ (void)chooseImageFromViewController:(UIViewController *) viewController
                         allowEditing:(BOOL) editing
                   imageMaxSizeLength:(CGFloat)lenght
                    CompletionHandler:(ImagePickerBackBlock ) handler;
@end
