//
//  WDBaseScene+MonsterLocation.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/14.
//

#import "WDBaseScene.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDBaseScene (MonsterLocation)

/// 设置怪物出生位置以及动画
- (void)setMLocationAndSave:(WDEnemyNode *)node;
- (void)setSmokeWithMonster:(WDBaseNode *)monsterNode
                       name:(NSString *)nameStr;

@end

NS_ASSUME_NONNULL_END
