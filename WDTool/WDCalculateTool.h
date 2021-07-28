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

///人物要走到目标的位置点（近战）
+ (CGPoint)calculateNodeMovePosition:(WDBaseNode *)attackNode
                               enemy:(WDBaseNode *)targetNode;
///人物要走到目标的位置点（远程）
+ (CGPoint)calculateNodeMovePositionForBow:(WDBaseNode *)attackNode
                                     enemy:(WDBaseNode *)targetNode;

///人物可以走的极限距离
+ (CGPoint)calculateMaxMovePosition:(CGPoint)movePoint
                               node:(WDBaseNode *)node;

/// 搜索
+ (WDBaseNode *)searchMonsterNearNode:(WDBaseNode *)node;
+ (WDBaseNode *)searchUserNearNode:(WDBaseNode *)node;
+ (WDBaseNode *)searchUserRandomNode:(WDBaseNode *)node;
+ (WDBaseNode *)searchUserBigDistanceNode:(WDBaseNode *)node;

#pragma mark - 图片计算相关 -
+ (SKTexture *)textureWithArmorKeyName:(NSString *)name
                             armorName:(NSString *)armor;

+ (WDBaseNode *)textureWithKeyName:(NSString *)name;
+ (WDBaseNode *)textureWithKeyNameForSkeleton:(NSString *)name;


+ (NSDictionary *)userArmorImageDic:(UIImage *)image;
+ (NSArray *)cutBow:(UIImage *)image;

+ (NSArray *)curImageWithImage:(UIImage *)image
                          line:(NSInteger)line
                       arrange:(NSInteger)arrange
                      itemSize:(CGSize)imageSize
                         count:(NSInteger)count;

+ (NSArray *)arrWithLine:(NSInteger)line
                 arrange:(NSInteger)arrange
               imageSize:(CGSize)imageSize
           subImageCount:(NSInteger)count
                   image:(UIImage *)image
           curImageFrame:(CGRect)frame;



+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

@end

NS_ASSUME_NONNULL_END
