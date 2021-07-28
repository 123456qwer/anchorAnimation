//
//  WDBaseNode+Animation.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/21.
//

#import "WDBaseNode+Animation.h"
#import "WDEnemyNode.h"
#import "WDBaseScene.h"
#import "WDBaseNode+Emoji.h"

@implementation WDBaseNode (Animation)

#pragma mark - 上半身 -
- (void)removeUpBodyAction
{
    [self.rightElbow removeActionForKey:kAnimationUpBody];
    [self.leftElbow removeActionForKey:kAnimationUpBody];
    [self.hip removeActionForKey:kAnimationUpBody];
    [self.body removeActionForKey:kAnimationUpBody];
}

/// 上半身跑动动画
- (void)upBodyActionForRun{
    
    [self removeUpBodyAction];

    NSDictionary *angleDic =
    @{kRightArm:@[@(-3),@(-15)],kLeftArm:@[@(20),@(0)],kBody:@[@(-20),@(-10)]};
    
    [self leftArmAction:angleDic[kLeftArm]];
    [self rightArmAction:angleDic[kRightArm]];
    [self bodyAndHipAction:angleDic[kBody]];
}

/// 上半身走动动画
- (void)upBodyActionForWalk{
    
    [self removeUpBodyAction];

    NSDictionary *angleDic =
    @{kRightArm:@[@(-3),@(-15)],kLeftArm:@[@(20),@(0)],kBody:@[@(-10),@(-4)]};
    
    [self leftArmAction:angleDic[kLeftArm]];
    [self rightArmAction:angleDic[kRightArm]];
    [self bodyAndHipAction:angleDic[kBody]];
}

/// 上半身站立动画
- (void)upBodyActionForStand{
    
    NSDictionary *angleDic =
    @{kRightArm:@[@(-6),@(-12)],kLeftArm:@[@(14),@(8)],kBody:@[@(-1),@(1)]};
    
    [self leftArmAction:angleDic[kLeftArm]];
    [self rightArmAction:angleDic[kRightArm]];
    [self bodyAndHipAction:angleDic[kBody]];
}

/// 右胳膊晃动
- (void)rightArmAction:(NSArray *)angleArr{
    
    CGFloat angle1 = [angleArr[0]floatValue];
    CGFloat angle2 = [angleArr[1]floatValue];
    
    SKAction *rightElbowAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(angle1) duration:0.5];
    SKAction *rightElbowAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(angle2) duration:0.5];
    SKAction *seqRightElbow = [SKAction sequence:@[rightElbowAction,rightElbowAction2]];
    SKAction *repRightElbow = [SKAction repeatActionForever:seqRightElbow];
    [self.rightElbow runAction:repRightElbow withKey:kAnimationUpBody];
}

/// 左胳膊晃动
- (void)leftArmAction:(NSArray *)angleArr{
    
    CGFloat angle1 = [angleArr[0]floatValue];
    CGFloat angle2 = [angleArr[1]floatValue];
    
    SKAction *leftElbowAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(angle1) duration:0.5];
    SKAction *leftElbowAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(angle2) duration:0.5];
    SKAction *seqElbow = [SKAction sequence:@[leftElbowAction,leftElbowAction2]];
    SKAction *repElbow = [SKAction repeatActionForever:seqElbow];
    [self.leftElbow runAction:repElbow withKey:kAnimationUpBody];
}

/// 上身摇摆
- (void)bodyAndHipAction:(NSArray *)angleArr
{
    CGFloat angle1 = [angleArr[0]floatValue];
    CGFloat angle2 = [angleArr[1]floatValue];
//    
    SKAction *bodyAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(angle1) duration:0.5];
    SKAction *bodyAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(angle2) duration:0.5];
    SKAction *seq = [SKAction sequence:@[bodyAction,bodyAction2]];
    SKAction *rep = [SKAction repeatActionForever:seq];
    [self.body runAction:rep withKey:kAnimationUpBody];
    
    
    SKAction *hipAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-angle1) duration:0.5];
    SKAction *hipAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-angle2) duration:0.5];
    SKAction *seqHip = [SKAction sequence:@[hipAction,hipAction2]];
    SKAction *repHip = [SKAction repeatActionForever:seqHip];
    [self.hip runAction:repHip withKey:kAnimationUpBody];
    
    
}


