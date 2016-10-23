//
//  DetailViewController.m
//  data
//
//  Created by Mac on 16/10/8.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "DataTableViewController.h"
#import "DetailViewController.h"
#import "DatabaseBL.h"

@interface DetailViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)NSArray *listdata;
@property(nonatomic,strong)DatabaseBL *bl;
@property(nonatomic,weak)id detailItem;

@property(nonatomic,strong)NSArray *viewControllers;
@property(nonatomic,strong)NSString *pdNmuber;
@property (strong, nonatomic) UIImageView *assemblyView;
@property (strong, nonatomic) UIImageView *panelView;
@property (strong, nonatomic) UIImageView *frameView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIScrollView *scrollView;




//懒加载优化图片加载
-(void)loadImage:(NSInteger)nextPage;
- (IBAction)changePage:(id)sender;
@end

@implementation DetailViewController
{
    CGFloat lastScale;
    CGRect oldFrame;    //保存图片原来的大小
    CGRect largeFrame;  //确定图片放大最大的程度
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.bl=[[DatabaseBL alloc]init];
 

    DatabaseB *information=[self.bl findPD:self.pd_detail];
    self.title=@"详细信息";
    
    self.pdNmuber=information.pd;
    //Description label
   self.pdNmuber=@"1204";
    //PD label
    UILabel *pdLable=[[UILabel alloc]initWithFrame:CGRectMake(40, 80, 60, 40)];
    pdLable.text=@"PD：";
    [self.view addSubview:pdLable];
    //PD textlabel

    UILabel *pdTextLable=[[UILabel alloc]initWithFrame:CGRectMake(100, 80, 60, 40)];
    pdTextLable.text=self.pdNmuber;
    pdTextLable.textColor=[UIColor blueColor];
    
    [self.view addSubview:pdTextLable];
    //Model label
    UILabel *modelLable=[[UILabel alloc]initWithFrame:CGRectMake(190, 80, 150, 40)];
    modelLable.text=@"Model：";
    [self.view addSubview:modelLable];
    //Model textlabel
    UILabel *modelTextLable=[[UILabel alloc]initWithFrame:CGRectMake(260, 80, 100, 40)];
    modelTextLable.text=[NSString stringWithFormat:@"%@",information.model_NO];
     modelTextLable.textColor=[UIColor blueColor];
    [self.view addSubview:modelTextLable];
    
    //Panel_wg label
    UILabel *panel_wgLable=[[UILabel alloc]initWithFrame:CGRectMake(40, 120, 100, 40)];
    panel_wgLable.text=@"Panel Wg：";
    [self.view addSubview:panel_wgLable];
    //panel_wg  textlabel
    UILabel *panel_wgTextLable=[[UILabel alloc]initWithFrame:CGRectMake(130, 120, 80, 40)];
    panel_wgTextLable.text=[NSString stringWithFormat:@"%@",information.panel_wg];
      panel_wgTextLable.textColor=[UIColor blueColor];
    [self.view addSubview:panel_wgTextLable];
    //frame_wg label
    UILabel *frame_wgLable=[[UILabel alloc]initWithFrame:CGRectMake(190, 120, 100, 40)];
    frame_wgLable.text=@"Frame Wg：";
    [self.view addSubview:frame_wgLable];
    //frame_wg  textlabel
    UILabel *frame_wgTextLable=[[UILabel alloc]initWithFrame:CGRectMake(280, 120, 80, 40)];
    frame_wgTextLable.text=[NSString stringWithFormat:@"%@",information.frame_wg];
     frame_wgTextLable.textColor=[UIColor blueColor];
    [self.view addSubview:frame_wgTextLable];
    //Total_wg label
    UILabel *total_wgLable=[[UILabel alloc]initWithFrame:CGRectMake(40, 160, 100, 40)];
    total_wgLable.text=@"Total Wg：";
    [self.view addSubview:total_wgLable];
    //Total_wg  textlabel
    UILabel *total_wgTextLable=[[UILabel alloc]initWithFrame:CGRectMake(130, 160, 100, 40)];
    total_wgTextLable.text=[NSString stringWithFormat:@"%@",information.total_wg];
    total_wgTextLable.textColor=[UIColor blueColor];
    [self.view addSubview:total_wgTextLable];
    UILabel *descriptionLable=[[UILabel alloc]initWithFrame:CGRectMake(15, 200, 200, 40)];
    descriptionLable.text=@"Description：";
    [self.view addSubview:descriptionLable];
    //Description  textlabel
    UILabel *descriptionTextLable=[[UILabel alloc]initWithFrame:CGRectMake(115, 200, 300, 40)];
    descriptionTextLable.text=[NSString stringWithFormat:@"%@",information.description1];
    descriptionTextLable.textColor=[UIColor blueColor];
    [self.view addSubview:descriptionTextLable];
    //Folded Dimensionlabel
    UILabel *folded_DimensionLable=[[UILabel alloc]initWithFrame:CGRectMake(16, 240, 200, 40)];
    folded_DimensionLable.text=@"Folded Dimension：";
    [self.view addSubview:folded_DimensionLable];
    //Folded Dimension  textlabel
    UILabel *folded_DimensionTextLable=[[UILabel alloc]initWithFrame:CGRectMake(180, 240, 200, 40)];
    folded_DimensionTextLable.text=[NSString stringWithFormat:@"%@",information.folded_Dimension];
     folded_DimensionTextLable.textColor=[UIColor blueColor];
    [self.view addSubview:folded_DimensionTextLable];
    //unFolded Dimensionlabel
    UILabel *unfolded_DimensionLable=[[UILabel alloc]initWithFrame:CGRectMake(15, 280, 200, 40)];
    unfolded_DimensionLable.text=@"Unfolded Dimension：";
    [self.view addSubview:unfolded_DimensionLable];
    //unFolded Dimension  textlabel
    UILabel *unfolded_DimensionTextLable=[[UILabel alloc]initWithFrame:CGRectMake(180, 280, 200, 40)];
    unfolded_DimensionTextLable.text=[NSString stringWithFormat:@"%@",information.unfolded_Dimension];
     unfolded_DimensionTextLable.textColor=[UIColor blueColor];
    [self.view addSubview:unfolded_DimensionTextLable];
//    加上scroll View
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    
    self.scrollView.delegate = self;
    
    self.scrollView.contentSize  = CGSizeMake(self.view.frame.size.width*3, self.scrollView.frame.size.height);
    self.scrollView.frame = self.view.frame;
    self.scrollView.pagingEnabled = TRUE;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    self.scrollView.showsVerticalScrollIndicator = FALSE;
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.frame.size.width-300)/2, self.view.frame.size.height-80, 300.0f, 37.0f)];

    [self.pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    self.pageControl.numberOfPages = 3;
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents: UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];

