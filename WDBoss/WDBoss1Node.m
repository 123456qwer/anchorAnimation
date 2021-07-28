//
//  WDBoss1Node.m
//  BattleHeartNew
//
//  Created by Mac on 2021/3/10.
//  Copyright © 2021 Macdddd. All rights reserved.
//

#import "WDBoss1Node.h"
#import "WDBaseScene.h"


@implementation WDBoss1Node

{
    Boss1Model *_boss1Model;
    CGPoint _position;
    int _stagger;
    WDBaseNode *_targetMonster;
    NSInteger _attackCount;
    NSInteger _skillIndex;
    WDBaseNode *_rewardNode;
}

+ (instancetype)initWithModel:(Boss1Model *)model
{
    WDBoss1Node *node = [WDBoss1Node spriteNodeWithTexture:model.walkArr[0]];
    [node setChildNodeWithModel:model];
    return node;
}

- (void)setChildNodeWithModel:(Boss1Model *)model
{
    //[super setChildNodeWithModel:model];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(upDataAction) name:kNotificationForUpData object:nil];

    
    _boss1Model = (Boss1Model *)model;
    
    self.xScale = 1.9;
    self.yScale = 1.9;
    
    self.name = kBoss1;
    [WDAttributeManager setSpriteAttribute:self];
    self.realSize = CGSizeMake(self.size.width / 2.0 / 2.0, self.size.height / 2.0 / 2.0);
    
    self.attackMaxSize = self.size.width / 2.0 / 2.0 / 2.0;
    self.attackMinSize = self.size.width / 2.0 / 2.0 - 35;
    
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width / 2.0 / 2.0, self.size.height / 2.0) center:CGPointMake(0, 0)];
    self.physicsBody = body;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.allowsRotation = NO;

        
    [self createMonsterAttackPhysicBodyWithPoint:CGPointMake(0, 0) size:CGSizeMake(self.size.width / 2.0 / 2.0, self.size.height / 2.0)];
   
    self.shadow = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"Shadow"]]];
    self.shadow.position = CGPointMake(0, - 80 * allScale);
    self.shadow.xScale = 0.1;
    self.shadow.yScale = 0.1;
    self.shadow.zPosition = -1;
    [self addChild:self.shadow];

    self.position = CGPointMake(kScreenWidth, 0);
    self.talkNode.xScale = 1;
    self.talkNode.yScale = 1;
    self.talkNode.position = CGPointMake(0, self.size.height / 2.0 - self.talkNode.size.height / 2.0);
    
    self.balloonNode.xScale = 1;
    self.balloonNode.yScale = 1;
    //self.balloonNode.position = CGPointMake(self.balloonNode.position.x, self.realSize.height / 2.0 + self.balloonNode.size.height);
    self.balloonNode.hidden = YES;
        
    ///血条
//    [self createBlood:2 * allScale];
//    [self setBloodYPosition:200 * allScale];
    [self addObserver:self forKeyPath:@"xScale" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionNew context:nil];
    ///血条
    [self createBlood:0.5 * allScale];
    self.bgBlood.size = CGSizeMake(self.realSize.width / 2.0,  self.bgBlood.size.height);
    self.bgBlood.position = CGPointMake(-self.realSize.width / 2.0 / 2.0, self.realSize.height / 2.0 + 25 * allScale);
    self.bgBlood.hidden = YES;
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (self.xScale > 0) {
        
        self.bgBlood.xScale = fabs(self.bgBlood.xScale);
        self.bgBlood.position = CGPointMake(-self.realSize.width / 2.0 / 2.0, self.bgBlood.position.y);
        self.direction = 1;
        self.talkNode.xScale = fabs(self.talkNode.xScale);
        
    }else{
        
        self.bgBlood.xScale = - fabs(self.bgBlood.xScale);
        self.bgBlood.position = CGPointMake(self.realSize.width / 2.0 / 2.0, self.bgBlood.position.y);
        self.direction = -1;
        self.talkNode.xScale = - fabs(self.talkNode.xScale);
    }
}

