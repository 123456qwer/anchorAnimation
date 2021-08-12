//
//  Boss2Node.m
//  MercenaryStory
//
//  Created by Mac on 2021/8/11.
//

#import "Boss2Node.h"
#import "WDBaseNode+Animation.h"
#import "WDBaseScene.h"
@implementation Boss2Node
{
}

- (void)createUserNodeWithScale:(CGFloat)scale
{
    [super createUserNodeWithScale:scale];
    
    [self setAllArmor:@"FireWizardArmor"];
    [self setHemletTexture:@"WizardHelm"];
    [self setHairTexture:@"ZombieShabby"];
    [self setEyeTexture:@"Eye_wizard"];
    [self setLeftWeapon:@"HardwoodWand"];
    [self setMouthTexture:@"Mouth_injured"];
    [self setBeardTexture:@"Beard1"];
    [self setRightShield:@"CardinalBook2"];
    [self standAction];
}

- (void)attackAction:(WDBaseNode *)enemyNode{
    
    if (self.state & Sprite_dead) {
        return;
    }
    
    if (self.state & Sprite_attack) {
        return;
    }
    
    self.state = self.state | Sprite_attack;
    self.targetNode = nil;
    
    NSArray *skillNames = @[@"runForAttackLight",@"throwAttackAction",@"callAttackAnimation"];
    NSInteger index = arc4random() % skillNames.count;
    if (index == 2) {
        WDBaseScene *scene = (WDBaseScene *)self.parent;
        if (scene.monsterArr.count > 2) {
            index = 0;
        }
    }
    
    //index = 3;
    NSString *skillName = skillNames[index];
    SEL action = NSSelectorFromString(skillName);
    if (action) {
        [self performSelector:action];
    }

    
}

- (void)setLeftWeapon:(NSString *)weaponName{
    
    [super setLeftWeapon:weaponName];
    
    SKEmitterNode *fireNode = [SKEmitterNode nodeWithFileNamed:@"Fire2"];
    fireNode.position = CGPointMake(0,100);
    fireNode.zPosition = 10000;
    fireNode.name     = @"fffff";
    [self.leftWeapon addChild:fireNode];
}


