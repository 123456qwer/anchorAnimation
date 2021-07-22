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
#import "WDBaseNode+Emoji.h"

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
   
    self.bgNode = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"Forest"]]];
    [self addChild:self.bgNode];

    CGFloat bgScale = 2 * kScreenWidth / self.bgNode.size.width;
    self.bgNode.xScale = 1;
    self.bgNode.yScale = 1;

    
    _priest = [WDBaseNode initActionWithName:kPriest superNode:self position:CGPointMake(0, 0)];
//    _priest = [WDBaseNode initActionWithName:kPriest superNode:self];
//    _archer = [WDBaseNode initActionWithName:kArcher superNode:self];
//    _wizard = [WDBaseNode initActionWithName:kWizard superNode:self];
    self.selectNode = _priest;
    self.selectNode.arrowNode.hidden = NO;
    //self.hateNameArr = @[_knight.name,_priest.name,_archer.name,_wizard.name];
   // self.hateNameArr = @[_knight.name];
    
   // [WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(1, 0)];
    
//    [WDBaseNode initActionWithName:kSolider1 superNode:self position:CGPointMake(0, 0)];
    
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_priest omgFaceState];
}



@end