//加入imageView
    CGFloat imageView_X=0;
    CGFloat imageView_Y=360;
    CGFloat imageView_Width=self.view.frame.size.width;
    CGFloat imageView_height=self.view.frame.size.height-imageView_Y-60;
    
        self.assemblyView = [[UIImageView alloc] initWithFrame:CGRectMake(imageView_X, imageView_Y, imageView_Width, imageView_height)];
     NSString *assemblyimageName=[NSString stringWithFormat:@"pd%@assembly.png",self.pdNmuber];
  
    self.assemblyView.image = [UIImage imageNamed:assemblyimageName];
    [self.scrollView addSubview:self.assemblyView];
   
    [self shakeToShow:self.assemblyView];
    self.assemblyView.userInteractionEnabled = YES;
    self.panelView.userInteractionEnabled = YES;
    self.frameView.userInteractionEnabled = YES;
 //双击图片放大
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    // 连续敲击2次
    tap.numberOfTapsRequired = 2;
    // 需要1根手指敲击
    tap.numberOfTouchesRequired = 1;
    
    [tap addTarget:self action:@selector(tapIconView:)];
    [self.assemblyView addGestureRecognizer:tap];
  
 //单击缩小图片
    UITapGestureRecognizer *tapone = [[UITapGestureRecognizer alloc] init];
    // 敲击1次
    tapone.numberOfTapsRequired = 1;
