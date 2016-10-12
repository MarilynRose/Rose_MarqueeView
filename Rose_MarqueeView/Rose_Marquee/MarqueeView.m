//
//  MarqueeView.m
//  Rose_MarqueeView
//
//  Created by Marilyn_Rose on 2016/10/12.
//  Copyright © 2016年 Marilyn_Rose. All rights reserved.
//
#define padding 50//弹幕间隔
#define ImgWidth 16
#define labHeight 30

#define SPEED   115
#import "MarqueeView.h"
#import "FaceManager.h"

@interface MarqueeView ()

@property(nonatomic,strong)UILabel * marqueeLabel;

@end

@implementation MarqueeView

-(id)initWithComment:(NSString *)comment{
    self = [super init];
    if (self) {
        
        NSString *str = [FaceManager removeEmoji:comment];
        
        
        //弹幕长度
        CGSize    langeSize  = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0]}];
        
        CGFloat width = langeSize.width;
        
        int count = [FaceManager reckonEmojiCountWithString:comment];
        //计算弹幕实际宽度
        self.bounds   = CGRectMake(0, 0,width+count*15+2*padding, labHeight);
        self.marqueeLabel.attributedText  =  [FaceManager emotionStrWithString:comment];
        self.marqueeLabel.frame = CGRectMake(padding, 20, width+count*15, 30);
        self.marqueeLabel.backgroundColor = [UIColor redColor];

    }
    return self;
}

//开始动画
-(void)startAnimation{
    
    /**
     *  根据弹幕长度执行动画
     */
    CGFloat secreenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat wholeWidth   = secreenWidth + CGRectGetWidth(self.bounds);
    
    //设置过屏幕的时间
    
    CGFloat duration     = wholeWidth/SPEED;
    //弹幕开始
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Start);
    }
    
    //完全进入
    //t = s/v
    //固定速度
    CGFloat enterDuration = CGRectGetWidth(self.bounds)/SPEED;
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration];
    
    
    __block  CGRect frame = self.frame;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        frame.origin.x -= wholeWidth;
        self.frame      = frame;
    } completion:^(BOOL finished) {
        if (self.moveStatusBlock) {
            self.moveStatusBlock(End);
        }
    }];
    
}

-(void)enterScreen{
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Enter);
        
    }
}
//结束动画
-(void)stopAnimation{
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}
-(UILabel*)marqueeLabel{
    if (!_marqueeLabel) {
        
        _marqueeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _marqueeLabel.lineBreakMode   =NSLineBreakByClipping;
        _marqueeLabel.font = [UIFont systemFontOfSize:14];
        _marqueeLabel.textAlignment = NSTextAlignmentCenter;
        _marqueeLabel.textColor     = [UIColor blackColor];
        [self addSubview:_marqueeLabel];
    }
    return _marqueeLabel;
}


@end
