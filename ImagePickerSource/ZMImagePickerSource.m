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

@interface ZMImagePickerSource ()

@property (nonatomic, copy) ImagePickerBackBlock callBackBlock;
@property (weak ,nonatomic) UIViewController *viewController;

@end

@implementation ZMImagePickerSource

- (void)dealloc
{
  NSLog(@"ZMImagePickerSource dealloc");
}


- (id)initWithViewController:(UIViewController *)paramVC andCallback:(ImagePickerBackBlock) callBackBlock{
    self = [super init];
    if (self) {
        self.viewController = paramVC;
        self.callBackBlock = [callBackBlock copy];
    }
    return self;
}

+ (void)chooseImageFromViewController:(UIViewController *) viewController
                         allowEditing:(BOOL) editing
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
            imagePickerSource.callBackBlock(image,image);
        } cancel:^{
            NSLog(@"ZMImagePickerControllerBlock cancel");
        }];
        
    } cancelHandler:^{
        NSLog(@"actionsheet cancel");
    }];

}
@end