#pragma mark - 腿部 -
- (void)removeLegAnimation
{
    [self.rightKnee removeActionForKey:KAnimationFootMove];
    [self.rightFoot removeActionForKey:KAnimationFootMove];
    [self.leftKnee removeActionForKey:KAnimationFootMove];
    [self.leftFoot removeActionForKey:KAnimationFootMove];
    
    
    self.rightKnee.zRotation = self.rightKnee.defaultAngle;
    self.rightFoot.zRotation = self.rightFoot.defaultAngle;
    
    self.leftKnee.zRotation = self.leftKnee.defaultAngle;
    self.leftFoot.zRotation = self.leftFoot.defaultAngle;
}
/// 左腿走
- (void)leftLegMoveAction{
    
    
    NSTimeInterval moveTime = self.walkTime;
    CGFloat angle = -self.legWalkAngle;
    
    SKAction *kneeAction1 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(angle) duration:moveTime];
    SKAction *kneeAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-angle) duration:moveTime];
    
    SKAction *kneeSeq = [SKAction sequence:@[kneeAction1,kneeAction2,[SKAction waitForDuration:moveTime ]]];
    SKAction *kneeRep = [SKAction repeatActionForever:kneeSeq];
    
    [self.leftKnee runAction:kneeRep withKey:KAnimationFootMove];
    
    
    SKAction *footAction1 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:moveTime];
    SKAction *footAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-angle * 2.0) duration:moveTime];
    SKAction *footWait = [SKAction waitForDuration:moveTime];
    SKAction *footSeq = [SKAction sequence:@[footAction2,footAction1,[SKAction waitForDuration:moveTime]]];
    SKAction *footRep = [SKAction repeatActionForever:footSeq];

    __weak typeof(self)weakSelf = self;
    [self.leftFoot runAction:footWait completion:^{
        [weakSelf.leftFoot runAction:footRep withKey:KAnimationFootMove];
    }];
}

/// 右腿走
- (void)rightLegMoveAction{
    
    NSTimeInterval moveTime = self.walkTime;
    CGFloat angle = self.legWalkAngle;
    
    
    SKAction *kneeAction1 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(angle) duration:moveTime];
    SKAction *kneeAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-angle) duration:moveTime];
    
    SKAction *kneeSeq = [SKAction sequence:@[kneeAction1,kneeAction2,kneeAction1]];
    SKAction *kneeRep = [SKAction repeatActionForever:kneeSeq];
    
    [self.rightKnee runAction:kneeRep withKey:KAnimationFootMove];
    
    SKAction *footAction1 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:moveTime];
    SKAction *footAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-angle * 2.0) duration:moveTime];
    SKAction *footWait = [SKAction waitForDuration:moveTime * 2];
    SKAction *footSeq = [SKAction sequence:@[footAction2,footAction1,[SKAction waitForDuration:moveTime]]];
    SKAction *footRep = [SKAction repeatActionForever:footSeq];

    __weak typeof(self)weakSelf = self;
    [self.rightFoot runAction:footWait completion:^{
        [weakSelf.rightFoot runAction:footRep withKey:KAnimationFootMove];
    }];
}


