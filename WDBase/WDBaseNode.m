//
//  WDBaseNode.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/17.
//

#import "WDBaseNode.h"
#import "WDBaseNode+Animation.h"
@implementation WDBaseNode
{
    WDBaseNode *_head;
    WDBaseNode *_eye;
    WDBaseNode *_eyeBrows;
    WDBaseNode *_ear;
    WDBaseNode *_mouth;
    WDBaseNode *_body;
    WDBaseNode *_hair;
    
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
}

- (void)createUserNodeWithScale:(CGFloat)scale{
    
    _walkTime = 0.3;
    
    //身体部位
    _body = [self textureWithKeyName:kBody];
    _body.zPosition      = 100;
    _body.position       = CGPointMake(0, -35 * scale);
    _body.anchorPoint    = CGPointMake(0.5, 0.3);
    _body.xScale = scale;
    _body.yScale = scale;
    [self addChild:_body];
    
    /// 创建投
    [self createHead];
   
    //胯部
    [self createHip];
    
    ///左胳膊
    [self createLeftArmssss];
    
    ///右胳膊
    [self createRightArmssss];
    
    ///脚和腿
    [self createKneeAndFoot];


//    [self walkAction];
//    [self upBodyAction];
}

///创建脑袋
- (void)createHead{
    
    //头
    _head = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"Head"]]];
    _head.xScale = 0.9;
    _head.yScale = 0.9;
    _head.zPosition = 101;
    _head.position = CGPointMake(-3, 72);
    [_body addChild:_head];
    
    
    //眼睛
    _eye = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"Eye_Male"]]];
    _eye.zPosition = 1;
    [_head addChild:_eye];
    
    //眉毛
    _eyeBrows = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"EyeBrows_Eyebrows"]]];
    _eyeBrows.zPosition = 1;
    [_head addChild:_eyeBrows];
    
    //嘴
    _mouth = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"Mouth_Normal"]]];
    _mouth.zPosition = 1;
    [_head addChild:_mouth];
    
//    //头发
    _hair = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"Hair6"]]];
    _hair.zPosition = 5;
    [_head addChild:_hair];
    
    _ear = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"Ears_HumanEar"]]];
    _ear.zPosition = 1;
    [_head addChild:_ear];
}

///创建胯部
- (void)createHip{
    
    _hip = [self textureWithKeyName:kHip];
    _hip.anchorPoint = CGPointMake(0.5, 0.5);
    _hip.position = CGPointMake(0, 7);
    _hip.zPosition = 110;
    [_body addChild:_hip];
}

///创建右侧胳膊、胳膊肘、右手、右手指
- (void)createRightArmssss{
    //右胳膊
    _rightArm = [self textureWithKeyName:kRightArm];
    _rightArm.anchorPoint = CGPointMake(0.43,0.6);
    _rightArm.position = CGPointMake(17, 65);
    _rightArm.zRotation = DEGREES_TO_RADIANS(-16);
    _rightArm.zPosition = -1;
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
    _rightHand.zPosition = 0;
    [_rightElbow addChild:_rightHand];

    //右手指
    _rightFinger = [self textureWithKeyName:kRightFinger];
    _rightFinger.anchorPoint = CGPointMake(0.5, 0.5);
    _rightFinger.zRotation = DEGREES_TO_RADIANS(-30);
    _rightFinger.position = CGPointMake(28, -3);
    _rightFinger.zPosition = 0;
    [_rightElbow addChild:_rightFinger];
    
    
    _rightArm.defaultAngle = DEGREES_TO_RADIANS(-16);

}

///创建左侧胳膊、胳膊肘、左手
- (void)createLeftArmssss{
    
    //左胳膊
    _leftArm = [self textureWithKeyName:kLeftArm];
    _leftArm.anchorPoint = CGPointMake(0.6,0.55);
    _leftArm.position    = CGPointMake(-36.5, 57);
    _leftArm.zPosition   = 120;
    [_body addChild:_leftArm];

    //左胳膊肘
    _leftElbow = [self textureWithKeyName:kLeftElbow];
    _leftElbow.anchorPoint = CGPointMake(0.5 ,0.6 );
    _leftElbow.position = CGPointMake(-26.5,-19.5);
    _leftElbow.zPosition = 121;
    [_leftArm addChild:_leftElbow];

    //左手
    _leftHand = [self textureWithKeyName:kLeftHand];
    _leftHand.anchorPoint = CGPointMake(0.5, 0.5 );
    _leftHand.position = CGPointMake(0,-25);
    _leftHand.zPosition = 122;
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
    _rightKnee.zPosition = 0;
    [_hip addChild:_rightKnee];
    
    //右脚
    _rightFoot = [self textureWithKeyName:kFoot];
    _rightFoot.anchorPoint = CGPointMake(0.5 , 0.65 );
    _rightFoot.position = CGPointMake(0, -23);
    _rightFoot.zPosition = 0;
    [_rightKnee addChild:_rightFoot];
    
    //左膝盖
    _leftKnee = [self textureWithKeyName:kKnee];
    _leftKnee.xScale = - fabs(_leftKnee.xScale);
    _leftKnee.anchorPoint = CGPointMake(0.5 , 0.55);
    _leftKnee.position = CGPointMake(-19, -5);
    _leftKnee.zPosition = 0;
    [_hip addChild:_leftKnee];
    
    //左脚
    _leftFoot = [self textureWithKeyName:kFoot];
    _leftFoot.xScale = - fabs(_leftFoot.xScale);
    _leftFoot.anchorPoint = CGPointMake(0.5 , 0.65 );
    _leftFoot.position = CGPointMake(0, -23);
    _leftFoot.zPosition = 0;
    [_leftKnee addChild:_leftFoot];
    
    _leftKnee.defaultAngle = DEGREES_TO_RADIANS(-5);
    _leftKnee.zRotation = DEGREES_TO_RADIANS(-5);
}


