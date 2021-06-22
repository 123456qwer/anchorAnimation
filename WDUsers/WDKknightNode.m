//
//  WDKknightNode.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/22.
//

#import "WDKknightNode.h"

@implementation WDKknightNode

- (void)createUserNodeWithScale:(CGFloat)scale
{
    [super createUserNodeWithScale:scale];
    
    self.name = kKinght;
    self.mode = Attack_singleHand;
    
    [WDAttributeManager setSpriteAttribute:self];
    
    [self setAllArmor:@"KnightArmor"];
    [self setLeftWeapon:@"FamilySword"];
    [self setRightShield:@"SteelShield"];
    
    [self standAction];
}

@end
