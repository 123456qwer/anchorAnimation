//
//  WDCalculateTool.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "WDBaseNode.h"
NS_ASSUME_NONNULL_BEGIN

@interface WDCalculateTool : NSObject

/// 数据计算相关
+ (SKTexture *)textureWithArmorKeyName:(NSString *)name
                             armorName:(NSString *)armor;

+ (WDBaseNode *)textureWithKeyName:(NSString *)name;

/// 图片计算相关
+ (NSArray *)curUserImage:(UIImage *)image;

+ (NSDictionary *)userImageDic;
+ (NSDictionary *)userArmorImageDic:(UIImage *)image;


@end

NS_ASSUME_NONNULL_END