#pragma mark - 攻击 -
/// 单手武器攻击
- (void)singleAttackAction:(WDBaseNode *)enemyNode{
    
  
    self.state = self.state | Sprite_attack;
   
    [self pauseWalkOrRun];

    /// 左胳膊的动作条
    SKAction *armAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(115) duration:0.15];
    
    SKAction *elbowAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(60) duration:0.15];
    SKAction *elbowAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:0.1];
    SKAction *elbowSeq = [SKAction sequence:@[elbowAction,elbowAction2]];
    
    SKAction *armAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-45) duration:0.1];
    SKAction *armAction3 = [SKAction rotateToAngle:self.leftArm.defaultAngle duration:0.1];
    SKAction *armSeq = [SKAction sequence:@[armAction2,armAction3]];
   
    /// 右胳膊的动作条
    SKAction *rightArmAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:0.15];
    
    SKAction *rightArm2Action = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-45) duration:0.1];
    SKAction *rightArm3Action = [SKAction rotateToAngle:self.rightArm.defaultAngle duration:0.1];
    SKAction *rightArmSeq = [SKAction sequence:@[rightArm2Action,rightArm3Action]];
    
    /// 身体的动作
    SKAction *bodyAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(5) duration:0.15];
    
    SKAction *bodyAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-10) duration:0.1];
    SKAction *bodyAction3 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:0.1];
    SKAction *bodySeq = [SKAction sequence:@[bodyAction2,bodyAction3]];
    
    SKAction *hipAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-5) duration:0.15];
    
    SKAction *hipAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(10) duration:0.1];
    SKAction *hipAction3 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:0.1];
    SKAction *hipSeq = [SKAction sequence:@[hipAction2,hipAction3]];
    
    
    __weak typeof(self)weakSelf = self;
    [self.body runAction:bodyAction];
    [self.hip runAction:hipAction];
    [self.rightArm runAction:rightArmAction];
    [self.leftArm runAction:armAction completion:^{
        
        [weakSelf.leftElbow runAction:elbowSeq completion:^{
            
            [weakSelf angleFaceState];
            
            SKAction *waitAction = [SKAction waitForDuration:0.1];
            ///未击中的情况下直接攻击
            __block NSTimeInterval attactWaitTime = 0.4;
            [weakSelf runAction:waitAction completion:^{
                
                ///击中判定
                int dis = fabs(weakSelf.position.x - enemyNode.position.x);
                int add = 0;
                if ([self isKindOfClass:[WDEnemyNode class]]) {
                    WDEnemyNode *node = (WDEnemyNode *)self;
                    add = node.randomAttackX;
                }else{
                    WDEnemyNode *node = (WDEnemyNode *)enemyNode;
                    add = node.randomAttackX;
                }
                
                if (dis <= self.size.width / 2.0 + enemyNode.size.width / 2.0 + add) {
                    //击中
                    [enemyNode beAttackAction:weakSelf attackNumber:weakSelf.ATK];
                    [enemyNode addHateNumberWithAttackNode:weakSelf];
                }else{
                    //未击中
                    attactWaitTime = 0.1;
                }
                
                
            }];
            
            
            
            
            [weakSelf.hip runAction:hipSeq completion:^{
                            
            }];
            
            [weakSelf.body runAction:bodySeq completion:^{
                            
            }];
            
            [weakSelf.rightArm runAction:rightArmSeq completion:^{
                            
            }];
            
            [weakSelf.leftArm runAction:armSeq completion:^{
                            
                [weakSelf normalFaceState];
                [weakSelf upBodyActionForStand];
                
                ///控制下攻击速度
                SKAction *waitAction = [SKAction waitForDuration:attactWaitTime];
                [weakSelf runAction:waitAction completion:^{
                    weakSelf.state = weakSelf.state ^ Sprite_attack;
                }];
                
            }];
            
        }];
    }];
    
    //攻击完毕
}

