//
//  WDPriestNode.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/24.
//

#import "WDPriestNode.h"

@implementation WDPriestNode
- (void)createUserNodeWithScale:(CGFloat)scale
{
    
    [super createUserNodeWithScale:scale];
    
    WDBaseModel *model = [[WDDataManager shareManager] searchData:kPriest];
    
    [self setArmorWithModel:model];


    [self setHairTexture:@"ShortPonytail"];
    [self setEyeTexture:@"EyesBlue"];
    [self setMouthTexture:@"Mouth_Bored"];

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
    
    if (self.cureNode) {
        if (self.position.x > self.cureNode.position.x) {
            self.xScale = - fabs(self.xScale);
        }else{
            self.xScale =  fabs(self.xScale);
        }
    }else if(self.targetNode){
        if (self.position.x > self.targetNode.position.x) {
            self.xScale = - fabs(self.xScale);
        }else{
            self.xScale =  fabs(self.xScale);
        }
    }
    
    if (self.cureNode) {
        [self cureAction];
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
        [weakSelf iceFireAction:enemyNode];
    }];
    
    [self.rightArm runAction:rightArmSeq];
    [self.body runAction:bodySeq];
    [self.hip runAction:hipSeq];
    
    [self.leftArm runAction:seqLeftArmAction completion:^{
        weakSelf.state = weakSelf.state ^ Sprite_attack;
    }];
    
}

- (void)iceFireAction:(WDBaseNode *)enemyNode
{
    if (self.state & Sprite_walk || self.state & Sprite_dead || self.state & Sprite_run) {
        return;
    }
        
    CGFloat x = 0;
    if (self.xScale > 0) {
        x = 58;
    }else{
        x = -58;
    }
    
    SKEmitterNode *fireNode = [SKEmitterNode nodeWithFileNamed:@"IceFire"];
    fireNode.position = CGPointMake(self.position.x + x, self.position.y + 18);
    fireNode.zPosition = 10000;
    fireNode.name     = @"fffff";
    [self.parent addChild:fireNode];
    
    WDBaseNode *targetNode = [WDBaseNode new];
    targetNode.zPosition = 100000;
    targetNode.position = CGPointMake(0, 0);
    targetNode.size = CGSizeMake(500, 500);
    targetNode.name = @"target";
    [self.parent addChild:targetNode];
    
    fireNode.targetNode = targetNode;
   
    NSTimeInterval time = fabs([WDCalculateTool distanceBetweenPoints:fireNode.position seconde:self.targetNode.position]) / 500;
    
    NSLog(@"时间:%lf",time);
    
    SKAction *moveAction = [SKAction moveTo:self.targetNode.position duration:time];
    SKAction *seq2 = [SKAction sequence:@[moveAction,[SKAction removeFromParent]]];
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, 10) center:CGPointMake(0, 0)];
    fireNode.physicsBody = body;
    fireNode.physicsBody.affectedByGravity = NO;
    fireNode.physicsBody.allowsRotation = NO;
    fireNode.name = @"iceFire";
    //fireNode.attackNumber = weakSelf.attackNumber;
    body.categoryBitMask = ARROW_CATEGORY;
    body.collisionBitMask = 0;
    
    //__weak typeof(self)weakSelf = self;
    [fireNode runAction:seq2 completion:^{
        [targetNode removeFromParent];
    }];
}

- (void)cureAction{
    
    self.state = self.state | Sprite_cure;
    
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
        [weakSelf.cureNode beCureAction:weakSelf];
        [WDNotificationManager addHateWithNode:weakSelf];
    }];
    [self.rightArm runAction:rightArmSeq];
    [self.body runAction:bodySeq];
    [self.hip runAction:hipSeq];
    
    [self.leftArm runAction:seqLeftArmAction completion:^{
        weakSelf.state = weakSelf.state ^ Sprite_cure;
    }];   
}

@end
