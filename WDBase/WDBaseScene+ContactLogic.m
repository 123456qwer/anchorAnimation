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
    
    
    /// 风攻击导致瘫痪
    if ([nodeA isKindOfClass:[WDUserNode class]] && [nodeB.name isEqualToString:@"wind"]) {
        [self windContactAction:nodeB user:nodeA];
    }else if([nodeB isKindOfClass:[WDUserNode class]] && [nodeA.name isEqualToString:@"wind"]){
        [self windContactAction:nodeA user:nodeB];
    }
    
    
    /// 怪物攻击击中玩家
    if ([nodeA isKindOfClass:[WDUserNode class]] && [nodeB isKindOfClass:[WDWeaponNode class]]) {
        CGFloat numer = nodeB.attackNumber;
        [nodeA beAttackAction:nodeB attackNumber:numer];

        [self weaponAttackAction:nodeA weaponNode:nodeB];
    }else if([nodeB isKindOfClass:[WDUserNode class]] && [nodeA isKindOfClass:[WDWeaponNode class]]){
        CGFloat numer = nodeA.attackNumber;
        [nodeB beAttackAction:nodeA attackNumber:numer];
        [self weaponAttackAction:nodeB weaponNode:nodeA];
    }
    
}

/// 怪物释放出的招式
- (void)weaponAttackAction:(WDBaseNode *)userNode
                weaponNode:(WDBaseNode *)weaponNode
{
    /// 鬼魂召唤的巨斧攻击
//    if ([weaponNode.name isEqualToString:@"axe"]) {
//
//        userNode.state = SpriteState_movie;
//        userNode.isMoveAnimation = NO;
//        [userNode removeAllActions];
//
//        [userNode runAction:[SKAction moveTo:weaponNode.position duration:0.2] completion:^{
//            userNode.state = SpriteState_stand;
//        }];
//    }
    
    
    /// 鬼魂召唤的鬼爪
//    if ([weaponNode.name isEqualToString:@"hand"]) {
//
//        userNode.affect = SpriteAffect_reduceSpeed;
//        CGPoint point = CGPointMake(-60, userNode.realSize.height + 40);
//        CGFloat scale = 3.0;
//        if ([userNode.name isEqualToString:kArcher]) {
//            point = CGPointMake(-60, userNode.realSize.height + 40);
//            scale = 3.0;
//        }
//
//        [userNode setAffectWithArr:userNode.model.statusReduceArr point:point scale:scale count:3];
//    }
    
}

/// 被BOSS的吹风攻击
- (void)windContactAction:(WDBaseNode *)windNode
                     user:(WDBaseNode *)userNode
{
   // userNode.paused = YES;
    userNode.state = userNode.state | Sprite_movie;
    [userNode removeAllActions];
    
   // userNode.reduceBloodNow = NO;
   // userNode.colorBlendFactor = 0;
   // [NSObject cancelPreviousPerformRequestsWithTarget:userNode];
    
    [windNode removeAllActions];
    windNode.physicsBody = nil;
    CGPoint point = CGPointZero;
    if (windNode.direction == -1) {
        point = CGPointMake(kScreenWidth - 100, windNode.position.y);
    }else{
        point = CGPointMake(-kScreenWidth + 100, windNode.position.y);
    }
    
    NSTimeInterval time = fabs(point.x - (windNode.direction * 600)) / 2000;
    SKAction *wind = [SKAction animateWithTextures:[WDTextureManager shareManager].boss1Model.windArr timePerFrame:0.1];
    SKAction *moveAction = [SKAction moveTo:point duration:time];
    SKAction *alpha = [SKAction fadeAlphaTo:0 duration:0.4];
    SKAction *gg = [SKAction group:@[wind,moveAction]];
    SKAction *seq = [SKAction sequence:@[gg,alpha,[SKAction removeFromParent]]];
    [windNode runAction:seq completion:^{
                
    }];
    
    [userNode runAction:moveAction completion:^{
        userNode.state = userNode.state ^ Sprite_movie;
    }];
}

@end
