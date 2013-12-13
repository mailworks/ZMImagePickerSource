//
//  UIImage+ResizeImage.m
//  ImagePickerSource
//
//  Created by Maveriks on 13-12-13.
//  Copyright (c) 2013年 Maveriks. All rights reserved.
//

#import "UIImage+ResizeImage.h"

@implementation UIImage (ResizeImage)

- (UIImage *)imageWithMaxSide:(CGFloat)length
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