//    双击失效时单击才有用

    [tapone requireGestureRecognizerToFail:tap];
    
    [self.assemblyView addGestureRecognizer:tapone];

    [tapone addTarget:self action:@selector(tapOne:)];
   
 //增加捏合手势
    UIPinchGestureRecognizer *pinchGes=[[UIPinchGestureRecognizer alloc]
                                        
                                        initWithTarget:self action:@selector(pinchView:)];
    self.assemblyView.userInteractionEnabled=YES;
     self.assemblyView.multipleTouchEnabled = YES;
  [self.assemblyView addGestureRecognizer:pinchGes];
    
 

    pinchGes.delegate=self;
    
}
- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGes{
   
    UIView *view = pinchGes.view;
    if (view.frame.size.height>=600) {
        view.transform=CGAffineTransformScale(view.transform, pinchGes.scale, pinchGes.scale);
        pinchGes.scale=1;
        NSLog(@" 捏合图片");
    }

}
-(void)tapOne:(UIPinchGestureRecognizer *)tap{
    UIImageView *imageView=(UIImageView*)tap.view;
     NSLog(@"d图片");
    [UIView beginAnimations:nil context:nil];
 
    //    结束动画
    NSLog(@"%f",imageView.frame.size.height);
  
    if (imageView.frame.size.height>500) {
        
     imageView.transform=CGAffineTransformRotate(imageView.transform, 268.608);
    if (self.pageControl.currentPage==1) {
        imageView.frame=CGRectMake(375, 360, 375, 247);
    }else if (self.pageControl.currentPage==2){
        imageView.frame=CGRectMake(375*2, 360, 375, 247);
    }else{
        imageView.frame=CGRectMake(0, 360, 375, 247);
    }
    }
    [UIView setAnimationDuration:0.5];
    [UIView commitAnimations];

}
-(void)tapIconView:(UIPinchGestureRecognizer *)tap{
    NSLog(@"双击图片");
//获取原来的视图
    UIImageView *imageView=(UIImageView*)tap.view;
//    动画效果函数
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
 
    NSLog(@"%f",imageView.frame.size.height);
    if (imageView.frame.size.height<350) {
        
     imageView.transform=CGAffineTransformRotate(imageView.transform, 89.535467);
    if (self.pageControl.currentPage==1) {
        imageView.frame=CGRectMake(375, 67, 375, 600);
    }else if (self.pageControl.currentPage==2){
        imageView.frame=CGRectMake(375*2, 67, 375, 600);
    }else{
        imageView.frame=CGRectMake(0, 67, 375, 600);
    }
    }
    
//    结束动画
    [UIView commitAnimations];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) scrollViewDidScroll: (UIScrollView *) scrollView {
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = offset.x / 320.0f;
    [self loadImage:self.pageControl.currentPage+1];
}

#pragma mark --实现UIPageControl事件处理
- (IBAction)changePage:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        NSInteger whichPage = self.pageControl.currentPage;
        self.scrollView.contentOffset = CGPointMake(320.0f * whichPage, 0.0f);
    }];
}
//lazy load
-(void)loadImage:(NSInteger)nextPage{
    CGFloat imageView_Y=360;
    CGFloat imageView_Width=self.view.frame.size.width;
    CGFloat imageView_height=self.view.frame.size.height-imageView_Y-60;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    // 连续敲击2次
    tap.numberOfTapsRequired = 2;
    // 需要1根手指敲击
    tap.numberOfTouchesRequired = 1;
    
    [tap addTarget:self action:@selector(tapIconView:)];
    
    UITapGestureRecognizer *tapone = [[UITapGestureRecognizer alloc] init];
    // 敲击1次
    tapone.numberOfTapsRequired = 1;
    //    双击失效时单击才有用
    [tapone addTarget:self action:@selector(tapOne:)];
    [tapone requireGestureRecognizerToFail:tap];
     self.panelView.userInteractionEnabled = YES;
    self.frameView.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *pinchGes=[[UIPinchGestureRecognizer alloc]
                                        
                                        initWithTarget:self action:@selector(pinchView:)];
 
    self.panelView.multipleTouchEnabled = YES;

    self.frameView.multipleTouchEnabled = YES;
    if(nextPage==1&&self.panelView==nil){
        
        NSString *panelimageName=[NSString stringWithFormat:@"pd%@panel.png",self.pdNmuber];
        self.panelView = [[UIImageView alloc] initWithFrame:CGRectMake(imageView_Width, imageView_Y, imageView_Width, imageView_height)];
        self.panelView.image = [UIImage imageNamed:panelimageName];
        [self.scrollView addSubview:self.panelView];
        [self.panelView addGestureRecognizer:tap];
        [self.panelView addGestureRecognizer:tapone];
        [self.panelView addGestureRecognizer:pinchGes];
        
    }
    if (nextPage==2&&self.frameView==nil) {
        NSString *frameImageView=[NSString stringWithFormat:@"pd%@frame.png",self.pdNmuber];
        self.frameView = [[UIImageView alloc] initWithFrame:CGRectMake(2 * imageView_Width, imageView_Y, imageView_Width, imageView_height)];
        self.frameView.image = [UIImage imageNamed:frameImageView];
        [self.scrollView addSubview:self.frameView];
    [self.frameView addGestureRecognizer:tap];
        [self.frameView addGestureRecognizer:tapone];
        [self.frameView addGestureRecognizer:pinchGes];
    }
    
}

@end
