//
//  ZMImagePickerControllerBlock.h
//  ImagePickerSource
//
//  Created by Maveriks on 13-12-9.
//  Copyright (c) 2013年 Maveriks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZMImagePickerControllerSelectImageHandler) (UIImage *image, NSDictionary *info, BOOL *dismiss);
typedef void(^ZMImagePickerControllerCancelBlock) ();

@interface ZMImagePickerControllerBlock : UIImagePickerController
@property (nonatomic, copy) ZMImagePickerControllerSelectImageHandler selectedHandler;
@property (nonatomic, copy) ZMImagePickerControllerCancelBlock cancelBlock;

- (void)showWithModalViewController:(UIViewController *)modalViewController
                           animated:(BOOL)animated
                    selectedHandler:(ZMImagePickerControllerSelectImageHandler) slectedHandler
                             cancel:(ZMImagePickerControllerCancelBlock) cancelBlock;

@end
