//
//  ViewController.m
//  ImagePickerSource
//
//  Created by Maveriks on 13-12-8.
//  Copyright (c) 2013年 Maveriks. All rights reserved.
//

#import "ViewController.h"
#import "ZMImagePickerSource.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong ,nonatomic) ZMImagePickerSource *imageSource;

@end

@implementation ViewController

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.imageSource = [[ZMImagePickerSource alloc] initWithViewController:self andCallback:^(UIImage *originalImage, UIImage *cropImage) {
        self.imageView.image = cropImage;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseImageClicked:(UIButton *)sender {
//    [ZMImagePickerSource chooseImageFromViewController:self CompletionHandler:^(UIImage *originalImage, UIImage *cropImage) {
//        self.imageView.image = cropImage;
//    }];
    [self.imageSource show];
}


- (IBAction)backBtnClicked:(UIButton *)sender {
    [[self presentingViewController] dismissModalViewControllerAnimated:YES];
}
@end
