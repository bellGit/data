//
//  ViewController.h
//  RegisterViewController
//
//  Created by Mac on 16/8/17.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAndPwdDAO.h"
@class UserAndPwdDAO;
@interface ViewController : UIViewController

@property(strong,nonatomic)UITextField *textFieldId;
@property(strong,nonatomic)UITextField *_textFieldPwd;
@end