/// 弓箭攻击
- (void)bowAttackAction:(WDBaseNode *)enemyNode{
    
   
    self.state = self.state | Sprite_attack;
   
    [self pauseWalkOrRun];
    
    self.bowMiddle.zPosition = 10000;
    self.rightHand.zPosition = 10001;
    self.rightFinger.zPosition = 10001;
    
    CGFloat rads = [WDCalculateTool angleForStartPoint:enemyNode.position EndPoint:self.position] ;
    if (self.position.x > enemyNode.position.x && self.position.y > enemyNode.position.y) {
        rads = rads - DEGREES_TO_RADIANS(45);
    }else if(self.position.x > enemyNode.position.x && self.position.y < enemyNode.position.y){
        rads = -rads + DEGREES_TO_RADIANS(45);
    }else if(self.position.x < enemyNode.position.x && self.position.y > enemyNode.position.y){
        rads = rads - DEGREES_TO_RADIANS(135);
    }else{
        rads = rads + DEGREES_TO_RADIANS(225);
    }
    
    
    
    CGFloat angle = RADIANS_TO_DEGREES(rads);
    if (angle > 75) {
        rads = DEGREES_TO_RADIANS(75);
    }else if(angle < 30){
        rads = DEGREES_TO_RADIANS(30);
    }

    NSTimeInterval time1 = 0.25;
    NSTimeInterval time2 = 0.2;
    NSTimeInterval time3 = 0.05;
    NSTimeInterval time4 = 0.2;
    if (self.skill1) {
        time1 = 0.1;
        time2 = 0.05;
        time3 = 0.01;
        time4 = 0.03;
    }
    
    ///左手的动作
    CGFloat leftAngle = 60 + RADIANS_TO_DEGREES(rads);
    if (leftAngle < 90) {
        leftAngle = 90;
    }
    
    SKAction *leftArmAction  = [SKAction rotateToAngle:DEGREES_TO_RADIANS(leftAngle) duration:time2];
    SKAction *leftArmAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(15) duration:time2];
    SKAction *leftArmAction3 = [SKAction rotateToAngle:self.leftArm.defaultAngle duration:time3];
    SKAction *leftArmSeq = [SKAction sequence:@[leftArmAction,leftArmAction2,leftArmAction3]];
    
    SKAction *leftElbowAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(60) duration:time2];
    SKAction *leftElbowAction2 = [SKAction rotateToAngle:self.leftElbow.defaultAngle duration:0.2];
    SKAction *leftElbowSeq = [SKAction sequence:@[[SKAction waitForDuration:    time2],leftElbowAction,leftElbowAction2]];
    
    SKAction *bowUpAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(40) duration:time2];
    SKAction *bowUpAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:time3];
    SKAction *bowUpSeq = [SKAction sequence:@[[SKAction waitForDuration:time2],bowUpAction,bowUpAction2]];
    
    SKAction *bowDownAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-180 - 40) duration:time2];
    SKAction *bowDownAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-180) duration:time3];
    SKAction *bowDownSeq = [SKAction sequence:@[[SKAction waitForDuration:time2],bowDownAction,bowDownAction2]];
    
    
    SKAction *rightArmAction = [SKAction rotateToAngle:rads duration:time1];
    
    SKAction *bodyAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(5) duration:time1];
    SKAction *hipAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-5) duration:time1];
    
    SKAction *bodyAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:time1];
    SKAction *hipAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:time1];
    
    [self.body runAction:bodyAction];
    [self.hip runAction:hipAction];
    
    SKAction *rightArmAction2 = [SKAction rotateToAngle:self.rightArm.defaultAngle duration:time1];
    
    __weak typeof(self)weakSelf = self;

    [self.rightArm runAction:rightArmAction completion:^{
        
        [weakSelf.bowUp runAction:bowUpSeq completion:^{
                    
        }];
        
        [weakSelf.bowDown runAction:bowDownSeq completion:^{
            

        }];
        
        [weakSelf.leftElbow runAction:leftElbowSeq completion:^{
                    
        }];
        
        
        weakSelf.mouth.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"Mouth_Fishy"]];
        
        [weakSelf.leftArm runAction:leftArmSeq completion:^{
            
            [weakSelf.body runAction:bodyAction2];
            [weakSelf.hip runAction:hipAction2];
            
            [weakSelf createArrow];
            
            [weakSelf.rightArm runAction:rightArmAction2 completion:^{
                
                [weakSelf normalFaceState];
                [weakSelf runAction:[SKAction waitForDuration:time4] completion:^{
                    weakSelf.state = weakSelf.state ^ Sprite_attack;
                }];
                
            }];
        }];
        
       
    }];
}

