//
//  WDEnemyNode.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/25.
//

#import "WDBaseNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDEnemyNode : WDBaseNode
/// 随机的攻击站位
@property (nonatomic,assign)CGFloat randomAttackX;
@property (nonatomic,assign)CGFloat randomAttackY;
@property (nonatomic,strong)WDHateManager *hateManager;
/// 这个需要走移动动画，不是CA那个
@property (nonatomic,assign)BOOL isSkillBossMove;


/// 设置仇恨体系
- (void)setHateSprites:(NSArray *)names;

/// 设置物理碰撞尺寸
- (void)createMonsterAttackPhysicBodyWithPoint:(CGPoint)point
                                          size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
