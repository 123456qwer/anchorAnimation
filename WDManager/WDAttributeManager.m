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
    
    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
    node.initBlood          = 1000;
    node.lastBlood          = 1000;
    node.attackNumber       = 20;
    node.CADisplaySpeed     = 3;
    node.attackDistance     = 0;
    node.attackNumber       = 25;
    node.hateNumber         = 100;
}

/// 初始化牧师数值
+ (void)initPriestAttribute:(WDBaseNode *)node{
    
    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
    node.initBlood          = 500;
    node.lastBlood          = 500;
    node.attackNumber       = 20;
    node.cureNumber         = 50;
    node.CADisplaySpeed     = 3;
    node.attackDistance     = 300;
    node.hateNumber         = 1;
}

/// 初始化弓箭手数值
+ (void)initArcherAttribute:(WDBaseNode *)node{
    
    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
    node.initBlood          = 500;
    node.lastBlood          = 500;
    node.attackNumber       = 20;
    node.cureNumber         = 50;
    node.CADisplaySpeed     = 3;
    node.attackDistance     = 300;
    node.hateNumber         = 2;
}

/// 初始化牧师数值
+ (void)initWizardAttribute:(WDBaseNode *)node{
    
    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
    node.initBlood          = 500;
    node.lastBlood          = 500;
    node.attackNumber       = 20;
    node.CADisplaySpeed     = 3;
    node.attackDistance     = 300;
    node.hateNumber         = 2;
}

#pragma mark - 敌对人物 -
/// 士兵1
+ (void)initSolider1Attribute:(WDBaseNode *)node{
    
    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
    node.initBlood          = 600;
    node.lastBlood          = 600;
    node.attackNumber       = 0;
    node.CADisplaySpeed     = 2;
}

/// 士兵2
+ (void)initSolider2Attribute:(WDBaseNode *)node{
    
    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
    node.initBlood          = 300;
    node.lastBlood          = 300;
    node.attackNumber       = 0;
    node.CADisplaySpeed     = 2;
    node.attackDistance     = 400;
}

/// 蝙蝠
+ (void)initRedBatAttribute:(WDBaseNode *)node{
    
    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
    node.initBlood          = 150;
    node.lastBlood          = 150;
    node.attackNumber       = 20;
    node.CADisplaySpeed     = 2;
    node.attackDistance     = 400;
}

/// BOSS1
+ (void)initBoss1Attribute:(WDBaseNode *)node{
    
    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
    node.initBlood          = 3000;
    node.lastBlood          = 3000;
    node.attackNumber       = 20;
    node.CADisplaySpeed     = 2;
    node.attackDistance     = 400;
}

@end
