//
//  RegisterViewController.m
//  RegisterViewController
//
//  Created by Mac on 16/8/17.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "RegisterViewController.h"
#import "ViewController.h"
@interface RegisterViewController ()<UITextFieldDelegate>

@property(strong,nonatomic)UITextField *_signUpUser;
@property(strong,nonatomic)UITextField *_signUpPwd;
@property(strong,nonatomic)UITextField *_signUpPwdAg;
@property(strong,nonatomic)UITextField *_signUpCode;
@property(strong,nonatomic)NSString *errorMessage;
-(IBAction)cancel:(id)sender;
@property(strong,nonatomic)UIButton* buttonVC;
-(void)saveSignUpUserIdAndPwd;

@end

@implementation RegisterViewController

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
    UILabel* labelemail = [[UILabel alloc] initWithFrame:CGRectMake(250,195, 150, 21)];
    labelemail.text = @"@lifetime.com";
    [self.view addSubview:labelemail];
    /// 1.添加用户ID：标签
    UILabel* labelId = [[UILabel alloc] initWithFrame:CGRectMake(40,195, 68, 21)];
    labelId.text = @"用户ID：";
    [self.view addSubview:labelId];
    /// 2.添加用户ID TextField
    UITextField* signUpUser = [[UITextField alloc] initWithFrame:CGRectMake(100, 190, 150, 30)];
    self._signUpUser=signUpUser;
    signUpUser.delegate=self;
    signUpUser.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:signUpUser];
    
    /// 3.添加密码：标签
    UILabel* labelPwd = [[UILabel alloc] initWithFrame:CGRectMake(55, 240, 51, 21)];
    labelPwd.text = @"密码：";
    [self.view addSubview:labelPwd];
    
    /// 4.添加密码 TextField
    UITextField* signUpPwd = [[UITextField alloc] initWithFrame:CGRectMake(100, 235, 200, 30)];
    self._signUpPwd=signUpPwd;
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
    self._signUpPwdAg=signUpPwdAg;
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
    self._signUpCode=textfieldCode;
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

    /// 8.添加 注册按钮
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB( );
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.48f, 0.60f, 1.0f, 1.0f});
    UIButton* buttonReg = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonReg.frame = CGRectMake((screen.size.width - 280)/2, 400, 280, 35);
    [buttonReg setTitle:@"注册" forState:UIControlStateNormal];
    [buttonReg.layer setBackgroundColor:colorref];
    [buttonReg.layer setCornerRadius:10.0f];
    buttonReg.titleLabel.font=[UIFont systemFontOfSize:18];
    [buttonReg setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [buttonReg addTarget:self action:@selector(signUpComplete:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buttonReg];
    
}

-(void)saveSignUpUserIdAndPwd{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"signUpUser"];
    [settings removeObjectForKey:@"signUpPwd"];
    [settings removeObjectForKey:@"signUpPwdAg"];
    [settings removeObjectForKey:@"signUpCode"];
    [settings setObject:self._signUpUser.text forKey:@"signUpUser"];
    [settings setObject:self._signUpPwd.text forKey:@"signUpPwd"];
    [settings setObject:self._signUpPwdAg.text forKey:@"signUpPwdAg"];
    [settings setObject:self._signUpCode.text forKey:@"signUpCode"];
    [settings synchronize];
}
-(void)getErrormessage{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString* errMessage=[settings objectForKey:@"ErrorMessage"];
    self.errorMessage=errMessage;
}
-(void)warning{
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示信息" message:self.errorMessage
                                                                    preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"OK!" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:true completion:nil];
    
}
- (void)signUpComplete:(id)sender {
    [self saveSignUpUserIdAndPwd];
    UserAndPwdDAO *dao=[UserAndPwdDAO sharedInstance];
    [dao clickSignUp];
 [self getErrormessage];
   
    NSLog(@"errormessage:%@",self.errorMessage);
    if ([self.errorMessage isEqualToString:@"注册成功"]) {
      [self dismissViewControllerAnimated:TRUE completion:^{
            NSLog(@"关闭警告");
            ViewController *viewController=[[ViewController alloc]init];
        viewController.textFieldId.text=self._signUpUser.text;

            [dao saveUserNameAndPwd:self._signUpUser.text andPwd:self._signUpPwd.text];
        
      
          }];
       
    }
    else{
         [self warning];
        self._signUpCode.text=@"";
        self._signUpPwd.text=@"";
        self._signUpPwdAg.text=@"";
    }
    
   
}

- (void)cancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:^{
        NSLog(@"点击Cancel按钮，关闭模态视图");
    }];
}

- (void)sentEmailCode:(id)sender {
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCodeNotification:) name:@"codeNotification" object:nil];
    UserAndPwdDAO *dao=[UserAndPwdDAO sharedInstance];
    [dao sentVerificationCode];

        NSLog(@"发送邮件验证码");
   
}
-(void)showCodeNotification:(NSNotification*)notification{
    NSDictionary *icode=[notification userInfo];
    
    [self.buttonVC setTitle:[icode objectForKey:@"name"] forState:UIControlStateNormal];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self._signUpUser resignFirstResponder];
    [self._signUpPwd resignFirstResponder];
    [self._signUpPwdAg resignFirstResponder];
    [self._signUpCode resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self._signUpUser resignFirstResponder];
     [self._signUpPwd resignFirstResponder];
     [self._signUpPwdAg resignFirstResponder];
    [self._signUpCode resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
