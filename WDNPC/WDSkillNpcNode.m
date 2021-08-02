//
//  WDSkillNpcNode.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/30.
//

#import "WDSkillNpcNode.h"

@implementation WDSkillNpcNode
- (void)createUserNodeWithScale:(CGFloat)scale
{
    [super createUserNodeWithScale:scale];
    

    [self setAllArmor:@"FireAdept"];

    [self standAction];
    
    [self setHairTexture:@"Dandy"];
    [self setEyeTexture:@"Eye6"];
    [self setMouthTexture:@"NO"];
    [self setEyeBrowsTexture:@"EyeBrows_Eyebrows"];
    [self setBeardTexture:@"VikingBeard"];
    [self setGlassTexture:@"SteampunkGlasses"];
    [self setRightShield:@"CardinalBook"];
    [self setLeftWeapon:@"ElderStaff"];
    
    //self.leftWeapon.zRotation = 0;
    
    SKEmitterNode *blueFire = [SKEmitterNode nodeWithFileNamed:@"BlueFire"];
    blueFire.zPosition = 1;
    blueFire.targetNode = self.parent;
    blueFire.position = CGPointMake(-10 * allScale, 235 * allScale);
    blueFire.name = @"blueFire";
    [self.leftWeapon addChild:blueFire];
}
@end
