//
//  WDBaseNode.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/17.
//

#import "WDBaseNode.h"
#import "WDBaseNode+Animation.h"
#import "WDEnemyNode.h"
@implementation WDBaseNode
{
    WDBaseNode *_head;
    WDBaseNode *_eye;
    WDBaseNode *_eyeBrows;
    WDBaseNode *_ear;
    WDBaseNode *_mouth;
    WDBaseNode *_body;
    WDBaseNode *_hair;
    WDBaseNode *_helmet;
    
    WDBaseNode *_leftWeapon;
    WDBaseNode *_rightWeapon;
    
    WDBaseNode *_leftArm;
    WDBaseNode *_leftElbow;
    WDBaseNode *_leftHand;
    
    WDBaseNode *_rightArm;
    WDBaseNode *_rightElbow;
    WDBaseNode *_rightHand;
    WDBaseNode *_rightFinger;
    
    WDBaseNode *_hip;
    
    WDBaseNode *_rightKnee;
    WDBaseNode *_rightFoot;
    
    WDBaseNode *_leftKnee;
    WDBaseNode *_leftFoot;
    
    WDBaseNode *_bgBlood;///血条背景
    WDBaseNode *_blood;  ///血条
    
    CGFloat     _bodyZ;
}

- (void)createUserNodeWithScale:(CGFloat)scale{

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(upDataAction) name:kNotificationForUpData object:nil];
    
    self.attackMaxSize = self.size.width / 2.0;
    self.attackMinSize = self.size.width / 3.0;
    
    _bodyZ    = 100;

    _walkTime = 0.2;
    _legWalkAngle = 30;
    
    //阴影
    _shadow = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"Shadow"]]];
    _shadow.position = CGPointMake(0, -125 * scale);
    _shadow.xScale = 0.3 * scale;
    _shadow.yScale = 0.3 * scale;
    [self addChild:_shadow];
    
    //身体部位
    _body = [self textureWithKeyName:kBody];
    _body.zPosition      = _bodyZ;
    _body.position       = CGPointMake(0, -65 * scale);
    _body.anchorPoint    = CGPointMake(0.5, 0.3);
    _body.xScale = scale;
    _body.yScale = scale;
    [self addChild:_body];
    
    ///创建头
    [self createHead];
   
    ///胯部
    [self createHip];
    
    ///左胳膊
    [self createLeftArmssss];
    
    ///右胳膊
    [self createRightArmssss];
    
    ///脚和腿
    [self createKneeAndFoot];
    
    ///血条
    [self createBlood:scale];
    
    [self addObserver:self forKeyPath:@"xScale" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionNew context:nil];
}

///创建脑袋、脸等
- (void)createHead{
    
    //头
    _head = [WDBaseNode spriteNodeWithTexture:[WDTextureManager shareManager].humanHead];
    _head.xScale = 0.9;
    _head.yScale = 0.9;
    _head.zPosition = 2;
    _head.position = CGPointMake(-3, 72);
    [_body addChild:_head];
    
    
    //眼睛
    _eye = [WDBaseNode spriteNodeWithTexture:[WDTextureManager shareManager].male_eye];
    _eye.zPosition = 0;
    [_head addChild:_eye];
    
    //眉毛
    _eyeBrows = [WDBaseNode spriteNodeWithTexture:[WDTextureManager shareManager].normalEyeBrows];
    _eyeBrows.zPosition = 0;
    [_head addChild:_eyeBrows];
    
    //嘴
    _mouth = [WDBaseNode spriteNodeWithTexture:[WDTextureManager shareManager].normalMouth];
    _mouth.zPosition = 0;
    [_head addChild:_mouth];
    
    self.defaultMouthTexture = _mouth.texture;
    
//    //头发
    UIImage *hairImage = [UIImage imageNamed:@"BuzzCut"];
    
    _hair = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:hairImage]];
    _hair.zPosition = 0;
    [_head addChild:_hair];
    
    

    //耳朵
    _ear = [WDBaseNode spriteNodeWithTexture:[WDTextureManager shareManager].normalEar];
    _ear.zPosition = 0;
    [_head addChild:_ear];
    
    //头盔
//    _hemlet = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"EliteKnightHelm"]]];
//    _hemlet.zPosition = 0;
//    [_head addChild:_hemlet];
   
}

