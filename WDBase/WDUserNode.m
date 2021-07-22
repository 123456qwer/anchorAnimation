//
//  WDUserNode.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/29.
//

#import "WDUserNode.h"
#import "WDBaseNode+Animation.h"
#import "WDBaseNode+Emoji.h"

@implementation WDUserNode

- (void)createUserNodeWithScale:(CGFloat)scale
{
    [super createUserNodeWithScale:scale];
    
    [self setArrowNodeWithPosition:CGPointMake(0, self.size.height - 60 * scale) scale:1 * scale];
    
    [self addBlood:0];
    self.bgBlood.position = CGPointMake(self.bgBlood.position.x, self.bgBlood.position.y);

    [self createUserAttackPhysicBodyWithPoint:CGPointMake(0, 0) size:self.size];
}

- (void)createUserAttackPhysicBodyWithPoint:(CGPoint)point
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
    self.physicsBody.categoryBitMask    = PLAYER_CATEGORY;
    self.physicsBody.collisionBitMask   = PLAYER_COLLISION;
    self.physicsBody.contactTestBitMask = PLAYER_CONTACT;
}

/// 这里需要CADisplay的移动速度方法
- (void)moveSameActionWithState:(SpriteState)moveState
                      movePoint:(CGPoint)movePoint
{
    
    /// 选中目标的话直接caDisplay移动，无目标就是直接移动,避免出现问题
    if (self.targetNode && !(self.targetNode.state & Sprite_dead)) {
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
        
        CGPoint point = [WDCalculateTool calculateNodeMovePosition:self enemy:self.targetNode];;
        
        
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
        
    }else{
        
        [super moveSameActionWithState:moveState movePoint:movePoint];
    }
    
    
}

- (void)selectSpriteAction
{
    SKAction *a = [SKAction colorizeWithColor:[UIColor blackColor] colorBlendFactor:1 duration:0.15];
    SKAction *b = [SKAction colorizeWithColorBlendFactor:0 duration:0.15];
    SKAction *seq = [SKAction sequence:@[a,b]];
    SKAction *rep = [SKAction repeatAction:seq count:4];
    
    [self.arrowNode runAction:rep];
    [self.shadow runAction:rep];
}

- (void)cureSelectSpriteAction{
    
    ///4ebd00
    SKAction *a = [SKAction colorizeWithColor:[UIColor redColor] colorBlendFactor:1 duration:0.15];
    SKAction *b = [SKAction colorizeWithColorBlendFactor:0 duration:0.15];
    SKAction *seq = [SKAction sequence:@[a,b]];
    SKAction *rep = [SKAction repeatAction:seq count:4];
    
    [self.shadow runAction:rep];
}


@end