- (void)moveToTheMap:(void (^)(BOOL isComplete))complete
{
    SKAction *attackAction = [SKAction animateWithTextures:_boss1Model.missArr timePerFrame:0.1];
    SKAction *rep2 = [SKAction repeatAction:attackAction count:3];
    SKAction *move = [SKAction moveTo:CGPointMake(-kScreenWidth + self.size.width, 0) duration:_boss1Model.missArr.count * 0.1 * 3];
    
    SKAction *gro = [SKAction group:@[move,rep2]];
    
    __weak typeof(self)weakSelf = self;
    [self runAction:gro completion:^{
        SKAction *talkAction = [SKAction animateWithTextures:weakSelf.boss1Model.attackArr5 timePerFrame:0.2];
        [weakSelf.talkNode setText:@"我是技能导师\n来试着打败我" hiddenTime:weakSelf.boss1Model.attackArr5.count * 0.2 completeBlock:^{
            weakSelf.state = Sprite_stand;
            complete(YES);
            
        }];
        [weakSelf runAction:talkAction completion:^{
                        
        }];
    }];
}


- (void)endAction:(void (^)(BOOL isComplete))complete
{
    self.completeBlock = complete;
    [self removeAllActions];
    self.colorBlendFactor = 0;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    SKAction *animation = [SKAction animateWithTextures:_boss1Model.winArr timePerFrame:0.2];
    //[WDTextureManager shareTextureManager].goText = @"去学习技能！";
    
    SKAction *action = [SKAction animateWithTextures:_boss1Model.walkArr timePerFrame:0.1];
    SKAction *move = [SKAction moveTo:CGPointMake(0, 0) duration:0.1 * _boss1Model.walkArr.count];
    SKAction *gr = [SKAction group:@[action,move]];
    [self runAction:gr completion:^{
        __weak typeof(self)weakSelf = self;
        [self.talkNode setText:@"你们通过了考验\n这是你们的奖励"];
       // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moveActionForClick) name:kNotificationForClickPrompt object:nil];
        [self runAction:animation completion:^{
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            [defaults setBool:YES forKey:kPassCheckPoint1];
//            [defaults setBool:YES forKey:kSkillNPC];
//            NSInteger ballCount = [defaults integerForKey:kSkillBall];
           // ballCount ++;
//            [defaults setInteger:ballCount forKey:kSkillBall];
            [weakSelf createReward:complete];
        }];
    }];
    
    
}

- (void)createReward:(void (^)(BOOL isComplete))complete{
    WDBaseNode *reward = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"select_no"]]];
    [self.parent addChild:reward];
    reward.name = @"click";
    reward.xScale = 0.1;
    reward.yScale = 0.1;
    reward.alpha = 0;
    reward.zPosition = 10000;
    reward.position = CGPointMake(self.position.x + 30, self.position.y - 30);
    
    SKAction *alphaA = [SKAction fadeAlphaTo:1 duration:0.6];
    SKAction *xS = [SKAction scaleTo:1.0 duration:0.6];
    SKAction *gr = [SKAction group:@[alphaA,xS]];
    
    _rewardNode = reward;
    
    __weak typeof(self)weakSelf = self;
    [reward runAction:gr completion:^{
        reward.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"select_yes"]];
        weakSelf.clickNode.hidden = NO;
        weakSelf.clickNode.position = CGPointMake(reward.position.x, reward.position.y - weakSelf.clickNode.size.height / 2.0 - reward.size.width / 2.0 + 10);
    }];
}

- (void)moveActionForClick{
    CGPoint movePoint = CGPointMake(kScreenWidth - 90, kScreenHeight - 90);
    CGFloat distance = [WDCalculateTool distanceBetweenPoints:movePoint seconde:_rewardNode.position];
    NSTimeInterval time = distance / 1200;
    SKAction *moveAction = [SKAction moveTo:CGPointMake(kScreenWidth - 90, kScreenHeight - 90) duration:time];
    [self.clickNode removeAllActions];
    [self.clickNode removeFromParent];
    __weak typeof(self)weakSelf = self;
    [_rewardNode runAction:moveAction completion:^{
        weakSelf.completeBlock(YES);
    }];
}



#pragma mark - 移动逻辑 -
- (void)upDataAction{
    [self observedNode];
}

