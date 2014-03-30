ZMImagePickerSource
===================

快速集成相册选择器
#### 介绍：
项目中经常需要从相册或者相机来选择照片，比如修改用户头像，有了它只需一句即可快速集成,可以将重复的代码移出控制器

	    [ZMImagePickerSource chooseImageFromViewController:self
                                          allowEditing:YES
                                    imageMaxSizeLength:150.f
                                     CompletionHandler:^(UIImage *image, NSDictionary *pickingMediainfo, BOOL *dismiss) {
       
        imgViewHeadimg.image = image;
        
    }];
   首先会弹出UIActionSheet 提示用户选择从相册还是拍照选取照片
