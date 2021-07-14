//
//  WDBaseScene+MonsterLocation.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/14.
//

#import "WDBaseScene+MonsterLocation.h"

@implementation WDBaseScene (MonsterLocation)

- (void)setMLocationAndSave:(WDEnemyNode *)node{
    node.state = Sprite_movie;
    node.targetNode = self.selectNode;
    [self.monsterArr addObject:node];
    [node setHateSprites:self.hateNameArr];
    [self setSmokeWithMonster:node name:node.name];
    
}

//烟雾出场
- (void)setSmokeWithMonster:(WDBaseNode *)monsterNode
                       name:(NSString *)nameStr
{
    
    WDBaseNode *node = [WDBaseNode spriteNodeWithTexture:self.textureManager.smokeArr[0]];
    monsterNode.position = [self appearPoint:monsterNode.position node:monsterNode];
    node.position = monsterNode.position;
    node.zPosition = 100000;
    node.name = @"smoke";
    node.xScale = 1.7;
    node.yScale = 1.7;
    [self addChild:node];
    SKAction *lightA = [SKAction animateWithTextures:self.textureManager.smokeArr timePerFrame:0.075];
    SKAction *alphaA = [SKAction fadeAlphaTo:0.2 duration:self.textureManager.smokeArr.count * 0.075];
    SKAction *r = [SKAction removeFromParent];
    SKAction *s = [SKAction sequence:@[[SKAction group:@[lightA,alphaA]],r]];
    
    [monsterNode runAction:[SKAction fadeAlphaTo:1 duration:self.textureManager.smokeArr.count * 0.075]];
    [node runAction:s completion:^{
        monsterNode.state = monsterNode.state ^ Sprite_movie;
    }];
}

/// 出场的位置
- (CGPoint)appearPoint:(CGPoint)point
                  node:(WDBaseNode *)node
{
    if (point.x == 0) {
        
        int ax = 1;
        int ay = 1;
        if (arc4random() % 2 == 0) {
            ax = -1;
        }
        if (arc4random() % 2 == 0) {
            ay = -1;
        }
        
        CGFloat x = (arc4random() % (int)kScreenWidth) ;
        CGFloat y = (arc4random() % (int)kScreenHeight) ;
        
        point = CGPointMake(x * ax, y * ay);
        
        ///从屏幕外出现
        if (arc4random() % 2 == 0) {
            
            if (point.x > 0) {
                point.x = kScreenWidth - node.size.width;
            }else{
                point.x = -kScreenWidth + node.size.width * 2.0;
            }
            
        }else{
            
            if (point.y > 0) {
                point.y = kScreenHeight - node.size.height;
            }else{
                point.y = -kScreenHeight + node.size.height;
            }
            
        }
        
    }
    
    return point;
}

@end
