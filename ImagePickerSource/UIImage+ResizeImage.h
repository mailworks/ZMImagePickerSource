//
//  UIImage+ResizeImage.h
//  ImagePickerSource
//
//  Created by Maveriks on 13-12-13.
//  Copyright (c) 2013年 Maveriks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ResizeImage)
- (UIImage *)imageWithMaxSide:(CGFloat)length;
@end
