//
//  EZOpenSDK+EZPrivateHeader.h
//  EzvizOpenSDK
//
//  Created by DeJohn Dong on 15/12/19.
//  Copyright © 2015年 Hikvision. All rights reserved.
//

#import "EZOpenSDK.h"
#import "EZTransferMessage.h"

@interface EZOpenSDK (EZPrivateHeader)

/**
 *  萤石开放平台SDK私有方法--根据关键字获取Http请求中公共参数的值的方法（4530专用接口）
 *
 *  @param key 关键字
 *
 *  @return 公共参数的值
 */
+ (NSString *)getHTTPPublicParam:(NSString *)key;

/**
 *  通过序列号和通道号构建EZPlayer对象（4530专用接口）
 *
 *  @param deviceSerial 设备序列号
 *  @param channel      通道号
 *  @param streamType   取流类型，0是主码流，1是子码流
 *
 *  @return EZPlayer对象
 */
+ (EZPlayer *)createPlayerWithDeviceSerial:(NSString *)deviceSerial
                                 channelNo:(NSInteger)channelNo
                                streamType:(NSInteger)streamType;

/**
 *  获取透明通道消息详情接口
 *
 *  @param messageId  消息ID
 *  @param completion 回调block
 *
 *  @return operation
 */
+ (NSOperation *)getTransferMessageInfo:(NSString *)messageId
                             completion:(void (^)(EZTransferMessage *message, NSError *error))completion;

@end
