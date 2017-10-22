//
//  Utils.h
//  EZOpenSDKDemo
//
//  Created by MrMessy on 2017/10/13.
//  Copyright © 2017年 hikvision. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 设备ptz命令 */
typedef NS_OPTIONS(NSUInteger, EZPTZCusCommamd) {
    EZPTZCusCommamdUp              = 0, //向上旋转
    EZPTZCusCommamdDown            = 1, //向下旋转
    EZPTZCusCommamdLeft            = 2, //向左旋转
    EZPTZCusCommamdRight           = 3, //向右旋转
    EZPTZCusCommamdZoomIn          = 8, //镜头拉进
    EZPTZCusCommamdZoomOut         = 9, //镜头拉远
};

@interface Utils : NSObject

-(void)controlPTZ: (NSString *)accessToken
     deviceSerial: (NSString *)deviceSerial
         cameraNo: (NSInteger)cameraNo
        direction: (EZPTZCusCommamd)direction
            speed: (NSInteger)speed
           action: (EZPTZAction)action
           result: (void (^)(NSError *error))resultBlock;

@end