- (void)observedNode
{
    //[super observedNode];
    
    self.zPosition = 10000 - self.position.y + 100;
    
    if (self.state & Sprite_attack || self.state & Sprite_dead || self.state & Sprite_walk || self.state & Sprite_movie) {
        return;
    }
    
    if (_attackCount >= arc4random() % 3 + 2) {
        self.targetNode = nil;
    }
    
    if (!self.targetNode) {
        self.targetNode = [WDCalculateTool searchUserNearNode:self];
        _attackCount = 0;
    }
    
    if (self.targetNode.state & Sprite_dead) {
        self.targetNode = nil;
        _attackCount = 0;
        return;
    }
    
    if (self.targetNode == nil) {
        return;
    }
    
    CGFloat distance = self.targetNode.position.x - self.position.x;
    if (distance < 0) {
        self.xScale = -fabs(self.xScale);
        self.direction = 1;
    }else{
        self.xScale = +fabs(self.xScale);
        self.direction = -1;
    }
    
    CGFloat personX = self.targetNode.position.x;
    CGFloat personY = self.targetNode.position.y;
    
    CGFloat monsterX = self.position.x;
    CGFloat monsterY = self.position.y;
    
    NSInteger distanceX = personX - monsterX;
    NSInteger distanceY = personY - monsterY;
    
    CGFloat moveX = monsterX;
    CGFloat moveY = monsterY;
    
    if (distanceX > 0) {
        
        self.xScale = 1 * fabs(self.xScale);
        if (fabs(distanceX) <= 400 && fabs(distanceX) >= 380) {
            moveX = monsterX;
        }else if (fabs(distanceX) >= 400) {
            moveX = monsterX + self.CADisplaySpeed;
        }else{
            moveX = monsterX - self.CADisplaySpeed;
        }

        
    }else if(distanceX < 0){
        
        self.xScale = -1 * fabs(self.xScale);
        if (fabs(distanceX) <= 400 && fabs(distanceX) >= 380) {
            moveX = monsterX;
        }else if (fabs(distanceX) >= 400) {
            moveX = monsterX - self.CADisplaySpeed;
        }else{
            moveX = monsterX + self.CADisplaySpeed;
        }
    }
    
    
    CGFloat farX = arc4random() % 500 + 400;
    CGFloat minX = arc4random() % 150 + 50;
    if (fabs(distanceY) < 10 && fabs(distanceX) > minX && fabs(distanceX) < farX) {
        [self monsterAttackAction];
        _attackCount ++;
        return;
    }else if(fabs(distanceY) < 10 && fabs(distanceY) > 0){
        moveY = monsterY;
    }else if(distanceY > 0){
        moveY = monsterY + self.CADisplaySpeed;
    }else if(distanceY < 0){
        moveY = monsterY - self.CADisplaySpeed;
    }
    
    if (0) {
        [self removeAllActions];
        self.colorBlendFactor = 0;
        self.state = Sprite_walk;
        
        SKAction *animation = [SKAction animateWithTextures:_boss1Model.missArr timePerFrame:0.1];
        SKAction *move = [SKAction moveTo:CGPointMake(0, 0) duration:_boss1Model.missArr.count * 0.1];
        __weak typeof(self)weakSelf = self;
        [self runAction:[SKAction group:@[animation,move]] completion:^{
            weakSelf.state = Sprite_walk;
        }];
        
        return;
    }
    
    CGPoint calculatePoint = CGPointMake(moveX, moveY);
    
    self.position = calculatePoint;
    self.zPosition = 650 - self.position.y;
    if (!self.isMoveAnimation) {
        
        self.isMoveAnimation = YES;
        //5张
        SKAction *moveAction = [SKAction animateWithTextures:_boss1Model.walkArr timePerFrame:0.15];
        SKAction *rep = [SKAction repeatActionForever:moveAction];
        [self runAction:rep completion:^{
        }];
    }
    
}

