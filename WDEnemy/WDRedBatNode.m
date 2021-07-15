//
//  WDRedBatNode.m
//  BattleHeartNew
//
//  Created by Mac on 2020/12/11.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import "WDRedBatNode.h"

@implementation WDRedBatNode
{
    WDRedBatModel *_batModel;
    CGPoint _position;
    int _stagger;
}

+ (instancetype)initWithModel:(WDRedBatModel *)model
{
    WDRedBatNode *node = [WDRedBatNode spriteNodeWithTexture:model.standArr[0]];
    [node setChildNodeWithModel:model];
    return node;
}

- (void)setChildNodeWithModel:(WDRedBatModel *)model
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(upDataAction) name:kNotificationForUpData object:nil];
    [model changeArr];
    self.shadow = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"Shadow"]]];
    self.shadow.position = CGPointMake(0, -340 * allScale);
    self.shadow.xScale = 0.5;
    self.shadow.yScale = 0.5;
    [self addChild:self.shadow];
    
    _stagger = 1;
    self.xScale = 0.3;
    self.yScale = 0.3;
    
    _batModel = (WDRedBatModel *)model;
    
    self.model = _batModel;
    self.realSize = CGSizeMake(self.size.width - 80, self.size.height - 10);
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(25, 50) center:CGPointMake(0, 0)];
    self.physicsBody = body;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.allowsRotation = NO;
        
    [self createMonsterAttackPhysicBodyWithPoint:CGPointMake(0, 0) size:CGSizeMake(self.realSize.width, self.realSize.height)];
    
    self.attackMaxSize = self.realSize.width / 2.0 + 15;
    self.attackMinSize = self.realSize.width / 3.0 + 15;
    //[self setBodyCanUse];
    

    SKAction *stand = [SKAction animateWithTextures:self.model.standArr timePerFrame:0.1];
    SKAction *rep = [SKAction repeatActionForever:stand];
    [self runAction:rep withKey:@"stand"];
    _position = CGPointMake(0, 0);
    
    
    [self addObserver:self forKeyPath:@"xScale" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionNew context:nil];
    
    ///血条
    [self createBlood:2 * allScale];
    [self setBloodYPosition:200 * allScale];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (self.xScale > 0) {
        self.bgBlood.xScale = fabs(self.bgBlood.xScale);
        self.bgBlood.position = CGPointMake(-self.size.width / 2.0, self.bgBlood.position.y);
        self.direction = 1;
    }else{
        self.bgBlood.xScale = - fabs(self.bgBlood.xScale);
        self.bgBlood.position = CGPointMake(self.size.width / 2.0, self.bgBlood.position.y);
        self.direction = -1;
    }
}

- (void)createRealSizeNode{
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithColor:[[UIColor orangeColor]colorWithAlphaComponent:0.7] size:self.size];
    node.zPosition = 100;
    [self addChild:node];
}

- (void)beAttackActionWithTargetNode:(WDBaseNode *)targetNode
{
    
}

- (void)beAttackAction:(WDBaseNode *)enemyNode attackNumber:(int)attackNumber{
    [super beAttackAction:enemyNode attackNumber:attackNumber];
    
    ///血量少于一半，硬直
    if (self.lastBlood * 2 < self.initBlood && _stagger == 1) {
        _stagger = 0;
        
        [self removeAllActions];
        self.state = Sprite_movie;
        self.colorBlendFactor = 0;
      
        
        SKAction *action = [SKAction animateWithTextures:self.model.beHurtArr timePerFrame:0.1];
        SKAction *move = [SKAction moveTo:CGPointMake(self.position.x + 60 * - self.direction, self.position.y) duration:0.3];
        SKAction *gr = [SKAction group:@[action,move]];
        __weak typeof(self)weakSelf = self;
        [self runAction:gr completion:^{
            weakSelf.state = Sprite_stand;
        }];
    }
    
}

- (void)deadAnimation{
    
    [self removeAllActions];
    self.state = Sprite_dead;
    
    SKAction *diedAction = [SKAction animateWithTextures:self.model.diedArr timePerFrame:0.1];
    SKAction *alpha = [SKAction fadeAlphaTo:0 duration:self.model.diedArr.count * 0.1];
    SKAction *gr = [SKAction group:@[diedAction,alpha]];
    SKAction *remo = [SKAction removeFromParent];
    SKAction *seq = [SKAction sequence:@[gr,remo]];
    __weak typeof(self)weakSelf = self;
    [self runAction:seq completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForDead object:weakSelf];
    }];
    
}

