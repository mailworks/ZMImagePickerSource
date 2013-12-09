//
//  ZMImagePickerSource.h
//  HarierAirCondition
//
//  Created by Lion on 13-7-9.
//  Copyright (c) 2013年 Lion. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ImagePickerBackBlock) (UIImage *originalImage, UIImage *cropImage);

@interface ZMImagePickerSource : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

- (id)initWithViewController:(UIViewController *)paramVC andCallback:(ImagePickerBackBlock) callBackBlock;

- (void)show;

+ (void)chooseImageFromViewController:(UIViewController *) viewController CompletionHandler:(ImagePickerBackBlock ) handler;

@end