///创建胯部
- (void)createHip{
    
    _hip = [self textureWithKeyName:kHip];
    _hip.anchorPoint = CGPointMake(0.5, 0.5);
    _hip.position = CGPointMake(0, 7);
    _hip.zPosition = 0;
    [_body addChild:_hip];
}

///创建右侧胳膊、胳膊肘、右手、右手指
- (void)createRightArmssss{
    //右胳膊
    _rightArm = [self textureWithKeyName:kRightArm];
    _rightArm.anchorPoint = CGPointMake(0.43,0.6);
    _rightArm.position = CGPointMake(17, 65);
    _rightArm.zRotation = DEGREES_TO_RADIANS(-16);
    _rightArm.zPosition = -3;
    [_body addChild:_rightArm];
    
    //右胳膊肘，这个地方其实位于图片手的位置
    _rightElbow = [self textureWithKeyName:kRightElbow];
    _rightElbow.anchorPoint = CGPointMake(0.3, 0.5);
    _rightElbow.position = CGPointMake( 7, -27);
    _rightElbow.zPosition = 0;
    [_rightArm addChild:_rightElbow];
   
    //右手
    _rightHand = [self textureWithKeyName:kRightHand];
    _rightHand.zRotation = DEGREES_TO_RADIANS(30);
    _rightHand.anchorPoint = CGPointMake(0.5, 0.5);
    _rightHand.position = CGPointMake(32,-5);
    _rightHand.zPosition = 1;
    [_rightElbow addChild:_rightHand];

    //右手指
    _rightFinger = [self textureWithKeyName:kRightFinger];
    _rightFinger.anchorPoint = CGPointMake(0.5, 0.5);
    _rightFinger.zRotation = DEGREES_TO_RADIANS(-30);
    _rightFinger.position = CGPointMake(28, -3);
    _rightFinger.zPosition = 2;
    [_rightElbow addChild:_rightFinger];
    

    
    _rightHand.defaultAngle = DEGREES_TO_RADIANS(30);
    _rightFinger.defaultAngle = DEGREES_TO_RADIANS(-30);
    _rightArm.defaultAngle = DEGREES_TO_RADIANS(-16);

}

///创建左侧胳膊、胳膊肘、左手
- (void)createLeftArmssss{
    
    //左胳膊
    _leftArm = [self textureWithKeyName:kLeftArm];
    _leftArm.anchorPoint = CGPointMake(0.6,0.55);
    _leftArm.position    = CGPointMake(-36.5, 57);
    _leftArm.zPosition   = 1;
    [_body addChild:_leftArm];

    //左胳膊肘
    _leftElbow = [self textureWithKeyName:kLeftElbow];
    _leftElbow.anchorPoint = CGPointMake(0.5 ,0.6 );
    _leftElbow.position = CGPointMake(-26.5,-19.5);
    _leftElbow.zPosition = 0;
    [_leftArm addChild:_leftElbow];

    //左手
    _leftHand = [self textureWithKeyName:kLeftHand];
    _leftHand.anchorPoint = CGPointMake(0.5, 0.5 );
    _leftHand.position = CGPointMake(0,-25);
    _leftHand.zPosition = 5;
    [_leftElbow addChild:_leftHand];

    //默认的角度
    _leftArm.defaultAngle = DEGREES_TO_RADIANS(5);
    _leftArm.zRotation = DEGREES_TO_RADIANS(5);
    
    _leftElbow.defaultAngle = DEGREES_TO_RADIANS(8);
    _leftElbow.zRotation = DEGREES_TO_RADIANS(8);
}

///创建腿和脚
- (void)createKneeAndFoot{
    
    //右膝盖
    _rightKnee = [self textureWithKeyName:kKnee];
    _rightKnee.anchorPoint = CGPointMake(0.5 , 0.55);
    _rightKnee.position = CGPointMake(18.3, -5);
    _rightKnee.zPosition = 1;
    [_hip addChild:_rightKnee];
    
    //右脚
    _rightFoot = [self textureWithKeyName:kFoot];
    _rightFoot.anchorPoint = CGPointMake(0.5 , 0.65 );
    _rightFoot.position = CGPointMake(0, -23);
    _rightFoot.zPosition = 1;
    [_rightKnee addChild:_rightFoot];
    
    //左膝盖
    _leftKnee = [self textureWithKeyName:kKnee];
    _leftKnee.xScale = - fabs(_leftKnee.xScale);
    _leftKnee.anchorPoint = CGPointMake(0.5 , 0.55);
    _leftKnee.position = CGPointMake(-19, -5);
    _leftKnee.zPosition = 2;
    [_hip addChild:_leftKnee];
    
    //左脚
    _leftFoot = [self textureWithKeyName:kFoot];
    _leftFoot.xScale = - fabs(_leftFoot.xScale);
    _leftFoot.anchorPoint = CGPointMake(0.5 , 0.65 );
    _leftFoot.position = CGPointMake(0, -23);
    _leftFoot.zPosition = 1;
    [_leftKnee addChild:_leftFoot];
    
    _leftKnee.defaultAngle = DEGREES_TO_RADIANS(-5);
    _leftKnee.zRotation = DEGREES_TO_RADIANS(-5);
}

