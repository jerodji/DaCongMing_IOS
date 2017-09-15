//
//  HYImagePickerManager.m
//  FlowerHan
//
//  Created by leimo on 2017/8/9.
//  Copyright © 2017年 leimo. All rights reserved.
//

#import "HYImagePickerManager.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface HYImagePickerManager()
{
    /** 用来记录ViewController */
    UIViewController *tempViewController;
}

@end

@implementation HYImagePickerManager

+ (instancetype)shareManager{

    static HYImagePickerManager *imagePicker;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        imagePicker = [HYImagePickerManager new];
    });
    return imagePicker;
}

#pragma mark - 检查权限
- (void)checkAVAuthorizationStatusFromViewController:(UIViewController *)viewController withComplectBlock:(void (^)())complection{
    
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                
                if (granted) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        complection();
                    });
                }
                else{
                    
                    NSLog(@"用户拒绝了访问相机权限");
                }
            }];
        }
        else if (status == AVAuthorizationStatusAuthorized){
            
            complection();
        }
        else if (status == AVAuthorizationStatusDenied){
            
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"⚠️ 警告" message:@"请去-> [设置 - 隐私 - 相机 ] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertC addAction:alertA];
            [viewController presentViewController:alertC animated:YES completion:nil];
        }
        else if (status == AVAuthorizationStatusRestricted){
            
            NSLog(@"系统原因,无法访问相册");
        }
        
    }
    else{
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alert1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:alert1];
        [viewController presentViewController:alertVC animated:YES completion:nil];
    }

}

#pragma mark - 访问资源
- (void)presentPhotoLibraryVCFromViewController:(UIViewController *)viewController withResultBlock:(void (^)(UIImage *))complection{

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //设置允许编辑
        imagePicker.allowsEditing = YES;
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [viewController presentViewController:imagePicker animated:YES completion:nil];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"访问相册失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }

    tempViewController = viewController;
    self.imageBlock = complection;
    
}

- (void)presentCameraVCFromViewController:(UIViewController *)viewController withResultBlock:(void (^)(UIImage *))complection{

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //设置允许编辑
        imagePicker.allowsEditing = YES;
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [viewController presentViewController:imagePicker animated:YES completion:nil];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"访问相册失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
    tempViewController = viewController;
    self.imageBlock = complection;
}

#pragma mark - 闪光灯
- (void)openFlashLight{
    
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device.torchMode == AVCaptureTorchModeOff) {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        [device unlockForConfiguration];
    }
}

- (void)closeFlashLight{

    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device.torchMode == AVCaptureTorchModeOn) {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}

#pragma mark - imagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //选择完成     判断选择的资源的image 还是media
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:(NSString *)kUTTypeImage]) {
        //如果取到的资源是image
        //UIImagePickerControllerEditedImage           编辑后的图片
        //UIImagePickerControllerOriginalImage         原图
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        self.imageBlock(image);
        
    }
    [tempViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [tempViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
