//
//  ViewController.m
//  Rose_MarqueeView
//
//  Created by Marilyn_Rose on 2016/10/12.
//  Copyright © 2016年 Marilyn_Rose. All rights reserved.
//

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHigth [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "MarqueeManager.h"
#import "MarqueeView.h"
#import "FaceManager.h"
@interface ViewController (){
    UIView     * _backView;
    MarqueeView * _bulletView;
}
@property (nonatomic,strong)MarqueeManager * manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(200, 300, 50, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(run) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"跑" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    
    [self creatMatqueeView];

}

-(void)run{
    
    NSString *string =  @"[吐]上[OK][菜刀][色][象棋]jdfkalsflksafklasf";
    
     [self.manager addRandomText:string];
    

}


-(void)creatMatqueeView{
    /**
     * 添加跑马灯
     */
    self.manager = [[MarqueeManager alloc]init];
    
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kWidth, 30)];
    _backView.backgroundColor = [UIColor colorWithWhite:0.333 alpha:1];
    _backView.hidden         = YES;
    
    __weak typeof(_backView)  weakBackView = _backView;
    __weak typeof(self) weakSelf = self;
    
    
    self.manager.generateViewBlock = ^(MarqueeView * view){
        
        [weakSelf addMarqueeView:view];
        
    };
    
    self.manager.screenBlock       =^(screenStatus status){
        switch (status) {
            case screenStart:
            {
                weakBackView.hidden = NO;
            }
                break;
            case screenEnd:{
                weakBackView.hidden = YES;
            }
                
            default:
                break;
        }
        
    };
    
    
    [self.view addSubview:_backView];
}


-(void)addMarqueeView:(MarqueeView*)marqueeView{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    marqueeView.frame    = CGRectMake(width, 0, CGRectGetWidth(marqueeView.bounds), CGRectGetHeight(marqueeView.bounds));
    [self.view addSubview:marqueeView];
    [marqueeView startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
