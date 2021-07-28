//
//  Boss1Node.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/27.
//

#import "Boss1Node.h"
#import "Boss1Model.h"
#import "WDBaseNode+Animation.h"
#import "WDBaseNode+Emoji.h"
#import "WDBaseScene.h"

@implementation Boss1Node
{
    Boss1Model *_boss1Model;
    SKEmitterNode *_emitterNode;
}

- (void)createUserNodeWithScale:(CGFloat)scale
{
    [super createUserNodeWithScale:scale];
    
    _boss1Model = [WDTextureManager shareManager].boss1Model;

    [self setAllArmor:@"FireAdept"];

    [self standAction];
    
    [self setHairTexture:@"Dandy"];
    [self setEyeTexture:@"Eye6"];
    [self setMouthTexture:@"NO"];
    [self setEyeBrowsTexture:@"EyeBrows_Eyebrows"];
    [self setBeardTexture:@"VikingBeard"];
    [self setGlassTexture:@"SteampunkGlasses"];
    [self setRightShield:@"CardinalBook"];
    [self setLeftWeapon:@"ElderStaff"];
    
    //self.leftWeapon.zRotation = 0;
    
    SKEmitterNode *blueFire = [SKEmitterNode nodeWithFileNamed:@"BlueFire"];
    blueFire.zPosition = 1;
    blueFire.targetNode = self.parent;
    blueFire.position = CGPointMake(-10 * allScale, 235 * allScale);
    blueFire.name = @"blueFire";
    [self.leftWeapon addChild:blueFire];
    
    
}

#pragma mark - 复写 -
- (void)upDataAction{
    
    [super upDataAction];
 
    if (!self.targetNode || self.targetNode.state & Sprite_dead) {
        self.targetNode = [WDCalculateTool searchUserRandomNode:self];
    }
}

- (void)attackAction:(WDBaseNode *)enemyNode{
  
    if (self.state & Sprite_attack) {
        return;
    }
    
    NSArray *skillNames = @[@"meteoriteAttackAnimation",@"pullAttackAnimation",@"flashAttackAnimation",@"moveToBigWindAttackPosition",@"callAttackAnimation"];
    NSInteger index = arc4random() % skillNames.count;
    if (index == 4) {
        WDBaseScene *scene = (WDBaseScene *)self.parent;
        if (scene.monsterArr.count > 5) {
            index = 3;
        }
    }
    //index = 3;
    NSString *skillName = skillNames[index];
    SEL action = NSSelectorFromString(skillName);
    if (action) {
        [self performSelector:action];
    }
}

