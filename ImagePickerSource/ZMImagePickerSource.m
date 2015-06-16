//
//  ZMImagePickerSource.m
//  HarierAirCondition
//
//  Created by Lion on 13-7-9.
//  Copyright (c) 2013年 Lion. All rights reserved.
//

#import "ZMImagePickerSource.h"
#import <objc/runtime.h>

#pragma mark - UIImagePickerController Block Category
static char kAssociatedObjectImgPickerSelectedHandlerKey;
static char kAssociatedObjectImgPickerCancelBlockKey;

typedef void (^ZMImagePickerControllerSelectImageHandler) (UIImage *image, NSDictionary *info, BOOL *dismiss);
typedef void(^ZMImagePickerControllerCancelBlock) ();

@interface UIImagePickerController (ZMBlockImagePickerController)<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

@property (nonatomic, copy) ZMImagePickerControllerSelectImageHandler selectedHandler;
@property (nonatomic, copy) ZMImagePickerControllerCancelBlock cancelBlock;

- (void)zm_showWithModalViewController:(UIViewController *)modalViewController
                              animated:(BOOL)animated
                       selectedHandler:(ZMImagePickerControllerSelectImageHandler) slectedHandler
                                cancel:(ZMImagePickerControllerCancelBlock) cancelBlock;

@end


@implementation UIImagePickerController (ZMBlockImagePickerController)
@dynamic selectedHandler;
@dynamic cancelBlock;

