//
//  EZInputSerialViewController.m
//  EZOpenSDKDemo
//
//  Created by DeJohn Dong on 15/10/28.
//  Copyright © 2015年 hikvision. All rights reserved.
//

#import "EZInputSerialViewController.h"
#import "DDKit.h"

@interface EZInputSerialViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIButton *nextButton;
@property (nonatomic, weak) IBOutlet UITextField *serialTextField;

@end

@implementation EZInputSerialViewController

- (void)dealloc
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"ad_input_manual", @"手动输入");
    
    self.serialTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    self.serialTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.serialTextField dd_addSeparatorWithType:ViewSeparatorTypeVerticalSide];
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

#pragma mark - UITextFieldDelegate Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.serialTextField == textField)
    {
        NSString *strTemp = [NSString stringWithFormat:@"%@%@", textField.text, string];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.serialTextField.text.length == 9) {
                self.nextButton.enabled = YES;
            } else {
                self.nextButton.enabled = NO;
            }
        });
        if ([strTemp length] > 9)
        {
            return NO;
        }
        
        return YES;
    }
    return YES;
}

#pragma mark - Custom Methods

- (IBAction)go2Result:(id)sender
{
    [GlobalKit shareKit].deviceSerialNo = self.serialTextField.text;
    [self performSegueWithIdentifier:@"go2InputResult" sender:nil];
}

@end
