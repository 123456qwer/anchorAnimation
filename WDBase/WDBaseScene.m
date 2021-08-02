//
//  WDBaseScene.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import "WDBaseScene.h"
#import "WDEquipScene.h"
#import "WDBaseScene+ContactLogic.h"


@implementation WDBaseScene
{
    SKSpriteNode *_bgNode1;
    SKSpriteNode *_bgNode2;
    SKSpriteNode *_bgNode;
}

- (void)didMoveToView:(SKView *)view
{
    /// 添加一些常用通知方法
    [self addObserve];
    
    self.physicsWorld.contactDelegate = self;
    self.scaleMode = SKSceneScaleModeAspectFill;

    //屏幕适配
    CGFloat screenWidth = kScreenWidth * 2.0;
    CGFloat screenHeight = kScreenHeight * 2.0;
    self.size = CGSizeMake(screenWidth, screenHeight);
    
    [self setBgScene];
}

- (void)setBgScene{
    
    _bgNode1    = (SKSpriteNode *)[self childNodeWithName:@"bgNode1"];
    _bgNode2    = (SKSpriteNode *)[self childNodeWithName:@"bgNode2"];
    _bgNode     = (SKSpriteNode *)[self childNodeWithName:@"bgNode"];

    CGFloat page = 5;
    
    //屏幕适配
    CGFloat screenWidth = kScreenWidth * 2.0;
    CGFloat screenHeight = kScreenHeight * 2.0;
    
    _bgNode.size = CGSizeMake(screenWidth + page, screenHeight + 5);
    _bgNode.position = CGPointMake(0, 0);
    
    _bgNode1.size = CGSizeMake(screenWidth + page, (screenWidth + page) / _bgNode1.size.width * _bgNode1.size.height);
    _bgNode1.position = CGPointMake(0, kScreenHeight - _bgNode1.size.height / 2.0);
    
    _bgNode2.size = CGSizeMake(screenWidth + page, (screenWidth + page) / _bgNode2.size.width * _bgNode2.size.height);
    _bgNode2.position = CGPointMake(0,- kScreenHeight + _bgNode2.size.height / 2.0);
    
    _bgNode2.zPosition = 10000;
}

#pragma mark - 通知方法 -
- (void)addObserve{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deadAction:) name:kNotificationForDead object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeEquip:) name:kNotificationForChangeEquip object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bossCallMonster:) name:kNotificationForBossCallMonster object:nil];
}

#pragma mark - 操作 -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchDownAtPoint:[t locationInNode:self]];}
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}

- (void)update:(NSTimeInterval)currentTime
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForUpData object:nil];
}

#pragma mark - getter -
- (SKSpriteNode *)confirmNode{
    if (!_confirmNode) {
        _confirmNode = [SKSpriteNode spriteNodeWithTexture:self.textureManager.confirm];
        _confirmNode.name = @"confirm";
        _confirmNode.zPosition = 100000;
        _confirmNode.xScale = 0.1;
        _confirmNode.yScale = 0.1;
        _confirmNode.position = CGPointMake(self.speakBgNode.size.width / 2.0 / 1.5 - _confirmNode.size.width * 2.0, 0);
        [self.speakBgNode addChild:_confirmNode];
    }
    
    return _confirmNode;
}

- (SKSpriteNode *)cancelNode{
    if (!_cancelNode) {
        _cancelNode = [SKSpriteNode spriteNodeWithTexture:self.textureManager.cancel];
        _cancelNode.position = CGPointMake(self.speakBgNode.size.width / 2.0 / 1.5, 0);
        _cancelNode.zPosition = 100000;
        _cancelNode.xScale = 0.1;
        _cancelNode.yScale = 0.1;
        _cancelNode.name   = @"cancel";
        [self.speakBgNode addChild:_cancelNode];
    }
    
    return _cancelNode;
}

- (SKSpriteNode *)speakBgNode{
    if (!_speakBgNode) {
        _speakBgNode = [SKSpriteNode spriteNodeWithTexture:self.textureManager.speak];
        _speakBgNode.zPosition = 100000;
        _speakBgNode.xScale = 1.5;
        _speakBgNode.yScale = 1.5;
        _speakBgNode.position = CGPointMake(0, -kScreenHeight + _speakBgNode.size.height / 1.5);
        [self addChild:_speakBgNode];
    }
    return _speakBgNode;
}

