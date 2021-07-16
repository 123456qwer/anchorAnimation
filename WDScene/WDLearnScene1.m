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
    BOOL _isFourClick;
    BOOL _isFiveClick;
    BOOL _isOverLear;
    
    WDRedBatNode *_redNode;
    WDBaseNode   *_leadHandNode;
    int  _diedNumber;

}

- (void)didMoveToView:(SKView *)view{
    
    [super didMoveToView:view];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moveEnd) name:kNotificationForMoveEnd object:nil];
    
    self.bgNode.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"LearnScene.jpg"]];
    
    self.knight.position = CGPointMake(-kScreenWidth / 2.0, 0);
    self.clickNode.position = CGPointMake(-kScreenWidth / 2.0, self.clickNode.position.y);
    self.clickNode.hidden = NO;
    
    self.knight.state = self.knight.state | Sprite_learn;
    [self.knight.talkNode setText:@"选中操作人物"];
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
    
    if (!_isFourClick) {
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
    
    if (_isOverLear) {
        [super touchUpAtPoint:pos];
        return;
    }
    
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
            [self.knight.talkNode setText:@"点击移动到\n箭头指定地"];
        }
        
        
    }else if(!_isSecondClick){
        
        /// 第二步，让玩家按要求走到指定位置
        for (SKSpriteNode *node in nodes) {
            if ([node.name isEqualToString:@"location"]) {
                [self.selectNode moveAction:CGPointMake(0, 0)];
                _isSecondClick = YES;
                self.knight.talkNode.hidden = YES;
                break;
            }
        }
        
    }
    
    
    
    
    if (!_isFirstClick) {
        return;
    }
    
    /// 第二步显示引导位置
    if (!_isSecondClick) {
        [self arrowMoveActionWithPos:CGPointMake(0, 0)];
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
                [self performSelector:@selector(priestLogin) withObject:nil afterDelay:5];
                self.knight.talkNode.hidden = YES;
                break;
            }
        }
    }
    
    if (!_isThirdClick) {
        return;
    }
    
    /// 第四步，切换英雄，选中牧师
    if (self.clickNode.hidden == NO && !_isFourClick) {
        for (SKSpriteNode *node in nodes) {
            if ([node.name isEqualToString:kPriest]) {
                self.selectNode.arrowNode.hidden = YES;
                self.selectNode = self.priest;
                self.selectNode.arrowNode.hidden = NO;
                _isFourClick = YES;
                self.clickNode.hidden = YES;
                [self leadCureHand];
                [self.priest.talkNode setText:@"拖动手指\n为他治疗"];
                break;
            }
        }
    }
    
    
    if (!_isFourClick) {
        return;
    }
    
    /// 第五步，治疗骑士
    if (_leadHandNode && self.selectLine.hidden == NO) {
        /// 获取离点击点最近位置友军
        CGFloat distance = 100000;
        WDBaseNode *knight = nil;
        for (SKSpriteNode *node in nodes) {
            if([node isKindOfClass:[WDUserNode class]]){
                CGFloat dis = [WDCalculateTool distanceBetweenPoints:pos seconde:node.position];
                 if (dis < distance && dis <= node.size.width) {
                     knight = (WDUserNode *)node;
                 }
            }
        }
        
        if (knight) {
            self.selectNode.cureNode = knight;
            self.selectNode.targetNode = nil;
            _isFiveClick = YES;
            self.knight.paused = NO;
            _redNode.paused    = NO;
            
            [_leadHandNode removeAllActions];
            [_leadHandNode removeFromParent];
            _leadHandNode = nil;
            self.priest.talkNode.hidden = YES;
        }
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



- (void)priestLogin{
    
    _redNode.paused = YES;
    self.knight.paused = YES;
    
    self.priest.state = self.priest.state | Sprite_learn;
    self.priest.alpha = 0;
    self.priest.position = CGPointMake(-150, 0);
    self.clickNode.position = CGPointMake(-150, - 80.f * self.yScale);

    [self.priest.talkNode setText:@"选中牧师妹妹"];
    [self setSmokeWithMonster:self.priest name:kPriest];
}

/// 引导治疗手势
- (void)leadCureHand{
    
    _leadHandNode = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"hand"]]];
    _leadHandNode.zPosition = 1000000;
 
    
    [self addChild:_leadHandNode];
    
    [self leadCure];
}

