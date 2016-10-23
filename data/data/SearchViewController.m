//
//  SearchViewController.m
//  data
//
//  Created by Mac on 16/10/8.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "SearchViewController.h"
#import "DetailViewController.h"
@interface SearchViewController ()<UITextFieldDelegate>

@property(strong,nonatomic)UITextField *searchTextField;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=@"精确搜索";
    // 1.添加查找 label
    UILabel* labelId = [[UILabel alloc] initWithFrame:CGRectMake(45,230, 68, 21)];
    labelId.text = @"查找：";
    [self.view addSubview:labelId];
    // 2.添加查找 TextField
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 225, 200, 30)];
    self.searchTextField.delegate=self;

    self.searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.searchTextField.placeholder=@"PD";
    self.searchTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.searchTextField.clearButtonMode=UITextFieldViewModeAlways;
    [self.view addSubview:self.searchTextField];
    // 3.添加查找按钮 picture
    UIButton *searchButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [searchButton setImage:[UIImage imageNamed:@"searchBar.png"] forState:UIControlStateNormal];
    searchButton.frame = CGRectMake(325, 225, 30, 30);
    [searchButton addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    // 4.添加底下说明文字
    UILabel* imformationLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,260, 300, 21)];
    imformationLabel.text = @"如查找:PD1204";
    imformationLabel.textColor=[UIColor blackColor];
    [self.view addSubview:imformationLabel];
    UILabel* imformationLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(100,280, 500, 21)];
    imformationLabel2.text = @"请输入1204";
imformationLabel2.textColor=[UIColor redColor];
    [self.view addSubview:imformationLabel2];

    
    

}
-(void)search:(id)sender{
    NSLog(@"开始查找");
    DetailViewController *detailViewController=[[DetailViewController alloc]init];
    detailViewController.pd_detail=self.searchTextField.text;
    [self.navigationController pushViewController:detailViewController animated:YES];
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.searchTextField resignFirstResponder];
        return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchTextField resignFirstResponder];

    
}
@end
