//
//  WDBaseNode+Animation.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/21.
//

#import "WDBaseNode+Animation.h"

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
- (void)upBodyActionForStand
{
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
    [self.leftKnee removeActionForKey:KAnimationFootMove];
    [self.leftFoot removeActionForKey:KAnimationFootMove];
    [self.rightKnee removeActionForKey:KAnimationFootMove];
    [self.rightFoot removeActionForKey:KAnimationFootMove];
    
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
    
    if (self.state & Sprite_attack) {
        return;
    }
    
    
    self.body.zRotation = DEGREES_TO_RADIANS(0);
    self.hip.zRotation  = DEGREES_TO_RADIANS(0);
    [self.body removeActionForKey:kAnimationUpBody];
    [self.hip removeActionForKey:kAnimationUpBody];
    
    self.state = self.state | Sprite_attack;
    
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
                CGFloat dis = [WDCalculateTool distanceBetweenPoints:weakSelf.position seconde:enemyNode.position];
                
                if (dis <= self.size.width / 2.0 + enemyNode.size.width / 2.0) {
                    //击中
                    [enemyNode beAttackAction:weakSelf];
                }
                
                ///击中后看下目标位移否
                CGFloat diss = [WDCalculateTool distanceBetweenPoints:weakSelf.position seconde:enemyNode.position];
                if (diss > self.size.width) {
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

#pragma mark - 表情 -
///正常
- (void)normalFaceState{
    
    self.mouth.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"Mouth_Normal"]];
    self.eyeBrows.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"EyeBrows_Eyebrows"]];
}

///生气
- (void)angleFaceState{
    
    self.mouth.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"Mouth_Angry"]];
    self.eyeBrows.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"EyeBrows_Angry"]];
}

@end
