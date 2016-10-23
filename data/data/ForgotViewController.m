//
//  ForgotViewController.m
//  RegisterViewController
//
//  Created by Mac on 16/10/2.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ForgotViewController.h"

@interface ForgotViewController ()<UITextFieldDelegate>

@property(strong,nonatomic)UITextField *_forgotUser;
@property(strong,nonatomic)UITextField *_forgotPwd;
@property(strong,nonatomic)UITextField *_forgotPwdAg;
@property(strong,nonatomic)UITextField *_forgotCode;
@property(strong,nonatomic)NSString *errorMessage;
-(void)saveForgotUserIdAndPwd;
-(IBAction)cancel:(id)sender;
@property(strong,nonatomic)UIButton* buttonVC;

@end

@implementation ForgotViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screen=[[UIScreen mainScreen]bounds];
    self.navigationItem.title=@"注册";
    
    UIBarButtonItem *canelButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
    self.navigationItem.leftBarButtonItem=canelButton;
    
    
    
    UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"R&D_back.png"]];
    bgView.frame = CGRectMake((screen.size.width - 100)/2, 70, 100, 120);
    [self.view addSubview:bgView];
    /// 1.添加用户ID：标签
    UILabel* labelId = [[UILabel alloc] initWithFrame:CGRectMake(40,195, 68, 21)];
    labelId.text = @"用户ID：";
    [self.view addSubview:labelId];
    /// 2.添加用户ID TextField
    UITextField* signUpUser = [[UITextField alloc] initWithFrame:CGRectMake(100, 190, 200, 30)];
    self._forgotUser=signUpUser;
    signUpUser.delegate=self;
    signUpUser.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:signUpUser];
    
    /// 3.添加密码：标签
    UILabel* labelPwd = [[UILabel alloc] initWithFrame:CGRectMake(55, 240, 51, 21)];
    labelPwd.text = @"密码：";
    [self.view addSubview:labelPwd];
    
    /// 4.添加密码 TextField
    UITextField* signUpPwd = [[UITextField alloc] initWithFrame:CGRectMake(100, 235, 200, 30)];
    self._forgotPwd=signUpPwd;
    signUpPwd.borderStyle = UITextBorderStyleRoundedRect;
    signUpPwd.delegate=self;
    signUpPwd.secureTextEntry=true;
    [self.view addSubview:signUpPwd];
    
    /// 5.添加再次输入密码：标签
    UILabel* labelPwdAg = [[UILabel alloc] initWithFrame:CGRectMake(20, 290, 100, 21)];
    labelPwdAg.text = @"再次输入：";
    [self.view addSubview:labelPwdAg];
    
    /// 6.添加再次输入密码 TextField
    UITextField* signUpPwdAg = [[UITextField alloc] initWithFrame:CGRectMake(100, 285, 200, 30)];
    self._forgotPwdAg=signUpPwdAg;
    signUpPwdAg.borderStyle = UITextBorderStyleRoundedRect;
    signUpPwdAg.delegate=self;
    signUpPwdAg.clearButtonMode=UITextFieldViewModeAlways;
    signUpPwdAg.secureTextEntry=true;
    [self.view addSubview:signUpPwdAg];
    
    /// 5.添加验证码：标签
    UILabel* labelCode= [[UILabel alloc] initWithFrame:CGRectMake(35, 335, 100, 21)];
    labelCode.text = @"验证码：";
    [self.view addSubview:labelCode];
    /// 6.添加验证码 TextField
    UITextField* textfieldCode = [[UITextField alloc] initWithFrame:CGRectMake(100, 330, 100, 30)];
    self._forgotCode=textfieldCode;
    textfieldCode.borderStyle = UITextBorderStyleRoundedRect;
    textfieldCode.delegate=self;
    textfieldCode.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:textfieldCode];
    
    /// 8.添加 发送邮件验证码按钮
    self.buttonVC = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonVC.frame = CGRectMake(200, 330, 150, 35);
    [self.buttonVC addTarget:self action:@selector(sentEmailCode:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonVC setTitle:@"发送邮件验证码" forState:UIControlStateNormal];
    [self.buttonVC setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self.view addSubview:self.buttonVC];
    
    /// 8.添加 完成修改按钮
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB( );
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.48f, 0.60f, 1.0f, 1.0f});
    UIButton* buttonReg = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonReg.frame = CGRectMake((screen.size.width - 280)/2, 400, 280, 35);
    [buttonReg setTitle:@"完成修改" forState:UIControlStateNormal];
    [buttonReg.layer setBackgroundColor:colorref];
    [buttonReg.layer setCornerRadius:10.0f];
    buttonReg.titleLabel.font=[UIFont systemFontOfSize:18];
    [buttonReg setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [buttonReg addTarget:self action:@selector(changeComplete:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buttonReg];
    
}
-(void)saveForgotUserIdAndPwd{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];

    [settings removeObjectForKey:@"signUpPwd"];
    [settings removeObjectForKey:@"signUpPwdAg"];
    [settings removeObjectForKey:@"signUpCode"];

    [settings setObject:self._forgotPwd.text forKey:@"forgotPwd"];
    [settings setObject:self._forgotPwdAg.text forKey:@"forgotPwdAg"];
    [settings setObject:self._forgotCode.text forKey:@"forgotCode"];
    [settings synchronize];
}
-(void)getErrormessage{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString* errMessage=[settings objectForKey:@"ErrorMessage"];
    self.errorMessage=errMessage;
}