//associated objcet
- (void)setSelectedHandler:(ZMImagePickerControllerSelectImageHandler)selectedHandler {
    
    objc_setAssociatedObject(self, &kAssociatedObjectImgPickerSelectedHandlerKey, selectedHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (ZMImagePickerControllerSelectImageHandler)selectedHandler {
    return  objc_getAssociatedObject(self, &kAssociatedObjectImgPickerSelectedHandlerKey);
}

- (void)setCancelBlock:(ZMImagePickerControllerCancelBlock)cancelBlock {
    objc_setAssociatedObject(self, &kAssociatedObjectImgPickerCancelBlockKey, cancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ZMImagePickerControllerCancelBlock)cancelBlock {
    return objc_getAssociatedObject(self, &kAssociatedObjectImgPickerCancelBlockKey);
}

- (void)zm_showWithModalViewController:(UIViewController *)modalViewController
                              animated:(BOOL)animated
                       selectedHandler:(ZMImagePickerControllerSelectImageHandler) slectedHandler
                                cancel:(ZMImagePickerControllerCancelBlock) cancelBlock {
    self.selectedHandler  = slectedHandler;
    self.cancelBlock = cancelBlock;
    self.delegate = self;
    [modalViewController presentModalViewController:self animated:animated];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *editedImage = (UIImage *)[info valueForKey:UIImagePickerControllerEditedImage];
    if(!editedImage)
        editedImage = (UIImage *)[info valueForKey:UIImagePickerControllerOriginalImage];
    
    BOOL dismiss = YES;
    if (self.selectedHandler) {
        self.selectedHandler(editedImage,info,&dismiss);
    }
    if (dismiss) {
        [picker dismissModalViewControllerAnimated:YES];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (picker.cancelBlock) {
        picker.cancelBlock();
    }
    [picker dismissModalViewControllerAnimated:YES];
}

@end

#pragma mark - UIActionSheet Block Category
static char kAssociatedObjecActionSheetDissmissKey;
static char kAssociatedObjecActionSheetCancelKey;

typedef void (^ZMActionSheetDismissHandler) (NSInteger selecedIndex);
typedef void (^ZMActionSheetCancelHandler) ();

@interface UIActionSheet (ZMBlockActionSheet)<UIActionSheetDelegate>

@property (nonatomic, copy) ZMActionSheetDismissHandler dissmissHandler;
@property (nonatomic, copy) ZMActionSheetCancelHandler cancelHandler;
@end

@implementation UIActionSheet (ZMBlockActionSheet)
@dynamic dissmissHandler;
@dynamic cancelHandler;

//Property associated object
- (void)setDissmissHandler:(ZMActionSheetDismissHandler)dissmissHandler {
    objc_setAssociatedObject(self, &kAssociatedObjecActionSheetDissmissKey, dissmissHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ZMActionSheetDismissHandler)dissmissHandler {
    return objc_getAssociatedObject(self, &kAssociatedObjecActionSheetDissmissKey);
}

- (void)setCancelHandler:(ZMActionSheetCancelHandler)cancelHandler {
    objc_setAssociatedObject(self, &kAssociatedObjecActionSheetCancelKey, cancelHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ZMActionSheetCancelHandler)cancelHandler {
    return objc_getAssociatedObject(self, &kAssociatedObjecActionSheetCancelKey);
}

//Method
- (void)zm_showInView:(UIView *)view
      DissmissHandler:(ZMActionSheetDismissHandler)dissmissHandler
        cancelHandler:(ZMActionSheetCancelHandler )cancelHandler
{
    self.delegate = self;
    self.dissmissHandler = dissmissHandler;
    self.cancelHandler = cancelHandler;
    
    if (view) {
        [self showInView:view];
    } else {
        //show keyWindow
        [self showInView:[UIApplication sharedApplication].keyWindow];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [actionSheet cancelButtonIndex]) {
        if (actionSheet.cancelHandler) {
            actionSheet.cancelHandler();
        }
    } else {
        if (actionSheet.dissmissHandler) {
            actionSheet.dissmissHandler(buttonIndex);
        }
    }
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    if (actionSheet.cancelHandler) {
        actionSheet.cancelHandler();
    }
}

@end

#pragma mark - UIImage Category
@interface UIImage (ZMResizeImage)
- (UIImage *)zm_imageWithMaxSide:(CGFloat)length;
@end

@implementation UIImage (ZMResizeImage)
- (UIImage *)zm_imageWithMaxSide:(CGFloat)length
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize imgSize = IMSizeReduce(self.size, length);
    UIImage *img = nil;
    
    // 创建一个 bitmap context
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, scale);
    // 将图片绘制到当前的 context 上
    [self drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)
           blendMode:kCGBlendModeNormal alpha:1.0];
    img = UIGraphicsGetImageFromCurrentImageContext();
    return img;
}

// 按比例减少尺寸
static inline
CGSize IMSizeReduce(CGSize size, CGFloat limit)
{
    CGFloat max = MAX(size.width, size.height);
    if (max < limit) {
        return size;
    }
    
    CGSize imgSize;
    CGFloat scale = size.height / size.width;
    
    if (size.width > size.height) {
        imgSize = CGSizeMake(limit, limit * scale);
    } else {
        imgSize = CGSizeMake(limit / scale, limit);
    }
    
    return imgSize;
}
@end

#pragma mark - ZMImagePickerSource
@interface ZMImagePickerSource ()

@property (nonatomic, copy) ImagePickerBackBlock callBackBlock;
@property (weak ,nonatomic) UIViewController *viewController;

@end

@implementation ZMImagePickerSource

- (void)dealloc
{
//  NSLog(@"ZMImagePickerSource dealloc");
}

+ (void)chooseImageFromViewController:(UIViewController *) viewController
                         allowEditing:(BOOL) editing
                   imageMaxSizeLength:(CGFloat)lenght
                    CompletionHandler:(ImagePickerBackBlock ) handler
{
    ZMImagePickerSource *imagePickerSource = [[ZMImagePickerSource alloc] init];
    imagePickerSource.viewController = viewController;
    imagePickerSource.callBackBlock = handler;

    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                                      delegate:nil
                                                             cancelButtonTitle:@"取消"
                                                        destructiveButtonTitle:nil
                                                             otherButtonTitles:@"拍照",@"从相册选取",nil];
    
    [actionSheet zm_showInView:viewController.view
            DissmissHandler:^(NSInteger selecedIndex) {
                
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = editing;
        if (0 == selecedIndex) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else if (1 == selecedIndex) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        [imagePicker zm_showWithModalViewController:imagePickerSource.viewController
                                        animated:YES
                                 selectedHandler:^(UIImage *image, NSDictionary *info, BOOL *dismiss) {
            //resize image
            UIImage *lastImage = nil;
            if (lenght > 0) {
                lastImage = [image zm_imageWithMaxSide:lenght];
            } else {
                lastImage = image;
            }
            imagePickerSource.callBackBlock(lastImage,info,dismiss);
            
        } cancel:^{
//            NSLog(@"ZMImagePickerControllerBlock cancel");
        }];
        
    } cancelHandler:^{
//        NSLog(@"actionsheet cancel");
    }];
}

@end





