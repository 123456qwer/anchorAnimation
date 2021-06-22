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

#pragma mark - 数据计算相关 -
///俩点之间的距离
+ (CGFloat)distanceBetweenPoints:(CGPoint)first
                         seconde:(CGPoint)second;

///俩点之间的角度
+ (CGFloat)angleForStartPoint:(CGPoint)startPoint
                     EndPoint:(CGPoint)endPoint;

///点击中敌人，确定人物要走到的位置
+ (CGPoint)calculateNodeMovePosition:(WDBaseNode *)user
                               enemy:(WDEnemyNode *)enemy;



#pragma mark - 图片计算相关 -
+ (NSArray *)curUserImage:(UIImage *)image;

+ (SKTexture *)textureWithArmorKeyName:(NSString *)name
                             armorName:(NSString *)armor;

+ (WDBaseNode *)textureWithKeyName:(NSString *)name;


+ (NSDictionary *)userImageDic;
+ (NSDictionary *)userArmorImageDic:(UIImage *)image;


@end

NS_ASSUME_NONNULL_END
