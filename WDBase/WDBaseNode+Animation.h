//
//  WDBaseNode+Animation.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/21.
//

#import "WDBaseNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDBaseNode (Animation)

/// 移除腿部的动画
- (void)removeLegAnimation;


- (void)upBodyActionForStand;
- (void)upBodyActionForWalk;
- (void)upBodyActionForRun;


/// 左腿走
- (void)leftLegMoveAction;
/// 右腿走
- (void)rightLegMoveAction;

/// 单手武器攻击
- (void)singleAttackAction:(WDBaseNode *)enemy;

///正常
- (void)normalFaceState;
///生气
- (void)angleFaceState;

@end

NS_ASSUME_NONNULL_END
