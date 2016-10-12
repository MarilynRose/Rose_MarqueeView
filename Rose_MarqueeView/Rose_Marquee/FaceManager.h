//
//  FaceManager.h
//  Rose_MarqueeView
//
//  Created by Marilyn_Rose on 2016/10/12.
//  Copyright © 2016年 Marilyn_Rose. All rights reserved.
//
#define kFaceIDKey          @"face_id"
#define kFaceNameKey        @"face_name"
#define kFaceImageNameKey   @"face_image_name"

#define kFaceRankKey        @"face_rank"
#define kFaceClickKey       @"face_click"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FaceManager : NSObject
+ (instancetype)shareInstance;



#pragma mark - emoji表情相关

/**
 *  获取所有的表情图片名称
 *
 *  @return 所有的表情图片名称
 */
+ (NSArray *)emojiFaces;

+ (NSString *)faceImageNameWithFaceID:(NSUInteger)faceID;

+ (NSString *)faceNameWithFaceID:(NSUInteger)faceID;
/**
 *  将文字中带表情的字符处理换成图片显示
 *
 *  @param text 未处理的文字
 *
 *  @return 处理后的文字
 */
+ (NSMutableAttributedString *)emotionStrWithString:(NSString *)text;


#pragma mark - 最近表情相关处理

/**
 *  获取最近使用的表情图片
 *
 *  
 */
+ (NSArray *)recentFaces;


/**
 *  存储一个最近使用的face
 *
 *  @param dict 包含以下key-value键值对
 *  face_id     表情id
 *  face_name   表情名称
 *  @return 是否存储成功
 */
+ (BOOL)saveRecentFace:(NSDictionary *)dict;

+ (int)reckonEmojiCountWithString:(NSString *)string;

+(NSString *)removeEmoji:(NSString *)text;
@end
