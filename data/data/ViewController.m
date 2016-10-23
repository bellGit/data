//
//  ViewController.m
//  RegisterViewController
//
//  Created by Mac on 16/8/17.
//  Copyright © 2016年 Mac. All rights reserved.
//
#import "UserAndPwdDAO.h"
#import "ViewController.h"
#import "RegisterViewController.h"
#import "ForgotViewController.h"

#import "SearchViewController.h"
#import "DataTableViewController.h"

@interface ViewController ()<UITextFieldDelegate>
-(void)saveTextFieldUserIdAndPwd;
-(void)getErrormessage;


@property(strong,nonatomic)NSString *errorMessage;
@end

@implementation ViewController
//@synthesize selectederrorMessage;
//@synthesize type_pwd,type_id;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screen=[[UIScreen mainScreen]bounds];
    
   self.navigationItem.title=@"登录";
    
    UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"R&D_back.png"]];
    bgView.frame = CGRectMake((screen.size.width - 100)/2, 80, 100, 120);
    [self.view addSubview:bgView];
   
    /// 1.添加用户ID：标签
    UILabel* labelId = [[UILabel alloc] initWithFrame:CGRectMake(40,250, 68, 21)];
    labelId.text = @"用户ID：";
    [self.view addSubview:labelId];
  /// 2.添加用户ID TextField
    self.textFieldId = [[UITextField alloc] initWithFrame:CGRectMake(100, 245, 150, 30)];
   
    self.textFieldId.delegate=self;
    self.textFieldId.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldId.placeholder=@"输入邮箱";
    self.textFieldId.clearButtonMode=UITextFieldViewModeAlways;
    [self.view addSubview:self.textFieldId];
    
    /// 1.添加用户ID：标签
    UILabel* labelemail = [[UILabel alloc] initWithFrame:CGRectMake(250,250, 150, 21)];
    labelemail.text = @"@lifetime.com";
[self.view addSubview:labelemail];
    
    /// 3.添加密码：标签
    UILabel* labelPwd = [[UILabel alloc] initWithFrame:CGRectMake(40, 320, 51, 21)];
    labelPwd.text = @"密码：";
    [self.view addSubview:labelPwd];
    
    /// 4.添加密码 TextField
    UITextField* textFieldPwd = [[UITextField alloc] initWithFrame:CGRectMake(100, 315, 200, 30)];
    self._textFieldPwd=textFieldPwd;
    textFieldPwd.borderStyle = UITextBorderStyleRoundedRect;
    textFieldPwd.delegate=self;
    textFieldPwd.secureTextEntry=true;
    [self.view addSubview:textFieldPwd];
    textFieldPwd.placeholder=@"输入密码";
   textFieldPwd.clearButtonMode=UITextFieldViewModeAlways;
    
    /// 5.添加 登录按钮
    UIButton* buttonLogin = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonLogin.frame = CGRectMake((screen.size.width - 280)/2, 400, 280, 35);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB( );
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.48f, 0.60f, 1.0f, 1.0f});
    [buttonLogin.layer setBackgroundColor:colorref];
    [buttonLogin.layer setCornerRadius:10.0f];
    [buttonLogin setTitle:@"登录" forState:UIControlStateNormal];
    buttonLogin.titleLabel.font=[UIFont systemFontOfSize:18];
    [ buttonLogin addTarget:self action:@selector(clickLogIn:) forControlEvents:UIControlEventTouchUpInside];
    [buttonLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:buttonLogin];
    
    /// 6.添加 注册按钮
    UIButton* buttonReg = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonReg.frame = CGRectMake((screen.size.width - 280)/2, 450, 280, 35);
    [buttonReg setTitle:@"注册" forState:UIControlStateNormal];
    [buttonReg.layer setBackgroundColor:colorref];
    [buttonReg.layer setCornerRadius:10.0f];
     buttonReg.titleLabel.font=[UIFont systemFontOfSize:18];
    [buttonReg setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [buttonReg addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buttonReg];
    /// 5.添加 忘记密码按钮
    UIButton* buttonFG = [UIButton buttonWithType:UIButtonTypeSystem];
     buttonFG.frame = CGRectMake((screen.size.width - 280)/2, 490, 280, 35);
     [buttonFG addTarget:self action:@selector(clickForget:) forControlEvents:UIControlEventTouchUpInside];
  
    [buttonFG setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [buttonFG setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:buttonFG];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerCompletion:) name:@"RegisterCompletionNotification" object:nil];
//   self.view.backgroundColor = [UIColor grayColor];
    
   
}
-(void)saveTextFieldUserIdAndPwd{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"textfieldUserId"];
    [settings removeObjectForKey:@"textfieldPwd"];
    [settings setObject:self.textFieldId.text forKey:@"textfieldUserId"];
    [settings setObject:self._textFieldPwd.text forKey:@"textfieldPwd"];
    [settings synchronize];
}

-(void)clickLogIn:(id)sender{
    [self saveTextFieldUserIdAndPwd];
    UserAndPwdDAO *dao=[UserAndPwdDAO sharedInstance];
   [dao logIn];

    [self getErrormessage];
    if ([self.errorMessage isEqualToString:@"登陆成功"]) {
     
                    UITabBarController *tabBarControll=[[UITabBarController alloc]init];
            SearchViewController* searchViewController1 = [[SearchViewController alloc] init];
            UINavigationController* navigationController1 = [[UINavigationController alloc] initWithRootViewController:searchViewController1];
            navigationController1.tabBarItem.title = @"精确查找";
            navigationController1.tabBarItem.image = [UIImage imageNamed:@"accurateSearch"];
            
            //设置表格标签
            DataTableViewController* dataTableViewController2 = [[DataTableViewController alloc] init];
            UINavigationController* navigationController2 = [[UINavigationController alloc] initWithRootViewController:dataTableViewController2];
            navigationController2.tabBarItem.title = @"表格查询";
            navigationController2.tabBarItem.image = [UIImage imageNamed:@"tableSearch"];
            tabBarControll.viewControllers = @[navigationController1, navigationController2];
        [self.navigationController presentViewController:tabBarControll animated:YES completion:nil];
    }else{
       NSLog(@"error=%@",self.errorMessage);
         [self warning];
//
    }
   
   
   
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
-(void)clickForget:(id)sender{
    NSLog(@"忘记密码");
  ForgotViewController *forgotViewController=[[ForgotViewController alloc]init];
    UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:forgotViewController];
    
   [self presentViewController:navigationController animated:TRUE completion:nil];
}

-(void)signUp:(id)sender{
    RegisterViewController *registerViewController=[[RegisterViewController alloc]init];
    UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:registerViewController];
    [self presentViewController:navigationController animated:TRUE completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)registerCompletion:(NSNotification*)notification{
    NSDictionary *theData=[notification userInfo];
    NSString *username=theData[@"username"];
    NSLog(@"username=%@",username);
    

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"return");
    [self.textFieldId resignFirstResponder];
    [self._textFieldPwd resignFirstResponder];
    return YES;
}

-(void)  touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textFieldId resignFirstResponder];
    [self._textFieldPwd resignFirstResponder];
}

@end
