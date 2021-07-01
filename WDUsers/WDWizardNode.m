//
//  WDWizardNode.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/29.
//

#import "WDWizardNode.h"

@implementation WDWizardNode

- (void)createUserNodeWithScale:(CGFloat)scale
{
    
    [super createUserNodeWithScale:scale];
    

    [self setAllArmor:@"FireWizardArmor"];
    [self setHemletTexture:@"WizardHelm"];
    [self setHairTexture:@"Hair5"];
    [self setEyeTexture:@"Eyes5"];
    [self setLeftWeapon:@"HardwoodWand"];
    [self setMouthTexture:@"Mouth_injured"];
    [self standAction];
}

#pragma mark - 复写 -
- (void)upDataAction
{
    [super upDataAction];
    
    if (self.state & Sprite_dead) {
        return;
    }
    
    if (self.state & Sprite_cure || self.state & Sprite_walk || self.state & Sprite_run) {
        return;
    }
    
    if(self.targetNode){
    
        if (self.position.x > self.targetNode.position.x) {
            self.xScale = - fabs(self.xScale);
        }else{
            self.xScale =  fabs(self.xScale);
        }
    }
    
 
    if (self.targetNode.state & Sprite_dead) {
        self.targetNode = nil;
    }
    
    if (self.targetNode) {
        [self attackAction:self.targetNode];
    }
    
}

- (void)attackAction:(WDBaseNode *)enemyNode
{
    if (self.state & Sprite_attack) {
        return;
    }
    
    if (self.state & Sprite_cure) {
        self.state = self.state ^ Sprite_cure;
    }
    
    self.state = self.state | Sprite_attack;
    
    [self removeAllBodyAction];
    
    NSTimeInterval time1 = 0.5;
    
    SKAction *leftArmAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(90) duration:time1];
    SKAction *leftArmAction2 = [SKAction rotateToAngle:self.leftArm.defaultAngle duration:time1];
    SKAction *seqLeftArmAction = [SKAction sequence:@[leftArmAction,[SKAction waitForDuration:0.3],leftArmAction2]];
    
    
    SKAction *leftElbowAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(45) duration:time1];
    SKAction *leftElbowAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(10) duration:0.2];
    SKAction *elbowSeq = [SKAction sequence:@[leftElbowAction,leftElbowAction2]];
    
    SKAction *rightArmAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-30) duration:time1];
    SKAction *rightArmAction2 = [SKAction rotateToAngle:self.rightArm.defaultAngle duration:time1];
    SKAction *rightArmSeq = [SKAction sequence:@[rightArmAction,[SKAction waitForDuration:0.3],rightArmAction2]];
    
    SKAction *bodyAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-10) duration:time1];
    SKAction *bodyAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:time1];
    SKAction *bodySeq = [SKAction sequence:@[bodyAction,[SKAction waitForDuration:0.3],bodyAction2]];
    
    SKAction *hipAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(10) duration:time1];
    SKAction *hipAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:time1];
    SKAction *hipSeq = [SKAction sequence:@[hipAction,[SKAction waitForDuration:0.3],hipAction2]];
    
    __weak typeof(self)weakSelf = self;
    [self.leftElbow runAction:elbowSeq completion:^{
        [weakSelf fireAction:enemyNode];
    }];
    
    [self.rightArm runAction:rightArmSeq];
    [self.body runAction:bodySeq];
    [self.hip runAction:hipSeq];
    
    [self.leftArm runAction:seqLeftArmAction completion:^{
        weakSelf.state = weakSelf.state ^ Sprite_attack;
    }];
    
}

- (void)fireAction:(WDBaseNode *)enemyNode{
    
    if (self.state & Sprite_walk || self.state & Sprite_dead || self.state & Sprite_run) {
        return;
    }
        
    CGFloat x = 0;
    if (self.xScale > 0) {
        x = 58;
    }else{
        x = -58;
    }
    
     WDBaseNode *arrowN = [[WDBaseNode alloc] init];
     arrowN.size = CGSizeMake(10, 10);
     arrowN.position = CGPointMake(self.position.x + x, self.position.y + 18);
     arrowN.zPosition = 100000;
     arrowN.xScale = 1;
     arrowN.yScale = 1;
     arrowN.zRotation = [WDCalculateTool angleForStartPoint:arrowN.position EndPoint:enemyNode.position];
     SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10,10) center:CGPointMake(0, 0)];
     body.categoryBitMask = ARROW_CATEGORY;
     body.collisionBitMask = 0;
     arrowN.physicsBody = body;
     arrowN.physicsBody.affectedByGravity = NO;
     arrowN.physicsBody.allowsRotation = NO;
     arrowN.name = @"wizardFire";
     arrowN.attackNumber = self.attackNumber;
    
     [self.parent addChild:arrowN];
    
    
    CGFloat distance = [WDCalculateTool distanceBetweenPoints:arrowN.position seconde:enemyNode.position];
    NSTimeInterval time = distance / 1000;
   
    
    SKAction *aa = [SKAction moveTo:enemyNode.position duration:time];
    SKAction *rem = [SKAction removeFromParent];
    SKAction *seee = [SKAction sequence:@[aa,rem]];
    [arrowN runAction:seee completion:^{
    }];
    
    ///火焰
     SKAction *moveAction = [SKAction moveTo:enemyNode.position duration:time];
     SKAction *alpha = [SKAction scaleTo:0 duration:0.3];
     SKAction *removeAction = [SKAction removeFromParent];
     SKAction *seq = [SKAction sequence:@[moveAction,alpha,removeAction]];

     SKEmitterNode *blueFire = [SKEmitterNode nodeWithFileNamed:@"Fire"];
     blueFire.zPosition = 20000;
     blueFire.targetNode = self.parent;
     blueFire.position = CGPointMake(arrowN.position.x + 10, arrowN.position.y);
     blueFire.name = @"blueFire";
     [blueFire runAction:seq completion:^{
     }];

     [self.parent addChild:blueFire];
}

@end