///创建血条
- (void)createBlood:(CGFloat)scale{
    
    UIColor *color = [UIColor blackColor];

    _bgBlood = [WDBaseNode spriteNodeWithColor:color size:CGSizeMake(self.size.width, 20 * scale)];
    _bgBlood.position = CGPointMake(-self.size.width / 2.0, self.size.height / 2.0 + _bgBlood.size.height + 30 * scale);
    [self addChild:_bgBlood];
    
    UIColor *color2 = UICOLOR_RGB(127, 255, 0, 1);
    if ([self isKindOfClass:[WDEnemyNode class]]) {
        color2 = UICOLOR_RGB(255, 227, 132, 1);
    }
    
    _blood = [WDBaseNode spriteNodeWithColor:color2 size:CGSizeMake(self.size.width, 20 * scale)];
    [_bgBlood addChild:_blood];
    
    _bgBlood.anchorPoint = CGPointMake(0, 0);
    _blood.anchorPoint   = CGPointMake(0, 0);
}

- (void)setBloodYPosition:(CGFloat)yPage{
    _bgBlood.position = CGPointMake(-self.size.width / 2.0, self.size.height / 2.0 + _bgBlood.size.height + yPage);
}

#pragma mark - 金色选中箭头 -
- (void)setArrowNodeWithPosition:(CGPoint)point
                           scale:(CGFloat)scale
{
    SKTexture *texture = [WDTextureManager shareManager].arrowTexture;
    _arrowNode = [WDBaseNode spriteNodeWithTexture:texture];
    _arrowNode.position = point;
    _arrowNode.xScale = scale;
    _arrowNode.yScale = scale;
    _arrowNode.zPosition = 100;
    _arrowNode.hidden = YES;
    [self addChild:_arrowNode];
    
    SKAction *move1 = [SKAction moveTo:CGPointMake(point.x,point.y + 30) duration:0.5];
    SKAction *move2 = [SKAction moveTo:CGPointMake(point.x, point.y ) duration:0.5];
    SKAction *seq = [SKAction sequence:@[move1,move2]];
    SKAction *rep = [SKAction repeatActionForever:seq];
    [_arrowNode runAction:rep withKey:@"arrow"];
}

- (WDTalkNode *)talkNode
{
    if (!_talkNode) {
        _talkNode = [WDTalkNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"talk"]]];
        _talkNode.zPosition = 1000;
        _talkNode.hidden = YES;
        _talkNode.xScale = 1.5;
        _talkNode.yScale = 1.5;
        _talkNode.position = CGPointMake(0, self.size.height - 1 * self.yScale);
        [self addChild:_talkNode];
    }
    
    return _talkNode;
}

- (WDBalloonNode *)balloonNode
{
    if (!_balloonNode) {
        
        NSArray *balloonArr = [[WDTextureManager shareManager]balloonTexturesWithLine:1];
        _balloonNode = [WDBalloonNode spriteNodeWithTexture:balloonArr[1]];
        _balloonNode.position = CGPointMake(_balloonNode.position.x, self.size.height / 2.0 + _balloonNode.size.height / 2.0);
        _balloonNode.xScale = 1.5;
        _balloonNode.yScale = 1.5;
        [_balloonNode setScaleAndPositionWithName:self.name];
        _balloonNode.zPosition = 100000;
        [self addChild:_balloonNode];
    }
    
    return _balloonNode;
}

#pragma mark - 行为 -✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (self.xScale > 0) {
        self.bgBlood.xScale = fabs(self.bgBlood.xScale);
        self.bgBlood.position = CGPointMake(-self.size.width / 2.0, self.bgBlood.position.y);
        self.direction = 1;
        self.talkNode.xScale = fabs(self.talkNode.xScale);
    }else{
        self.bgBlood.xScale = - fabs(self.bgBlood.xScale);
        self.bgBlood.position = CGPointMake(self.size.width / 2.0, self.bgBlood.position.y);
        self.direction = -1;
        self.talkNode.xScale = - fabs(self.talkNode.xScale);
    }
}

