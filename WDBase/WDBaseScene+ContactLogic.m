//
//  WDBaseScene+ContactLogic.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/25.
//

#import "WDBaseScene+ContactLogic.h"

@implementation WDBaseScene (ContactLogic)

- (void)contactLogicAction:(SKPhysicsContact *)contact{

    WDBaseNode *nodeA = (WDBaseNode *)contact.bodyA.node;
    WDBaseNode *nodeB = (WDBaseNode *)contact.bodyB.node;
    
    ///弓箭触碰到敌人
    if ([nodeA.name isEqualToString:@"user_arrow"]) {
        int numer = nodeA.attackNumber;
        if ([nodeB isKindOfClass:[WDEnemyNode class]]) {
            [nodeB beAttackAction:nodeA attackNumber:numer];
            WDArcherNode *node = (WDArcherNode *)[self childNodeWithName:kArcher];
            [nodeB addHateNumberWithAttackNode:node];
            //弓箭手吸血技能
//            if (node.skill4) {
//                [node setBloodNodeNumber:-numer];
//            }
        }
    }else if([nodeB.name isEqualToString:@"user_arrow"]){
        int numer = nodeB.attackNumber;
        if ([nodeA isKindOfClass:[WDEnemyNode class]]) {
            [nodeA beAttackAction:nodeB attackNumber:numer];
            WDArcherNode *node = (WDArcherNode *)[self childNodeWithName:kArcher];
            [nodeA addHateNumberWithAttackNode:node];
            //弓箭手吸血技能
//            if (node.skill4) {
//                [node setBloodNodeNumber:-numer];
//            }
        }
    }
    
    ///弓箭触碰玩家
    if ([nodeA.name isEqualToString:@"enemy_arrow"]) {
        int numer = nodeA.attackNumber;
        [nodeA removeAllActions];
        [nodeA removeFromParent];
        if ([nodeB isKindOfClass:[WDUserNode class]]) {
            [nodeB beAttackAction:nodeA attackNumber:numer];
        }
    }else if([nodeB.name isEqualToString:@"enemy_arrow"]){
        int numer = nodeB.attackNumber;
        [nodeB removeAllActions];
        [nodeB removeFromParent];
        if ([nodeA isKindOfClass:[WDUserNode class]]) {
            [nodeA beAttackAction:nodeB attackNumber:numer];
        }
    }
    
    
    ///冰火触碰(牧师)
    if ([nodeA.name isEqualToString:@"iceFire"] && ![nodeB isKindOfClass:[WDUserNode class]]) {
        CGFloat numer = 10;
        [nodeA removeFromParent];
        WDPriestNode *node = (WDPriestNode *)[self childNodeWithName:kPriest];
        [nodeB addHateNumberWithAttackNode:node];
        if ([nodeB isKindOfClass:[WDEnemyNode class]]) {
            [nodeB beAttackAction:nodeA attackNumber:numer];
        }
        
    }else if([nodeB.name isEqualToString:@"iceFire"] && ![nodeA isKindOfClass:[WDUserNode class]]){
        CGFloat numer = 10;
        [nodeB removeFromParent];
        WDPriestNode *node = (WDPriestNode *)[self childNodeWithName:kPriest];
        [nodeA addHateNumberWithAttackNode:node];
        if ([nodeA isKindOfClass:[WDEnemyNode class]]) {
            [nodeA beAttackAction:nodeB attackNumber:numer];
        }
    }
    
    
    ///wizardFire
    if ([nodeA.name isEqualToString:@"wizardFire"] && ![nodeB isKindOfClass:[WDUserNode class]]) {
        CGFloat numer = 10;
        [nodeA removeFromParent];
        WDWizardNode *node = (WDWizardNode *)[self childNodeWithName:kWizard];
        [nodeB addHateNumberWithAttackNode:node];
        if ([nodeB isKindOfClass:[WDEnemyNode class]]) {
            [nodeB beAttackAction:nodeA attackNumber:numer];
        }
        
    }else if([nodeB.name isEqualToString:@"wizardFire"] && ![nodeA isKindOfClass:[WDUserNode class]]){
        CGFloat numer = 10;
        [nodeB removeFromParent];
        WDWizardNode *node = (WDWizardNode *)[self childNodeWithName:kWizard];
        [nodeA addHateNumberWithAttackNode:node];
        if ([nodeA isKindOfClass:[WDEnemyNode class]]) {
            [nodeA beAttackAction:nodeB attackNumber:numer];
        }
    }
    
}


@end