- (SKLabelNode *)speakLabelNode{
    
    if (!_speakLabelNode) {
        
        NSString *fontName = @"Noteworthy";
        SKLabelNode *node = [SKLabelNode labelNodeWithFontNamed:fontName];
        node.name = @"text";
        node.numberOfLines = 0;
        node.text = @"";
        node.fontColor = [UIColor whiteColor];
        node.zPosition = 100;
        node.colorBlendFactor = 1;
        node.fontSize = 30;
        node.color = [SKColor blackColor];
        node.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        node.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [self.speakBgNode addChild:node];
        _speakLabelNode = node;
    }
    
    return _speakLabelNode;
    
}

/// 操作线
- (WDBaseNode *)selectLine
{
    if (!_selectLine) {
        _selectLine = [WDBaseNode spriteNodeWithColor:UICOLOR_RGB(255, 227, 132, 1) size:CGSizeMake(50, 50)];
        _selectLine.anchorPoint = CGPointMake(0, 0);
        _selectLine.name = @"selectLine";
        _selectLine.zPosition = 10;
        _selectLine.hidden = YES;
        [self addChild:_selectLine];
    }
    
    return _selectLine;
}

- (WDBaseNode *)arrowNode
{
    if (!_arrowNode) {
        _arrowNode = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"arrow"]]];
        _arrowNode.zPosition = 2;
        _arrowNode.name = @"arrow";
        _arrowNode.alpha = 0;
        [self addChild:_arrowNode];
    }
    
    return _arrowNode;
}


- (WDBaseNode *)locationNode
{
    if (!_locationNode) {
        _locationNode = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"biaoji"]]];
        _locationNode.zPosition = 1;
        _locationNode.name = @"location";
        _locationNode.alpha = 0;
        [self addChild:_locationNode];
    }
    
    return _locationNode;
}

- (WDTextureManager *)textureManager
{
    if (!_textureManager) {
        _textureManager = [WDTextureManager shareManager];
    }
    
    return _textureManager;
}

- (NSMutableArray *)monsterArr{
    
    if (!_monsterArr) {
        _monsterArr = [NSMutableArray array];
    }
    
    return _monsterArr;
}

- (NSMutableArray *)userArr{
    
    if (!_userArr) {
        _userArr = [NSMutableArray array];
    }
    
    return _userArr;;
}


- (WDKknightNode *)knight{
   
    if (!_knight) {
        _knight = [WDBaseNode initActionWithName:kKinght superNode:self position:CGPointMake(0, 0)];
        [self.userArr addObject:_knight];
    }
    
    return _knight;
}

- (WDArcherNode *)archer{
   
    if (!_archer) {
        _archer = [WDBaseNode initActionWithName:kArcher superNode:self position:CGPointMake(0, 0)];
        [self.userArr addObject:_archer];
    }
    
    return _archer;
}

- (WDWizardNode *)wizard{
   
    if (!_wizard) {
        _wizard = [WDBaseNode initActionWithName:kWizard superNode:self position:CGPointMake(0, 0)];
        [self.userArr addObject:_wizard];
    }
    
    return _wizard;
}

- (WDPriestNode *)priest{
   
    if (!_priest) {
        _priest = [WDBaseNode initActionWithName:kPriest superNode:self position:CGPointMake(0, 0)];
        [self.userArr addObject:_priest];
    }
    
    return _priest;
}

- (WDSkillNpcNode *)skillLearnNpc{
    
    if (!_skillLearnNpc) {
        _skillLearnNpc = [WDBaseNode initActionWithName:kLearnSkillNPC superNode:self position:CGPointMake(self.knight.position.x - self.knight.size.width * 3.0, self.knight.position.y + self.knight.size.height)];
    }
    
    return _skillLearnNpc;
    
}


- (SKSpriteNode *)clickNode{
    if (!_clickNode) {
        _clickNode = [SKSpriteNode spriteNodeWithTexture:self.textureManager.handClickArr[0]];
        _clickNode.hidden = YES;
        _clickNode.name = @"click";
        _clickNode.position = CGPointMake(0, - 80.f * self.yScale);
        [self addChild:_clickNode];
        _clickNode.zPosition = 100000;
        NSArray *animationArr = [self.textureManager.handClickArr subarrayWithRange:NSMakeRange(0, 2)];
        SKAction *an = [SKAction animateWithTextures:animationArr timePerFrame:0.5];
        SKAction *re = [SKAction repeatActionForever:an];
        [_clickNode runAction:re];
    }
    
    return _clickNode;
}

- (SKSpriteNode *)leftOrRightNode{
    if (!_leftOrRightNode) {
        _leftOrRightNode = [SKSpriteNode spriteNodeWithTexture:self.textureManager.handClickArr[2]];
        _leftOrRightNode.hidden = YES;
        _leftOrRightNode.name = @"click";
        _leftOrRightNode.position = CGPointMake(0, 0);
        [self addChild:_leftOrRightNode];
        _leftOrRightNode.zPosition = 100000;
        
    }
    return _leftOrRightNode;
}

