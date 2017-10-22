//
//  ViewController.m
//  EZOpenSDKDemo
//
//  Created by DeJohn Dong on 15/10/27.
//  Copyright © 2015年 hikvision. All rights reserved.
//

#import "ViewController.h"

#import "DDKit.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *ddnsDemoBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ddnsDemoBtn.hidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

#pragma mark - Action Methods

- (IBAction)go2CameraList:(id)sender
{
//    //获取EZMain的stroyboard文件
//    UIStoryboard *ezMainStoryboard = [UIStoryboard storyboardWithName:@"EZMain" bundle:nil];
//    //获取EZMain.storyboard的实例ViewController--获取摄像头列表
//    UIViewController *instanceVC = [ezMainStoryboard instantiateViewControllerWithIdentifier:@"EZCameraList"];
//    //push摄像头列表的viewController
//    [self.navigationController pushViewController:instanceVC animated:YES];
    
    /**
     *  下面代码功能与以上的注释方法相同
     */
    [self performSegueWithIdentifier:@"go2CameraList" sender:nil];
}

- (IBAction)logout:(id)sender
{
    [EZOPENSDK logout:^(NSError *error) {
        [[GlobalKit shareKit] clearSession];
    }];
}

- (IBAction)goAPI:(id)sender
{
    [self performSegueWithIdentifier:@"go2DemoAPI" sender:nil];
}

- (IBAction)addQQGroup:(id)sender
{
    NSString *urlStr = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external", @"511147309",@"626a9c0f72a1d877a6dc7f286db0098375436993cd22c323f5934566acc3ca8c"];
    NSURL *url = [NSURL URLWithString:urlStr];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
    }
}


@end