/// 一直在更新的方法
- (void)upDataAction
{
    /// 父类只负责Z坐标和死亡以及移除腿部动画的操作，其他游戏逻辑子类自行实现
    self.zPosition = 10000 - self.position.y;
    
    
    if (self.state & Sprite_stand && !(self.state & Sprite_dead)) {
        [self removeLegAnimation];
    }
  
}

/// 移动
- (void)moveAction:(CGPoint)movePoint{
    
    self.bowMiddle.zPosition = 0;
    self.rightHand.zPosition = 1;
    self.rightFinger.zPosition = 2;
    [self removeBowAnimation];
    
    if (self.isRunState) {
        [self wdRunAction:movePoint];
    }else{
        [self walkAction:movePoint];
    }
}

/// 行走
- (void)walkAction:(CGPoint)movePoint{
        
    self.legWalkAngle = 30;
    [self moveSameActionWithState:Sprite_walk movePoint:movePoint];
}

/// 跑动
- (void)wdRunAction:(CGPoint)movePoint{
    self.legWalkAngle = 60;
    [self moveSameActionWithState:Sprite_run movePoint:movePoint];
}

/// 站住的动作，停止腿部运动
- (void)standAction{
    
    //跑和走、站立不能同时
    if (self.state & Sprite_run) {
        self.state = self.state ^ Sprite_run;
    }
        
    if (self.state & Sprite_walk) {
        self.state = self.state ^ Sprite_walk;
    }
    
    self.state = self.state | Sprite_stand;
    
    
    [self removeLegAnimation];
    [self upBodyActionForStand];

}


/// 攻击
- (void)attackAction:(WDBaseNode *)enemyNode{
    
    if (self.state & Sprite_attack) {
        return;
    }
    
    [self pauseWalkOrRun];
    
    switch (self.mode) {
        case Attack_singleHand:
        {
            [self singleAttackAction:enemyNode];
        }
            break;
        case Attack_twoHand:
        {
            
        }
            break;
        case Attack_bow:
        {
            [self bowAttackAction:enemyNode];
        }
            break;
            
        default:
            break;
    }
    
}


/// 被攻击
- (void)beAttackAction:(WDBaseNode *)enemyNode
          attackNumber:(int)attackNumber{
  
    [self bleedAnimation:attackNumber];
    [self reduceBlood:attackNumber];
}

/// 被治疗
- (void)beCureAction:(WDBaseNode *)cureNode
{
    [self addBlood:cureNode.cureNumber];
}

/// 死亡
- (void)deadAction
{
    if (self.state & Sprite_learn) {
        [self addBlood:self.initBlood];
        return;
    }
    
    self.state = Sprite_dead;
    [self deadAnimation];
}

- (void)addHateNumberWithAttackNode:(WDBaseNode *)node{}


#pragma mark - 穿盔甲、武器 -
- (void)createSrpiteWithSuperNode:(WDBaseNode *)superNode
                        armorName:(NSString *)armorName{
    
    WDBaseNode *armorNode = (WDBaseNode *)[superNode childNodeWithName:superNode.name];
    if (!armorNode) {
        armorNode = [WDBaseNode spriteNodeWithTexture:[WDCalculateTool textureWithArmorKeyName:superNode.name armorName:armorName]];
        armorNode.anchorPoint = superNode.anchorPoint;
        armorNode.name = superNode.name;
        [superNode addChild:armorNode];
    }else{
        armorNode.texture = [WDCalculateTool textureWithArmorKeyName:superNode.name armorName:armorName];
    }
    
    
}

- (void)setAllArmor:(NSString *)armorName{
   
    
    [self setBodyArmor:armorName];
    [self setHipArmor:armorName];

    [self setleftFootArmor:armorName];
    [self setLeftKneeArmor:armorName];
    [self setLeftElbowArmor:armorName];
    [self setLeftArmArmor:armorName];
    [self setLeftHandArmor:armorName];
    
  
    [self setRightKneeArmor:armorName];
    [self setRightFootArmor:armorName];
    [self setRightArmArmor:armorName];
    [self setRightElbowArmor:armorName];
    [self setRightHandArmor:armorName];
    [self setRightFingerArmor:armorName];
}

