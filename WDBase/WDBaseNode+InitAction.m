//
//  WDBaseNode+InitAction.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/24.
//

#import "WDBaseNode+InitAction.h"
/// 玩家
#import "WDKknightNode.h"
#import "WDPriestNode.h"
#import "WDArcherNode.h"
#import "WDWizardNode.h"

/// 怪物
#import "WDSolider1Node.h"
#import "WDSolider2BowNode.h"


static CGFloat allScale = 0.4;
@implementation WDBaseNode (InitAction)
/// 初始化方法
+ (id)initActionWithName:(NSString *)spriteName
               superNode:(WDBaseScene *)superNode
{
    NSString *selName = [NSString stringWithFormat:@"init%@Action:superNode:",spriteName];
    SEL sel = NSSelectorFromString(selName);
    if ([self respondsToSelector:sel]) {
        return [self performSelector:sel withObject:spriteName withObject:superNode];
    }

    return nil;
}

#pragma mark - singleHandAttack -
+ (void)singleAttackWithName:(NSString *)spriteName
                        node:(WDBaseNode *)node
                   superNode:(SKSpriteNode *)superNode{
    
    node.anchorPoint = CGPointMake(0.5, 0.5);
    node.name = spriteName;
    node.mode = Attack_singleHand;
    node.numberName = [NSString stringWithFormat:@"%@_%d",spriteName,spriteNumber ++];
    [node createUserNodeWithScale:allScale];
    [superNode addChild:node];
    
    [WDAttributeManager setSpriteAttribute:node];

}

#pragma mark - bowAttack -
+ (void)bowAttackWithName:(NSString *)spriteName
                     node:(WDBaseNode *)node
                superNode:(SKSpriteNode *)superNode{
    
    node.anchorPoint = CGPointMake(0.5, 0.5);
    node.name = spriteName;
    node.mode = Attack_bow;
    node.numberName = [NSString stringWithFormat:@"%@_%d",spriteName,spriteNumber ++];
    [node createUserNodeWithScale:allScale];
    [superNode addChild:node];
    
    [WDAttributeManager setSpriteAttribute:node];

}

#pragma mark - 玩家 -
#pragma mark - 骑士 -
+ (WDKknightNode *)initKnightAction:(NSString *)spriteName
                          superNode:(SKSpriteNode *)superNode{
    

    WDKknightNode *node = [[WDKknightNode alloc] init];
    node.size = CGSizeMake(145 * allScale, 300 * allScale);
    [self singleAttackWithName:spriteName node:node superNode:superNode];
    return node;
}

#pragma mark - 牧师 -
+ (WDPriestNode *)initPriestAction:(NSString *)spriteName
                         superNode:(SKSpriteNode *)superNode{
    
    WDPriestNode *node = [[WDPriestNode alloc] init];
    node.size = CGSizeMake(145 * allScale, 300 * allScale);
    [self singleAttackWithName:spriteName node:node superNode:superNode];
    return node;
}

#pragma mark - 弓箭手 -
+ (WDArcherNode *)initArcherAction:(NSString *)spriteName
                         superNode:(SKSpriteNode *)superNode{
    
    WDArcherNode *node = [[WDArcherNode alloc] init];
    node.size = CGSizeMake(145 * allScale, 300 * allScale);
    [self bowAttackWithName:spriteName node:node superNode:superNode];

    return node;
}

#pragma mark - 法师 -
+ (WDWizardNode *)initWizardAction:(NSString *)spriteName
                         superNode:(SKSpriteNode *)superNode{
    
    WDWizardNode *node = [[WDWizardNode alloc] init];
    node.size = CGSizeMake(145 * allScale, 300 * allScale);
    [self singleAttackWithName:spriteName node:node superNode:superNode];
    return node;
}


#pragma mark - 敌人 -
#pragma mark - 骷髅兵 -
+ (WDSolider1Node *)initSolider1Action:(NSString *)spriteName
                             superNode:(SKSpriteNode *)superNode{
   
    WDSolider1Node *node = [[WDSolider1Node alloc] init];
    node.size = CGSizeMake(145 * allScale, 300 * allScale);
    [self singleAttackWithName:spriteName node:node superNode:superNode];
    return node;
}

+ (WDSolider2BowNode *)initSolider2Action:(NSString *)spriteName
                                superNode:(SKSpriteNode *)superNode{
   
    WDSolider2BowNode *node = [[WDSolider2BowNode alloc] init];
    node.size = CGSizeMake(145 * allScale, 300 * allScale);
    [self bowAttackWithName:spriteName node:node superNode:superNode];
    return node;
}



@end