#pragma mark - 操作 -
/// 开始触碰
- (void)touchDownAtPoint:(CGPoint)pos {
   
    //[self.selectNode deadAction];
}

/// 手指移动
- (void)touchMovedToPoint:(CGPoint)pos {
    
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
    
    pos = [WDCalculateTool calculateMaxMovePosition:pos node:_selectNode];
    
    NSArray *nodes = [self nodesAtPoint:pos];
    CGFloat distance = 10000;
    WDEnemyNode *enemy = nil;
    WDUserNode  *user = nil;

    /// 牧师或其他治疗拖动治疗的情况，只考虑选中玩家，忽略敌人
    if ([self.selectNode.name isEqualToString:kPriest] && self.selectLine.hidden == NO) {
        
        /// 获取离点击点最近位置友军
        for (SKSpriteNode *node in nodes) {
            if([node isKindOfClass:[WDUserNode class]]){
                CGFloat dis = [WDCalculateTool distanceBetweenPoints:pos seconde:node.position];
                 if (dis < distance && dis <= node.size.width) {
                     user = (WDUserNode *)node;
                     distance = dis;
                     enemy = nil;
                 }
            }
        }
        
    }else{
        
        /// 获取离点击点最近位置的敌人
        for (SKSpriteNode *node in nodes) {
            if ([node isKindOfClass:[WDEnemyNode class]]) {
               CGFloat dis = [WDCalculateTool distanceBetweenPoints:pos seconde:node.position];
                if (dis < distance && dis <= node.size.width) {
                    enemy = (WDEnemyNode *)node;
                    distance = dis;
                    user = nil;
                }
            }else if([node isKindOfClass:[WDUserNode class]]){
                CGFloat dis = [WDCalculateTool distanceBetweenPoints:pos seconde:node.position];
                 if (dis < distance && dis <= node.size.width) {
                     user = (WDUserNode *)node;
                     distance = dis;
                     enemy = nil;
                 }
            }
        }
        
    }
    
    
    
    
    if (user) {
        
        ///选中user的情况
        [self changeOrCureUser:user];
        [self hiddenArrow];
        
    }else if(enemy){
    
        ///选中敌人
        [self clickEneny:enemy];
        [self hiddenArrow];
        
    }else{
        
        ///单纯移动
        self.selectNode.targetNode = enemy;
        [self.selectNode moveAction:pos];
        [self arrowMoveActionWithPos:pos];
    }
    

    self.selectLine.hidden = YES;
    self.selectLine.size = CGSizeMake(0, 0);
    
}

/// 点击到人物（切换人物或者治疗）
- (void)changeOrCureUser:(WDUserNode *)user{
    
    /// 以后可能增加治疗者（引导线存在的情况下，选中人物是加血状态）
    if ([self.selectNode.name isEqualToString:kPriest] && self.selectLine.hidden == NO) {
        
        self.selectNode.cureNode = user;
        self.selectNode.targetNode = nil;
        [user cureSelectSpriteAction];
        
    }else{
        
        [self changeSelectNode:user];
    }
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
    
    if (self.selectNode.attackDistance > 0) {
        [self.selectNode attackAction:enemy];
    }
}

/// 显示装备栏
- (void)presentEquipScene{
    if (self.prenestMenuForArmorBlock) {
        self.prenestMenuForArmorBlock(self.selectNode.name);
    }
}

/// 换装通知
- (void)changeEquip:(NSNotification *)notification{
    NSLog(@"%@",notification);
}

/// 招小怪
- (void)bossCallMonster:(NSNotification *)notification{
    NSLog(@"%@",notification);
}

#pragma mark - 释放技能 -
- (void)skill1Action{
    [_selectNode skill1Action];
}
- (void)skill2Action{
    [_selectNode skill2Action];
}
- (void)skill3Action{
    [_selectNode skill3Action];
}
- (void)skill4Action{
    [_selectNode skill4Action];
}
- (void)skill5Action{
    [_selectNode skill5Action];
}

#pragma mark - 人物死亡置空 -
- (void)deadForRelease:(WDBaseNode *)node{
    
    if ([node.name isEqualToString:kKinght]) {
        _knight = nil;
    }else if([node.name isEqualToString:kArcher]){
        _archer = nil;
    }else if([node.name isEqualToString:kPriest]){
        _priest = nil;
    }else if([node.name isEqualToString:kWizard]){
        _wizard = nil;
    }
    
}

