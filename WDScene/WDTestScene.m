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
    self.bgNode.xScale = bgScale;
    self.bgNode.yScale = bgScale;

    
    _knight = [WDBaseNode initActionWithName:kKinght superNode:self position:CGPointMake(0, 0)];
//    _priest = [WDBaseNode initActionWithName:kPriest superNode:self];
//    _archer = [WDBaseNode initActionWithName:kArcher superNode:self];
//    _wizard = [WDBaseNode initActionWithName:kWizard superNode:self];
    self.selectNode = _knight;
    self.selectNode.arrowNode.hidden = NO;
    //self.hateNameArr = @[_knight.name,_priest.name,_archer.name,_wizard.name];
    self.hateNameArr = @[_knight.name];
    
    //[WDBaseNode initTextureActionWithName:kRedBat superNode:self position:CGPointMake(0, 0)];
    [WDBaseNode initActionWithName:kSolider1 superNode:self position:CGPointMake(0, 0)];
    
    _knight.position = CGPointMake(0, 0);
    _priest.position = CGPointMake(_priest.size.width, 0);
    _wizard.position = CGPointMake(-_priest.size.width, 0);
    _archer.position = CGPointMake(-_priest.size.width * 2.0, 0);
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForChangeUser object:self.selectNode.name];
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForHiddenSkill object:@(1)];

}



@end
