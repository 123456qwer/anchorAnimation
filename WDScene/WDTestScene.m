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
  
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_priest omgFaceState];
}



@end
