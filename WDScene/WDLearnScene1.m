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
#import "WDBaseNode+Emoji.h"

@implementation WDLearnScene1
{
    BOOL _isFirstClick;
    BOOL _isSecondClick;
    BOOL _isThirdClick;
    BOOL _isFourClick;
    BOOL _isFiveClick;
    BOOL _isOverLear;
    BOOL _isAllOver; /// 战斗结束
    BOOL _isSelectOver; /// 选择结束
    
    WDRedBatNode *_redNode;
    WDBaseNode   *_leadHandNode;
    int  _diedNumber;
    BOOL _isCreate;
   
}



- (void)didMoveToView:(SKView *)view{
    
    
    if (_isCreate) {
        
        /// 这里是从换装界面回来
        [self endEquip];
                
        
        return;
    }
    
    [super didMoveToView:view];
    
    _isCreate = YES;
    
  
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moveEnd) name:kNotificationForMoveEnd object:nil];
    
    
    self.knight.position = CGPointMake(-kScreenWidth / 2.0, 0);
    self.clickNode.position = CGPointMake(-kScreenWidth / 2.0, self.clickNode.position.y);
    self.clickNode.hidden = NO;
    
    self.knight.state = self.knight.state | Sprite_learn;
    
    
    [self setTextAction:@"选中操作人物"];

   
    

    
}

/// 开始触碰
- (void)touchDownAtPoint:(CGPoint)pos {

}

/// 手指移动
- (void)touchMovedToPoint:(CGPoint)pos {
    
    if (_isAllOver) {
        return;
    }

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
    
    
    if (_isSelectOver) {
        
        return;
    }
    
    if (_isAllOver) {
        
        NSArray *nodes = [self nodesAtPoint:pos];
        __weak typeof(self)weakSelf = self;
        for (SKSpriteNode *node in nodes) {
            
            if ([node.name isEqualToString:@"confirm"]) {
                
                [self hiddenConfirmNodes];
                [self changeSelectNode:self.knight];
                [self setTextAction:@"虽然在下还有要事在身，但为报恩\n在所不辞！" hiddenTime:3 completeBlock:^{
                    [weakSelf endTalkYes1];
                }];
                _isSelectOver = YES;
                break;
            }else if([node.name isEqualToString:@"cancel"]){
                
                [self hiddenConfirmNodes];
                [self changeSelectNode:self.knight];
                [self setTextAction:@"因为在下还有要事在身，所以。。。。" hiddenTime:3 completeBlock:^{
                    [weakSelf endTalkNo1];
                }];
                _isSelectOver = YES;
                break;
            }
        }
        
        return;
    }
    
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
            [self.selectNode selectSpriteAction];
            //[self.knight.talkNode setText:@"点击移动到\n箭头指定地"];
            [self setTextAction:@"点击移动到箭头指定地点"];
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
                [self stopTalk];
                [self performSelector:@selector(priestLogin) withObject:nil afterDelay:5];
                self.knight.talkNode.hidden = YES;
                _redNode.state = _redNode.state ^ Sprite_movie;
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
                [self.selectNode selectSpriteAction];
                [self setTextAction:@"拖动手指为他治疗"];
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
            self.selectNode.state = self.selectNode.state ^ Sprite_movie;
            _isFiveClick = YES;
            self.knight.paused = NO;
            _redNode.paused    = NO;
            [knight cureSelectSpriteAction];
            [self stopTalk];
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
    
    [enemy selectSpriteAction];
    self.selectNode.targetNode = enemy;
    self.selectNode.cureNode   = nil;
    [self.selectNode removeAllActions];
    
    if (self.selectNode.attackDistance > 0) {
        [self.selectNode attackAction:enemy];
    }

}



- (void)priestLogin{
    
    _redNode.paused = YES;
    self.knight.paused = YES;
    
    self.priest.state = self.priest.state | Sprite_learn;
    self.priest.state = self.priest.state | Sprite_movie;
    self.priest.alpha = 0;
    self.priest.position = CGPointMake(-150, 0);
    self.clickNode.position = CGPointMake(-150, - 80.f * self.yScale);

    //[self.priest.talkNode setText:@"选中牧师妹妹"];
    [self setTextAction:@"选中牧师妹妹"];
    
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
            //[weakSelf.knight.talkNode setText:@"点击选中怪物"];
            [weakSelf setTextAction:@"点击选中怪物"];
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
    _redNode.state = Sprite_movie;
    [self addChild:_redNode];
    _redNode.alpha = 0;
   
    _redNode.position = CGPointMake(kScreenWidth / 2.0, 0);
    [self setSmokeWithMonster:_redNode name:kRedBat];
    [WDAttributeManager setSpriteAttribute:_redNode];
    _redNode.numberName = @"showRedBat";
  
}