#pragma mark - 陨石攻击 -
/** 陨石攻击动画 9 */
- (void)meteoriteAttackAnimation{
    
    self.state = self.state | Sprite_attack;
    
    [self pauseWalkOrRun];
    
    [self performSelector:@selector(meteoriteAttackWithCount:) withObject:nil afterDelay:0.2];
    [self performSelector:@selector(meteoriteAttackWithCount:) withObject:nil afterDelay:0.4];
    self.leftArm.zPosition = 21;
    NSTimeInterval time1 = 0.4;
    NSTimeInterval waitTime = 0.8;
    /// 又胳膊
    SKAction *rightHandAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(30) duration:time1];
    SKAction *rightHandAction2 = [SKAction rotateToAngle:self.rightArm.defaultAngle duration:time1];
    SKAction *rightArmSeq = [SKAction sequence:@[rightHandAction,[SKAction waitForDuration:waitTime],rightHandAction2]];
    
    /// 法术书
    SKAction *shieldAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-30) duration:time1];
    SKAction *shieldAction2 = [SKAction rotateToAngle:self.shield.defaultAngle duration:time1];
    SKAction *shieldSeq = [SKAction sequence:@[shieldAction,[SKAction waitForDuration:waitTime],shieldAction2]];
    
    
    /// 左胳膊
    SKAction *leftArmAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(90) duration:time1];
    SKAction *leftArmAction2 = [SKAction rotateToAngle:self.leftArm.defaultAngle duration:time1];
    SKAction *leftArmSeq = [SKAction sequence:@[leftArmAction,[SKAction waitForDuration:waitTime],leftArmAction2]];
    
    /// 左手
    SKAction *leftHandAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-40) duration:0.2];
    SKAction *leftHandAction2 = [SKAction rotateToAngle:self.leftHand.defaultAngle duration:0.2];
    SKAction *leftHandActionS = [SKAction sequence:@[leftHandAction,leftHandAction2]];
    SKAction *leftHandRep = [SKAction repeatAction:leftHandActionS count:2];
    SKAction *leftHandSeq = [SKAction sequence:@[[SKAction waitForDuration:time1],leftHandRep]];
    
    SKAction *bodyAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(-10) duration:time1];
    SKAction *bodyAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:time1];
    SKAction *bodySeq = [SKAction sequence:@[bodyAction,[SKAction waitForDuration:0.8],bodyAction2]];
    
    SKAction *hipAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(10) duration:time1];
    SKAction *hipAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(0) duration:time1];
    SKAction *hipSeq = [SKAction sequence:@[hipAction,[SKAction waitForDuration:0.8],hipAction2]];
    
    __weak typeof(self)weakSelf = self;
    [self.leftHand runAction:leftHandSeq];
    
    [self.leftArm runAction:leftArmSeq];
    
    
    [self.body runAction:bodySeq];
    [self.hip   runAction:hipSeq];
    
    [self.shield runAction:shieldSeq];

    [self.rightArm runAction:rightArmSeq completion:^{
        weakSelf.targetNode = [WDCalculateTool searchUserRandomNode:weakSelf];
        weakSelf.state = weakSelf.state ^ Sprite_attack;
        weakSelf.leftArm.zPosition = 20;
    }];
    
    
}
/** 陨石攻击 */
- (void)meteoriteAttackWithCount:(NSInteger)count
{
    WDBaseNode *randomNode = [WDCalculateTool searchUserRandomNode:self];
    WDBaseNode *meteoriteShadow = [WDBaseNode spriteNodeWithTexture:_boss1Model.shadowTexture];
    meteoriteShadow.zPosition = randomNode.zPosition + 100;
    meteoriteShadow.position = CGPointMake(randomNode.position.x + 5, randomNode.position.y - 80);
    [self.targetNode.parent addChild:meteoriteShadow];
    meteoriteShadow.name = @"meteoriteShadow";
    meteoriteShadow.alpha = 0.1;
    
    NSTimeInterval time = 1.5;
    
    SKAction *mShadowAlphaAction = [SKAction fadeAlphaBy:0.8 duration:time];
    SKAction *removeAction = [SKAction removeFromParent];
    
    SKAction *xyScale = [SKAction scaleXTo:2.0 y:2.0 duration:time];
    SKAction *seq = [SKAction sequence:@[mShadowAlphaAction,removeAction]];
    SKAction *gro = [SKAction group:@[xyScale,seq]];
    
    [meteoriteShadow runAction:gro];
    
    WDBaseNode *targetNode = [WDBaseNode new];
    targetNode.zPosition = 100000;
    targetNode.position = meteoriteShadow.position;
    targetNode.size = CGSizeMake(500, 500);
    targetNode.name = @"target";
    [self.parent addChild:targetNode];
    
    SKEmitterNode *fireNode = [SKEmitterNode nodeWithFileNamed:@"Fire2"];
    fireNode.position = CGPointMake(self.targetNode.position.x + 600, self.targetNode.position.y + 600);
    fireNode.zPosition = 100000;
    fireNode.name     = @"fffff";
    fireNode.particleLifetimeRange = 0.5;
    [self.parent addChild:fireNode];
    
    fireNode.targetNode = targetNode;
    
    SKAction *moveAction = [SKAction moveTo:meteoriteShadow.position duration:time];
    SKAction *scaleAction = [SKAction scaleTo:15.0 duration:time];
    SKAction *gro2 = [SKAction group:@[moveAction,scaleAction]];
    SKAction *seq2 = [SKAction sequence:@[gro2,[SKAction removeFromParent]]];
    seq.timingMode = SKActionTimingEaseOut;
    
    __block Boss1Model *model = _boss1Model;
    __block WDBaseNode *parentNode = (WDBaseNode *)self.parent;
    __weak typeof(self)weakSelf = self;
    [fireNode runAction:seq2 completion:^{
        [targetNode removeFromParent];
        
        WDWeaponNode *boomNode = [WDWeaponNode spriteNodeWithTexture:model.meteoriteArr2[1]];
        boomNode.position = CGPointMake(fireNode.position.x + 40, fireNode.position.y + 120);
        boomNode.zPosition = 20000;
        boomNode.xScale = 2.0;
        boomNode.yScale = 2.0;
        boomNode.name = @"meteorite1";
        boomNode.ATK = weakSelf.targetNode.BLOOD_INIT / 4;
      //  boomNode.floatAttackNumber = 10;
        boomNode.alpha = 0.6;
        [parentNode addChild:boomNode];
        
        SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(100, 100) center:CGPointMake(-50, -50)];
        body.allowsRotation = NO;
        body.affectedByGravity = NO;
        body.categoryBitMask = MONSTER_CATEGORY;
        body.contactTestBitMask = MONSTER_CONTACT;
        body.collisionBitMask = 0;
        boomNode.physicsBody = body;
        
        SKAction *fireAction2 = [SKAction animateWithTextures:[model.meteoriteArr2 subarrayWithRange:NSMakeRange(1, model.meteoriteArr2.count - 1)] timePerFrame:0.1];
        SKAction *removeAction = [SKAction removeFromParent];
        [boomNode runAction:[SKAction sequence:@[model.musicFireAction,fireAction2,removeAction]]];
    }];
}


