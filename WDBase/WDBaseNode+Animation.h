//
//  WDBaseNode+Animation.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/21.
//

#import "WDBaseNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDBaseNode (Animation)

/// 上半身运动
- (void)upBodyAction;

/// 左腿走
- (void)leftLegWalkAction;

/// 右腿走
- (void)rightLegWalkAction;

/// 右胳膊晃动
- (void)rightArmStandAction;

/// 左胳膊晃动
- (void)leftArmStandAction;

/// 单手武器攻击
- (void)singleAttackAction;

@end

NS_ASSUME_NONNULL_END
