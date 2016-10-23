//
//  UserAndPwdDAO.m
//  persistenceLayer
//
//  Created by Mac on 16/10/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "UserAndPwdDAO.h"
#import "ViewController.h"
#import "RegisterViewController.h"
#import "ForgotViewController.h"
@implementation UserAndPwdDAO
@synthesize _errormessage;
@synthesize selectedForgot;

static UserAndPwdDAO *sharedSingleton = nil;

+ (UserAndPwdDAO *)sharedInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedSingleton = [[super alloc] init];
        
    });
    return sharedSingleton;
}
-(void)getTextFieldUserIdAndPwd{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString* textFieldUserId=[settings objectForKey:@"textfieldUserId"];
    NSString* textFieldPwd=[settings objectForKey:@"textfieldPwd"];
    self.logInUserName=textFieldUserId;
    self.logInPwd=textFieldPwd;
}
-(void)logIn{
    [self getTextFieldUserIdAndPwd];
    [self getUserNameAndPwd];
    if ([self.logInUserName isEqualToString:self.user1]&&[self.logInPwd isEqualToString: self.temp]) {
        NSLog(@"登陆成功");
        self.errMessage=@"登陆成功";
        [self saveErrormessage:self.errMessage];
    }else{
        self.errMessage=[NSString stringWithFormat:@"账户或密码错误"];
        [self saveErrormessage:self.errMessage];
    }
}
-(void)sentVerificationCode{
    int x=100000;
    int y=999999;
    int z=arc4random()%y+x;
   self.codecontent=[NSString stringWithFormat:@"%i",z];
    NSLog(@"code=%@",self.codecontent);
[[NSNotificationCenter defaultCenter] postNotificationName:@"codeNotification"  object:self  userInfo:@{@"name":self.codecontent}];
}
-(void)getSignUpUserIdAndPwd{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString* txtsignUpUserId=[settings objectForKey:@"signUpUser"];
    NSString* txtsignUpPwd=[settings objectForKey:@"signUpPwd"];
     NSString* txtsignUpPwdAg=[settings objectForKey:@"signUpPwdAg"];
    NSString* txtsignUpCode=[settings objectForKey:@"signUpCode"];
   
    self.signUpUserName=txtsignUpUserId;
    self.signUpPwd=txtsignUpPwd;
    self.signUpPwdAg=txtsignUpPwdAg;
    self.signUpCode=txtsignUpCode;

}
//
-(void)clickSignUp{
    

    [self getSignUpUserIdAndPwd];
    if ([self.signUpCode isEqualToString:@""]) {
        self.errMessage=@"请输入验证码";
        [self saveErrormessage:self.errMessage];
        } else if ([self.signUpUserName isEqualToString:self.user1]) {
        self.errMessage=@"该账户已经注册";
        [self saveErrormessage:self.errMessage];
         }else if(![self.signUpPwd isEqualToString:self.signUpPwdAg]){
             self.errMessage=[NSString stringWithFormat:@"两次输入的密码不一致:%@,%@",self.signUpPwd,self.signUpPwdAg];
            [self saveErrormessage:self.errMessage];
        }else if (![self.signUpCode isEqualToString:self.codecontent ]){
        self.errMessage=@"验证码输入错误";
            
            [self saveErrormessage:self.errMessage];
    }else{
        self.errMessage=@"注册成功";
     [self saveErrormessage:self.errMessage];
        NSLog(@"注册成功");
    }

    

    
}
-(void)getForgotUserIdAndPwd{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];

    NSString* txtforgotPwd=[settings objectForKey:@"forgotPwd"];
    NSString* txtforgotPwdAg=[settings objectForKey:@"forgotPwdAg"];
    NSString* txtforgotCode=[settings objectForKey:@"forgotCode"];
    

    self.forgotPwd=txtforgotPwd;
    self.forgotPwdAg=txtforgotPwdAg;
    self.forgotCode=txtforgotCode;
    
}
-(void)clickCompleteChange{
    [self getForgotUserIdAndPwd];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"codeNotification"  object:self  userInfo:@{@"name":self.forgotCode}];
    if ([self.forgotCode isEqualToString:@""]) {
        self.errMessage=@"请输入验证码";
        [self saveErrormessage:self.errMessage];
    }else if(![self.forgotPwd isEqualToString:self.forgotPwdAg]){
            self.errMessage=@"两次输入的密码不一致";
        [self saveErrormessage:self.errMessage];
        }else if (![self.forgotCode isEqualToString:self.codecontent]){
            self.errMessage=@"验证码输入错误";
            [self saveErrormessage:self.errMessage];
    }else{
            self.errMessage=@"修改成功";
        [self saveErrormessage:self.errMessage];
            NSLog(@"修改成功");
        }
        
    }



-(void)saveErrormessage:(NSString*)error_Message{
     NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"ErrorMessage"];
    [settings setObject:error_Message forKey:@"ErrorMessage"];
    [settings synchronize];
}

-(void)saveUserNameAndPwd:(NSString *)userName andPwd:(NSString *)pwd{
    
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];

    [settings setObject:userName forKey:@"UserName"];
  [settings setObject:pwd forKey:@"Password"];
    [settings synchronize];
}
-(void)getUserNameAndPwd{
  
        NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
   self.user1=[settings objectForKey:@"UserName"];
        self.temp = [settings objectForKey:@"Password"];

    
    
   }

- (id)copyWithZone:(NSZone *)zone{
    UserAndPwdDAO *errorItem = [[UserAndPwdDAO allocWithZone:zone] init];
    errorItem._errormessage=self.errMessage;
   
   
    
    return errorItem;
}
@end