- (void)moveEndDouble{
    
    
    if ((self.knight.state & Sprite_stand) && (self.priest.state & Sprite_stand)) {
        [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotificationForMoveEnd object:nil];
        self.priest.xScale =  - fabs(self.priest.xScale);
        self.knight.xScale =  fabs(self.priest.xScale);
        [self overBattle];
    }
    
    
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
            self.priest.state = self.priest.state | Sprite_movie;
            [self.priest standAction];
           
            __weak typeof(self)weakSelf = self;
            [self setTextAction:@"总算搞定了!" hiddenTime:1 completeBlock:^{
                weakSelf.knight.xScale = -fabs(weakSelf.knight.xScale);
                weakSelf.selectNode.arrowNode.hidden = YES;
                weakSelf.selectNode = weakSelf.knight;
                weakSelf.selectNode.arrowNode.hidden = NO;
                
                [weakSelf setTextAction:@"感谢英雄搭救在下！！！！" hiddenTime:1 completeBlock:^{
                    [weakSelf createTwoMonster];
                }];
            }];

        }else if(self.monsterArr.count == 0){
            
            self.priest.state = self.priest.state ^ Sprite_cure;
            self.priest.cureNode = nil;
            _isAllOver = YES;
            [self.knight moveAction:CGPointMake(0, 0)];
            [self.priest moveAction:CGPointMake(kScreenWidth / 3.0, 0)];
            //主要调整一下朝向
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moveEndDouble) name:kNotificationForMoveEnd object:nil];
            
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
        
        weakSelf.selectNode.arrowNode.hidden = YES;
        weakSelf.selectNode = weakSelf.priest;
        weakSelf.selectNode.arrowNode.hidden = NO;
        
        [weakSelf setTextAction:@"有话一会说,先解决这些怪物" hiddenTime:2 completeBlock:^{
            weakSelf.priest.state = self.priest.state ^ Sprite_movie;
            node1.state = Sprite_stand;
            node2.state = Sprite_stand;
            [weakSelf learnOver];
            [weakSelf stopTalk];
        }];
    }];

}

- (void)learnOver{
    _isOverLear = YES;
}




/// 整个战斗结束后剧情
- (void)overBattle{
    
    self.priest.CUR = self.knight.BLOOD_INIT - self.knight.BLOOD_LAST;
    [self.knight beCureAction:self.priest];
    self.knight.bgBlood.hidden = YES;
    self.priest.bgBlood.hidden = YES;
    self.priest.state = self.priest.state | Sprite_movie;
   
    _isAllOver = YES;
    __weak typeof(self)weakSelf = self;
    [self changeSelectNode:self.knight];
    [self setTextAction:@"救命之恩！在下没齿难忘!" hiddenTime:2 completeBlock:^{
       
        [weakSelf changeSelectNode:weakSelf.priest];
        [weakSelf.priest fishyFaceState];
        
        [weakSelf setTextAction:@"我有一个疑问，你为什么要裸奔啊？" hiddenTime:2 completeBlock:^{
            
            [weakSelf.knight omgFaceState];
            
            
            [weakSelf.knight.balloonNode setBalloonWithLine:6 hiddenTime:2 completeBlock:^{
                
                [weakSelf talkTwo];
                
                [weakSelf.priest normalFaceState];
            }];
        
        }];
    }];
}

- (void)talkTwo{
    
    __weak typeof(self)weakSelf = self;
    [self setTextAction:@"嘛，这样吧！你打开装栏\n我送你一些装备吧" hiddenTime:2 completeBlock:^{
        
        [weakSelf changeSelectNode:weakSelf.knight];
        [weakSelf.knight loveFaceState];
        
        [weakSelf setTextAction:@"真的嘛！？！？！？" hiddenTime:2 completeBlock:^{
            
            [weakSelf stopTalk];
            weakSelf.leftOrRightNode.hidden = NO;
            CGPoint point1 = CGPointMake(weakSelf.leftOrRightNode.size.width + 70, -kScreenHeight + weakSelf.leftOrRightNode.size.height - 20);
            CGPoint point2 = CGPointMake(weakSelf.leftOrRightNode.size.width, -kScreenHeight + weakSelf.leftOrRightNode.size.height - 20);
            weakSelf.leftOrRightNode.position = point1;
            SKAction *move = [SKAction moveTo:point2 duration:0.3];
            SKAction *move2 = [SKAction moveTo:point1 duration:0.3];
            SKAction *seq = [SKAction sequence:@[move,move2]];
            SKAction *rep = [SKAction repeatActionForever:seq];
            [weakSelf.leftOrRightNode runAction:rep];
            
            
            WDBaseModel *model = [[WDDataManager shareManager]searchData:kKinght];
            model.Equip_shield = @"SteelShield_5";
            model.Equip_helmet = @"EliteKnightHelm_3";
            model.Equip_armor  = @"KnightArmor_3";
            model.Equip_pauldrons = @"KnightArmor_3";
            model.Equip_gloves = @"KnightArmor_3";
            model.Equip_belt = @"KnightArmor_3";
            model.Equip_boots = @"KnightArmor_3";
            
            NSString *allArmorName = [NSString stringWithFormat:@"%@_user",kKinght];
            WDBaseModel *modelAll = [[WDDataManager shareManager]searchData:allArmorName];
            [modelAll appendDataWithModel:model name:allArmorName];
        
            weakSelf.presentEquipBlock(kKinght);
        }];
        
        
    }];
    
  
}

