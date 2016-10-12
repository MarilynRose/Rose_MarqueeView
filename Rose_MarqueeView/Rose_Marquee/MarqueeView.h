//
//  MarqueeView.h
//  Rose_MarqueeView
//
//  Created by Marilyn_Rose on 2016/10/12.
//  Copyright © 2016年 Marilyn_Rose. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger ,moveStatus) {
    Start,
    Enter,
    End
};
@interface MarqueeView : UIView
@property (nonatomic,copy)void (^moveStatusBlock)(moveStatus);  //弹幕状态回调
/**
 *  初始化弹幕
 */
-(id)initWithComment:(NSString*)comment;
//开始动画
-(void)startAnimation;
//结束动画
-(void)stopAnimation;
@end
