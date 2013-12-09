//
//  ZMActionSheetBlock.m
//  ImagePickerSource
//
//  Created by Maveriks on 13-12-9.
//  Copyright (c) 2013年 Maveriks. All rights reserved.
//

#import "ZMActionSheetBlock.h"
@interface ZMActionSheetBlock()<UIActionSheetDelegate>


@end

@implementation ZMActionSheetBlock

- (void)dealloc
{
    NSLog(@"ZMActionSheetBlock delloc");
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)showInView:(UIView *)view
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
- (void)actionSheet:(ZMActionSheetBlock *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
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

- (void)actionSheetCancel:(ZMActionSheetBlock *)actionSheet
{
    if (actionSheet.cancelHandler) {
        actionSheet.cancelHandler();
    }
}

@end
