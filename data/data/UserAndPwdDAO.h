//
//  UserAndPwdDAO.h
//  persistenceLayer
//
//  Created by Mac on 16/10/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ViewController;
@class ForgotViewController;
@class RegisterViewController;
@interface UserAndPwdDAO : UIViewController<NSCopying>
{
    NSString *_errormessage;
  
}
@property (nonatomic,copy) NSString *_errormessage;

+ (UserAndPwdDAO *)sharedInstance;
-(void)logIn;
-(void)clickCompleteChange;
-(void)clickSignUp;
-(void)sentVerificationCode;
-(void)saveUserNameAndPwd:(NSString *)userName andPwd:(NSString *)pwd;
-(void)saveErrormessage:(NSString*)error_Message;

-(void)getUserNameAndPwd;
@property(strong,nonatomic)NSString *errMessage;

@property(strong,nonatomic)NSString *user1;
@property(strong,nonatomic)NSString *temp;
@property(nonatomic,strong)NSString *codecontent;

@property(nonatomic,copy)ForgotViewController *selectedForgot;
-(void)getTextFieldUserIdAndPwd;
@property(strong,nonatomic)NSString *logInUserName;
@property(strong,nonatomic)NSString *logInPwd;
-(void)getSignUpUserIdAndPwd;
@property(strong,nonatomic)NSString *signUpUserName;
@property(strong,nonatomic)NSString *signUpPwd;
@property(strong,nonatomic)NSString *signUpPwdAg;
@property(strong,nonatomic)NSString *signUpCode;
-(void)getForgotUserIdAndPwd;
@property(strong,nonatomic)NSString  *forgotPwd;
@property(strong,nonatomic)NSString  *forgotPwdAg;
@property(strong,nonatomic)NSString  *forgotCode;
@end
