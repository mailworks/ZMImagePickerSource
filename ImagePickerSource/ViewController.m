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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseImageClicked:(UIButton *)sender {
    
    [ZMImagePickerSource chooseImageFromViewController:self
                                          allowEditing:YES
                                    imageMaxSizeLength:100
                                     CompletionHandler:^(UIImage *image, NSDictionary *pickingMediainfo, BOOL *dismiss) {
                                         
        self.imageView.image = image;
        NSLog(@"imgeSize:%@",NSStringFromCGSize(image.size));
                                         
    }];
    
}


- (IBAction)backBtnClicked:(UIButton *)sender {
    
    [[self presentingViewController] dismissModalViewControllerAnimated:YES];
}

@end
