//
//  ZMActionSheetBlock.h
//  ImagePickerSource
//
//  Created by Maveriks on 13-12-9.
//  Copyright (c) 2013年 Maveriks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZMActionSheetDismissHandler) (NSInteger selecedIndex);
typedef void (^ZMActionSheetCancelHandler) ();


@interface ZMActionSheetBlock : UIActionSheet
@property (nonatomic, copy) ZMActionSheetDismissHandler dissmissHandler;
@property (nonatomic, copy) ZMActionSheetCancelHandler cancelHandler;

- (void)showInView:(UIView *)view
   DissmissHandler:(ZMActionSheetDismissHandler)dissmissHandler
     cancelHandler:(ZMActionSheetCancelHandler )cancelHandler;

@end