#pragma mark - 拖拽攻击
/// 拖拽施法
- (void)pullAttackAnimation{
    
    if (self.targetNode.state & Sprite_dead) {
        return;
    }
    
    [self pauseWalkOrRun];

    self.leftArm.zPosition = 21;
    [self.targetNode removeAllActions];

    self.targetNode.state = self.targetNode.state | Sprite_movie;
    
    self.state = Sprite_attack;
    
    NSTimeInterval time = 0.3;
    
    SKAction *leftArmAction = [SKAction rotateToAngle:DEGREES_TO_RADIANS(180) duration:time];
    SKAction *leftArmAction2 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(180) - DEGREES_TO_RADIANS(45) duration:time];
    SKAction *leftArmAction3 = [SKAction rotateToAngle:DEGREES_TO_RADIANS(180) duration:time];
    SKAction *leftArmSeq1 = [SKAction sequence:@[leftArmAction2,leftArmAction3]];
    SKAction *leftArmRep = [SKAction repeatAction:leftArmSeq1 count:3];

  
    
    SKAction *leftHandAction = [SKAction rotateToAngle:self.leftHand.defaultAngle - DEGREES_TO_RADIANS(45) duration:0.3];
    SKAction *leftHandAction1 = [SKAction rotateToAngle:self.leftHand.defaultAngle duration:0.3];
    SKAction *leftHandSeq1 = [SKAction sequence:@[leftHandAction,leftHandAction1]];
    SKAction *leftHandRep = [SKAction repeatAction:leftHandSeq1 count:3];
    
    [self createPullWind];
    
    __weak typeof(self)weakSelf = self;
    [self.leftArm runAction:leftArmAction completion:^{
        
        [weakSelf.leftArm runAction:leftArmRep completion:^{
            
            [weakSelf singleAttackAction:weakSelf.targetNode];
            
        }];
        
        [weakSelf.leftHand runAction:leftHandRep];
    }];

}