/// 弓
- (void)createArrow{
    
    
    SKTexture *arrow = self.arrowTexture;
    __weak typeof(self)weakSelf = self;
  
    CGFloat direction = 1;
    if (self.xScale < 0) {
        direction = -1;
    }
    
    CGFloat poY = 0;
    if (self.position.y < self.targetNode.position.y) {
        poY = 20 * fabs(self.xScale);
    }
    
    NSString *arrowName = @"user_arrow";
    uint32_t a = ARROW_CATEGORY;
    if ([self isKindOfClass:[WDEnemyNode class]]) {
        arrowName = @"enemy_arrow";
        a = ARROW_CATEGORY_ENEMY;
    }
    
    WDBaseNode *arrowN = [WDBaseNode spriteNodeWithTexture:arrow];
     arrowN.position = CGPointMake(weakSelf.position.x + self.size.width / 2.0 * direction, weakSelf.bowMiddle.position.y + self.position.y + poY);
     arrowN.zPosition = 100000;
     arrowN.xScale = 0.4;
     arrowN.yScale = 0.4;
     arrowN.zRotation = [WDCalculateTool angleForStartPoint:arrowN.position EndPoint:weakSelf.targetNode.position];
     SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(arrowN.size.width / 3.0, arrowN.size.height / 3.0) center:CGPointMake(0, 0)];
     body.categoryBitMask = a;
     body.collisionBitMask = 0;
     arrowN.physicsBody = body;
     arrowN.physicsBody.affectedByGravity = NO;
     arrowN.physicsBody.allowsRotation = NO;
     arrowN.name = arrowName;
     arrowN.ATK = weakSelf.ATK;
    
     [weakSelf.parent addChild:arrowN];
     
     CGFloat distance = [WDCalculateTool distanceBetweenPoints:arrowN.position seconde:weakSelf.targetNode.position];
     NSTimeInterval time = distance / 1000;
   
    
     SKAction *aa = [SKAction moveTo:weakSelf.targetNode.position duration:time];
     SKAction *rem = [SKAction removeFromParent];
     SKAction *seee = [SKAction sequence:@[aa,rem]];
     [arrowN runAction:seee completion:^{
     }];
     
     ///火焰
//     SKAction *moveAction = [SKAction moveTo:weakSelf.targetNode.position duration:time];
//     SKAction *alpha = [SKAction scaleTo:0 duration:0.3];
//     SKAction *removeAction = [SKAction removeFromParent];
//     SKAction *seq = [SKAction sequence:@[moveAction,alpha,removeAction]];
//     
//     SKEmitterNode *blueFire = [SKEmitterNode nodeWithFileNamed:@"Fire"];
//     blueFire.zPosition = 20000;
//     blueFire.targetNode = weakSelf.parent;
//     blueFire.position = CGPointMake(arrowN.position.x + 10, arrowN.position.y);
//     blueFire.name = @"blueFire";
//     [blueFire runAction:seq completion:^{
//     }];
//     
//     [weakSelf.parent addChild:blueFire];
    //self.attackNumber = self.trueAttackNumber;
}

/// 死亡
- (void)deadAnimation{
    
    [self removeAllBodyAction];
    
    NSTimeInterval time1 = 0.4;
    
    SKAction *bodyAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(45) duration:time1];
    SKAction *leftFootAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(45) duration:time1];
    SKAction *rightKneeAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(45) duration:time1];
    SKAction *rightFootAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-15) duration:time1];
    SKAction *rightArmAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(45) duration:time1];
    SKAction *leftArmAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(45) duration:time1];
    SKAction *leftElbowAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(30) duration:time1];
    
    
    [self.leftElbow runAction:leftElbowAction];
    [self.leftArm runAction:leftArmAction];
    [self.rightArm runAction:rightArmAction];
    [self.rightFoot runAction:rightFootAction];
    [self.rightKnee runAction:rightKneeAction];
    [self.leftFoot runAction:leftFootAction];
    
     
    NSTimeInterval time2 = 0.15;
    
    __weak typeof(self)weakSelf = self;
    [self.body runAction:bodyAction completion:^{
            
        [weakSelf deadFaceState];
        
        SKAction *bodyAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(90) duration:time2];
        SKAction *rightKneeAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-10) duration:time2];
        SKAction *rightFootAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-25) duration:time2];
        SKAction *leftKneeAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(5) duration:time2];
        SKAction *leftFootAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(5) duration:time2];
        SKAction *leftArmAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:time2];
        SKAction *leftElbowAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:time2];
        SKAction *rightArmAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-35) duration:time2];
        
        [weakSelf.rightArm runAction:rightArmAction];
        [weakSelf.leftElbow runAction:leftElbowAction];
        [weakSelf.leftArm runAction:leftArmAction];
        [weakSelf.leftFoot runAction:leftFootAction];
        [weakSelf.leftKnee runAction:leftKneeAction];
        [weakSelf.rightFoot runAction:rightFootAction];
        [weakSelf.rightKnee runAction:rightKneeAction];
        
        SKAction *alp  = [SKAction fadeAlphaTo:0 duration:0.5];
        SKAction *remo = [SKAction removeFromParent];
        [weakSelf.body runAction:bodyAction completion:^{
            [weakSelf runAction:[SKAction sequence:@[alp,remo]] completion:^{
                [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForDead object:weakSelf];
            }];
           
        }];
    }];
}



