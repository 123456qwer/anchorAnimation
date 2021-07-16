//
//  WDBaseNode+InitAction.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/24.
//

#import "WDBaseNode.h"

NS_ASSUME_NONNULL_BEGIN
@class WDBaseScene;
@interface WDBaseNode (InitAction)
/// 初始化方法(骨骼动画系列)
+ (id)initActionWithName:(NSString *)spriteName
               superNode:(WDBaseScene *)superNode
                position:(CGPoint)initPoint;

/// 初始化方法(帧动画系列)
+ (id)initTextureActionWithName:(NSString *)spriteName
                      superNode:(WDBaseScene *)superNode
                      initPoint:(CGPoint)initPoint;

@end

NS_ASSUME_NONNULL_END
