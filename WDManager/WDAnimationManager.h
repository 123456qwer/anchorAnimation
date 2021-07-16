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
@end

NS_ASSUME_NONNULL_END