- (void)setBodyArmor:(NSString *)armorName{
    [self createSrpiteWithSuperNode:_body armorName:armorName];
}
- (void)setLeftArmArmor:(NSString *)armorName{
    [self createSrpiteWithSuperNode:_leftArm armorName:armorName];
}
- (void)setLeftElbowArmor:(NSString *)armorName{
    [self createSrpiteWithSuperNode:_leftElbow armorName:armorName];
}
- (void)setLeftHandArmor:(NSString *)armorName{
    [self createSrpiteWithSuperNode:_leftHand armorName:armorName];
}
- (void)setRightArmArmor:(NSString *)armorName{
    [self createSrpiteWithSuperNode:_rightArm armorName:armorName];
}
- (void)setRightElbowArmor:(NSString *)armorName{
    [self createSrpiteWithSuperNode:_rightElbow armorName:armorName];
}
- (void)setRightHandArmor:(NSString *)armorName{
    [self createSrpiteWithSuperNode:_rightHand armorName:armorName];
}
- (void)setRightFingerArmor:(NSString *)armorName{
    [self createSrpiteWithSuperNode:_rightFinger armorName:armorName];
}
/// 胯部不太一样，直接加在BODY上
- (void)setHipArmor:(NSString *)armorName{
    
    WDBaseNode *armorNode = [WDBaseNode spriteNodeWithTexture:[WDCalculateTool textureWithArmorKeyName:@"hip" armorName:armorName]];
    armorNode.anchorPoint = CGPointMake(0.5, 0.5);
    armorNode.position = CGPointMake(0, 7);
    [_body addChild:armorNode];
    armorNode.zPosition = 3;
}
- (void)setRightKneeArmor:(NSString *)armorName{
    [self createSrpiteWithSuperNode:_rightKnee armorName:armorName];
}
- (void)setRightFootArmor:(NSString *)armorName{
    [self createSrpiteWithSuperNode:_rightFoot armorName:armorName];
}
- (void)setLeftKneeArmor:(NSString *)armorName{
    [self createSrpiteWithSuperNode:_leftKnee armorName:armorName];
}
- (void)setleftFootArmor:(NSString *)armorName{
    [self createSrpiteWithSuperNode:_leftFoot armorName:armorName];
}

/// 设置头发
- (void)setHairTexture:(NSString *)name{
    self.hair.texture = [SKTexture textureWithImage:[UIImage imageNamed:name]];
}

/// 设置嘴巴
- (void)setMouthTexture:(NSString *)name{
    self.mouth.texture = [SKTexture textureWithImage:[UIImage imageNamed:name]];
    self.defaultMouthTexture = self.mouth.texture;
}

/// 设置眉毛
- (void)setEyeBrowsTexture:(NSString *)name{
    self.eyeBrows.texture = [SKTexture textureWithImage:[UIImage imageNamed:name]];
}

/// 设置眼睛
- (void)setEyeTexture:(NSString *)name{
    self.eye.texture = [SKTexture textureWithImage:[UIImage imageNamed:name]];
}

/// 帽子
- (void)setHemletTexture:(NSString *)name{
    if (!_hemlet) {
        _hemlet = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"EliteKnightHelm"]]];
        _hemlet.zPosition = 0;
        [_head addChild:_hemlet];
    }
    
    self.hemlet.texture = [SKTexture textureWithImage:[UIImage imageNamed:name]];
}

- (void)setLeftWeapon:(NSString *)weaponName{
    
    //左手武器
    if (!_leftWeapon) {
        _leftWeapon = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:weaponName]]];
        _leftWeapon.anchorPoint = _leftHand.anchorPoint;
        _leftWeapon.position = CGPointMake(0, -1);
        _leftWeapon.zPosition = -1;
        _leftWeapon.zRotation = DEGREES_TO_RADIANS(-130);
        [_leftHand addChild:_leftWeapon];
        
        _leftWeapon.name = @"leftWeapon";
    }
    
    _leftWeapon.texture = [SKTexture textureWithImage:[UIImage imageNamed:weaponName]];
    
}

- (void)setRightWeapon:(NSString *)weaponName{
    
    //右手武器
    _rightWeapon = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:weaponName]]];
    _rightWeapon.anchorPoint = CGPointMake(0.5, 0.5);
    _rightWeapon.position = CGPointMake(28, -15);
    _rightWeapon.zPosition = 0;
    _rightWeapon.zRotation = DEGREES_TO_RADIANS(-30);
    [_rightElbow addChild:_rightWeapon];
    
    
    _rightWeapon.name = @"rightWeapon";
}

