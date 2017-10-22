//
//  EZWifiInfoViewController.m
//  EZOpenSDKDemo
//
//  Created by DeJohn Dong on 15/10/29.
//  Copyright © 2015年 hikvision. All rights reserved.
//

#import "EZWifiInfoViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "DDKit.h"
#import "EZWifiConfigViewController.h"

@interface EZWifiInfoViewController ()

@property (nonatomic, weak) IBOutlet UIButton *nextButton;
@property (nonatomic, weak) IBOutlet UILabel *tipsLabel;
@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *passwordLabel;

@end

@implementation EZWifiInfoViewController

- (void)dealloc
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"wifi_connect_wifi_title", @"第二步，连接WiFi");
    
    self.nameTextField.leftView = self.nameLabel;
    self.nameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.nameTextField.enabled = NO;
    
    self.passwordTextField.leftView = self.passwordLabel;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    NSArray *interfaces = CFBridgingRelease(CNCopySupportedInterfaces());
    for (NSString *ifnam in interfaces)
    {
        NSDictionary *info = CFBridgingRelease(CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam));
        self.nameTextField.text = info[@"SSID"];
        break;
    }
    
    [self.nameTextField dd_addCornerRadius:4.0f lineColor:[UIColor lightGrayColor]];
    [self.passwordTextField dd_addCornerRadius:4.0f lineColor:[UIColor lightGrayColor]];
    [self.nextButton dd_addCornerRadius:19.0 lineColor:[UIColor dd_hexStringToColor:@"0x1b9ee2"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue destinationViewController] isKindOfClass:[EZWifiConfigViewController class]]) {
        ((EZWifiConfigViewController *)[segue destinationViewController]).ssid = self.nameTextField.text;
        ((EZWifiConfigViewController *)[segue destinationViewController]).password = self.passwordTextField.text;
    }
}

- (IBAction)nextAction:(id)sender
{
    [self performSegueWithIdentifier:@"go2WifiConfig" sender:nil];
}

@end