#pragma mark - 火球雨 -
/// 扔法杖召唤火雨
- (void)throwAttackAction{
    
    [self removeAllBodyAction];
    [self removeAllActions];
    [self standAction];
    
    self.leftArm.zPosition = 21;
    
    NSTimeInterval time1 = 0.2;
    NSTimeInterval time2 = 0.6;
    
    CGPoint stickPoint = self.leftWeapon.position;
    
    SKAction *leftArmAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(90) duration:time1];
    
    SKAction *weaponAction = [SKAction moveTo:CGPointMake(stickPoint.x + 300, stickPoint.y) duration:time2];
    CGFloat degrees = DEGREES_TO_RADIANS(360) + self.leftWeapon.defaultAngle + self.leftHand.defaultAngle + DEGREES_TO_RADIANS(50);
    SKAction *weaponAction2 = [SKAction rotateToAngle:degrees  duration:time2];
    SKAction *weaponGro = [SKAction group:@[weaponAction,weaponAction2]];
    SKAction *weaponWait = [SKAction waitForDuration:time1];
   
    SKAction *weaponActionR1 = [SKAction rotateToAngle:degrees + DEGREES_TO_RADIANS(3) duration:0.1];
    SKAction *weaponActionR2 = [SKAction rotateToAngle:degrees - DEGREES_TO_RADIANS(3) duration:0.1];
    SKAction *weSeq = [SKAction sequence:@[weaponActionR1,weaponActionR2]];
    SKAction *weaponRep = [SKAction repeatAction:weSeq count:12];
    SKAction *weaponSeq = [SKAction sequence:@[weaponWait,weaponGro]];

    [self.leftArm runAction:leftArmAction];
    
    __weak typeof(self)weakSelf = self;
    [self.leftWeapon runAction:weaponSeq completion:^{
        
        
        SKEmitterNode *fireNode = (SKEmitterNode *)[weakSelf.leftWeapon childNodeWithName:@"fffff"];
        
        NSTimeInterval time = 0.2;
        for (int i = 0; i < 12; i ++) {
            [weakSelf performSelector:@selector(fireAttackAction) withObject:nil afterDelay:time];
            time += 0.2;
        }
        
       
        SKAction *sca = [SKAction scaleTo:9 duration:0.5];
        SKAction *sca2 = [SKAction scaleTo:1 duration:0.5];

        [fireNode runAction:sca];
        
        [weakSelf.leftWeapon runAction:weaponRep completion:^{
            [fireNode runAction:sca2 completion:^{
                
                SKAction *weaponRo = [SKAction rotateToAngle:weakSelf.leftWeapon.defaultAngle duration:time2];
                SKAction *weaponMo = [SKAction moveTo:stickPoint duration:time2];
                SKAction *gr = [SKAction group:@[weaponRo,weaponMo]];
                [weakSelf.leftWeapon runAction:gr completion:^{
                    [weakSelf.leftArm runAction:[SKAction rotateToAngle:weakSelf.leftArm.defaultAngle duration:time1] completion:^{
                        [weakSelf standAction];
                        weakSelf.leftArm.zPosition = 20;
                        weakSelf.state = weakSelf.state ^ Sprite_attack;
                    }];
                }];
            }];
        }];
    }];
    
    
    
   
}
- (void)fireAttackAction{
    
    SKEmitterNode *fireNode2 = [SKEmitterNode nodeWithFileNamed:@"BlueFire2"];
    fireNode2.position = CGPointMake(self.position.x + self.leftWeapon.position.y + 30, self.position.y + self.leftWeapon.position.x - 95);
    fireNode2.zPosition = 100;
    fireNode2.name     = @"BlueFire";
    [self.parent addChild:fireNode2];
    //fireNode2.targetNode = self.parent;
    
    WDWeaponNode *w = [WDWeaponNode spriteNodeWithColor:[[UIColor blackColor]colorWithAlphaComponent:0] size:CGSizeMake(5, 5)];
    w.ATK = self.ATK;
    w.name = @"BlueFire";
    [fireNode2 addChild:w];
    
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(w.size.width, w.size.height) center:CGPointMake(0, 0)];
    body.allowsRotation = NO;
    body.affectedByGravity = NO;
    body.categoryBitMask = MONSTER_CATEGORY;
    body.contactTestBitMask = MONSTER_CONTACT;
    body.collisionBitMask = 0;
    w.physicsBody = body;
    
    WDBaseNode *random = [WDCalculateTool searchUserRandomNode:self];
    
    CGFloat distance = [WDCalculateTool distanceBetweenPoints:fireNode2.position seconde:random.position];
    NSTimeInterval time = distance / 600;

    SKAction *move = [SKAction moveTo:random.position duration:time];
    SKAction *sca = [SKAction scaleTo:0 duration:0.5];
    SKAction *remo = [SKAction removeFromParent];
    SKAction *seq = [SKAction sequence:@[move,sca,remo]];
    [fireNode2 runAction:seq completion:^{
    }];
}