- (void)monsterAttackAction{
    
    CGFloat distance = self.targetNode.position.x - self.position.x;
    if (distance < 0) {
        self.xScale = -fabs(self.xScale);
        self.direction = 1;
    }else{
        self.xScale = +fabs(self.xScale);
        self.direction = -1;
    }
    
    NSArray *skillNames = @[@"meteoriteAttackAnimation",@"pullAttackAnimation",@"flashAttackAnimation",@"callAttackAnimation",@"callAttackAnimation",@"bookAttackBigAnimation"];

    NSInteger index = arc4random() % skillNames.count;
    if (index == 3 || index == 4) {
        WDBaseScene *scene = (WDBaseScene *)self.parent;
        if (scene.monsterArr.count > 5) {
            index = 1;
        }
    }
    //index = 5;
    NSString *skillName = skillNames[index];
    SEL action = NSSelectorFromString(skillName);
//    _skillIndex ++;
//    if (_skillIndex >= skillNames.count) {
//        _skillIndex = 0;
//    }
    
    /**
     1.直接忽略（如果是基本类型比如 void，int这样的）。
     2.把返回值先 retain，等到用不到的时候再 release（最常见的情况）。
     3.不 retain，等到用不到的时候直接 release（用于 init、copy 这一类的方法，或者标注ns_returns_retained的方法）。
     4.什么也不做，默认返回值在返回前后是始终有效的（一直到最近的 release pool 结束为止，用于标注ns_returns_autoreleased的方法）。
     
     而调performSelector:的时候，系统会默认返回值并不是基本类型，但也不会 retain、release，也就是默认采取第 4 种做法。所以如果那个方法本来应该属于前 3 种情况，都有可能会造成内存泄漏。

     一下警告的问题，这里可以忽略
     */
    if (action) {
        [self performSelector:action];
    }
   
}

/** 书攻击，大幅度 2 = = */
- (void)bookAttackBigAnimation{
    
    self.state = Sprite_attack;
    
    SKAction *attackAction = [SKAction animateWithTextures:_boss1Model.attackArr2 timePerFrame:0.1];
    
    
    
    WDBaseNode *windNode = [WDBaseNode spriteNodeWithTexture:_boss1Model.windArr[0]];
    windNode.alpha = 0;
    windNode.zPosition = 10000;
    windNode.position = CGPointMake(self.position.x, self.position.y);
    windNode.name = @"wind";
    windNode.direction = self.direction;
    windNode.xScale = 1.5;
    windNode.yScale = 1.5;
    [self.parent addChild:windNode];
    
    [self performSelector:@selector(windPhy:) withObject:windNode afterDelay:7 * 0.1];
    NSTimeInterval time = fabs(windNode.position.x + (self.direction * 600)) / 1000;
    //0.7秒等待时间
    CGFloat windFlyX = self.direction * -600;
    if (windFlyX > kScreenWidth) {
        windFlyX = kScreenWidth - 170;
    }else if(windFlyX < -kScreenWidth){
        windFlyX = -kScreenWidth + 170;
    }
    SKAction *windAction = [SKAction animateWithTextures:_boss1Model.windArr timePerFrame:0.1];
    SKAction *waitAction  = [SKAction waitForDuration:6 * 0.1];
    SKAction *alphaAction = [SKAction fadeAlphaTo:0.7 duration:0.1];
    SKAction *moveAction  = [SKAction moveTo:CGPointMake(windFlyX, self.position.y) duration:time];

    SKAction *gro = [SKAction group:@[windAction,alphaAction,moveAction]];
    SKAction *remove = [SKAction removeFromParent];
    SKAction *alpha = [SKAction fadeAlphaTo:0 duration:0.3];
    SKAction *seq = [SKAction sequence:@[waitAction,gro,alpha,remove]];
    
    __weak typeof(self)weakSelf = self;
    [windNode runAction:seq completion:^{
    }];
    
    [self runAction:attackAction completion:^{
        weakSelf.state = Sprite_stand;
    }];
}

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

/** 召唤小怪 6 */
- (void)callAttackAnimation{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForBossCallMonster object:nil];
    
    self.state = Sprite_attack;
    SKAction *attackAction = [SKAction animateWithTextures:_boss1Model.attackArr6 timePerFrame:0.1];
    
    __weak typeof(self)weakSelf = self;
    [self runAction:attackAction completion:^{
        weakSelf.state = Sprite_stand;
    }];
}

