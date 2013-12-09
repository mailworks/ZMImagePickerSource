//
//  ZMImagePickerSource.m
//  HarierAirCondition
//
//  Created by Lion on 13-7-9.
//  Copyright (c) 2013年 Lion. All rights reserved.
//

#import "ZMImagePickerSource.h"
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

- (void)show{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取",nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            [self presentImagePickerControllerType:UIImagePickerControllerSourceTypeCamera
                                     allowsEditing:YES
                          andPresentViewController:self.viewController];

        }
            break;
            
        case 1:
        {
            [self presentImagePickerControllerType:UIImagePickerControllerSourceTypePhotoLibrary
                                     allowsEditing:YES
                          andPresentViewController:self.viewController];
        }
            break;
        default:
            break;
    }
}

- (void)presentImagePickerControllerType:(UIImagePickerControllerSourceType) type
                           allowsEditing:(BOOL) editing
                andPresentViewController:(id)controller
{
    
    if (type == UIImagePickerControllerSourceTypeCamera) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            NSLog(@"You device not camera");
            return;
        }
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.allowsEditing = editing;
    picker.sourceType = type;
    picker.delegate = self;
    
    if (!controller) {
         // TODO: present from navigationController
        
    }
    [controller presentModalViewController:picker animated:YES];
}


#pragma mark - Image picker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqual:@"public.image"] ) {
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];
        //        UIImage *scaleImage = [self scaleImage:editImage toScale:0.5];
//        UIImage *scaleImage = [editImage thumbnailImage:80 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationDefault];
        if (self.callBackBlock) {
            self.callBackBlock(originalImage,editImage);
        }
    }
    [self.viewController dismissModalViewControllerAnimated:YES];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.viewController dismissModalViewControllerAnimated:YES];
}


+ (void)chooseImageFromViewController:(UIViewController *) viewController CompletionHandler:(ImagePickerBackBlock ) handler;
{
    ZMImagePickerSource *imagePickerSource = [[ZMImagePickerSource alloc] init];
    imagePickerSource.viewController = viewController;
    imagePickerSource.callBackBlock = handler;
    [imagePickerSource show];
}
@end