#pragma mark - 互动 -
/// 减血血条动画
- (void)reduceBlood:(CGFloat)attackNumber
{
    if (self.state & Sprite_dead) {
        return;
    }
    
    CGFloat lastBlood = self.BLOOD_LAST - attackNumber;
   
    if (lastBlood <= 0) {
        attackNumber = self.BLOOD_LAST;
        self.BLOOD_LAST = 0;
    }else{
        self.BLOOD_LAST = lastBlood;
    }
    
    
    
    ///剩余血的半分比
    CGFloat percent = (float)self.BLOOD_LAST / (float)self.BLOOD_INIT;
    ///攻击量的半分比
    CGFloat attackPercent = (float)attackNumber / (float)self.BLOOD_INIT;
    
    CGFloat width   = fabs(self.bgBlood.size.width * percent);
    CGFloat reduceWidth = fabs(self.bgBlood.size.width * attackPercent);
    UIColor *color = UICOLOR_RGB(124, 42, 42, 1);
    CGFloat bloodHeight = self.blood.size.height;
    
    self.blood.size = CGSizeMake(width, bloodHeight);
    
    WDBaseNode *reduce = [WDBaseNode spriteNodeWithColor:color size:CGSizeMake(reduceWidth, bloodHeight)];
    reduce.zPosition = 1;
    reduce.position = CGPointMake(width,0);
    reduce.anchorPoint = CGPointMake(0, 0);
    [self.blood addChild:reduce];
    
    SKAction *size = [SKAction scaleToSize:CGSizeMake(0, bloodHeight) duration:0.3];
    SKAction *remo = [SKAction removeFromParent];
    SKAction *seq = [SKAction sequence:@[size,remo]];
    [reduce runAction:seq];
    
    if (self.BLOOD_LAST <= 0) {
        [self deadAction];
    }else if (self.BLOOD_LAST >= self.BLOOD_INIT) {
        self.bgBlood.hidden = YES;
    }else{
        self.bgBlood.hidden = NO;
    }
}

/// 加血
- (void)addBlood:(int)cureNumber
{
    if (self.state & Sprite_dead) {
        return;
    }
    
    CGFloat lastBlood = self.BLOOD_LAST + cureNumber;
   
    if (lastBlood >= self.BLOOD_INIT) {
        cureNumber = self.BLOOD_INIT - self.BLOOD_LAST;
        lastBlood = self.BLOOD_INIT;
    }
    
    self.BLOOD_LAST = lastBlood;
    
    ///剩余血的半分比
    CGFloat percent = (float)self.BLOOD_LAST / (float)self.BLOOD_INIT;
    ///攻击量的半分比
    CGFloat attackPercent = (float)cureNumber / (float)self.BLOOD_INIT;
    
    CGFloat width   = fabs(self.bgBlood.size.width * percent);
    CGFloat reduceWidth = fabs(self.bgBlood.size.width * attackPercent);
    UIColor *color = UICOLOR_RGB(124, 42, 42, 1);
    CGFloat bloodHeight = self.blood.size.height;
    
    self.blood.size = CGSizeMake(width, bloodHeight);
    
    WDBaseNode *reduce = [WDBaseNode spriteNodeWithColor:color size:CGSizeMake(reduceWidth, bloodHeight)];
    reduce.zPosition = 1;
    reduce.position = CGPointMake(width,0);
    reduce.anchorPoint = CGPointMake(0, 0);
    [self.blood addChild:reduce];
    
    SKAction *size = [SKAction scaleToSize:CGSizeMake(0, bloodHeight) duration:0.3];
    SKAction *remo = [SKAction removeFromParent];
    SKAction *seq = [SKAction sequence:@[size,remo]];
    [reduce runAction:seq];
    
    if (self.BLOOD_LAST >= self.BLOOD_INIT) {
        self.bgBlood.hidden = YES;
    }else{
        self.bgBlood.hidden = NO;
    }
    
    SKEmitterNode *d = (SKEmitterNode *)[self childNodeWithName:@"cureFire"];
    if (d) {
        [d removeFromParent];
    }
    
    SKEmitterNode *deadFire = [SKEmitterNode nodeWithFileNamed:@"cureFire"];
    deadFire.name = @"cureFire";
    deadFire.position = CGPointMake(0, 0);
    deadFire.zPosition = 100000;
    [self addChild:deadFire];

    SKAction *cureAction = [SKAction waitForDuration:0.9];
    SKAction *re = [SKAction removeFromParent];
    [deadFire runAction:[SKAction sequence:@[cureAction,re]]];
}


