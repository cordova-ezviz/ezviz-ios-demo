//
//  EZPlayDemoViewController.m
//  EZOpenSDKDemo
//
//  Created by DeJohn Dong on 16/3/30.
//  Copyright © 2016年 hikvision. All rights reserved.
//

#import "EZPlayDemoViewController.h"

#import "EZPlayer.h"


@interface EZPlayDemoViewController ()<EZPlayerDelegate> {
    EZPlayer *_player1;
    EZPlayer *_player2;
    EZPlayer *_player3;
    EZPlayer *_player4;
}

@property (nonatomic, weak) IBOutlet UIView *playerView1;
@property (nonatomic, weak) IBOutlet UIView *playerView2;
@property (nonatomic, weak) IBOutlet UIView *playerView3;
@property (nonatomic, weak) IBOutlet UIView *playerView4;


@end

@implementation EZPlayDemoViewController

- (void)dealloc
{
    [EZOPENSDK releasePlayer:_player1];
    [EZOPENSDK releasePlayer:_player2];
    [EZOPENSDK releasePlayer:_player3];
    [EZOPENSDK releasePlayer:_player4];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if (!_player1)
//    {
//        _player1 = [EZOPENSDK createPlayerWithCameraId:_cameraList[0]];
//    }
//    [_player1 setPlayerView:_playerView1];
//    _player1.delegate = self;
//    [_player1 startRealPlay];
//    
//    if (!_player2)
//    {
//        _player2 = [EZOPENSDK createPlayerWithCameraId:_cameraList[1]];
//    }
//    [_player2 setPlayerView:_playerView2];
//    _player2.delegate = self;
//    [_player2 startRealPlay];
//    
//    if (!_player3)
//    {
//        _player3 = [EZOPENSDK createPlayerWithCameraId:_cameraList[2]];
//    }
//    [_player3 setPlayerView:_playerView3];
//    _player3.delegate = self;
//    [_player3 startRealPlay];
    
//    if (!_player4)
//    {
//        _player4 = [EZOPENSDK createPlayerWithCameraId:_cameraList[3]];
//    }
//    [_player4 setPlayerView:_playerView4];
//    _player4.delegate = self;
//    [_player4 startRealPlay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - PlayerDelegate Methods

- (void)player:(EZPlayer *)player didPlayFailed:(NSError *)error
{
    NSLog(@"player = %@, error = %@",player, error);
}

- (void)player:(EZPlayer *)player didReceivedMessage:(NSInteger)messageCode
{
    NSLog(@"player = %@, messageCode = %d", player, (int)messageCode);
}

#pragma mark - Action Methods

- (IBAction)tapTouch:(id)sender
{
    
}

@end