/// 拉拽攻击出现在人物身上的风
- (void)createPullWind{
    
    [self performSelector:@selector(bePullAction:) withObject:self.targetNode afterDelay:0.7 + 0.9];
    
    WDBaseNode *windNode = [WDBaseNode spriteNodeWithTexture:_boss1Model.windArr[0]];
    windNode.alpha = 0;
    windNode.xScale = 2.0;
    windNode.yScale = 2.0;
    windNode.zPosition = 10000;
    windNode.name = @"windwindwind";
    windNode.position = CGPointMake(0, 20);
    [self.targetNode addChild:windNode];
    
    SKAction *windAction = [SKAction animateWithTextures:_boss1Model.windArr timePerFrame:0.1];
    SKAction *rep = [SKAction repeatActionForever:windAction];
    SKAction *alphaAction = [SKAction fadeAlphaTo:0.7 duration:0.5];
    SKAction *seq2 = [SKAction sequence:@[alphaAction]];
   
    SKAction *gro = [SKAction group:@[seq2,rep]];
    SKAction *remove = [SKAction removeFromParent];
    SKAction *seqA = [SKAction sequence:@[gro,remove]];
    [windNode runAction:seqA];
}

/// 拖拽过来致命一锤
- (void)singleAttackAction:(WDBaseNode *)enemyNode{
    
    WDBaseNode *node = (WDBaseNode *)[enemyNode childNodeWithName:@"windwindwind"];
    //[node removeAllActions];
    SKAction *alphaA = [SKAction fadeAlphaTo:0 duration:0.3];
    SKAction *remo = [SKAction removeFromParent];
    [node runAction:[SKAction sequence:@[alphaA,remo]]];
    
    self.state = self.state | Sprite_attack;
   
    [self.bowUp removeAllActions];
    [self.bowDown removeAllActions];
    [self.hip removeAllActions];
    [self.body removeAllActions];
    [self.leftArm removeAllActions];
    [self.leftElbow removeAllActions];
    [self.leftKnee removeAllActions];
    [self.leftFoot removeAllActions];
    [self.rightArm removeAllActions];
    [self.rightElbow removeAllActions];
    [self.rightKnee removeAllActions];
    [self.rightFoot removeAllActions];

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
                    [enemyNode beAttackAction:weakSelf attackNumber:enemyNode.BLOOD_INIT / 2];
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
                    weakSelf.targetNode = [WDCalculateTool searchUserRandomNode:weakSelf];
                    weakSelf.state = weakSelf.state ^ Sprite_attack;
                    weakSelf.leftArm.zPosition = 20;
                }];
                
            }];
            
        }];
    }];
    
}
/// 龙卷风拖拽
- (void)bePullAction:(WDBaseNode *)targetMonster{

    SKAction *move = [SKAction moveTo:CGPointMake(self.position.x + self.direction * (self.size.width / 2.0 + self.targetNode.size.width / 2.0 ), self.position.y) duration:0.4];
    //__weak typeof(self)weakSelf = self;
    [self.targetNode runAction:move completion:^{
        if (targetMonster.state & Sprite_dead) {
            return;
        }
        targetMonster.state = targetMonster.state ^ Sprite_movie;
    }];
}