/// 出血动画
- (void)bleedAnimation:(CGFloat)attackNumber
{
    
//    if ([self isKindOfClass:[WDEnemyNode class]]) {
//        return;;
//    }
    
    int index = arc4random() % 8;
    
    CGFloat xScale = 1;
    CGFloat xPage  = 0;
    CGFloat yPage  = 20;
   
    //index = 8;
    
    if (index == 0) {
        xScale = self.direction;
        xPage  = self.direction * -40;
        yPage  = 0;
    }else if(index == 1){
        xScale = self.direction;
        xPage  = self.direction * 0;
        yPage  = 60;
    }else if(index == 2){
        xScale = - self.direction;
        xPage  = xScale * 30;
        yPage  = -20;
    }else if(index == 3){
        xScale = - self.direction;
        xPage  = xScale * 10;
        yPage  = -10;
    }else if(index == 4){
        xScale = - self.direction;
        xPage  = xScale * 10;
        yPage  = -10;
    }else if(index == 5){
        xScale = - self.direction;
        xPage  = xScale * 10;
        yPage  = -10;
    }else if(index == 6){
        xScale = - self.direction;
        xPage  = xScale * 15;
        yPage  = -10;
    }else if(index == 7){
        xScale = - self.direction;
        xPage  = xScale * 15;
        yPage  = -10;
    }
    
    
    
    
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:[WDTextureManager shareManager].bloodHitArr[index][0]];
    node.zPosition = 1000;
    node.xScale = xScale;
    node.position = CGPointMake(self.position.x + xPage, self.position.y + yPage);
    [self.parent addChild:node];
    
    SKAction *bloodAction1 = [SKAction animateWithTextures:[WDTextureManager shareManager].bloodHitArr[index] timePerFrame:0.025];
    SKAction *remo = [SKAction removeFromParent];
    [node runAction:[SKAction sequence:@[bloodAction1,remo]] completion:^{
            
    }];
}

/// 行走动画(跑和走在里边判断了)
- (void)moveSameActionWithState:(SpriteState)moveState
                      movePoint:(CGPoint)movePoint{
    
    if (self.state & Sprite_stand) {
        self.state = self.state ^ Sprite_stand;
    }
    
    if (self.state & Sprite_attack) {
        self.state = self.state ^ Sprite_attack;
    }
    
    if (self.state & Sprite_cure) {
        self.state = self.state ^ Sprite_cure;
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

    [self normalFaceState];
    
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
    
    CGFloat distance = [WDCalculateTool distanceBetweenPoints:self.position seconde:movePoint];
    
    CGFloat speed = isWalk ? self.animationWalkSpeed : self.animationRunSpeed;
    
    NSTimeInterval moveTime = fabs(distance) / speed;
    SKAction *moveAction = [SKAction moveTo:movePoint duration:moveTime];
    __weak typeof(self)weakSelf = self;
    __block NSString *name = self.name;
    [self runAction:moveAction completion:^{
        WDBaseScene *base = (WDBaseScene *)weakSelf.parent;
        if ([name isEqualToString:base.selectNode.name]) {
            [base hiddenArrow];
        }
        
        [weakSelf standAction];
        if (weakSelf.moveFinishBlock) {
            weakSelf.moveFinishBlock();
            weakSelf.moveFinishBlock = NULL;
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForMoveEnd object:nil];
    }];

}

@end
