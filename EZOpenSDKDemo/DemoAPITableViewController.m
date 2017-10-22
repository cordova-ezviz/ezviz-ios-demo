//
//  DemoAPITableViewController.m
//  EZOpenSDKDemo
//
//  Created by DeJohn Dong on 15/11/24.
//  Copyright © 2015年 hikvision. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "DemoAPITableViewController.h"

#import "DDKit.h"
#import "EZLeaveMessage.h"
#import "EZDeviceInfo.h"
#import "EZUserInfo.h"
#import "EZAccessToken.h"
#import "EZStorageInfo.h"
#import "EZCameraInfo.h"
#import "EZDetectorInfo.h"
#import "EZLivePlayViewController.h"
#import "EZPlayDemoViewController.h"
#import "MBProgressHUD.h"
#import "EZAreaInfo.h"

@interface DemoAPITableViewController ()
{
    NSInteger _i;
    NSString *_cameraId;
}

@property (nonatomic, strong) NSMutableArray *apis;
@property (nonatomic, strong) NSMutableArray *columns;
@property (nonatomic, strong) NSMutableArray *videoList;
@property (nonatomic, strong) NSMutableArray *favorites;
@property (nonatomic, strong) NSMutableArray *leaveList;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation DemoAPITableViewController

- (void)dealloc
{
    NSLog(@"%@ dealloc", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"DemoAPI";
    
    if(!_apis)
        _apis = [NSMutableArray new];
    
    if(!_columns)
        _columns = [NSMutableArray new];
    
    if(!_videoList)
        _videoList = [NSMutableArray new];
    
    if(!_favorites)
        _favorites = [NSMutableArray new];
    
    if (!_leaveList) {
        _leaveList = [NSMutableArray new];
    }
    
    [_apis removeAllObjects];
    [_apis addObjectsFromArray:@[NSLocalizedString(@"api_mirror_test", @"镜像翻转接口测试")]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //判断本地保存的accessToken，然后向SDK设置AccessToken。
    if([GlobalKit shareKit].accessToken)
    {
        [EZOPENSDK setAccessToken:[GlobalKit shareKit].accessToken];
    }
    else
    {
        [EZOPENSDK openLoginPage:^(EZAccessToken *accessToken) {
            [[GlobalKit shareKit] setAccessToken:accessToken.accessToken];
            [EZOPENSDK setAccessToken:accessToken.accessToken];
        }];
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apis.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DemoAPICell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = _apis[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([indexPath row] == 0)
    {
        __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = NSLocalizedString(@"api_getting_device_list", @"正在获取用户设备列表...");
        [EZOPENSDK getDeviceList:0
                        pageSize:10
                      completion:^(NSArray *deviceList, NSInteger totalCount, NSError *error) {
                          if (error)
                          {
                              hud.labelText = [NSString stringWithFormat:@"%@（%d）",NSLocalizedString(@"api_get_device_list_fail",@"设备列表获取失败"), (int)error.code];
                              [hud hide:YES afterDelay:0.5];
                              return;
                          }
                          for (EZDeviceInfo *deviceInfo in deviceList)
                          {
                              if (deviceInfo.cameraNum > 0 && deviceInfo.status == 1) {
                                  NSString *deviceSerial = deviceInfo.deviceSerial;
                                  EZCameraInfo *cameraInfo = [deviceInfo.cameraInfo firstObject];
                                  hud.labelText = NSLocalizedString(@"api_flip_over",@"正在操作设备通道画面翻转...");
                                  [EZOPENSDK controlVideoFlip:deviceSerial
                                                     cameraNo:cameraInfo.cameraNo
                                                      command:EZDisplayCommandCenter
                                                       result:^(NSError *error) {
                                                           hud.labelText = [NSString stringWithFormat:@"%@：error code is %d",NSLocalizedString(@"api_flip_over_result",@"画面翻转结果"), (int)error.code];
                                                           [hud hide:YES afterDelay:0.5];
                                                       }];
                                  break;
                              }
                          }
                      }];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)checkCancel:(id)sender {
    __weak typeof(self) weakSelf = self;
    [EZOPENSDK openChangePasswordPage:^(NSInteger resultCode) {
        NSLog(@"resultCode = %d", (int)resultCode);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

@end
