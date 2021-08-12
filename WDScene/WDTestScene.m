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
#import "Boss2Node.h"



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
    Boss2Node *_boss2Node;
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
    self.archer.position = CGPointMake(0, 0);
    self.knight.position = CGPointMake(200, 0);
    //self.knight.isRunState = YES;
    self.priest.position = CGPointMake(400, 0);

    _boss2Node = [WDBaseNode initActionWithName:kBoss2 superNode:self position:CGPointMake(-600,-50)];
    
    [WDNotificationManager hiddenSkillView:1];
    [WDNotificationManager changeUser:self.priest.name];

    [self setHead];
}

- (void)setHead{
    self.knightHead.position = CGPointMake(kScreenWidth - self.knightHead.realSize.width - 20 , kScreenHeight - self.knightHead.realSize.height - 10);
    self.archerHead.position = CGPointMake(kScreenWidth - self.knightHead.realSize.width * 2 - 40 ,kScreenHeight - self.archerHead.realSize.height - 10);
    self.priestHead.position = CGPointMake(kScreenWidth - self.knightHead.realSize.width * 3 - 60 ,kScreenHeight - self.priestHead.realSize.height - 10);
}

- (void)touchUpAtPoint:(CGPoint)pos{
    
    [super touchUpAtPoint:pos];
  
    //[self testBoss2];
}

- (void)testBoss2{
    [_boss2Node attackAction:self.knight];
}

- (void)testBoss1{
    
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
