//
//  WDArcherNode.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/24.
//

#import "WDArcherNode.h"

@implementation WDArcherNode
- (void)createUserNodeWithScale:(CGFloat)scale
{
    [super createUserNodeWithScale:scale];
    
    [self setAllArmor:@"ArcherArmor"];
    [self setHemletTexture:@"BowmanHelm"];
    
    [self setBow:@"FamilyBow"];
}

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
        [self attackAction:self.targetNode];
    }
}

- (void)attackAction:(WDBaseNode *)enemyNode
{
    if (self.position.x > enemyNode.position.x) {
        self.xScale = - fabs(self.xScale);
    }else{
        self.xScale =  fabs(self.xScale);
    }
    
    [super attackAction:enemyNode];
   
}


@end