- (void)changeComplete:(id)sender {
    [self saveForgotUserIdAndPwd];
    UserAndPwdDAO *dao=[UserAndPwdDAO sharedInstance];
    [dao clickCompleteChange];
    [self getErrormessage];


    NSLog(@"errormessage:%@",self.errorMessage);
    if ([self.errorMessage isEqualToString:@"修改成功"]) {
        [self dismissViewControllerAnimated:TRUE completion:^{
            NSLog(@"修改成功");
            
            [dao saveUserNameAndPwd:self._forgotUser.text andPwd:self._forgotPwd.text];
        }];
        
    }
    else{
        [self warning];
        self._forgotCode.text=@"";
        self._forgotPwd.text=@"";
        self._forgotPwdAg.text=@"";
    }
    
    
}
- (void)cancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:^{
        NSLog(@"点击Cancel按钮，关闭模态视图");
    }];
}
-(void)showCodeNotification:(NSNotification*)notification{
    NSDictionary *icode=[notification userInfo];
 
    [self.buttonVC setTitle:[icode objectForKey:@"name"] forState:UIControlStateNormal];

}
-(void)warning{
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示信息" message:self.errorMessage
                                                                    preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"OK!" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:true completion:nil];
    
}
- (void)sentEmailCode:(id)sender {
      NSLog(@"发送邮件验证码");
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCodeNotification:) name:@"codeNotification" object:nil];
    UserAndPwdDAO *dao=[UserAndPwdDAO sharedInstance];
    [dao sentVerificationCode];
  
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self._forgotUser resignFirstResponder];
    [self._forgotPwd resignFirstResponder];
    [self._forgotPwdAg resignFirstResponder];
    [self._forgotCode resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self._forgotUser resignFirstResponder];
    [self._forgotPwd resignFirstResponder];
    [self._forgotPwdAg resignFirstResponder];
    [self._forgotCode resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (id)copyWithZone:(NSZone *)zone{
//    ForgotViewController *forgotItem = [[ForgotViewController allocWithZone:zone] init];
//    self.forgot_id=self._forgotUser.text;
//    self.forgot_pwd=self._forgotPwd.text;
//    self.forgot_pwdAg=self._forgotPwdAg.text;
//    self.forgot_code=self._forgotCode.text;
//    forgotItem.forgot_id = self.forgot_id;
//    forgotItem.forgot_pwd = self.forgot_pwd;
//    forgotItem.forgot_pwdAg = self.forgot_pwdAg;
//    forgotItem.forgot_code = self.forgot_code;
//    return forgotItem;
//}
@end
