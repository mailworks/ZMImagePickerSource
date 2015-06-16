ZMImagePickerSource
===================

快速集成相册选择器
#### 介绍：
项目中经常需要从相册或者相机来选择照片，比如修改用户头像，一般会用到UIActionSheet来提示用户从相册或拍摄选取照片，根据用户的选择来调用UIImagePickerController选取相片，虽然实现起来简单但是写起来麻烦而且在Controller中会留下许多代码不利于维护，所以将UIActionSheet和UIImagePickerController简单封装起立这样仅需一行代码即可在Controller中快速集成。

	    [ZMImagePickerSource chooseImageFromViewController:self
                                          allowEditing:YES
                                    imageMaxSizeLength:150.f
                                     CompletionHandler:^(UIImage *image, NSDictionary *pickingMediainfo, BOOL *dismiss) {
       
        imgViewHeadimg.image = image;
        
    }];
  
