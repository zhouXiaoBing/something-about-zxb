
//
//  UpLoadProgressViewController.m
//  collectionIos
//
//  Created by Mac on 2018/2/27.
//  Copyright © 2018年 Vitagou. All rights reserved.
//
/*
 
 */

#import "UpLoadProgressViewController.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LxGridViewFlowLayout.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TZGifPhotoPreviewController.h"
#import "TZLocationManager.h"



@interface UpLoadProgressViewController()<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>{
    
    NSMutableArray *_selectedPhotos;
    
    NSMutableArray *_selectedAssets;
    
    BOOL _isSelectOriginalPhoto;//原图
    
    CGFloat _itemWH;
    
    CGFloat _margin;
}

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (strong, nonatomic) LxGridViewFlowLayout *layout;

@property (strong, nonatomic) CLLocation *location;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
// 设置开关
@property (weak, nonatomic) IBOutlet UISwitch *showTakePhotoBtnSwitch;  ///< 在内部显示拍照按钮

@property (weak, nonatomic) IBOutlet UISwitch *sortAscendingSwitch;     ///< 照片排列按修改时间升序

@property (weak, nonatomic) IBOutlet UISwitch *allowPickingVideoSwitch; ///< 允许选择视频

@property (weak, nonatomic) IBOutlet UISwitch *allowPickingImageSwitch; ///< 允许选择图片

@property (weak, nonatomic) IBOutlet UISwitch *allowPickingGifSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *allowPickingOriginalPhotoSwitch; ///< 允许选择原图

@property (weak, nonatomic) IBOutlet UISwitch *showSheetSwitch; ///< 显示一个sheet,把拍照按钮放在外面

@property (weak, nonatomic) IBOutlet UITextField *maxCountTF;  ///< 照片最大可选张数，设置为1即为单选模式

@property (weak, nonatomic) IBOutlet UITextField *columnNumberTF;

@property (weak, nonatomic) IBOutlet UISwitch *allowCropSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *needCircleCropSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *allowPickingMuitlpleVideoSwitch;


@end

@implementation UpLoadProgressViewController

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (UIImagePickerController *)imagePickerVc{
    
    if(_imagePickerVc == nil){
        _imagePickerVc = [[UIImagePickerController alloc]init];
        _imagePickerVc.delegate = self;
        
        if(iOS7Later){
            _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        }
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        
    }
    
    return _imagePickerVc;
}

@end