#pragma mark - 光波 -
- (void)runForAttackLight{
    
   
    BOOL isLeft = YES;
  
    CGFloat y = 0;
//    if (arc4random() % 2 == 0) {
//        y = arc4random() % (int)self.size.height;
//    }else{
//        y = - arc4random() % (int)self.size.height;
//    }
    
    WDBaseNode *node = [WDCalculateTool searchUserRandomNode:self];
    y = node.position.y;
    
    CGPoint point1 = CGPointMake(0 - kScreenWidth + self.size.width * 2.0, y);
    CGPoint point2 = CGPointMake(kScreenWidth - self.size.width * 2.0, y);
    
   
    CGPoint point = CGPointMake(0, 0);
   
    if (arc4random() % 2 == 0) {
        point = point1;
        isLeft = YES;
    }else{
        point = point2;
        isLeft = NO;
    }
    
    CGFloat dis = [WDCalculateTool distanceBetweenPoints:point seconde:self.position];
    
    if (dis < 10) {
        
        [self pushLightAttackAction];
        
    }else{
        
        self.legWalkAngle = 60;
        __weak typeof(self)weakSelf = self;
        [self runrunrun:Sprite_run movePoint:point block:^{
            if (isLeft) {
                weakSelf.xScale = fabs(weakSelf.xScale);
            }else{
                weakSelf.xScale = -fabs(weakSelf.xScale);
            }
            [weakSelf removeAllBodyAction];
            [weakSelf pushLightAttackAction];
            weakSelf.legWalkAngle = 30;
        }];
       
    }
    
    
}
- (void)pushLightAttackAction{
    
    self.state = self.state | Sprite_attack;

    self.bgBlood.alpha = 1;

    [self pauseWalkOrRun];
    
    NSTimeInterval time2 = 0.5;
    SKAction *leftArmAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(90) duration:time2];
    
    SKAction *leftHandAction = [SKAction rotateToAngle:self.defaultAngle + DEGREES_TO_RADIANS(-70) duration:time2];
    
    SKAction *leftHandAction2 = [SKAction rotateToAngle:self.defaultAngle + DEGREES_TO_RADIANS(-65) duration:0.01];
    SKAction *leftHandAction3 = [SKAction rotateToAngle:self.defaultAngle + DEGREES_TO_RADIANS(-70) duration:0.01];
    
    SKAction *leftHandSeq = [SKAction sequence:@[leftHandAction2,leftHandAction3]];
    SKAction *leftHandRep = [SKAction repeatAction:leftHandSeq count:100];
   
    self.leftArm.zPosition = 21;
    
   
    /// 又胳膊
    SKAction *rightArmAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(30) duration:time2];
    SKAction *rightArmAction2 = [SKAction rotateToAngle:self.rightArm.defaultAngle duration:time2];
    SKAction *rightArmSeq = [SKAction sequence:@[rightArmAction]];
    
    /// 法术书
    SKAction *shieldAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-30) duration:time2];
    SKAction *shieldAction2 = [SKAction rotateToAngle:self.shield.defaultAngle duration:time2];
    SKAction *shieldSeq = [SKAction sequence:@[shieldAction]];
    
    __weak typeof(self)weakSelf = self;
    [self.shield runAction:shieldSeq];

    [self.rightArm runAction:rightArmSeq completion:^{
        weakSelf.leftArm.zPosition = 20;
    }];
    
    
    SKAction *bodyAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(30) duration:0.2];
    SKAction *bodyAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:time2];
    SKAction *bodySeq = [SKAction sequence:@[bodyAction]];
    
    SKAction *hipAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-30) duration:0.2];
    SKAction *hipAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:time2];
    SKAction *hipSeq = [SKAction sequence:@[hipAction]];
    
    SKAction *leftArmAction3 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(180) duration:0.2];
    SKAction *rightArmAction3 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(60) duration:0.2];
    SKAction *shieldAction3 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-60) duration:0.2];
    
    [self.leftHand runAction:leftHandAction completion:^{
        
        SKNode *no = [weakSelf.parent childNodeWithName:@"bbb"];
        [no removeFromParent];

        SKEmitterNode *fireNode2 = [SKEmitterNode nodeWithFileNamed:@"BlueFire"];
        fireNode2.position = CGPointMake(weakSelf.position.x + self.direction * 55.f,weakSelf.position.y - 10);
        fireNode2.zPosition = 10000;
        fireNode2.name     = @"BigBlueFire";
        fireNode2.xScale = 3;
        fireNode2.yScale = 3;
        [weakSelf.parent addChild:fireNode2];
        
        
      
        
        
        SKAction *fa = [SKAction scaleTo:0.1 duration:100 * (0.02)];
        [fireNode2 runAction:fa completion:^{
            ///基本秒杀
            WDWeaponNode *w = [WDWeaponNode spriteNodeWithColor:[[UIColor blackColor]colorWithAlphaComponent:0] size:CGSizeMake(5, 5)];
            w.ATK = 10000000;
            w.name = @"BigBlueFire";
            [fireNode2 addChild:w];
            SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(w.size.width, w.size.height) center:CGPointMake(0, 0)];
            body.allowsRotation = NO;
            body.affectedByGravity = NO;
            body.categoryBitMask = MONSTER_CATEGORY;
            body.contactTestBitMask = MONSTER_CONTACT;
            body.collisionBitMask = 0;
            w.physicsBody = body;
        }];
        

        [weakSelf.leftHand runAction:leftHandRep completion:^{
            
            fireNode2.particleBirthRate = 10000;
            CGFloat x = 0;
            if (self.position.x < 0) {
                x = kScreenWidth + 1000;
            }else{
                x = - kScreenWidth - 1000;
            }
            
            fireNode2.targetNode = weakSelf.parent;
            CGFloat dis = [WDCalculateTool distanceBetweenPoints:CGPointMake(x, 0) seconde:weakSelf.position];
            NSTimeInterval t = dis / 3500;
            SKAction *move = [SKAction moveToX:x duration:t];
            SKAction *s = [SKAction sequence:@[move,[SKAction waitForDuration:2],REMOVE_ACTION]];
            [fireNode2 runAction:s completion:^{
                            
            }];
            
            [weakSelf.body runAction:bodySeq];
            [weakSelf.hip runAction: hipSeq];
            
            [weakSelf.leftArm runAction:leftArmAction3];
            [weakSelf.rightArm runAction:rightArmAction3];
            
            [weakSelf.shield runAction:shieldAction3 completion:^{
                [weakSelf.shield runAction:shieldAction2];
                [weakSelf.rightArm runAction:rightArmAction2];
                [weakSelf.leftArm runAction:[SKAction rotateToAngle:weakSelf.leftArm.defaultAngle duration:time2]];
                [weakSelf.leftHand runAction:[SKAction rotateToAngle:weakSelf.leftHand.defaultAngle duration:time2]];
                [weakSelf.body runAction:bodyAction2];
                [weakSelf.hip runAction:hipAction2 completion:^{
                    weakSelf.targetNode = [WDCalculateTool searchUserRandomNode:weakSelf];
                    weakSelf.state = weakSelf.state ^ Sprite_attack;
                    [weakSelf standAction];
                }];
                
            }];

        }];
    }];
    
    [self.leftArm runAction:leftArmAction];
}