- (void)endEquip{
    
    [self.leftOrRightNode removeAllActions];
    self.leftOrRightNode.hidden = YES;
    
    WDBaseModel * model = [[WDDataManager shareManager]searchData:kKinght];
    [self.knight setArmorWithModel:model];
    [self changeSelectNode:self.priest];

    /// 没换衣服和换衣服对话不一样
    __weak typeof(self)weakSelf = self;
    if ([model.Equip_armor isEqualToString:@"n"]) {
        
        [weakSelf.knight omgFaceState];
        [weakSelf.priest fishyFaceState];
        
        [self setTextAction:@"看来你还是喜欢裸奔啊。。。" hiddenTime:2 completeBlock:^{
            [weakSelf endEquip2];
            
        }];
       
        
    }else{
        
        [self setTextAction:@"看起来不错，很适合你" hiddenTime:2 completeBlock:^{
            [weakSelf endEquip2];
            [weakSelf.knight normalFaceState];
        }];
       
    }

}

- (void)endEquip2{
    
    [self.knight normalFaceState];
    [self.priest normalFaceState];
    __weak typeof(self)weakSelf = self;
    [self setTextAction:@"总之如今战乱，妖魔横行\n我准备组建个雇佣兵组织" hiddenTime:3 completeBlock:^{
        [weakSelf setTextAction:@"你意向如何，要不要加入呢？" hiddenTime:2 completeBlock:^{
            [weakSelf showConfirmNodes];
        }];
    }];
    
}

- (void)endTalkNo1{
    
    [self changeSelectNode:self.priest];
    
    __weak typeof(self)weakSelf = self;
    [self setTextAction:@"作为报恩，你先暂时加入我把。" hiddenTime:2 completeBlock:^{
        [weakSelf endTalk2];
    }];
}

- (void)endTalkYes1{
    
   
    [self changeSelectNode:self.priest];

    __weak typeof(self)weakSelf = self;
    [self setTextAction:@"那真是太好了！" hiddenTime:2 completeBlock:^{
        [weakSelf endTalk2];
    }];
}

- (void)endTalk2{
    
    [self hiddenConfirmNodes];
    [self changeSelectNode:self.priest];
    
    __weak typeof(self)weakSelf = self;
    [self setTextAction:@"你那套装备,是前任骑士留下的..." hiddenTime:3 completeBlock:^{
        [weakSelf.priest normalFaceState];
        [weakSelf stopTalk];
        [weakSelf.priest sadFaceState];
        [weakSelf.priest.balloonNode setBalloonWithLine:8 hiddenTime:2 completeBlock:^{
            [weakSelf endTalk3];
        }];
    }];
    
}

- (void)endTalk3{
    
    [self.priest normalFaceState];
    __weak typeof(self)weakSelf = self;
    [self setTextAction:@"嘛，总之，算你在内目前总共三个人\n还有一个路痴弓箭手" hiddenTime:4 completeBlock:^{
        [weakSelf setTextAction:@"咱们的小佣兵团还会不断壮大！！" hiddenTime:3 completeBlock:^{
            [weakSelf setTextAction:@"事不宜迟，出发赶往临时的集合地点吧。" hiddenTime:3 completeBlock:^{
                
                [weakSelf over];
                
            }];
        }];
    }];
}

- (void)over{
    
    self.priest.state = self.priest.state ^ Sprite_movie;
    [self stopTalk];
    [self.priest moveAction:CGPointMake(kScreenWidth + 1000, 0)];
    [self.knight moveAction:CGPointMake(kScreenWidth + 50, 0)];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(overAndOver) name:kNotificationForMoveEnd object:nil];
}

- (void)overAndOver{
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:kLearnPass1];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"下一章！");
    [self changeSceneWithName:@"WDLearnScene2"];
}

@end
