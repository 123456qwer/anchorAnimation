//
//  WDTestScene.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import "WDTestScene.h"
#import "WDKknightNode.h"
#import "WDSolider1Node.h"
#import "WDSolider2BowNode.h"

#import "WDPriestNode.h"
#import "WDArcherNode.h"
#import "WDWizardNode.h"

@implementation WDTestScene
{
    WDBaseNode *_head;
    WDBaseNode *_body;
    
    WDBaseNode *_leftArm;
    WDBaseNode *_leftElbow;
    WDBaseNode *_leftHand;
    
    WDBaseNode *_rightArm;
    WDBaseNode *_rightElbow;
    WDBaseNode *_rightHand;
    WDBaseNode *_rightFinger;
    
    WDBaseNode *_hip;
    
    WDBaseNode *_rightKnee;
    WDBaseNode *_rightFoot;
    
    WDBaseNode *_leftKnee;
    WDBaseNode *_leftFoot;
    
    NSTimeInterval _walkTime;
    WDKknightNode *_knight;
    WDPriestNode  *_priest;
    WDArcherNode  *_archer;
    WDWizardNode  *_wizard;
    
    WDSolider1Node    *_enemyNode;
    WDSolider1Node    *_enemyNode2;
    WDSolider2BowNode    *_enemyNode3;

    int a;
    int b;
    WDBaseNode *node;
}

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
  
    CGFloat bgScale = 2 * kScreenWidth / self.bgNode.size.width;
//    self.bgNode.xScale = bgScale;
//    self.bgNode.yScale = bgScale;
//   self.bgNode.
    
    
  
    _knight = [WDBaseNode initActionWithName:kKinght superNode:self];
    _priest = [WDBaseNode initActionWithName:kPriest superNode:self];
    _archer = [WDBaseNode initActionWithName:kArcher superNode:self];
    _wizard = [WDBaseNode initActionWithName:kWizard superNode:self];
    
    _enemyNode = [WDBaseNode initActionWithName:kSolider1 superNode:self];
    _enemyNode2 = [WDBaseNode initActionWithName:kSolider1 superNode:self];
    _enemyNode3 = [WDBaseNode initActionWithName:kSolider2 superNode:self];
    
    self.selectNode = _knight;
    self.selectNode.arrowNode.hidden = NO;
    
    
    _knight.position = CGPointMake(0, 0);
    _priest.position = CGPointMake(_priest.size.width, 0);
    _wizard.position = CGPointMake(-_priest.size.width, 0);
    _archer.position = CGPointMake(-_priest.size.width * 2.0, 0);
//
//
    NSArray *names = @[_knight.name,_priest.name,_archer.name,_wizard.name];
//    NSArray *names = @[_knight.name];

    [_enemyNode setHateSprites:names];
    [_enemyNode2 setHateSprites:names];
    [_enemyNode3 setHateSprites:names];
}

//- (void)update:(NSTimeInterval)currentTime
//{
//    [super update:currentTime];
//    [_enemyNode upDataAction];
//    [_enemyNode2 upDataAction];
//    [_wizard upDataAction];
//    [_knight upDataAction];
//    [_priest upDataAction];
//    [_archer upDataAction];
//
//    
//}

@end
