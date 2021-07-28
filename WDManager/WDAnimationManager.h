//
//  WDAnimationManager.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDAnimationManager : NSObject
/// 被攻击刀光动画
+ (void)demageAnimation:(WDBaseNode *)node
                  point:(CGPoint)point
                  scale:(CGFloat)scale
              demagePic:(NSString *)imageName;

/// 加血数字动画
+ (void)addBloodNumberAnimation:(WDBaseNode *)node
                         number:(int)number;

/// 减血数字动画
+ (void)reduceBloodNumberAnimation:(WDBaseNode *)node
                            number:(int)number;

@end

NS_ASSUME_NONNULL_END
