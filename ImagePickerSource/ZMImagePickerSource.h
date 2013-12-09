//
//  ZMImagePickerSource.h
//  HarierAirCondition
//
//  Created by Lion on 13-7-9.
//  Copyright (c) 2013年 Lion. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ImagePickerBackBlock) (UIImage *originalImage, UIImage *cropImage);

@interface ZMImagePickerSource : NSObject

+ (void)chooseImageFromViewController:(UIViewController *) viewController
                         allowEditing:(BOOL) editing
                    CompletionHandler:(ImagePickerBackBlock ) handler;
@end