#pragma mark - 物理检测 -
- (void)didBeginContact:(SKPhysicsContact *)contact{
    [self contactLogicAction:contact];
}
- (void)didEndContact:(SKPhysicsContact *)contact{
    
}

#pragma mark - 对话 -
- (void)setTextAction:(NSString *)text{
    self.speakBgNode.hidden = NO;
    self.speakLabelNode.text = text;
}

- (void)setTextAction:(NSString *)text
           hiddenTime:(NSInteger)time
        completeBlock:(void (^)(void))completeBlock{
   
    self.speakBgNode.hidden = NO;
    self.speakLabelNode.text = text;
    self.talkCompleteBlock = completeBlock;
    
    [self performSelector:@selector(endTalkAction) withObject:nil afterDelay:time];
    
}

- (void)changeSelectNode:(WDBaseNode *)node{
    _selectNode.arrowNode.hidden = YES;
    _selectNode = node;
    _selectNode.arrowNode.hidden = NO;
    
    [_selectNode selectSpriteAction];
    [WDNotificationManager changeUser:self.selectNode.name];
}

- (void)changeSelectNodeDirection:(NSInteger)direction
                             node:(nonnull WDBaseNode *)node{
    node.xScale = fabs(node.xScale) * direction;
}

- (void)endTalkAction{
    
    if (self.talkCompleteBlock) {
        self.talkCompleteBlock();
    }
}


- (void)stopTalk{
    self.speakBgNode.hidden = YES;
}

- (void)setClickNodePositionWithNode:(WDBaseNode *)node{
    self.clickNode.position = CGPointMake(node.position.x, self.clickNode.position.y);
    self.clickNode.hidden = NO;
}

- (void)showConfirmNodes{
    self.cancelNode.hidden = NO;
    self.confirmNode.hidden = NO;
}

- (void)hiddenConfirmNodes{
    self.cancelNode.hidden = YES;
    self.confirmNode.hidden = YES;
}

#pragma mark - 指示箭头 -
- (void)hiddenArrow{
   
    WDBaseNode *arrow  = self.arrowNode;
    WDBaseNode *location = self.locationNode;
            
    [arrow removeAllActions];
    [location removeAllActions];
            
    arrow.alpha = 0;
    location.alpha = 0;
}

- (void)arrowMoveActionWithPos:(CGPoint)pos{
    WDBaseNode *arrow  = self.arrowNode;
    WDBaseNode *location = self.locationNode;
       
    [arrow removeAllActions];
    [location removeAllActions];

    CGFloat y = pos.y;
       
    arrow.alpha = 1;
    location.alpha = 1;
    arrow.position = CGPointMake(pos.x, y + 30 * self.yScale);
    location.position = CGPointMake(pos.x, y - 60 * self.yScale);
       
    SKAction *move1 = [SKAction moveTo:CGPointMake(pos.x,y + 70 * self.yScale) duration:0.3];
    SKAction *move2 = [SKAction moveTo:CGPointMake(pos.x, y + 30 * self.yScale) duration:0.3];
    SKAction *seq = [SKAction sequence:@[move1,move2]];
    SKAction *rep = [SKAction repeatActionForever:seq];
    [arrow runAction:rep];
       
    SKAction *alpha1 = [SKAction fadeAlphaTo:0.6 duration:0.3];
    SKAction *alpha2 = [SKAction fadeAlphaTo:1 duration:0.3];
    SKAction *seq1 = [SKAction sequence:@[alpha1,alpha2]];
    SKAction *rep2 = [SKAction repeatActionForever:seq1];
    [location runAction:rep2];
}

- (void)setHateNameArrWithNode:(NSArray *)nodes{
   
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:nodes.count];
    for (int i = 0; i < nodes.count; i ++) {
        WDBaseNode *node = nodes[i];
        [arr addObject:node.name];
    }
    
    _hateNameArr = [arr copy];
}


#pragma mark - 死亡方法 -
- (void)deadAction:(NSNotification *)notification{
    
    WDBaseNode *node = (WDBaseNode *)notification.object;
    
    if ([node isKindOfClass:[WDUserNode class]]) {
        
        NSLog(@"玩家：%@ 死亡了",node.name);
        
        
    }else if([node isKindOfClass:[WDEnemyNode class]]){
        
        NSLog(@"敌人：%@ 死亡了",node.name);
        [self.monsterArr removeObject:node];
        
    }
    
}

#pragma mark - 切换场景 -
- (void)changeSceneWithName:(NSString *)sceneName{
    if (self.changeSceneBlock) {
        self.changeSceneBlock(sceneName);
    }
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%@释放了",NSStringFromClass([self class]));
}


@end