- (void)attackActionWithEnemyNode:(WDBaseNode *)enemyNode
{
    if (self.state & Sprite_attack) {
        return;
    }
    
    self.state = self.state | Sprite_attack;
    
    CGFloat direction = self.direction;
    
    
    NSArray *sub = [self.model.attackArr1 subarrayWithRange:NSMakeRange(0, 6)];
    NSArray *sub2 = [self.model.attackArr1 subarrayWithRange:NSMakeRange(6, self.model.attackArr1.count - 6)];
    SKAction *texture = [SKAction animateWithTextures:sub timePerFrame:0.1];
    texture.timingMode = SKActionTimingEaseIn;

    
    //突进
    SKAction *wait = [SKAction waitForDuration:0.1 * 4];
    SKAction *move = [SKAction moveTo:CGPointMake(self.position.x + 70 * direction, self.position.y) duration:0.2];
    SKAction *seqq = [SKAction sequence:@[wait,move]];
    SKAction *gro = [SKAction group:@[seqq,texture]];
    
    
    //位移回去
    SKAction *move2 = [SKAction moveTo:self.position duration:0.2];
    move2.timingMode = SKActionTimingEaseOut;
    SKAction *texture2 = [SKAction animateWithTextures:sub2 timePerFrame:0.1 * sub2.count];
    texture2.timingMode = SKActionTimingEaseOut;
    SKAction *gr = [SKAction group:@[move2,texture2]];
    
    
    __weak typeof(self)weakSelf = self;
    [self runAction:gro completion:^{
        
        if ([self canReduceBlood]) {
            [enemyNode beAttackAction:weakSelf attackNumber:weakSelf.attackNumber];
            [enemyNode addHateNumberWithAttackNode:weakSelf];
        }
        
        [weakSelf runAction:gr completion:^{
            weakSelf.state = weakSelf.state ^ Sprite_attack;
        }];
        
    }];
}


- (BOOL)canReduceBlood{
   
    /// 超出距离
    int distanceX = fabs(self.position.x - self.targetNode.position.x);
    int distanceY = fabs(self.position.y - self.targetNode.position.y);
    WDBaseNode *node = (WDBaseNode *)self.targetNode;
    if (distanceX > self.attackMaxSize + node.attackMaxSize || distanceY > self.size.height / 3.0) {
      
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)canAttack{
   
    /// 超出距离
    int distanceX = fabs(self.position.x - self.targetNode.position.x);
    int distanceY = fabs(self.position.y - self.targetNode.position.y);
    WDBaseNode *node = (WDBaseNode *)self.targetNode;
    if (distanceX > self.attackMaxSize + node.attackMaxSize || distanceY > self.size.height / 3.0 || distanceX < self.attackMinSize) {
      
        return NO;
    }else{
        return YES;
    }
}



- (void)upDataAction{
    
    [self observedNode];
}

- (void)observedNode
{
    
    self.zPosition = 10000 - self.position.y;
    self.zPosition = self.zPosition + 100;
      
    
    if (self.state & Sprite_dead) {
        return;
    }
    
    if (self.state & Sprite_movie) {
        return;
    }
    
    
    if (self.state & Sprite_attack) {
        return;
    }
   
    if (!self.targetNode) {

        return;
    }
    
    
    /// 玩家死亡
    if (self.targetNode.state & Sprite_dead) {
        self.targetNode = nil;
        [self standAction];
        return;
    }
    
    /// 行走方向
    if (self.targetNode.position.x > self.position.x) {
        self.xScale = fabs(self.xScale);
    }else{
        self.xScale = - fabs(self.xScale);
    }
    
    
   
    if ([self canAttack]) {
        [self attackActionWithEnemyNode:self.targetNode];
        return;
    }
    
    CGPoint point = [WDCalculateTool calculateNodeMovePosition:self enemy:self.targetNode];
    
    
    CGFloat distanceX = self.position.x - point.x;
    CGFloat distanceY = self.position.y - point.y;
    
  
    NSInteger xDirection = 1;
    NSInteger yDirection = 1;
    
    if (distanceX > 0) {
        xDirection = -1;
    }else{
        xDirection = 1;
    }
       
    if (distanceY > 0) {
        yDirection = -1;
    }else{
        yDirection = 1;
    }
       
    CGFloat aDX = fabs(distanceX);
    CGFloat aDY = fabs(distanceY);
    //斜边英文。。。。等比计算
    CGFloat hypotenuse = sqrt(aDX * aDX + aDY * aDY);
       
    CGFloat moveX = self.CADisplaySpeed * aDX / hypotenuse * xDirection;
    CGFloat moveY = self.CADisplaySpeed * aDY / hypotenuse * yDirection;
       
           
    CGFloat pointX = self.position.x + moveX;
    CGFloat pointY = self.position.y + moveY;
    
    
   
    self.position = CGPointMake(pointX, pointY);
       
    SKAction *moveAnimation = [self actionForKey:@"moveAnimation"];
    if (!moveAnimation) {
        SKAction *texture = [SKAction animateWithTextures:self.model.walkArr timePerFrame:0.05];
        SKAction *rep = [SKAction repeatActionForever:texture];
        [self runAction:rep withKey:@"moveAnimation"];
    }
}

- (void)releaseAction
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (void)dealloc
{
    _batModel = nil;
}

@end
