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

@implementation WDLearnScene4
{
    BOOL _isBegin;
    int _createNumber;
    Boss1Node *_bossNode;
}

- (void)didMoveToView:(SKView *)view{
    
    [super didMoveToView:view];
    
    
    
    self.archer.position = CGPointMake(0, 0);
    self.knight.position = CGPointMake(-200, 0);
    self.priest.position = CGPointMake(200, 0);
    
    self.archer.state = self.archer.state | Sprite_movie;
    
    [self setHateNameArrWithNode:@[self.archer,self.knight,self.priest]];
    
    [self changeSelectNode:self.knight];
    __weak typeof(self)weakSelf = self;
    [self setTextAction:@"就是这里了" hiddenTime:2 completeBlock:^{
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


- (void)touchUpAtPoint:(CGPoint)pos{
    
    if (!_isBegin) {
        return;
    }
    
    [super touchUpAtPoint:pos];
    
}

/// 死亡通知
- (void)deadAction:(NSNotification *)notification{
    
    
    WDBaseNode *node = (WDBaseNode *)notification.object;
    
    if ([node isKindOfClass:[WDUserNode class]]) {
        
        [self.userArr removeObject:node];
        
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
            
        }else if(_createNumber < 5){
            
            [WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(0, 0)];
            _createNumber ++;
        }
        
        

    }
    
}

- (void)createBoss{
    
    _bossNode = [WDBaseNode initActionWithName:kBoss1 superNode:self position:CGPointMake(1, 0)];
    [self beginToBoss];
}

- (void)beginToBoss{
    
    self.knight.state = self.knight.state ^ Sprite_movie;
    self.archer.state = self.archer.state ^ Sprite_movie;
    self.priest.state = self.priest.state ^ Sprite_movie;
}

- (void)bossCallMonster:(NSNotification *)notification{
    
    [WDBaseNode initTextureActionWithName:kRedBat superNode:self initPoint:CGPointMake(0, 0)];
}


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

@end
