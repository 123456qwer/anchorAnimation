//
//  WDLearnScene4.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/23.
//

#import "WDLearnScene4.h"
#import "WDBaseNode+Emoji.h"
#import "WDBoss1Node.h"
#import "Boss1Node.h"
#import "WDBaseNode+Emoji.h"
#import "WDBaseNode+Animation.h"
#import "WDBaseScene+Moive.h"

@implementation WDLearnScene4
{
    BOOL _isBegin;
    int _createNumber;
    Boss1Node *_bossNode;
    BOOL _isPass;
    bool _part[1000];
}

- (void)didMoveToView:(SKView *)view{
    
    [super didMoveToView:view];
    
    self.passStr = kPassCheckPoint1;
    
    //self.archer.ATK = 500;
    self.archer.position = CGPointMake(0, 0);
    self.knight.position = CGPointMake(-200, 0);
    self.priest.position = CGPointMake(200, 0);
    
    self.archer.state = self.archer.state | Sprite_movie;
    
    [self setHateNameArrWithNode:@[self.archer,self.knight,self.priest]];
    
    [self changeSelectNode:self.knight];
    __weak typeof(self)weakSelf = self;
    [self setTextAction:@"就是这里了" hiddenTime:1 completeBlock:^{
        [weakSelf setTextAction:@"(???):来者何人？扰我清净!" hiddenTime:2 completeBlock:^{
            [weakSelf createMonster];
        }];
    }];
}

- (void)createMonster{
    
    [self hiddenArrow];
    for (int i = 0; i < 5; i ++) {
       WDBaseNode *node = [WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(0, 0)];
        node.state = node.state | Sprite_learn;
        _createNumber ++;
    }
   
    
    [self changeSelectNode:self.priest];
    __weak typeof(self)weakSelf = self;
    [self setTextAction:@"看来得先处理掉这些再说了！" hiddenTime:2 completeBlock:^{
        for (WDBaseNode *node in weakSelf.monsterArr) {
            node.state = Sprite_stand;
        }
        [weakSelf stopTalk];
        [weakSelf begin];
    }];
    
}

- (void)begin{
    _isBegin = YES;
    self.archer.state = self.archer.state ^ Sprite_movie;
    [WDNotificationManager hiddenSkillView:1];
    [WDNotificationManager changeUser:self.priest.name];
}

/// 开始触碰
- (void)touchDownAtPoint:(CGPoint)pos {
}

