//
//  WDEnemyNode.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/25.
//

#import "WDEnemyNode.h"
#import "WDBaseNode+Animation.h"
#import "WDBaseNode+Emoji.h"

@implementation WDEnemyNode
#pragma mark - 敌人 -
- (void)createUserNodeWithScale:(CGFloat)scale{
    
    [super createUserNodeWithScale:scale];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addHateNumber:) name:kNotificationForAddHateNumber object:nil];
    
    [self createMonsterAttackPhysicBodyWithPoint:CGPointMake(0, 0) size:self.size];
}

- (void)createMonsterAttackPhysicBodyWithPoint:(CGPoint)point
                                          size:(CGSize)size
{
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:size center:point];
    body.allowsRotation = NO;
    body.affectedByGravity = NO;
    self.physicsBody = body;
    
    [self setBodyCanUse];
}

- (void)setBodyCanUse
{
    self.physicsBody.categoryBitMask    = MONSTER_CATEGORY;
    self.physicsBody.collisionBitMask   = MONSTER_COLLISION;
    self.physicsBody.contactTestBitMask = MONSTER_CONTACT;
}

#pragma mark - 仇恨系统 -
- (void)setHateSprites:(NSArray *)names
{
    WDHateManager *manager = [[WDHateManager alloc] init];
    self.hateManager = manager;
    self.hateManager.hateDic = [NSMutableDictionary dictionary];
    
    for (NSString *name in names) {
        [self.hateManager.hateDic setObject:@(0) forKey:name];
    }
    
}

- (void)addHateNumber:(NSNotification *)notification{
    
    WDBaseNode *node = (WDBaseNode *)notification.object;
    [self addHateNumberWithAttackNode:node];
    
}


- (void)addHateNumberWithAttackNode:(WDBaseNode *)node{
    
    if (!node) {
        return;
    }
    
    int hateNumber = [self.hateManager.hateDic[node.name]intValue];
    CGFloat attackNumber = node.ATK;
    if ([node.name isEqualToString:kPriest]) {
        attackNumber = 0;
    }
    
    /// 目前仇恨值的计算是node自带的仇恨值 + 攻击力 + 之前积累的仇恨值
    hateNumber = node.hateNumber + attackNumber + hateNumber;
    
    [self.hateManager.hateDic setObject:@(hateNumber) forKey:node.name];
    
    NSArray *hateNames = self.hateManager.hateDic.allKeys;
    int bigNumber = hateNumber;
    for (int i = 0; i < hateNames.count; i ++) {
        
        NSString *name = hateNames[i];
        int hateN = [self.hateManager.hateDic[name]intValue];
        if (bigNumber <= hateN) {
            bigNumber = hateN;
        }
    }
    
    if (hateNumber == bigNumber) {
        self.targetNode = node;
    }
}



