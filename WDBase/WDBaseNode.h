//
//  WDBaseNode.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/17.
//

#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,SpriteState) {
    
    /// 默认站立
    Sprite_stand  = 1,        ///0000 0000
   
    /// 行走
    Sprite_walk   = 1 << 1,   ///0000 0001
    
    /// 跑
    Sprite_run    = 1 << 2,   ///0000 0010
    
    /// 攻击
    Sprite_attack = 1 << 3,   ///0000 0100
    
    
};

typedef NS_ENUM(NSInteger,AttackMode) {
    
    /// 单手武器
    Attack_singleHand = 0,       /// 0000 0000
    
    /// 双手武器
    Attack_twoHand    = 1 << 0,  /// 0000 0001
    
    /// 弓
    Attack_bow        = 1 << 1,  /// 0000 0010
    
    
};


@interface WDBaseNode : SKSpriteNode

@property (nonatomic,strong)WDBaseNode *body;
@property (nonatomic,strong)WDBaseNode *leftArm;
@property (nonatomic,strong)WDBaseNode *leftElbow;
@property (nonatomic,strong)WDBaseNode *leftHand;
@property (nonatomic,strong)WDBaseNode *rightArm;
@property (nonatomic,strong)WDBaseNode *rightElbow;
@property (nonatomic,strong)WDBaseNode *rightHand;
@property (nonatomic,strong)WDBaseNode *rightFinger;
@property (nonatomic,strong)WDBaseNode *hip;
@property (nonatomic,strong)WDBaseNode *rightKnee;
@property (nonatomic,strong)WDBaseNode *rightFoot;
@property (nonatomic,strong)WDBaseNode *leftKnee;
@property (nonatomic,strong)WDBaseNode *leftFoot;
@property (nonatomic,strong)WDBaseNode *head;
@property (nonatomic,strong)WDBaseNode *eye;
@property (nonatomic,strong)WDBaseNode *eyeBrows;
@property (nonatomic,strong)WDBaseNode *ear;
@property (nonatomic,strong)WDBaseNode *mouth;
@property (nonatomic,strong)WDBaseNode *hair;




/// 默认角度
@property (nonatomic,assign)CGFloat defaultAngle;
/// 攻击模式 根据武器不同而不同
@property (nonatomic,assign)AttackMode mode;
/// 人物状态
@property (nonatomic,assign)SpriteState state;

@property (nonatomic,assign)NSTimeInterval walkTime;

- (void)setBodyArmor:(NSString *)armorName;
- (void)setHipArmor:(NSString *)armorName;


- (void)setLeftArmArmor:(NSString *)armorName;
- (void)setLeftElbowArmor:(NSString *)armorName;
- (void)setLeftHandArmor:(NSString *)armorName;
- (void)setLeftKneeArmor:(NSString *)armorName;
- (void)setleftFootArmor:(NSString *)armorName;


- (void)setRightArmArmor:(NSString *)armorName;
- (void)setRightElbowArmor:(NSString *)armorName;
- (void)setRightHandArmor:(NSString *)armorName;
- (void)setRightFingerArmor:(NSString *)armorName;
- (void)setRightKneeArmor:(NSString *)armorName;
- (void)setRightFootArmor:(NSString *)armorName;

- (void)setAllArmor:(NSString *)armorName;


/// 设置武器（左）
- (void)setLeftWeapon:(NSString *)weaponName;
/// 设置武器（右）
- (void)setRightWeapon:(NSString *)weaponName;


///创建裸体人物
- (void)createUserNodeWithScale:(CGFloat)scale;


#pragma mark - 人物行为方法 -
/// 走动的方法
- (void)walkAction;

/// 站住的动作，停止腿部运动
- (void)standAction;

/// 攻击
- (void)attackAction;


@end

NS_ASSUME_NONNULL_END
