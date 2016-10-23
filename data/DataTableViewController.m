//
//  DataTableViewController.m
//  data
//
//  Created by Mac on 16/10/8.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "DataTableViewController.h"
#import "DetailViewController.h"
#import "DatabaseBL.h"
@interface DataTableViewController ()<UISearchBarDelegate,UISearchResultsUpdating>
@property(nonatomic,strong)NSArray *listdata;
@property(nonatomic,strong)DatabaseBL *bl;
@property(nonatomic,strong)UISearchController *searchController;
@property(nonatomic,strong)NSMutableArray  *listFilterTeams;
@property(nonatomic,strong)DatabaseBL *bg;
@property(nonatomic,strong)NSString *strPD1;
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSInteger)scope;
@end

@implementation DataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=@"表格浏览";
    self.bl=[[DatabaseBL alloc]init];
    self.listdata=[self.bl findAllPdOrModel_NO];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadView:)name:@"reloadViewNotification" object:nil];
    
    [self filterContentForSearchText:@"" scope:-1];
    self.searchController=[[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater=self;
    self.searchController.dimsBackgroundDuringPresentation=false;
    self.searchController.searchBar.scopeButtonTitles=@[@"PD查询",@"Model NO查询"];
    self.searchController.searchBar.delegate=self;
    self.tableView.tableHeaderView=self.searchController.searchBar;
    self.searchController.searchBar.keyboardType=UIKeyboardTypeNumberPad;
    [self.searchController.searchBar sizeToFit];

}
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSInteger)scope{
    if ([searchText length]==0) {
        self.listFilterTeams=[NSMutableArray arrayWithArray:self.listdata];
        
        return;
      
        
    }

    NSPredicate *scopePredicate;
    NSArray *tempArray ;
    
    switch (scope) {
        case 0://中文 name字段是中文名
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.pd contains[c] %@",searchText];
            tempArray =[self.listdata filteredArrayUsingPredicate:scopePredicate];
            self.listFilterTeams = [NSMutableArray arrayWithArray:tempArray];
            break;
        case 1: //英文 image字段保存英文名
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.model_NO contains[c] %@",searchText];
            tempArray =[self.listdata filteredArrayUsingPredicate:scopePredicate];
            self.listFilterTeams = [NSMutableArray arrayWithArray:tempArray];
            break;
        default:
            //查询所有
            self.listFilterTeams = [NSMutableArray arrayWithArray:self.listdata];
            break;
    }
        }

-(void)reloadView:(NSNotification*)notification{
    NSMutableArray *resList=[notification object];
    self.listdata=resList;
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#pragma mark --实现表视图数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listFilterTeams count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    DatabaseB *information=self.listFilterTeams[indexPath.row];

    cell.textLabel.text =[NSString stringWithFormat:@"PD-%@,%@",information.pd,information.description1 ];
    

    cell.detailTextLabel.text=[NSString stringWithFormat:@"Model NO.%@",information.model_NO];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 
    NSString *StrModel_NO=cell.textLabel.text;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:StrModel_NO];
   [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,7)];
    [cell.textLabel setAttributedText:str];


    return cell;
}
#pragma mark --实现UISearchBarDelegate协议方法
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
 
  
    NSInteger selectedIndex=[indexPath row];
    DatabaseB *information=self.listFilterTeams[selectedIndex];
    DetailViewController *detailViewController=[[DetailViewController alloc]init];
    detailViewController.pd_detail=information.pd;
    [self.view willRemoveSubview:self.searchController.searchBar];
////    UINavigationController *navigationconrtoller=[[UINavigationController alloc]init];
//      navigationconrtoller.title=@" 详细信息";
//   [self.navigationController presentViewController:detailViewController animated:YES completion:nil];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
#pragma mark --实现UISearchResultsUpdating协议方法
-(void)viewWillDisappear:(BOOL)animated{
//    self.searchController.searchBar.hidden=YES;
//[self.searchController.searchBar removeFromSuperview];
//    [self.tableView.tableHeaderView removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated{
    self.searchController.searchBar.hidden=NO;
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = searchController.searchBar.text;
    //查询
    
    [self filterContentForSearchText:searchString scope:searchController.searchBar.selectedScopeButtonIndex];
    

    [self.tableView reloadData];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 [self.searchController.searchBar resignFirstResponder];
  
}


@end