/// 一直在更新的方法
- (void)upDataAction
{
    self.zPosition = 4000 - self.position.y;
   
    if (self.state & Sprite_dead) {
        return;
    }
    
    if (self.state & Sprite_movie) {
        return;
    }
    
    /// 死亡状态忽略
    if (self.state & Sprite_stand && !(self.state & Sprite_dead)) {
        [self removeLegAnimation];
    }
    
    /// 目标死亡，清除仇恨
    if (self.targetNode.state & Sprite_dead) {
        [self.hateManager.hateDic setObject:@(0) forKey:self.targetNode.name];
    }
    
    if (self.attackDistance == 0) {
        
        /// 近战攻击
        if (self.targetNode && !(self.targetNode.state & Sprite_dead)) {
            
            /// 行走方向
            if (self.targetNode.position.x > self.position.x) {
                self.xScale = fabs(self.xScale);
            }else{
                self.xScale = - fabs(self.xScale);
            }
            
            /// 攻击、走动、跑动状态不处理
            if (self.state & Sprite_attack) {
                return;
            }
            
            /// 超出距离
            int distance = fabs(self.position.x - self.targetNode.position.x);
            int distanceY = fabs(self.position.y - self.targetNode.position.y);
            
            ///如果目标的目标不是自己
            if(![self.targetNode.targetNode.numberName isEqualToString:self.numberName] && self.targetNode.targetNode){
                
                if (self.targetNode.xScale > 0 && self.position.x > self.targetNode.position.x) {
                    CGPoint movePoint = [WDCalculateTool calculateNodeMovePosition:self enemy:self.targetNode];
                    [self moveAction:movePoint];
                    return;
                }else if(self.targetNode.xScale < 0 && self.position.x < self.targetNode.position.x){
                    CGPoint movePoint = [WDCalculateTool calculateNodeMovePosition:self enemy:self.targetNode];
                    [self moveAction:movePoint];
                    return;
                }
                
            }
            
            
            if (distance > self.attackMaxSize + self.targetNode.attackMaxSize || distanceY > self.size.height / 3.0 || distance < self.attackMinSize) {
                CGPoint movePoint = [WDCalculateTool calculateNodeMovePosition:self enemy:self.targetNode];
                [self moveAction:movePoint];
                
            }else{
                
                ///可以攻击的状态
                [self attackAction:self.targetNode];
            }
        }
    }else{
        
        
        /// 远程攻击
        if (self.targetNode && !(self.targetNode.state & Sprite_dead)) {
            
            /// 行走方向
            if (self.targetNode.position.x > self.position.x) {
                self.xScale = fabs(self.xScale);
            }else{
                self.xScale = - fabs(self.xScale);
            }
            
            /// 攻击、走动、跑动状态不处理
            if (self.state & Sprite_attack) {
                return;
            }
            
            /// 超出距离
            int distance = fabs([WDCalculateTool distanceBetweenPoints:self.position seconde:self.targetNode.position]);
            CGFloat wi = self.parent.frame.size.width / 2.0;
            int x = self.position.x;
            BOOL isMax = NO;
            int a = wi - self.size.width;
            int b = -wi + self.size.width;
            if (x >= a) {
                isMax = YES;
            }else if(x <= b){
                isMax = YES;
            }
             
            if (isMax && distance < self.attackDistance) {
                ///可以攻击的状态
                [self attackAction:self.targetNode];
                
            }else if (distance > self.attackDistance) {
                
                CGPoint movePoint = [WDCalculateTool calculateNodeMovePositionForBow:self enemy:self.targetNode];
                [self moveAction:movePoint];
                
            }else{
                ///可以攻击的状态
                [self attackAction:self.targetNode];
            }
        }
    }
    
    
}

/// 这里需要CADisplay的移动速度方法
- (void)moveSameActionWithState:(SpriteState)moveState
                      movePoint:(CGPoint)movePoint
{
    if (self.state & Sprite_stand) {
        self.state = self.state ^ Sprite_stand;
    }
    
    if (self.state & Sprite_attack) {
        self.state = self.state ^ Sprite_attack;
    }
    
    BOOL isWalk = YES;
    
    if (moveState == Sprite_walk) {
        if (self.state & Sprite_run) {
            self.state = self.state ^ Sprite_run;
        }
        
    }else{
        if (self.state & Sprite_walk) {
            self.state = self.state ^ Sprite_walk;
        }
        isWalk = NO;
    }

    
    if (!(self.state & moveState)) {
        
        [self.hip removeAllActions];
        [self.body removeAllActions];
        [self.leftArm removeAllActions];
        [self.leftElbow removeAllActions];
        [self.rightArm removeAllActions];
        
        self.leftArm.zRotation = self.leftArm.defaultAngle;
        self.rightArm.zRotation = self.rightArm.defaultAngle;
        self.hip.zRotation = 0;
        self.body.zRotation = 0;
        
        [self removeLegAnimation];
        [self performSelector:@selector(rightLegMoveAction) withObject:nil afterDelay:self.walkTime / 2];
        [self rightLegMoveAction];
        [self leftLegMoveAction];
        if (isWalk) {
            [self upBodyActionForWalk];
        }else{
            [self upBodyActionForRun];
        }
    }
    
    [self removeAllActions];
    self.state = self.state | moveState;
    
    
    if (movePoint.x < self.position.x) {
        self.xScale = - fabs(self.xScale);
    }else{
        self.xScale = fabs(self.xScale);
    }
    
    CGPoint point = [WDCalculateTool calculateNodeMovePosition:self enemy:self.targetNode];
    if (self.attackDistance > 0) {
        point = [WDCalculateTool calculateNodeMovePositionForBow:self enemy:self.targetNode];
    }
    
    
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
}


- (void)dealloc
{
    NSLog(@"%@释放了",self.name);
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotificationForAddHateNumber object:nil];
}



@end