/// 手指移动
- (void)touchMovedToPoint:(CGPoint)pos {
    
    if (_isPass) {
        self.selectLine.hidden = YES;
        return;
    }
    
    if (!_isBegin) {
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

/// 死亡通知
- (void)deadAction:(NSNotification *)notification{
    
    
    WDBaseNode *node = (WDBaseNode *)notification.object;
    
    if ([node isKindOfClass:[WDUserNode class]]) {
        
        [self.userArr removeObject:node];
        [self deadForRelease:node];
        
        if ([node.name isEqualToString:self.selectNode.name]) {
            [self changeSelectNode:self.userArr.firstObject];
        }
        
        if (self.userArr.count == 0) {
         
            if (_bossNode) {
                [self noPassForBoss2];
            }else{
                
            }
            
        }
        
        
        
    }else if([node isKindOfClass:[WDEnemyNode class]]){
        
        NSLog(@"敌人：%@ 死亡了",node.name);
        [self.monsterArr removeObject:node];
        
        
        if (self.monsterArr.count == 0) {
        
            self.knight.state = self.knight.state | Sprite_movie;
            self.archer.state = self.archer.state | Sprite_movie;
            self.priest.state = self.priest.state | Sprite_movie;
            
            [self createBoss];
            
        }else if(_createNumber < 15){
            
            [WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(0, 0)];
            _createNumber ++;
        }
    }
    
}

- (void)createBoss{
    
    _bossNode = [WDBaseNode initActionWithName:kBoss1 superNode:self position:CGPointMake(1, 0)];
    [self performSelector:@selector(beginToBoss) withObject:nil afterDelay:14 * 0.075];
   
    
    /// 设置BOSS挂了以后的回调
    __weak typeof(self)weakSelf = self;
    [_bossNode setDeadBlock:^{
        [weakSelf bossDeadAction];
    }];
}

- (void)beginToBoss{
    
    self.knight.state = self.knight.state ^ Sprite_movie;
    self.archer.state = self.archer.state ^ Sprite_movie;
    self.priest.state = self.priest.state ^ Sprite_movie;
}

- (void)bossCallMonster:(NSNotification *)notification{
    
    [WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(0, 0)];
}


/// 没有过关被老家伙嘲讽
- (void)noPassForBoss2{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [_bossNode removeAllActions];
    
    _bossNode.state = Sprite_movie;
    _bossNode.xScale = fabs(1);
    _bossNode.yScale = fabs(1);
    _bossNode.alpha  = 1;
    _bossNode.zRotation = 0;
    
    [_bossNode.talkNode setText:@"你们还不够格哦"];
    __weak typeof(self)weakSelf = self;
    [self runAction:[SKAction waitForDuration:3] completion:^{
        weakSelf.changeSceneBlock(@"WDFirstCampsiteScene");
    }];
    
    for (WDBaseNode *node in self.monsterArr) {
        if (![node isEqualToNode:_bossNode]) {
            [node deadAction];
        }
    }
    
    [WDNotificationManager hiddenSkillView:0];
    [self.textureManager releaseAction];
}

- (void)setNoIndex:(NSInteger)index1
          yesIndex:(NSInteger)index2{
    _part[index1] = NO;
    _part[index2] = YES;
}


/// 点击结束
- (void)touchUpAtPoint:(CGPoint)pos{
    
    if (!_isBegin) {
        return;
    }
    
    if (!_isPass) {
        [super touchUpAtPoint:pos];
    }else{
        
        
        if (_part[0]) {
            
            [self.archer angleFaceStateWithEye];
            [self.priest angleFaceStateWithEye];
        
            
            [self changeSelectNode:self.priest];
            [self setTextAction:@"我看你刚才活蹦乱跳着呢\n一点也不像个长者！"];
            
            [self setNoIndex:0 yesIndex:1];
            
        }else if(_part[1]){
            
            [self changeSelectNode:self.archer];
            [self setTextAction:@"就是！就是！"];
            
            [self setNoIndex:1 yesIndex:2];
            
        }else if(_part[2]){
            
            
            
            [self.knight.balloonNode setBalloonWithLine:Balloon_awkward hiddenTime:0];
            [self changeSelectNode:self.knight];
            [self setTextAction:@"好啦好啦，总之你要找的人就是他了\n他可以教授我们技能"];
            
            [self setNoIndex:2 yesIndex:3];
            
        }else if(_part[3]){
            
            [self.archer normalFaceState];
            [self.priest normalFaceState];
            self.knight.balloonNode.hidden = YES;
            [self changeSelectNode:nil];
            
            [self setTextAction:@"(???):\n看在你们能战胜我的份儿上\n我就姑且答应你们吧！"];
          
            [self setNoIndex:3 yesIndex:4];

            
        }else if(_part[4]){
            
            [self.archer angleFaceStateWithEye];
            [self.priest angleFaceStateWithEye];
            
            [self.knight.balloonNode setBalloonWithLine:Balloon_awkward hiddenTime:0];
            
            [self setNoIndex:4 yesIndex:5];

            
            
        }else if(_part[5]){
            
            [self.archer normalFaceState];
            [self.priest normalFaceState];
            [self.knight normalFaceState];
            
            [self setTextAction:@"眼镜大师:\n我叫<眼镜大师>\n作为战胜我的奖励，可以免费教你们一个技能"];
            [self bossDeadActionMovie];
            //[self setNoIndex:5 yesIndex:6];
            _part[5] = NO;
            
        }else if(_part[6]){
            
            __weak typeof(self)weakSelf = self;
            [self moveActionForClick:^{
                [weakSelf setTextAction:@"眼镜大师:\n这个绿色珠子可以兑换一个技能\n谨慎选择要学技能的人物"];
                [self setNoIndex:6 yesIndex:7];
            }];
            
            
        }else if(_part[7]){
            
            [self setNoIndex:7 yesIndex:8];
            self.changeSceneBlock(@"WDFirstCampsiteScene");
        }
    }
    
    
}

- (void)rewardAlready{
    [self setTextAction:@"眼镜大师:\n这个绿色珠子可以兑换一个技能\n谨慎选择要学技能的人物"];
    [self setNoIndex:5 yesIndex:6];
}

/// 通过关卡
- (void)bossDeadAction{
    
    for (WDBaseNode *node in self.monsterArr) {
        if (![node isEqualToNode:_bossNode]) {
            [node deadAction];
        }
    }
    
    _isPass = YES;
    
    self.knight.bgBlood.hidden = YES;
    self.priest.bgBlood.hidden = YES;
    self.archer.bgBlood.hidden = YES;
    _bossNode.bgBlood.hidden   = YES;
    
    __weak typeof(self)weakSelf = self;
    weakSelf.priest.state = Sprite_movie;
    weakSelf.archer.state = Sprite_movie;
    weakSelf.knight.state = Sprite_movie;
    
    [self.knight removeAllBodyAction];
    [self.priest removeAllBodyAction];
    [self.archer removeAllBodyAction];
    
    
    [self.priest moveAction:CGPointMake(0, 0) moveFinishBlock:^{
        weakSelf.priest.xScale = fabs(weakSelf.priest.xScale);
    }];
    [self.archer moveAction:CGPointMake(self.priest.size.width * 2.5, 0) moveFinishBlock:^{
        weakSelf.archer.xScale=  fabs(weakSelf.archer.xScale);
    }];
    [self.knight moveAction:CGPointMake(-self.priest.size.width * 2.5, 0) moveFinishBlock:^{
        weakSelf.knight.xScale = fabs(weakSelf.knight.xScale);
    }];
    
    
    [WDNotificationManager hiddenSkillView:0];
    [self setTextAction:@"(???):\n你们这些年轻人，不能下手轻些么！\n怎么说我也是个长者！"];
    [self setNoIndex:0 yesIndex:0];
    
}

@end