#pragma mark - 闪电攻击 -
/// 闪电攻击
- (void)flashAttackAnimation{

    self.state = self.state | Sprite_attack;
    self.leftArm.zPosition = 21;
//
    [self performSelector:@selector(createCloudNode) withObject:nil afterDelay:0.55];
//    [self performSelector:@selector(createCloudNode) withObject:nil afterDelay:0.6];
    
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
    }];

}
/// 创建云
- (void)createCloudNode{
    
    WDBaseNode *cloudNode = [WDBaseNode spriteNodeWithTexture:_boss1Model.cloudTexture];
    WDBaseNode *randomNode = [WDCalculateTool searchUserRandomNode:self];
    
   
    
    cloudNode.xScale = 0.1;
    cloudNode.yScale = 0.1;
    cloudNode.alpha = 0;
    cloudNode.position = CGPointMake(self.position.x, self.position.y);
    cloudNode.zPosition = 10000;
    cloudNode.name = @"cloud";
    [self.parent addChild:cloudNode];
    
    CGPoint movePoint = CGPointMake(randomNode.position.x, randomNode.position.y + randomNode.size.height + cloudNode.size.height);
    
    SKAction *move = [SKAction moveTo:movePoint duration:0.5];
    SKAction *scaleAction = [SKAction scaleTo:0.7 duration:0.5];
    SKAction *alphaA = [SKAction fadeAlphaTo:1 duration:0.5];
    
    SKAction *blinkA = [SKAction fadeAlphaTo:0.9 duration:0.15];
    SKAction *blinkB = [SKAction fadeAlphaTo:1.0 duration:0.15];
    
    SKAction *bSeq = [SKAction sequence:@[blinkA,blinkB]];
    SKAction *gro = [SKAction group:@[move,scaleAction,alphaA]];
    
    SKAction *rep = [SKAction repeatAction:bSeq count:3];
    SKAction *alphaB = [SKAction fadeAlphaTo:0 duration:0.5];
    SKAction *remo = [SKAction removeFromParent];
    SKAction *seq2 = [SKAction sequence:@[rep,alphaB,remo]];
    
    __weak typeof(self)weakSelf = self;
    [cloudNode runAction:gro completion:^{
        
        [cloudNode runAction:seq2];
        [weakSelf flash:cloudNode.position];
    }];
    
}
/// 创建闪电攻击
- (void)flash:(CGPoint)point{
    WDWeaponNode *flashNode = [WDWeaponNode spriteNodeWithTexture:_boss1Model.flashArr[0]];
    flashNode.position = CGPointMake(point.x, point.y - flashNode.size.height);
    flashNode.zPosition = 9999;
    flashNode.xScale = 1.5;
    flashNode.yScale = 1.5;
    flashNode.alpha  = 0.8;
    flashNode.ATK = self.targetNode.BLOOD_INIT / 5;
    //flashNode.floatAttackNumber = 20;
    flashNode.name = @"flash";
    CGRect rect = CGRectMake(0, 0, flashNode.size.width / 2.0, flashNode.size.height);
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rect.size.width, rect.size.height) center:CGPointMake(rect.origin.x, rect.origin.y)];
    body.allowsRotation = NO;
    body.affectedByGravity = NO;
    body.categoryBitMask = MONSTER_CATEGORY;
    body.contactTestBitMask = MONSTER_CONTACT;
    body.collisionBitMask = 0;
    flashNode.physicsBody = body;
    
    [self.parent addChild:flashNode];
    //3张图 0.1 * 3 * 3
    SKAction *flashAction = [SKAction animateWithTextures:_boss1Model.flashArr timePerFrame:0.1];
    SKAction *repAction = [SKAction repeatAction:flashAction count:3];
    SKAction *seq2 = [SKAction sequence:@[_boss1Model.musicFlashAction,repAction,REMOVE_ACTION]];
    
    [flashNode runAction:seq2 completion:^{
        
    }];
}



#pragma mark - 飓风攻击 -
/// 飓风攻击前先移动到攻击位置
- (void)moveToBigWindAttackPosition{
   
    
    self.targetNode = [WDCalculateTool searchUserBigDistanceNode:self];
    
    self.state = self.state | Sprite_movie;
    self.state = self.state | Sprite_attack;
    
    SKEmitterNode *blueFire = [SKEmitterNode nodeWithFileNamed:@"BlueFire"];
    blueFire.zPosition = 100000;
    blueFire.targetNode = self.parent;
    blueFire.position = self.position;
    blueFire.name = @"bbb";
    NSTimeInterval time = 0.6;
    
    self.bgBlood.alpha = 0;
    
    SKAction *fadeAlpha = [SKAction fadeAlphaTo:0 duration:time];
    SKAction *scale = [SKAction scaleTo:0 duration:time];
    SKAction *rot = [SKAction rotateToAngle:DEGREES_TO_RADIANS(720) duration:time];
    SKAction *gr = [SKAction group:@[fadeAlpha,scale,rot]];
    
    CGPoint movePoint = [WDCalculateTool calculateNodeMovePosition:self enemy:self.targetNode];
    
    CGFloat distance = [WDCalculateTool distanceBetweenPoints:movePoint seconde:self.position];
    NSTimeInterval time2 = distance / 1000;
    
    SKAction *move = [SKAction moveTo:movePoint duration:time2];
    SKAction *seq = [SKAction sequence:@[[SKAction waitForDuration:time],move]];
    
    __weak typeof(self)weakSelf = self;
    [self runAction:gr completion:^{
        [weakSelf.parent addChild:blueFire];
        [weakSelf runAction:move];
    }];
    
    [blueFire runAction:seq completion:^{
        SKAction *fadeAlpha2 = [SKAction fadeAlphaTo:1 duration:time];
        SKAction *scale2 = [SKAction scaleTo:1 duration:time];
        SKAction *gr2 = [SKAction group:@[fadeAlpha2,scale2,rot]];
        [weakSelf runAction:gr2 completion:^{
            weakSelf.state = weakSelf.state ^ Sprite_movie;
            [weakSelf bigWindAttack];
            
        }];
    }];
    
}

