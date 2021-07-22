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

/// 行走动画
- (void)moveSameActionWithState:(SpriteState)moveState
                      movePoint:(CGPoint)movePoint;

/// 单手武器攻击
- (void)singleAttackAction:(WDBaseNode *)enemy;
///弓箭攻击
- (void)bowAttackAction:(WDBaseNode *)enemyNode;

/// 死亡动画
- (void)deadAnimation;

///减血
- (void)reduceBlood:(CGFloat)attackNumber;
///加血
- (void)addBlood:(int)cureNumber;

///出血动画
- (void)bleedAnimation:(CGFloat)attackNumber;

@end

NS_ASSUME_NONNULL_END