#pragma mark - 召唤小怪 -
/// 召唤小怪
- (void)callAttackAnimation{
    
    self.state = self.state | Sprite_attack;
    self.leftArm.zPosition = 21;

    
    [self pauseWalkOrRun];
    
    NSTimeInterval time1 = 0.5;
    
    SKAction *leftArmAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(90) duration:time1];
    SKAction *leftArmAction2 = [SKAction rotateToAngle:self.leftArm.defaultAngle duration:time1];
    SKAction *seqLeftArmAction = [SKAction sequence:@[leftArmAction,[SKAction waitForDuration:0.3],leftArmAction2]];
    
    
    SKAction *leftElbowAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(45) duration:time1];
    SKAction *leftElbowAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(10) duration:0.2];
    SKAction *elbowSeq = [SKAction sequence:@[leftElbowAction,leftElbowAction2]];
    
    SKAction *bodyAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-10) duration:time1];
    SKAction *bodyAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:time1];
    SKAction *bodySeq = [SKAction sequence:@[bodyAction,[SKAction waitForDuration:0.3],bodyAction2]];
    
    SKAction *hipAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(10) duration:time1];
    SKAction *hipAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:time1];
    SKAction *hipSeq = [SKAction sequence:@[hipAction,[SKAction waitForDuration:0.3],hipAction2]];
    
    /// 又胳膊
    SKAction *rightHandAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(30) duration:time1];
    SKAction *rightHandAction2 = [SKAction rotateToAngle:self.rightArm.defaultAngle duration:time1];
    SKAction *rightArmSeq = [SKAction sequence:@[rightHandAction,[SKAction waitForDuration:0.3],rightHandAction2]];
    
    /// 法术书
    SKAction *shieldAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-30) duration:time1];
    SKAction *shieldAction2 = [SKAction rotateToAngle:self.shield.defaultAngle duration:time1];
    SKAction *shieldSeq = [SKAction sequence:@[shieldAction,[SKAction waitForDuration:0.3],shieldAction2]];
    
    __weak typeof(self)weakSelf = self;
    [self.leftElbow runAction:elbowSeq completion:^{
        //[weakSelf iceFireAction:enemyNode];
        
    }];
    
    [self.rightArm runAction:rightArmSeq];
    [self.body runAction:bodySeq];
    [self.hip runAction:hipSeq];
    [self.shield runAction:shieldSeq];
    
    [self.leftArm runAction:seqLeftArmAction completion:^{
        weakSelf.targetNode = [WDCalculateTool searchUserRandomNode:weakSelf];
        weakSelf.state = weakSelf.state ^ Sprite_attack;
        weakSelf.leftArm.zPosition = 20;
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForBossCallMonster object:nil];
    }];
}


/// 这里需要CADisplay的移动速度方法
- (void)runrunrun:(SpriteState)moveState
        movePoint:(CGPoint)movePoint
            block:(void (^)(void))complete{
    
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
        complete();
    }];
}


- (void)upDataAction{
    
    if (self.state & Sprite_dead) {
        return;
    }
    
    if (self.state & Sprite_attack) {
        return;
    }
    
    [super upDataAction];
 
  
}

@end
