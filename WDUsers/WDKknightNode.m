//
//  WDKknightNode.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/22.
//

#import "WDKknightNode.h"
#import "WDEnemyNode.h"
@implementation WDKknightNode

- (void)createUserNodeWithScale:(CGFloat)scale
{
    [super createUserNodeWithScale:scale];
    
    
    [self setAllArmor:@"KnightArmor"];
    [self setLeftWeapon:@"FamilySword"];
    [self setRightShield:@"SteelShield"];
    [self standAction];
}

#pragma mark - 复写 -
- (void)upDataAction
{
    [super upDataAction];
    
    if (self.state & Sprite_dead) {
        return;
    }
    
    if (self.targetNode.state & Sprite_dead) {
        self.targetNode = nil;
    }
    
    if (self.targetNode) {
        
        /// 行走方向
        if (self.targetNode.position.x > self.position.x) {
            self.xScale = fabs(self.xScale);
        }else{
            self.xScale = - fabs(self.xScale);
        }
        
        /// 攻击、走动、跑动状态不处理
        if (self.state & Sprite_attack) {
            return;
        }
        
        
        /// 超出距离
        int distanceX = fabs(self.position.x - self.targetNode.position.x);
        int distanceY = fabs(self.position.y - self.targetNode.position.y);
        WDEnemyNode *node = (WDEnemyNode *)self.targetNode;
        if (distanceX > self.size.width + node.randomAttackX || distanceY > self.size.height / 3.0) {
            CGPoint movePoint = [WDCalculateTool calculateNodeMovePosition:self enemy:self.targetNode];
            [self moveAction:movePoint];
            return;
        }
        ///可以攻击的状态
        [self attackAction:self.targetNode];
        
    }
}

- (void)beAttackAction:(WDBaseNode *)enemyNode
          attackNumber:(int)attackNumber{
   
    [super beAttackAction:enemyNode attackNumber:attackNumber];
    
    if ((!self.targetNode || self.targetNode.state & Sprite_dead) && !(self.state & Sprite_run || self.state & Sprite_walk) && [enemyNode isKindOfClass:[WDEnemyNode class]]) {
        self.targetNode = enemyNode;
    }
  
}



#pragma mark - 技能 -
- (void)skill1Action
{
   
}

- (void)skill2Action
{
    
}

- (void)skill3Action
{
    
}

- (void)skill4Action
{
    
}

- (void)skill5Action
{
    
}

@end