/** 陨石攻击动画 9 */
- (void)meteoriteAttackAnimation{
    
    self.state = Sprite_attack;
    SKAction *attackAction = [SKAction animateWithTextures:_boss1Model.attackArr9 timePerFrame:0.1];
    
    [self performSelector:@selector(meteoriteAttackWithCount:) withObject:nil afterDelay:0.2];
    [self performSelector:@selector(meteoriteAttackWithCount:) withObject:nil afterDelay:0.6];
//    [self performSelector:@selector(meteoriteAttackWithCount:) withObject:nil afterDelay:1.0];
    
    __weak typeof(self)weakSelf = self;
    [self runAction:attackAction completion:^{
        weakSelf.state = Sprite_stand;
    }];
}

/** 陨石攻击 */
- (void)meteoriteAttackWithCount:(NSInteger)count
{
    WDBaseNode *randomNode = [WDCalculateTool searchUserNearNode:self];
    WDBaseNode *meteoriteShadow = [WDBaseNode spriteNodeWithTexture:_boss1Model.shadowTexture];
    meteoriteShadow.zPosition = randomNode.zPosition - 10;
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
    fireNode.zPosition = 10000;
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
    [fireNode runAction:seq2 completion:^{
        [targetNode removeFromParent];
        
        WDWeaponNode *boomNode = [WDWeaponNode spriteNodeWithTexture:model.meteoriteArr2[1]];
        boomNode.position = CGPointMake(fireNode.position.x + 40, fireNode.position.y + 120);
        boomNode.zPosition = 2000;
        boomNode.xScale = 2.0;
        boomNode.yScale = 2.0;
        boomNode.name = @"meteorite1";
        boomNode.ATK = 20;
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

/** 闪电攻击 5 */
- (void)flashAttackAnimation{

    self.state = Sprite_attack;
    SKAction *attackAction = [SKAction animateWithTextures:_boss1Model.attackArr5 timePerFrame:0.1];
    
    [self performSelector:@selector(createCloudNode) withObject:nil afterDelay:0.2];
    [self performSelector:@selector(createCloudNode) withObject:nil afterDelay:0.6];
//    [self performSelector:@selector(createCloudNode) withObject:nil afterDelay:1];
    __weak typeof(self)weakSelf = self;
    [self runAction:attackAction completion:^{
        weakSelf.state = Sprite_stand;
    }];
}

/** 创建云 */
- (void)createCloudNode
{
    WDBaseNode *cloudNode = [WDBaseNode spriteNodeWithTexture:_boss1Model.cloudTexture];
    WDBaseNode *randomNode = [WDCalculateTool searchUserNearNode:self];
    
    cloudNode.xScale = 0.5;
    cloudNode.yScale = 0.5;
    cloudNode.alpha = 0;
    cloudNode.position = CGPointMake(randomNode.position.x, randomNode.position.y + randomNode.size.height + cloudNode.size.height);
    cloudNode.zPosition = 10000;
    cloudNode.name = @"cloud";
    [self.parent addChild:cloudNode];
    
    SKAction *scaleAction = [SKAction scaleTo:0.7 duration:0.5];
    SKAction *alphaA = [SKAction fadeAlphaTo:1 duration:0.5];
    
    SKAction *blinkA = [SKAction fadeAlphaTo:0.9 duration:0.15];
    SKAction *blinkB = [SKAction fadeAlphaTo:1.0 duration:0.15];
    
    SKAction *bSeq = [SKAction sequence:@[blinkA,blinkB]];
    SKAction *gro = [SKAction group:@[scaleAction,alphaA]];
    
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

/** 创建闪电攻击 */
- (void)flash:(CGPoint)point{
    WDWeaponNode *flashNode = [WDWeaponNode spriteNodeWithTexture:_boss1Model.flashArr[0]];
    flashNode.position = CGPointMake(point.x, point.y - flashNode.size.height);
    flashNode.zPosition = 9999;
    flashNode.xScale = 1.5;
    flashNode.yScale = 1.5;
    flashNode.alpha  = 0.8;
    flashNode.ATK = 20;
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

/** 拉拽攻击 8 */
- (void)pullAttackAnimation{
    if (self.targetNode.state & Sprite_dead) {
        return;
    }

    [self removeAllActions];
    self.isMoveAnimation = NO;
    
    [self.targetNode removeAllActions];
    //self.targetNode.paused = YES;
    self.targetNode.state = self.targetNode.state | Sprite_movie;
    
    self.state = Sprite_attack;
    
    Boss1Model *_model = _boss1Model;
    
    SKAction *attackAction = [SKAction animateWithTextures:[_model.attackArr8 subarrayWithRange:NSMakeRange(0, 4)] timePerFrame:0.1];
    SKAction *waitAction    = [SKAction waitForDuration:0.4];
    SKAction *attackAction2 = [SKAction animateWithTextures:[_model.attackArr8 subarrayWithRange:NSMakeRange(4, _model.attackArr8.count - 4)] timePerFrame:0.1];
    
    SKAction *seq = [SKAction sequence:@[attackAction,waitAction,attackAction2]];
    [self performSelector:@selector(bePullAction:) withObject:self.targetNode afterDelay:0.7];
    
    WDBaseNode *windNode = [WDBaseNode spriteNodeWithTexture:_model.windArr[0]];
    windNode.alpha = 0;
    windNode.xScale = 2.0;
    windNode.yScale = 2.0;
    windNode.zPosition = 10000;
    [self.targetNode addChild:windNode];
    
    SKAction *windAction = [SKAction animateWithTextures:_model.windArr timePerFrame:0.1];
    SKAction *alphaAction = [SKAction fadeAlphaTo:0.7 duration:0.5];
    SKAction *waitAlpha0 = [SKAction waitForDuration:0.5];
    SKAction *alpha0Action = [SKAction fadeAlphaTo:0 duration:0.2];
    SKAction *seq2 = [SKAction sequence:@[alphaAction,waitAlpha0,alpha0Action]];
   
    SKAction *gro = [SKAction group:@[seq2,windAction]];
    
    
    SKAction *remove = [SKAction removeFromParent];
    SKAction *seqA = [SKAction sequence:@[gro,remove]];
    
    [windNode runAction:seqA completion:^{
        
    }];
    
    __weak typeof(self)weakSelf = self;
    [self runAction:seq completion:^{
        [weakSelf bookAttack];
    }];
}

- (void)bePullAction:(WDBaseNode *)targetMonster{

    SKAction *move = [SKAction moveTo:CGPointMake(self.position.x - self.direction * 80, self.position.y) duration:0.4];
    //__weak typeof(self)weakSelf = self;
    [self.targetNode runAction:move completion:^{
        if (targetMonster.state & Sprite_dead) {
            return;
        }
        targetMonster.state = targetMonster.state ^ Sprite_movie;
    }];
}

- (void)bookAttack{
    
    SKAction *book1 = [SKAction animateWithTextures:_boss1Model.attackArr1 timePerFrame:0.1];
    [self performSelector:@selector(attackAction) withObject:nil afterDelay:0.1 * 3];

    __weak typeof(self)weakSelf = self;
    [self runAction:book1 completion:^{
        weakSelf.state = Sprite_stand;
    }];
}

#pragma mark - 真实的被击中
- (void)attackAction
{
    CGFloat distanceX = self.position.x - self.targetNode.position.x;
    CGFloat distanceY = self.position.y - self.targetNode.position.y;
 
    CGFloat bigDistance = self.size.width / 2.0 / 2.0 + self.targetNode.size.width / 2.0;
    
    if (fabs(distanceX) < bigDistance && fabs(distanceY) < 100) {
        [self.targetNode beAttackAction:self attackNumber:self.targetNode.BLOOD_INIT / 5];
    }
}

- (void)releaseAction
{
    //[super releaseAction];
}

- (void)dealloc
{
    NSLog(@"boss1被销毁了");
    _boss1Model = nil;
}

- (void)moveAction{
    
    SKAction *moveAnimation = [SKAction animateWithTextures:_boss1Model.walkArr timePerFrame:0.1];
    SKAction *rep = [SKAction repeatActionForever:moveAnimation];
    [self runAction:rep withKey:@"move"];
}

@end
