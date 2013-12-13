//
//  ZMImagePickerSource.m
//  HarierAirCondition
//
//  Created by Lion on 13-7-9.
//  Copyright (c) 2013年 Lion. All rights reserved.
//

#import "ZMImagePickerSource.h"
#import "ZMActionSheetBlock.h"
#import "ZMImagePickerControllerBlock.h"
#import "UIImage+ResizeImage.h"

@interface ZMImagePickerSource ()

@property (nonatomic, copy) ImagePickerBackBlock callBackBlock;
@property (weak ,nonatomic) UIViewController *viewController;

@end

@implementation ZMImagePickerSource

- (void)dealloc
{
  NSLog(@"ZMImagePickerSource dealloc");
}

+ (void)chooseImageFromViewController:(UIViewController *) viewController
                         allowEditing:(BOOL) editing
                   imageMaxSizeLength:(CGFloat)lenght
                    CompletionHandler:(ImagePickerBackBlock ) handler
{
    ZMImagePickerSource *imagePickerSource = [[ZMImagePickerSource alloc] init];
    imagePickerSource.viewController = viewController;
    imagePickerSource.callBackBlock = handler;
    
    ZMActionSheetBlock *actionSheet = [[ZMActionSheetBlock alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取",nil];
    
    [actionSheet showInView:viewController.view DissmissHandler:^(NSInteger selecedIndex) {
        NSLog(@"selectedIndex:%d",selecedIndex);
        
        ZMImagePickerControllerBlock *imagePicker = [[ZMImagePickerControllerBlock alloc] init];
        imagePicker.allowsEditing = editing;
        if (0 == selecedIndex) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else if (1 == selecedIndex) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        [imagePicker showWithModalViewController:imagePickerSource.viewController animated:YES selectedHandler:^(UIImage *image, NSDictionary *info, BOOL *dismiss) {
            //resize image
            UIImage *lastImage = nil;
            if (lenght > 0) {
                lastImage = [image imageWithMaxSide:lenght];
            } else {
                lastImage = image;
            }
            imagePickerSource.callBackBlock(lastImage,info,dismiss);
            
        } cancel:^{
            NSLog(@"ZMImagePickerControllerBlock cancel");
        }];
        
    } cancelHandler:^{
        NSLog(@"actionsheet cancel");
    }];

}


@end
