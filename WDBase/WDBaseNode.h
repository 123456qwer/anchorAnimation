//
//  WDBaseNode.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/17.
//

#import <SpriteKit/SpriteKit.h>
#import "WDAttributeManager.h"

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

@class WDEnemyNode;
@class WDUserNode;
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
@property (nonatomic,strong)WDBaseNode *hemlet;
@property (nonatomic,strong)WDBaseNode *shield;
@property (nonatomic,strong)WDBaseNode *shadow;

/// 是否开启跑状态
@property (nonatomic,assign)BOOL isRunState;

/// 默认角度
@property (nonatomic,assign)CGFloat defaultAngle;
/// 攻击模式 根据武器不同而不同
@property (nonatomic,assign)AttackMode mode;
/// 人物状态
@property (nonatomic,assign)SpriteState state;
/// 目标人物
@property (nonatomic,strong)WDEnemyNode *targetNode;

///腿部走路动画时间
@property (nonatomic,assign)NSTimeInterval walkTime;
///腿部走路的角度
@property (nonatomic,assign)CGFloat legWalkAngle;


#pragma mark - 人物属性 -

/// 动画过程中人物走动速度、默认(220)
@property (nonatomic,assign)CGFloat animationWalkSpeed;
/// 动画过程中人物跑动速度 默认(300)
@property (nonatomic,assign)CGFloat animationRunSpeed;


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
/// 设置右手盾牌
- (void)setRightShield:(NSString *)shieldName;


///实时更新状态
- (void)upDataAction;
///创建裸体人物
- (void)createUserNodeWithScale:(CGFloat)scale;


#pragma mark - 人物行为方法 -
/// 移动方法统一调用，根据状态判断是跑是走
- (void)moveAction:(CGPoint)movePoint;

/// 走动的方法
- (void)walkAction:(CGPoint)movePoint;

/// 跑的方法
- (void)wdRunAction:(CGPoint)movePoint;

/// 站住的动作，停止腿部运动
- (void)standAction;

/// 攻击
- (void)attackAction:(WDBaseNode *)enemyNode;

/// 被攻击
- (void)beAttackAction:(WDBaseNode *)enemyNode;



@end




/// 玩家人物
@interface WDUserNode : WDBaseNode
@end


/// 敌对人物
@interface WDEnemyNode : WDBaseNode
@end


NS_ASSUME_NONNULL_END
