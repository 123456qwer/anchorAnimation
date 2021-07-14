//
//  WDBaseScene.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import "WDBaseScene.h"
#import "WDBaseScene+ContactLogic.h"


@implementation WDBaseScene

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
    
    self.bgNode = (SKSpriteNode *)[self childNodeWithName:@"bgNode"];
    CGFloat yScale = self.size.height / self.bgNode.size.height;
    self.bgNode.yScale = yScale;
    self.bgNode.xScale = yScale;
}

#pragma mark - 通知方法 -
- (void)addObserve{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deadAction:) name:kNotificationForDead object:nil];
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
/// 操作线
- (WDBaseNode *)selectLine
{
    if (!_selectLine) {
        _selectLine = [WDBaseNode spriteNodeWithColor:UICOLOR_RGB(255, 227, 132, 1) size:CGSizeMake(50, 50)];
        _selectLine.anchorPoint = CGPointMake(0, 0);
        _selectLine.name = @"selectLine";
        _selectLine.zPosition = 10;
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
    
    NSLog(@"屏宽 :%lf bg宽 :%lf",kScreenWidth,self.bgNode.size.width);
    NSLog(@"x: %lf %lf",pos.x,pos.y);
    
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
        
    }else{
        
        self.selectNode.arrowNode.hidden = YES;
        self.selectNode = user;
        self.selectNode.arrowNode.hidden = NO;
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
    [self.selectNode pauseWalkOrRun];

    
    CGFloat dis = [WDCalculateTool distanceBetweenPoints:enemy.position seconde:self.selectNode.position];
    
    if (dis <= self.selectNode.size.width || self.selectNode.attackDistance > 0) {
        [self.selectNode attackAction:enemy];
    }else{
        CGPoint movePoint = [WDCalculateTool calculateNodeMovePosition:self.selectNode enemy:enemy];
        [_selectNode moveAction:movePoint];
    }
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

#pragma mark - 物理检测 -
- (void)didBeginContact:(SKPhysicsContact *)contact{
    [self contactLogicAction:contact];
}
- (void)didEndContact:(SKPhysicsContact *)contact{
}





#pragma mark - 指示箭头 -
- (void)hiddenArrow
{
   
    WDBaseNode *arrow  = self.arrowNode;
    WDBaseNode *location = self.locationNode;
            
    [arrow removeAllActions];
    [location removeAllActions];
            
    arrow.alpha = 0;
    location.alpha = 0;
}

- (void)arrowMoveActionWithPos:(CGPoint)pos
{
    WDBaseNode *arrow  = self.arrowNode;
    WDBaseNode *location = self.locationNode;
       
    [arrow removeAllActions];
    [location removeAllActions];

    CGFloat y = pos.y;
       
    arrow.alpha = 1;
    location.alpha = 1;
    arrow.position = CGPointMake(pos.x, y);
    location.position = CGPointMake(pos.x, y - 80);
       
    SKAction *move1 = [SKAction moveTo:CGPointMake(pos.x,y + 40) duration:0.3];
    SKAction *move2 = [SKAction moveTo:CGPointMake(pos.x, y ) duration:0.3];
    SKAction *seq = [SKAction sequence:@[move1,move2]];
    SKAction *rep = [SKAction repeatActionForever:seq];
    [arrow runAction:rep];
       
    SKAction *alpha1 = [SKAction fadeAlphaTo:0.6 duration:0.3];
    SKAction *alpha2 = [SKAction fadeAlphaTo:1 duration:0.3];
    SKAction *seq1 = [SKAction sequence:@[alpha1,alpha2]];
    SKAction *rep2 = [SKAction repeatActionForever:seq1];
    [location runAction:rep2];
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%@释放了",NSStringFromClass([self class]));
}


@end
