//
//  HYImagePickerManager.h
//  FlowerHan
//
//  Created by leimo on 2017/8/9.
//  Copyright © 2017年 leimo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^ImageBlock)(UIImage *resultImage);

@interface HYImagePickerManager : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/** 获取图片的Block */
@property (nonatomic,copy) ImageBlock imageBlock;

+ (instancetype)shareManager;

/**
 *  检查摄像头权限
 */
- (void)checkAVAuthorizationStatusFromViewController:(UIViewController *)viewController withComplectBlock:(void(^)())complection;
;

/*!
 @method
 @brief presentImagePickerViewControllerPhotoLibray
 @param viewController  currentViewController
 @param complection     complectionBlock
 */
- (void)presentPhotoLibraryVCFromViewController:(UIViewController *)viewController withResultBlock:(void(^)(UIImage *image))complection;

/*!
 @method
 @brief presentImagePickerViewControllerCamera
 @param viewController  currentViewController
 @param complection     complectionBlock
 */
- (void)presentCameraVCFromViewController:(UIViewController *)viewController withResultBlock:(void(^)(UIImage *image))complection;

/*!
 @method
 @brief    打开闪关灯
 */
- (void)openFlashLight;

/*!
 @method
 @brief    关闭闪光灯
 */
- (void)closeFlashLight;

@end
