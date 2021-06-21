//
//  WDBaseNode+Animation.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/21.
//

#import "WDBaseNode+Animation.h"

@implementation WDBaseNode (Animation)

/// 上半身运动
- (void)upBodyAction{
    
    [self.rightElbow removeActionForKey:kAnimationUpBody];
    [self.leftElbow removeActionForKey:kAnimationUpBody];
    [self.hip removeActionForKey:kAnimationUpBody];
    [self.body removeActionForKey:kAnimationUpBody];
    
    [self leftArmStandAction];
    [self rightArmStandAction];
}

/// 左腿走
- (void)leftLegWalkAction{
    NSTimeInterval moveTime = self.walkTime;
    CGFloat angle = -15;
    
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
- (void)rightLegWalkAction{
    
    NSTimeInterval moveTime = self.walkTime;
    CGFloat angle = 15;
    
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

/// 右胳膊晃动
- (void)rightArmStandAction{
    SKAction *rightElbowAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-6) duration:0.5];
    SKAction *rightElbowAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-12) duration:0.5];
    SKAction *seqRightElbow = [SKAction sequence:@[rightElbowAction,rightElbowAction2]];
    SKAction *repRightElbow = [SKAction repeatActionForever:seqRightElbow];
    [self.rightElbow runAction:repRightElbow withKey:kAnimationUpBody];
}

/// 左胳膊晃动
- (void)leftArmStandAction{
    
    SKAction *bodyAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-1) duration:0.5];
    SKAction *bodyAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(1) duration:0.5];
    SKAction *seq = [SKAction sequence:@[bodyAction,bodyAction2]];
    SKAction *rep = [SKAction repeatActionForever:seq];
    [self.body runAction:rep withKey:kAnimationUpBody];
    
    
    SKAction *hipAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(1) duration:0.5];
    SKAction *hipAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-1) duration:0.5];
    SKAction *seqHip = [SKAction sequence:@[hipAction,hipAction2]];
    SKAction *repHip = [SKAction repeatActionForever:seqHip];
    [self.hip runAction:repHip withKey:kAnimationUpBody];
    
    SKAction *leftElbowAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(14) duration:0.5];
    SKAction *leftElbowAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(8) duration:0.5];
    SKAction *seqElbow = [SKAction sequence:@[leftElbowAction,leftElbowAction2]];
    SKAction *repElbow = [SKAction repeatActionForever:seqElbow];
    [self.leftElbow runAction:repElbow withKey:kAnimationUpBody];
}



/// 单手武器攻击
- (void)singleAttackAction{
    
    if (self.state & Sprite_attack) {
        return;
    }
    
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
            
            [weakSelf.hip runAction:hipSeq completion:^{
                            
            }];
            
            [weakSelf.body runAction:bodySeq completion:^{
                            
            }];
            
            [weakSelf.rightArm runAction:rightArmSeq completion:^{
                            
            }];
            
            [weakSelf.leftArm runAction:armSeq completion:^{
                            
                [weakSelf normalFaceState];
                weakSelf.state = weakSelf.state ^ Sprite_attack;
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
