//
//  WDSolider2BowNode.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/29.
//

#import "WDSolider2BowNode.h"

@implementation WDSolider2BowNode
- (void)createUserNodeWithScale:(CGFloat)scale
{
    [super createUserNodeWithScale:scale];
    
  
    self.head.texture = [WDTextureManager shareManager].skeletonHead;
    self.hemlet.texture = nil;
    self.hair.texture = nil;
    self.eye.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"Eye_Zombies1"]];
    self.ear.texture = nil;
//    [self setAllArmor:@"KnightArmor"];
//    [self setLeftWeapon:@"HunterShortBow"];
//    [self setRightShield:@"SteelShield"];
    [self setBow:@"HunterShortBow"];
    [self standAction];
    

    
    CGFloat dirctionX = 1;
    CGFloat dirctionY = 1;

    if (arc4random() % 2 == 0) {
        dirctionX = -1;
    }
    
    if (arc4random() % 2 == 0) {
        dirctionY = -1;
    }
    
//    self.randomAttackX = (arc4random() % (int)(self.size.width / 3)) * dirctionX;
//    self.randomAttackY = (arc4random() % (int)(self.size.height / 3)) * dirctionY;
    self.randomAttackY = 0;
    self.randomAttackX = 0;
    
}

- (WDBaseNode *)textureWithKeyName:(NSString *)name{
    return [WDCalculateTool textureWithKeyNameForSkeleton:name];
}


- (void)upDataAction{
    [super upDataAction];
    
}


@end
