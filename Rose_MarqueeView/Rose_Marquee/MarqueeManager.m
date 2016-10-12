//
//  MarqueeManager.m
//  Rose_MarqueeView
//
//  Created by Marilyn_Rose on 2016/10/12.
//  Copyright © 2016年 Marilyn_Rose. All rights reserved.
//

#import "MarqueeManager.h"

@interface MarqueeManager (){
    //运行的数组是否为空
    
    BOOL  _isEmpty;
}

//弹幕使用过程中的数据
@property (nonatomic,strong)NSMutableArray * bulletComments;

//存储弹幕view的数组变量
@property (nonatomic,strong)NSMutableArray * bulletViews;

//存储临时变量
@property (nonatomic,strong)NSMutableArray * tempAry;

@end

@implementation MarqueeManager

-(void)start{
    
    [self.bulletComments addObjectsFromArray:self.datasource];
    if (_isEmpty==NO&&self.tempAry.count==0) {
        [self initBulletComments];
        
    }
    
    
}
-(void)stop{
    
}

//初始化弹幕，随机分配弹幕轨迹
-(void)initBulletComments{
    
    if (self.bulletComments.count>0) {
        
        //从弹幕数组中逐一取出弹幕数据
        NSString * comment = [self.bulletComments firstObject];
        [self.bulletComments removeObjectAtIndex:0];
        //创建弹幕view
        [self creatBulletView:comment];
        
        
    }
    
    
}
//创建弹幕view
-(void)creatBulletView:(NSString*)comment{
    MarqueeView * view = [[MarqueeView alloc]initWithComment:comment];
    [self.bulletViews addObject:view];
    __weak typeof  (view) weakView = view;
    __weak typeof  (self) weakSelf = self;
    view.moveStatusBlock  =^(moveStatus status){
        switch (status) {
            case Start:
            {//弹幕开始进入屏幕，将变量加入bullerViews中
                [weakSelf.bulletViews addObject:weakView];
                [weakSelf.tempAry     addObject:@(1)];
                
                if (self.screenBlock) {
                    self.screenBlock(screenStart);
                }
            }
                break;
            case Enter:{
                //弹幕完全进入屏幕，判断是否还有其他内容，如果有，在弹幕轨迹中再次创建一个弹幕
                NSString * comment = [weakSelf nextComment];
                if (comment) {
                    [weakSelf creatBulletView:comment];
                    
                    _isEmpty = YES;
                }else{
                    _isEmpty = NO;
                }
                //完全进入后，这个时候清空数组，表明完全进入状态
                [weakSelf.tempAry removeAllObjects];
                
            }
                break;
            case End:{
                //弹幕飞出屏幕后，从bulletviews中删除，释放资源
                if ([weakSelf.bulletViews containsObject:weakView]) {
                    [weakView                     stopAnimation];
                    [weakSelf.bulletViews removeObject:weakView];
                }
                
                //判断屏幕上是否还有弹幕
                if (weakSelf.bulletViews.count==0) {
                    if (self.screenBlock) {
                        self.screenBlock(screenEnd);
                    }
                }
                
            }
            default:
                break;
        }
        
        
    };
    if (self.generateViewBlock) {
        self.generateViewBlock(view);
    }
    
}


//判断数据源是否还有下一条数据
-(NSString*)nextComment{
    if (self.bulletComments.count==0) {
        return nil;
    }
    NSString * comment = [self.bulletComments firstObject];
    if (comment) {
        [self.bulletComments removeObjectAtIndex:0];
    }
    return comment;
    
}

-(NSMutableArray*)datasource{
    if (!_datasource) {
        
        return _datasource = [NSMutableArray array];
    }
    return _datasource;
}
- (void)addRandomText:(NSString *)randomText
{
    if (randomText.length){
        
        [self.datasource addObject:randomText];
        [self start];
        [self.datasource removeObjectAtIndex:0];
        
        
        
    }
}



-(NSMutableArray*)bulletComments{
    if (!_bulletComments) {
        return _bulletComments = [NSMutableArray array];
    }
    return _bulletComments;
}

-(NSMutableArray*)tempAry{
    if (!_tempAry ) {
        return _tempAry = [NSMutableArray array];
    }
    return _tempAry;
}

-(NSMutableArray*)bulletViews{
    if (!_bulletViews) {
        return _bulletViews = [NSMutableArray array];
    }
    return _bulletViews;
}



@end
