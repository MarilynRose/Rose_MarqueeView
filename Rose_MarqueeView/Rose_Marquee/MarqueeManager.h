//
//  MarqueeManager.h
//  Rose_MarqueeView
//
//  Created by Marilyn_Rose on 2016/10/12.
//  Copyright © 2016年 Marilyn_Rose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarqueeView.h"
typedef NS_ENUM(NSInteger ,screenStatus) {
    screenStart,
    screenEnd
};
@interface MarqueeManager : NSObject

@property (nonatomic,copy) void (^generateViewBlock)(MarqueeView* view);

@property (nonatomic,copy) void (^screenBlock)(screenStatus);

//跑马灯的数据来源
@property (nonatomic,strong)NSMutableArray * datasource;

//跑马灯开始执行
-(void)start;

//跑马灯结束
-(void)stop;

- (void)addRandomText:(NSString *)randomText;

@end
