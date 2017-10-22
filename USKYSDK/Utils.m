//
//  Utils.m
//  EZOpenSDKDemo
//
//  Created by MrMessy on 2017/10/13.
//  Copyright © 2017年 hikvision. All rights reserved.
//

#import "Utils.h"
#import "AFHTTPRequestOperationManager.h"

@implementation Utils

-(void)controlPTZ: (NSString *)accessToken
     deviceSerial: (NSString *)deviceSerial
         cameraNo: (NSInteger)cameraNo
        direction: (EZPTZCusCommamd)direction
            speed: (NSInteger)speed
           action: (EZPTZAction)action
           result: (void (^)(NSError *error))resultBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *channelNo = [NSString stringWithFormat:@"%ld",(long)cameraNo];
    NSString *speedStr = [NSString stringWithFormat:@"%ld",(long)speed];
    NSString *actionStr = action == 1 ? @"start" : @"stop";
    NSString *directionStr = [NSString stringWithFormat:@"%ld",(long)direction];
    
    NSLog(@"channelNo: %@,speedStr:%@,actionStr:%@,directionStr:%@,accessToken:%@",channelNo,speedStr,actionStr,directionStr,accessToken);
    
    NSDictionary *parameters = [[NSDictionary alloc]initWithObjectsAndKeys:accessToken,@"accessToken",deviceSerial,@"deviceSerial", channelNo ,@"channelNo",directionStr,@"direction",speedStr,@"speed",nil];
    NSString *url = [@"https://open.ys7.com/api/lapp/device/ptz/" stringByAppendingString:actionStr];
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = (long)[(NSDictionary *)responseObject valueForKey:@"code"];
        if (code == 200) {
            resultBlock(nil);
        }else {
            NSError *error = [NSError errorWithDomain:url
                                                 code:(long)[(NSDictionary *)responseObject valueForKey:@"code"]
                                             userInfo:(NSDictionary *)responseObject];
            resultBlock(error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        resultBlock(error);
    }];


}

@end
