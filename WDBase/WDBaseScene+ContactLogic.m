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
        int numer = nodeA.ATK;
        if ([nodeB isKindOfClass:[WDEnemyNode class]]) {
            WDArcherNode *node = (WDArcherNode *)[self childNodeWithName:kArcher];
            [nodeB addHateNumberWithAttackNode:node];
            [nodeB beAttackAction:node attackNumber:numer];
            //弓箭手吸血技能
//            if (node.skill4) {
//                [node setBloodNodeNumber:-numer];
//            }
        }
    }else if([nodeB.name isEqualToString:@"user_arrow"]){
        int numer = nodeB.ATK;
        if ([nodeA isKindOfClass:[WDEnemyNode class]]) {
            WDArcherNode *node = (WDArcherNode *)[self childNodeWithName:kArcher];
            [nodeA addHateNumberWithAttackNode:node];
            [nodeA beAttackAction:node attackNumber:numer];
            //弓箭手吸血技能
//            if (node.skill4) {
//                [node setBloodNodeNumber:-numer];
//            }
        }
    }
    
    ///弓箭触碰玩家
    if ([nodeA.name isEqualToString:@"enemy_arrow"]) {
        int numer = nodeA.ATK;
        [nodeA removeAllActions];
        [nodeA removeFromParent];
        if ([nodeB isKindOfClass:[WDUserNode class]]) {
            [nodeB beAttackAction:nodeA attackNumber:numer];
        }
    }else if([nodeB.name isEqualToString:@"enemy_arrow"]){
        int numer = nodeB.ATK;
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
            [nodeB beAttackAction:node attackNumber:numer];
        }
        
    }else if([nodeB.name isEqualToString:@"iceFire"] && ![nodeA isKindOfClass:[WDUserNode class]]){
        CGFloat numer = 10;
        [nodeB removeFromParent];
        WDPriestNode *node = (WDPriestNode *)[self childNodeWithName:kPriest];
        [nodeA addHateNumberWithAttackNode:node];
        if ([nodeA isKindOfClass:[WDEnemyNode class]]) {
            [nodeA beAttackAction:node attackNumber:numer];
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
        [self weaponAttackAction:nodeA weaponNode:nodeB];
    }else if([nodeB isKindOfClass:[WDUserNode class]] && [nodeA isKindOfClass:[WDWeaponNode class]]){
        [self weaponAttackAction:nodeB weaponNode:nodeA];
    }
    
}

/// 怪物释放出的招式
- (void)weaponAttackAction:(WDBaseNode *)userNode
                weaponNode:(WDBaseNode *)weaponNode
{
    CGFloat attackNumber = weaponNode.ATK;
    
    if ([weaponNode.name isEqualToString:@"BlueFire"]) {
        
        /// BOSS2蓝色烟火攻击，需要用身体挡住
        SKEmitterNode *node = (SKEmitterNode *)weaponNode.parent;
        [node removeAllActions];
        SKAction *alpha = [SKAction scaleTo:0 duration:0.5];
        [node runAction:[SKAction sequence:@[alpha,REMOVE_ACTION]] completion:^{
                        
        }];
        
        
        [userNode beAttackAction:weaponNode attackNumber:attackNumber];

        
    }else {
        
        [userNode beAttackAction:weaponNode attackNumber:attackNumber];
        
    }
    
}

/// 被BOSS的吹风攻击
- (void)windContactAction:(WDBaseNode *)windNode
                     user:(WDBaseNode *)userNode
{
   // userNode.paused = YES;
    userNode.state = userNode.state | Sprite_movie;
    [userNode removeAllActions];
    [userNode beAttackAction:windNode attackNumber:windNode.ATK];
   // userNode.reduceBloodNow = NO;
   // userNode.colorBlendFactor = 0;
   // [NSObject cancelPreviousPerformRequestsWithTarget:userNode];
    
    [windNode removeAllActions];
    windNode.physicsBody = nil;
    CGPoint point = CGPointZero;
    if (windNode.direction == 1) {
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
