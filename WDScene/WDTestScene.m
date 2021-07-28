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
#import "WDBoss1Node.h"
#import "Boss1Node.h"

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
    WDBoss1Node *_bossNode;
    Boss1Node *_b;
    SKLabelNode *_label;
    
}

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
//    _b = [WDBaseNode initActionWithName:kBoss1 superNode:self position:CGPointMake(0, 0)];
////    _b.xScale = 2.0;
////    _b.yScale = 2.0;
//   
//    self.priest.position = CGPointMake(0, 0);
//    self.knight.position = CGPointMake(kScreenWidth - 300, 0);
//    self.knight.initBlood = 10000000;
//    self.knight.lastBlood = 10000000;
//    self.knight.xScale = 2.0;
//    self.knight.yScale = 2.0;
    
    
//Charter
    
    [self knight];
    
    
   
}

- (void)touchUpAtPoint:(CGPoint)pos{
    
    [super touchUpAtPoint:pos];
    [self.knight beAttackAction:self.priest attackNumber:5];
  
}

- (void)testBoss{
    [self knight];
    [self priest];
    [self archer];
    
    _bossNode = [WDBoss1Node initWithModel:self.textureManager.boss1Model];
    _bossNode.state = Sprite_movie;
    [self addChild:_bossNode];
    [self.monsterArr addObject:_bossNode];
    
    __weak typeof(self)weakSelf = self;
    [_bossNode moveToTheMap:^(BOOL isComplete) {
        for (WDBaseNode *node in weakSelf.userArr) {
            node.state = Sprite_stand;
        }
        
        [weakSelf noPassForBoss2];
    }];
    
    [WDNotificationManager hiddenSkillView:1];
}

- (void)bossCallMonster:(NSNotification *)notification{
    
    [WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(0, 0)];
    
}

- (void)noPassForBoss2{
    SKAction *animation = [SKAction animateWithTextures:_bossNode.boss1Model.winArr timePerFrame:0.15];
    _bossNode.state = Sprite_movie;
    [_bossNode.talkNode setText:@"你们还不够格哦"];
    __weak typeof(self)weakSelf = self;
    [_bossNode runAction:animation completion:^{
        weakSelf.changeSceneBlock(@"WDLearnScene4");
    }];
}

@end
