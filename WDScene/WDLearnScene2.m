//
//  WDLearnScene2.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/21.
//

#import "WDLearnScene2.h"
#import "WDBaseNode+Emoji.h"

@implementation WDLearnScene2
{
    BOOL _part1;
    BOOL _part2;
    BOOL _part3;
    BOOL _part4;
    BOOL _part5;

}


- (void)didMoveToView:(SKView *)view{
    
    [super didMoveToView:view];
   
    self.bgNode.size = CGSizeMake(kScreenWidth * 2.0, kScreenHeight * 2.0);
    self.archer.position = CGPointMake(-kScreenWidth, 0);
    [self.archer moveAction:CGPointMake(-kScreenWidth / 2.0, 0)];
    self.archer.state = self.archer.state | Sprite_learn;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(endMove1) name:kNotificationForMoveEnd object:nil];
    
    [WDNotificationManager changeUser:self.archer.name];
}

- (void)endMove1{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotificationForMoveEnd object:nil];
    [self changeSelectNode:self.archer];
    [self setTextAction:@"这个地方怎么似曾相识啊？"];
    [self setClickNodePositionWithNode:self.archer];
    [self.archer fishyFaceState];
}

/// 开始触碰
- (void)touchDownAtPoint:(CGPoint)pos {
}

/// 手指移动
- (void)touchMovedToPoint:(CGPoint)pos {
    
    if (!_part1) {
        return;
    }
    //return;
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
    
    /// 第一部分，创建3怪物
    if (!_part1) {
        
        WDArcherNode *archer = nil;
        NSArray *nodes = [self nodesAtPoint:pos];
        for (SKSpriteNode *node in nodes) {
            if ([node.name isEqualToString:kArcher]) {
                archer = (WDArcherNode *)node;
                _part1 = YES;
                [self createThreeMonster];
                [self.archer omgFaceState];
                break;
            }
        }
        
        
        
        return;
    }
    
    
    
    /// 第二部分,攻击怪物
    if (_part2) {
        [super touchUpAtPoint:pos];
        return;
    }
    
    /// 第三部分，释放技能攻击怪物
    if (_part3) {
        [super touchUpAtPoint:pos];
        return;
    }
    
    ///
    if (_part4) {
        return;
    }
    

    self.selectLine.hidden = YES;
    self.selectLine.size = CGSizeMake(0, 0);
    
}

/// 创建三怪物
- (void)createThreeMonster{
    
    self.clickNode.hidden = YES;
    
    WDBaseNode *node1 = [WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(1, 0)];
    WDBaseNode *node2 =[WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(150, 0)];
    WDBaseNode *node3 = [WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(299, 0)];
    
    node1.state = node1.state | Sprite_learn;
    node2.state = node2.state | Sprite_learn;
    node3.state = node3.state | Sprite_learn;
    
    [self.archer.balloonNode setBalloonWithLine:1 hiddenTime:2];
    __weak typeof(self)weakSelf = self;
    [self setTextAction:@"吓我一跳！先解决眼前麻烦再说" hiddenTime:2 completeBlock:^{
        [weakSelf.archer normalFaceState];
        node1.state = Sprite_stand;
        node2.state = Sprite_stand;
        node3.state = Sprite_stand;
        [weakSelf stopTalk];
        [weakSelf setPart2:YES];
    }];
}

- (void)setPart2:(BOOL)isPart2{
    _part2 = isPart2;
}
- (void)setPart3:(BOOL)isPart3{
    _part3 = isPart3;
}

- (void)endMove2{
        
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotificationForMoveEnd object:nil];
    [self createFourMonster];
}

- (void)createFourMonster{
    
    [self hiddenArrow];
    WDBaseNode *node1 = [WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(0, 0)];
    WDBaseNode *node2 =[WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(0, 0)];
    WDBaseNode *node3 = [WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(0, 0)];
    WDBaseNode *node4 = [WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(0, 0)];
    
    node1.state = node1.state | Sprite_learn;
    node2.state = node2.state | Sprite_learn;
    node3.state = node3.state | Sprite_learn;
    node4.state = node4.state | Sprite_learn;
    
    [self.archer.balloonNode setBalloonWithLine:1 hiddenTime:2];
    __weak typeof(self)weakSelf = self;
    [self.archer omgFaceState];
    [self setTextAction:@"这没完没了了啊！是时候拿出真本事了！" hiddenTime:3 completeBlock:^{
        [weakSelf.archer normalFaceState];
        weakSelf.archer.mouth.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"Mouth_Angry"]];
        [weakSelf setTextAction:@"让你们见识一下我多年练就的手速！！" hiddenTime:3 completeBlock:^{
            [WDNotificationManager hiddenSkillView:1];
            [weakSelf stopTalk];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationForShowSkill object:@(0)];
            
            
        }];
    }];
    
}

- (void)skill1Action{
    
    for (WDBaseNode *node in self.monsterArr) {
        node.state = Sprite_stand;
    }
    _part3 = YES;
    [self.selectNode skill1Action];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationForShowSkill object:@(5)];

}



- (void)deadAction:(NSNotification *)notification{
    
    WDBaseNode *node = (WDBaseNode *)notification.object;
    
    if ([node isKindOfClass:[WDUserNode class]]) {
        
    }else if([node isKindOfClass:[WDEnemyNode class]]){
        
        NSLog(@"敌人：%@ 死亡了",node.name);
        [self.monsterArr removeObject:node];
        if(self.monsterArr.count == 0 && _part2){
            [self hiddenArrow];
            _part2 = NO;
            [self.selectNode moveAction:CGPointMake(0, 0)];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(endMove2) name:kNotificationForMoveEnd object:nil];
        }else if(self.monsterArr.count == 0 && _part3){
            
            [WDNotificationManager hiddenSkillView:0];
            [self hiddenArrow];
            _part3 = NO;
            _part4 = YES;
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(endMove3) name:kNotificationForMoveEnd object:nil];
            [self.selectNode moveAction:CGPointMake(0, 0)];
        }

    }
    
}

- (void)endMove3{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotificationForMoveEnd object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(overAndOver) name:kNotificationForMoveEnd object:nil];
    
    __weak typeof(self)weakSelf = self;
    [self setTextAction:@"时候不早了，该动身前往集合地了" hiddenTime:2 completeBlock:^{
        [weakSelf stopTalk];
        [weakSelf.selectNode moveAction:CGPointMake(kScreenWidth + 200, 0)];
    }];
    
}


- (void)overAndOver{
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:kLearnPass2];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"下一章！");
    [self changeSceneWithName:@"WDLearnScene3"];
}

@end