/// 飓风
- (void)bigWindAttack{
    
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
        
        [weakSelf createBigWind];

        [weakSelf.leftHand runAction:leftHandRep completion:^{
           
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
                }];
                
                
            }];

        }];
    }];
    
    [self.leftArm runAction:leftArmAction];
    
 
}

- (void)createBigWind{
    
    WDBaseNode *windNode = [WDBaseNode spriteNodeWithTexture:_boss1Model.windArr[0]];
    windNode.alpha = 1;
    windNode.zPosition = 30000;
    windNode.position = CGPointMake(self.position.x + self.direction * 180 * allScale, self.position.y - 20 * allScale);
    windNode.name = @"wind";
    windNode.direction = self.direction;
    windNode.xScale = 0;
    windNode.yScale = 0;
    windNode.ATK = self.targetNode.BLOOD_INIT / 3;
    [self.parent addChild:windNode];
    
    SKAction *animation = [SKAction animateWithTextures:_boss1Model.windArr timePerFrame:0.1];
    SKAction *rep = [SKAction repeatActionForever:animation];
    [windNode runAction:rep];
    
    SKAction *scaleAction = [SKAction scaleTo:1.5 duration:100 * 0.02];
    __weak typeof(self)weakSelf = self;
    [windNode runAction:scaleAction completion:^{
        [weakSelf windGo:windNode];
    }];
}

- (void)windGo:(WDBaseNode *)windNode{
    
    [self windPhy:windNode];
    NSTimeInterval time = fabs(windNode.position.x + (self.direction * 1200)) / 3000;
    //0.7秒等待时间
    CGFloat windFlyX = self.direction * 1200;
    if (windFlyX > kScreenWidth) {
        windFlyX = kScreenWidth - 170;
    }else if(windFlyX < -kScreenWidth){
        windFlyX = -kScreenWidth + 170;
    }

    SKAction *moveAction  = [SKAction moveTo:CGPointMake(windFlyX, self.position.y) duration:time];

    SKAction *gro = [SKAction group:@[moveAction]];
    SKAction *remove = [SKAction removeFromParent];
    SKAction *alpha = [SKAction fadeAlphaTo:0 duration:0.3];
    SKAction *seq = [SKAction sequence:@[gro,alpha,remove]];
    
    [windNode runAction:seq completion:^{
    }];
}

/// 设置飓风物理体积
- (void)windPhy:(WDBaseNode *)windNode{
    CGRect rect = CGRectMake(self.direction * (-70), 0, 100, 100);
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(rect.size.width, rect.size.height) center:CGPointMake(rect.origin.x, rect.origin.y)];
    body.allowsRotation = NO;
    body.affectedByGravity = NO;
    body.categoryBitMask = 0;
    body.contactTestBitMask = PLAYER_CONTACT;
    body.collisionBitMask = 0;
    windNode.physicsBody = body;
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

#pragma mark - 因为仇恨导致切换目标，风不消失的问题 -
- (void)addHateNumberWithAttackNode:(WDBaseNode *)node{
    
    if (self.state & Sprite_attack) {
        
    }else{
        [super addHateNumberWithAttackNode:node];
    }
    
}





@end