#pragma mark - 行为 -
/// 行走，不能同时调用，会有问题
- (void)walkAction{
    
    //跑和走、站立不能同时
    if (self.state & Sprite_run) {
        self.state = self.state ^ Sprite_run;
    }
        
    if (self.state & Sprite_stand) {
        self.state = self.state ^ Sprite_stand;
    }
    
    self.state = self.state | Sprite_walk;
    
    [self performSelector:@selector(rightLegWalkAction) withObject:nil afterDelay:_walkTime / 2];
    [self leftLegWalkAction];
    [self upBodyAction];
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
    
    [_leftKnee removeActionForKey:KAnimationFootMove];
    [_leftFoot removeActionForKey:KAnimationFootMove];
    [_rightKnee removeActionForKey:KAnimationFootMove];
    [_rightFoot removeActionForKey:KAnimationFootMove];
    
    _rightKnee.zRotation = _rightKnee.defaultAngle;
    _rightFoot.zRotation = _rightFoot.defaultAngle;
    
    _leftKnee.zRotation = _leftKnee.defaultAngle;
    _leftFoot.zRotation = _leftFoot.defaultAngle;
    
    [self upBodyAction];
}

/// 攻击
- (void)attackAction{
    
    switch (self.mode) {
        case Attack_singleHand:
        {
            [self singleAttackAction];
        }
            break;
        case Attack_twoHand:
        {
            
        }
            break;
        case Attack_bow:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}








#pragma mark - 穿盔甲、武器 -
- (void)createSrpiteWithSuperNode:(WDBaseNode *)superNode
                        armorName:(NSString *)armorName{
    WDBaseNode *armorNode = [WDBaseNode spriteNodeWithTexture:[WDCalculateTool textureWithArmorKeyName:superNode.name armorName:armorName]];
    armorNode.anchorPoint = superNode.anchorPoint;
    [superNode addChild:armorNode];
    armorNode.zPosition = 0;
}

- (void)setAllArmor:(NSString *)armorName{
    [self setBodyArmor:@"Armor2"];
    [self setHipArmor:@"Armor2"];

    [self setleftFootArmor:@"Armor2"];
    [self setLeftKneeArmor:@"Armor2"];
    [self setLeftElbowArmor:@"Armor2"];
    [self setLeftArmArmor:@"Armor2"];
    [self setLeftHandArmor:@"Armor2"];
    
    
    [self setRightArmArmor:@"Armor2"];
    [self setRightElbowArmor:@"Armor2"];
    [self setRightHandArmor:@"Armor2"];
    [self setRightFingerArmor:@"Armor2"];
    [self setRightKneeArmor:@"Armor2"];
    [self setRightFootArmor:@"Armor2"];
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
- (void)setHipArmor:(NSString *)armorName{
    [self createSrpiteWithSuperNode:_hip armorName:armorName];
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

- (void)setLeftWeapon:(NSString *)weaponName{
    
    //左手武器
    _leftWeapon = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:weaponName]]];
    _leftWeapon.anchorPoint = _leftHand.anchorPoint;
    _leftWeapon.position = CGPointMake(0, -1);
    _leftWeapon.zPosition = -1;
    _leftWeapon.zRotation = DEGREES_TO_RADIANS(-130);
    [_leftHand addChild:_leftWeapon];
}
- (void)setRightWeapon:(NSString *)weaponName{
    
    //右手武器
    _rightWeapon = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:weaponName]]];
    _rightWeapon.anchorPoint = CGPointMake(0.5, 0.5);
    _rightWeapon.position = CGPointMake(28, -15);
    _rightWeapon.zPosition = 0;
    _rightWeapon.zRotation = DEGREES_TO_RADIANS(-30);
    [_rightElbow addChild:_rightWeapon];
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




@end
