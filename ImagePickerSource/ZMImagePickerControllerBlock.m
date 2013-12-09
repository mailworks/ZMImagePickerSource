//
//  ZMImagePickerControllerBlock.m
//  ImagePickerSource
//
//  Created by Maveriks on 13-12-9.
//  Copyright (c) 2013年 Maveriks. All rights reserved.
//

#import "ZMImagePickerControllerBlock.h"

@interface ZMImagePickerControllerBlock ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ZMImagePickerControllerBlock
- (void)dealloc
{
    NSLog(@"ZMImagePickerControllerBlock dealloc");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showWithModalViewController:(UIViewController *)modalViewController
                           animated:(BOOL)animated
                    selectedHandler:(ZMImagePickerControllerSelectImageHandler) slectedHandler
                             cancel:(ZMImagePickerControllerCancelBlock) cancelBlock
{
    self.delegate = self;
    self.selectedHandler = slectedHandler;
    self.cancelBlock = cancelBlock;
    [modalViewController presentModalViewController:self animated:animated];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(ZMImagePickerControllerBlock *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
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

- (void)imagePickerControllerDidCancel:(ZMImagePickerControllerBlock *)picker
{
    if (picker.cancelBlock) {
        picker.cancelBlock();
    }
    [picker dismissModalViewControllerAnimated:YES];
}
@end