- (void)setRightShield:(NSString *)shieldName{
    //右手盾牌
    _shield = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:shieldName]]];
    _shield.anchorPoint = CGPointMake(0.5, 0.5);
    _shield.position = CGPointMake(40, -15);
    _shield.zPosition = 7;
    _shield.zRotation = DEGREES_TO_RADIANS(10);
    [_rightElbow addChild:_shield];
   
    _shield.name = @"shield";
}

- (void)setBow:(NSString *)bowName{
    
    NSArray *bowArr = [WDCalculateTool cutBow:[UIImage imageNamed:bowName]];
    
    SKTexture *middle = bowArr[0];
    SKTexture *bow    = bowArr[1];
    SKTexture *arrow  = bowArr[2];
    
    self.arrowTexture = arrow;
    
    _bowMiddle = [WDBaseNode spriteNodeWithTexture:middle];
    _bowMiddle.anchorPoint = CGPointMake(0.5, 0.5);
    _bowMiddle.position = CGPointMake(35, -8);
    _bowMiddle.zPosition = 0;
    _bowMiddle.zRotation = DEGREES_TO_RADIANS(-30);
    [_rightElbow addChild:_bowMiddle];
    
    _bowUp = [WDBaseNode spriteNodeWithTexture:bow];
    _bowUp.anchorPoint = CGPointMake(0.5, 0.2);
    _bowUp.position = CGPointMake(1, 20);
    _bowUp.zPosition = 0;
    _bowUp.zRotation = DEGREES_TO_RADIANS(0);
    _bowUp.defaultAngle = DEGREES_TO_RADIANS(0);
    [_bowMiddle addChild:_bowUp];

    
    _bowDown = [WDBaseNode spriteNodeWithTexture:bow];
    _bowDown.anchorPoint = CGPointMake(0.5, 0.2);
    _bowDown.position = CGPointMake(1, -17);
    _bowDown.zPosition = 0;
    _bowDown.xScale  = -1;
    _bowDown.zRotation = DEGREES_TO_RADIANS(- 180);
    _bowDown.defaultAngle = DEGREES_TO_RADIANS(- 180);
    [_bowMiddle addChild:_bowDown];
    
}


#pragma mark - 一些判断方法 -
/// 停止走或者跑
- (void)pauseWalkOrRun
{
    if (self.state & Sprite_walk) {
        self.state = self.state ^ Sprite_walk;
    }
    
    if (self.state & Sprite_run) {
        self.state = self.state ^ Sprite_run;
    }
    
    [self removeLegAnimation];
    [self removeAllBodyAction];
}

#pragma mark - 释放技能 -
- (void)skill1Action{
    self.skill1 = YES;
}
- (void)skill2Action{
    self.skill2 = YES;
}
- (void)skill3Action{
    self.skill3 = YES;
}
- (void)skill4Action{
    self.skill4 = YES;
}
- (void)skill5Action{
    self.skill5 = YES;
}

#pragma mark - 私有辅助方法 -
- (void)phyWithNode:(WDBaseNode *)node{
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:node.size center:CGPointMake(0, 0)];
    node.physicsBody = body;
    node.physicsBody.affectedByGravity = NO;
    node.physicsBody.allowsRotation = NO;
    node.physicsBody.categoryBitMask = 0;
}
- (WDBaseNode *)textureWithKeyName:(NSString *)name{
    return [WDCalculateTool textureWithKeyName:name];
}


- (void)removeBowAnimation{
    [self.bowUp removeAllActions];
    [self.bowDown removeAllActions];
    self.bowUp.zRotation = self.bowUp.defaultAngle;
    self.bowDown.zRotation = self.bowDown.defaultAngle;
}

- (void)removeAllBodyAction
{
    
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
    
    self.leftArm.zRotation = self.leftArm.defaultAngle;
    self.rightArm.zRotation = self.rightArm.defaultAngle;
    self.bowUp.zRotation = self.bowUp.defaultAngle;
    self.bowDown.zRotation = self.bowDown.defaultAngle;
    self.hip.zRotation = 0;
    self.body.zRotation = 0;
}

- (void)dealloc
{
    //NSLog(@"%@释放了",self.name);
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotificationForUpData object:nil];
}


@end


