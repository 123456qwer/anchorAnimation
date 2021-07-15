//
//  WDLearnScene1.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/15.
//

#import "WDLearnScene1.h"
#import "WDKknightNode.h"
#import "WDSolider1Node.h"
#import "WDBaseScene+MonsterLocation.h"
#import "WDRedBatNode.h"
#import "WDRedBatModel.h"

@implementation WDLearnScene1
{
    BOOL _isFirstClick;
    BOOL _isSecondClick;
    BOOL _isThirdClick;
}

- (void)didMoveToView:(SKView *)view{
    
    [super didMoveToView:view];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moveEnd) name:kNotificationForMoveEnd object:nil];
    
    self.bgNode.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"LearnScene.jpg"]];
    
    [self knight];
    
    self.clickNode.hidden = NO;
}

/// 开始触碰
- (void)touchDownAtPoint:(CGPoint)pos {

}

/// 手指移动
- (void)touchMovedToPoint:(CGPoint)pos {
    

    if (!_isFirstClick) {
        return;
    }
    
    if (!_isSecondClick) {
        return;
    }
    
    if (!_isThirdClick) {
        return;
    }
    
    self.selectLine.position = CGPointMake(self.selectNode.position.x, self.selectNode.position.y);
    ///引导线
    //斜边
    CGFloat width = [WDCalculateTool distanceBetweenPoints:pos seconde:self.selectLine.position];
    self.selectLine.size = CGSizeMake(width, 10);
    self.selectLine.hidden = NO;
    //角度
    self.selectLine.zRotation = [WDCalculateTool angleForStartPoint:self.selectLine.position EndPoint:pos];
    //NSLog(@"%lf",self.selectLine.zRotation);
    //[self.selectLine createLinePhyBody];

}

/// 触碰结束
- (void)touchUpAtPoint:(CGPoint)pos {
    
    
    
    NSArray *nodes = [self nodesAtPoint:pos];
    /// 第一步，选中玩家
    if (!self.selectNode) {
        WDKknightNode *knight = nil;
        for (SKSpriteNode *node in nodes) {
            if ([node.name isEqualToString:kKinght]) {
                knight = (WDKknightNode *)node;
            }
        }
        
        if (knight && !_isFirstClick) {
            _isFirstClick = YES;
            self.selectNode = knight;
            self.selectNode.arrowNode.hidden = NO;
            self.clickNode.hidden = YES;
        }
        
        
    }else if(!_isSecondClick){
        
        /// 第二步，让玩家按要求走到指定位置
        for (SKSpriteNode *node in nodes) {
            if ([node.name isEqualToString:@"location"]) {
                [self.selectNode moveAction:CGPointMake(kScreenWidth / 2.0, 0)];
                _isSecondClick = YES;
                break;
            }
        }
        
    }
    
    
    
    
    if (!_isFirstClick) {
        return;
    }
    
    /// 第二步显示引导位置
    if (!_isSecondClick) {
        [self arrowMoveActionWithPos:CGPointMake(kScreenWidth / 2.0, 0)];
    }
    
    
    if (!_isSecondClick) {
        return;
    }
    
    /// 第三步，点击怪物进行攻击
    if (self.clickNode.hidden == NO && !_isThirdClick) {
        for (SKSpriteNode *node in nodes) {
            if ([node.name isEqualToString:kRedBat]) {
                WDEnemyNode *enemy = (WDEnemyNode *)node;
                [self clickEneny:enemy];
                enemy.targetNode = self.selectNode;
                _isThirdClick = YES;
                self.clickNode.hidden = YES;
                break;
            }
        }
    }
    
    if (!_isThirdClick) {
        return;
    }
    

    self.selectLine.hidden = YES;
    self.selectLine.size = CGSizeMake(0, 0);
    
}

/// 点击到敌人
- (void)clickEneny:(WDEnemyNode *)enemy{
    
    if ([self.selectNode.targetNode isEqualToNode:enemy]) {
        return;
    }
    
    /// 重置攻击状态
    if (self.selectNode.state & Sprite_attack) {
        self.selectNode.state = self.selectNode.state ^ Sprite_attack;
    }
    
    self.selectNode.targetNode = enemy;
    self.selectNode.cureNode   = nil;
    [self.selectNode removeAllActions];
    [self.selectNode pauseWalkOrRun];

    
    CGFloat dis = [WDCalculateTool distanceBetweenPoints:enemy.position seconde:self.selectNode.position];
    
    if (dis <= self.selectNode.size.width || self.selectNode.attackDistance > 0) {
        [self.selectNode attackAction:enemy];
    }else{
        CGPoint movePoint = [WDCalculateTool calculateNodeMovePosition:self.selectNode enemy:enemy];
        [self.selectNode moveAction:movePoint];
    }
}

#pragma mark - 通知方法 -
- (void)moveEnd{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotificationForMoveEnd object:nil];
    
    WDRedBatModel *_redBatModel = [[WDRedBatModel alloc] init];
    [_redBatModel setNormalTexturesWithName:kRedBat standNumber:12 runNumber:0 walkNumber:8 diedNumber:8 attack1Number:7];
    
    WDRedBatNode *node = [WDRedBatNode initWithModel:_redBatModel];
    node.name = kRedBat;
    [self addChild:node];
    node.alpha = 0;
    
    [self setSmokeWithMonster:node name:kRedBat];
    [WDAttributeManager setSpriteAttribute:node];
}

//烟雾出场
- (void)setSmokeWithMonster:(WDBaseNode *)monsterNode
                       name:(NSString *)nameStr
{
    
    WDBaseNode *node = [WDBaseNode spriteNodeWithTexture:self.textureManager.smokeArr[0]];
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
    
    __weak typeof(self)weakSelf = self;
    [monsterNode runAction:[SKAction fadeAlphaTo:1 duration:self.textureManager.smokeArr.count * 0.075]];
    [node runAction:s completion:^{
        weakSelf.clickNode.hidden = NO;
    }];
}

@end
