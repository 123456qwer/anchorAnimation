//
//  WDKknightNode.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/22.
//

#import "WDKknightNode.h"
#import "WDEnemyNode.h"
#import "WDBaseNode+Animation.h"

@implementation WDKknightNode

- (void)createUserNodeWithScale:(CGFloat)scale
{
    [super createUserNodeWithScale:scale];
    
    WDBaseModel *model = [[WDDataManager shareManager]searchData:kKinght];
    
    [self setArmorWithModel:model];

    [self standAction];
    [self setEyeTexture:@"Eye_knight"];

    
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
        [self standAction];
    }
    
    if (self.state & Sprite_attack) {
        [self removeLegAnimation];
        return;
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
        if (distanceX > self.attackMaxSize + node.attackMaxSize || distanceY > self.size.height / 3.0 || distanceX < self.attackMinSize) {
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
    [WDNotificationManager addHateWithNode:self];
    
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


- (void)dealloc
{
    NSLog(@"11111");
}

@end
