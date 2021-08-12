//
//  WDAttributeManager.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/22.
//

#import "WDAttributeManager.h"

@implementation WDAttributeManager

+ (void)setSpriteAttribute:(WDBaseNode *)node
{
    NSString *selName = [NSString stringWithFormat:@"init%@Attribute:",node.name];
    SEL sel = NSSelectorFromString(selName);
    if ([self respondsToSelector:sel]) {
        [self performSelector:sel withObject:node];
    }
}

#pragma mark - 玩家人物 -
/// 初始化骑士数值
+ (void)initKnightAttribute:(WDBaseNode *)node{
    
    WDBaseModel *model = [[WDDataManager shareManager]searchData:kKinght];
    
    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
    node.BLOOD_INIT         = 300;
    node.BLOOD_LAST         = 300;
    node.ATK                = 20;
    node.ATK_WEAPON         = [model getSingleValueWithName:@"Equip_sword1h"];
    node.ATK_FLOAT          = 3;
    node.DEF                = 3 + [model getAllDefines];
    node.CADisplaySpeed     = 3;
    node.attackDistance     = 0;
    node.hateNumber         = 100;
}

/// 初始化牧师数值
+ (void)initPriestAttribute:(WDBaseNode *)node{
    
    WDBaseModel *model = [[WDDataManager shareManager]searchData:kPriest];

    node.animationWalkSpeed  = 220;
    node.animationRunSpeed   = 300;
    node.BLOOD_INIT          = 150;
    node.BLOOD_LAST          = 150;
    node.ATK                 = 20;
    node.ATK_WEAPON         = [model getSingleValueWithName:@"Equip_sword1h"];
    node.DEF                 = 0 + [model getAllDefines];
    node.CUR                 = 50;
    node.CUR_FLOAT           = 5;
    node.CADisplaySpeed      = 3;
    node.attackDistance      = 300;
    node.hateNumber          = 1;
}

/// 初始化弓箭手数值
+ (void)initArcherAttribute:(WDBaseNode *)node{
    WDBaseModel *model = [[WDDataManager shareManager]searchData:kArcher];

    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
    node.BLOOD_INIT         = 250;
    node.BLOOD_LAST         = 250;
    node.ATK                = 20;
    node.ATK_FLOAT          = 8;
    node.ATK_WEAPON         = [model getSingleValueWithName:@"Equip_bow"];
    node.DEF                = 0 + [model getAllDefines];
    node.CADisplaySpeed     = 3;
    node.attackDistance     = 300;
    node.hateNumber         = 2;
}

/// 初始化巫师数值
+ (void)initWizardAttribute:(WDBaseNode *)node{
    
    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
    node.BLOOD_INIT          = 100;
    node.BLOOD_LAST          = 100;
    node.ATK       = 20;
    node.CADisplaySpeed     = 3;
    node.attackDistance     = 300;
    node.hateNumber         = 2;
}

#pragma mark - 敌对人物 -
/// 士兵1
+ (void)initSolider1Attribute:(WDBaseNode *)node{
    
    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
    node.BLOOD_INIT          = 300;
    node.BLOOD_LAST          = 300;
    node.ATK       = 35;
    node.ATK_FLOAT  = 8;
    node.CADisplaySpeed     = 2;
}

/// 士兵2
+ (void)initSolider2Attribute:(WDBaseNode *)node{
    
    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
    node.BLOOD_INIT          = 150;
    node.BLOOD_LAST          = 150;
    node.ATK       = 40;
    node.ATK_FLOAT  = 8;
    node.CADisplaySpeed     = 2;
    node.attackDistance     = 400;
}

/// 蝙蝠
+ (void)initRedBatAttribute:(WDBaseNode *)node{
    
    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
    node.BLOOD_INIT         = 150;
    node.BLOOD_LAST         = 150;
    node.ATK                = 30;
    node.ATK_FLOAT          = 3;
    node.CADisplaySpeed     = 2;
    node.attackDistance     = 400;
}

/// BOSS1
+ (void)initBoss1Attribute:(WDBaseNode *)node{
    
    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
    node.BLOOD_INIT         = 3000;
    node.BLOOD_LAST         = 3000;
    node.ATK                = 20;
    node.ATK_FLOAT          = 20;
    node.CADisplaySpeed     = 2;
    node.attackDistance     = 500;
}

/// BOSS2
+ (void)initBoss2Attribute:(WDBaseNode *)node{
    
    node.animationWalkSpeed = 300;
    node.animationRunSpeed  = 400;
    node.BLOOD_INIT         = 300000;
    node.BLOOD_LAST         = 300000;
    node.ATK                = 30;
    node.ATK_FLOAT          = 30;
    node.CADisplaySpeed     = 2;
    node.attackDistance     = 500;
}

@end