/// 递归调用治疗手势
- (void)leadCure{
    if (!_leadHandNode) {
        return;
    }
    _leadHandNode.position = CGPointMake(self.priest.position.x + 15, self.priest.position.y - 60 * self.yScale);
    SKAction *move = [SKAction moveTo:CGPointMake(self.knight.position.x + 15, self.priest.position.y - 60 * self.yScale) duration:1.0];
    __weak typeof(self)weakSelf = self;
    [_leadHandNode runAction:move completion:^{
        [weakSelf leadCure];
    }];
}

//烟雾出场
- (void)setSmokeWithMonster:(WDBaseNode *)monsterNode
                       name:(NSString *)nameStr
{
    if (_isFiveClick) {
        self.hateNameArr = @[self.knight.name,self.priest.name];
        [super setSmokeWithMonster:monsterNode name:nameStr];
        return;
    }
    
    self.clickNode.position = CGPointMake(monsterNode.position.x, self.clickNode.position.y);
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
        if ([monsterNode.name isEqualToString:kRedBat]) {
            [weakSelf.knight.talkNode setText:@"点击选中怪物"];
        }
        weakSelf.clickNode.hidden = NO;
    }];
}

#pragma mark - 通知方法 -
- (void)moveEnd{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotificationForMoveEnd object:nil];
    
    WDRedBatModel *_redBatModel = [[WDRedBatModel alloc] init];
    [_redBatModel setNormalTexturesWithName:kRedBat standNumber:12 runNumber:0 walkNumber:8 diedNumber:8 attack1Number:7];
    
    _redNode = [WDRedBatNode initWithModel:_redBatModel];
    _redNode.name = kRedBat;
    [self addChild:_redNode];
    _redNode.alpha = 0;
   
    _redNode.position = CGPointMake(kScreenWidth / 2.0, 0);
    [self setSmokeWithMonster:_redNode name:kRedBat];
    [WDAttributeManager setSpriteAttribute:_redNode];
    _redNode.attackNumber = 100;
    _redNode.numberName = @"showRedBat";
}

#pragma mark - 死亡方法 -
- (void)deadAction:(NSNotification *)notification{
    
    WDBaseNode *node = (WDBaseNode *)notification.object;
    
    if ([node isKindOfClass:[WDUserNode class]]) {
        

        
        
    }else if([node isKindOfClass:[WDEnemyNode class]]){
        
        NSLog(@"敌人：%@ 死亡了",node.name);
        [self.monsterArr removeObject:node];
        if ([node.numberName isEqualToString:@"showRedBat"]) {
            _redNode = nil;
            self.priest.cureNode = nil;
            self.priest.state = self.priest.state ^ Sprite_cure;
            [self.priest standAction];
            __weak typeof(self)weakSelf = self;
            [self.priest.talkNode setText:@"总算搞定了" hiddenTime:1 completeBlock:^{
                weakSelf.knight.xScale = -fabs(weakSelf.knight.xScale);
                [weakSelf.knight.talkNode setText:@"感谢英雄搭救" hiddenTime:1 completeBlock:^{
                    [weakSelf createTwoMonster];
                }];
            }];
        }else if(self.monsterArr.count == 0){
            
            self.priest.state = self.priest.state ^ Sprite_cure;
            self.priest.cureNode = nil;
            self.priest.xScale =  fabs(self.priest.xScale);
            self.knight.xScale = - fabs(self.priest.xScale);
            [self.knight moveAction:CGPointMake(0, 0)];
            [self.priest moveAction:CGPointMake(kScreenWidth / 3.0, 0)];
            
        }
        
        
    }
    
}


- (void)createTwoMonster{
    
    
    WDBaseNode *node1 = [WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(kScreenWidth - 100, 0)];
    WDBaseNode *node2 =[WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(-kScreenWidth + 100, 0)];
   
    node1.state = node1.state | Sprite_learn;
    node2.state = node2.state | Sprite_learn;
    
    [self.knight.balloonNode setBalloonWithLine:1 hiddenTime:1];
    __weak typeof(self)weakSelf = self;
    [self.priest.balloonNode setBalloonWithLine:1 hiddenTime:1 completeBlock:^{
        [weakSelf.priest.talkNode setText:@"有话一会说\n先解决这些" hiddenTime:2 completeBlock:^{
            node1.state = Sprite_stand;
            node2.state = Sprite_stand;
            [weakSelf learnOver];
        }];
    }];

}

- (void)learnOver{
    _isOverLear = YES;
}

@end
