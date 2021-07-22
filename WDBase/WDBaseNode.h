//
//  WDBaseNode.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/17.
//

#import <SpriteKit/SpriteKit.h>

#import "WDAttributeManager.h"
#import "WDHateManager.h"
#import "WDTalkNode.h"
#import "WDBalloonNode.h"



NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,EquipType) {
    
    /// 头盔
    Equip_helmet    = 1, /// 0000 0001
    
    /// 衣服
    Equip_armor     = 2,
    
    /// 肩膀
    Equip_pauldrons = 3,
    
    /// 手套
    Equip_gloves    = 4,
    
    /// 腰带
    Equip_belt      = 5,
    
    /// 靴子
    Equip_boots     = 6,
    
    /// 盾牌
    Equip_shield    = 7,
    
    /// 单手武器
    Equip_sword1h    = 8,
    
    /// 双手武器
    Equip_sword2h    = 9,
    
    /// 弓
    Equip_bow    = 10,
    
    /// 眼罩
    Equip_mask    = 11,
    
    /// 眼镜
    Equip_glasses    = 12,
    
};


typedef NS_ENUM(NSInteger,SpriteState) {
    
    /// 默认站立
    Sprite_stand  = 1,        ///0000 0001
   
    /// 行走
    Sprite_walk   = 1 << 1,   ///0000 0010
    
    /// 跑
    Sprite_run    = 1 << 2,   ///0000 0100
    
    /// 攻击
    Sprite_attack = 1 << 3,   ///0000 1000
    
    /// 治疗
    Sprite_cure   = 1 << 4,   ///0001 0000
    
    /// 死亡
    Sprite_dead   = 1 << 5,   ///0010 0000
    
    /// 电影态
    Sprite_movie  = 1 << 6,   ///0100 0000
    
    /// 教学关卡
    Sprite_learn  = 1 << 7,   ///1000 0000
    
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
@class WDBaseModel;
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

/// 弓把手部份
@property (nonatomic,strong)WDBaseNode *bowMiddle;
/// 弓上部
@property (nonatomic,strong)WDBaseNode *bowUp;
/// 弓下部
@property (nonatomic,strong)WDBaseNode *bowDown;
/// 弓箭
@property (nonatomic,strong)SKTexture *arrowTexture;

///默认嘴的纹理
@property (nonatomic,strong)SKTexture *defaultMouthTexture;
///默认眼睛的纹理
@property (nonatomic,strong)SKTexture *defaultEyeTexture;
///默认眉毛的纹理
@property (nonatomic,strong)SKTexture *defaultEyesBrowsTexture;

/// 选中箭头
@property (nonatomic,strong)WDBaseNode *arrowNode;

/// 是否开启跑状态
@property (nonatomic,assign)BOOL isRunState;

/// 默认角度
@property (nonatomic,assign)CGFloat defaultAngle;
/// 攻击模式 根据武器不同而不同
@property (nonatomic,assign)AttackMode mode;
/// 人物状态
@property (nonatomic,assign)SpriteState state;
/// 目标人物
@property (nonatomic,strong)WDBaseNode *_Nullable targetNode;
/// 治愈人物
@property (nonatomic,strong)WDBaseNode *_Nullable cureNode;
/// 血条背景
@property (nonatomic,strong)WDBaseNode *bgBlood;
/// 血条
@property (nonatomic,strong)WDBaseNode *blood;
/// 攻击距离
@property (nonatomic,assign)int attackDistance;
/// 代号
@property (nonatomic,copy)NSString *numberName;
/// 对话框
@property (nonatomic,strong)WDTalkNode *talkNode;
/// 表情
@property (nonatomic,strong)WDBalloonNode *balloonNode;

///腿部走路动画时间
@property (nonatomic,assign)NSTimeInterval walkTime;
///腿部走路的角度
@property (nonatomic,assign)CGFloat legWalkAngle;

/// 近战可以出发攻击的最大距离
@property (nonatomic,assign)int attackMaxSize;

/// 近战可以发出攻击的最小距离
@property (nonatomic,assign)int attackMinSize;

/// 技能是否在释放状态
@property (nonatomic,assign)BOOL skill1;
@property (nonatomic,assign)BOOL skill2;
@property (nonatomic,assign)BOOL skill3;
@property (nonatomic,assign)BOOL skill4;
@property (nonatomic,assign)BOOL skill5;

/**
 
  仇恨系统 仇恨值相当于默认人物的仇恨值 + 攻击造成的伤害
  
 
 */
/// 仇恨系统
@property (nonatomic,assign)int hateNumber;


#pragma mark - 人物属性 -

/// 动画过程中人物走动速度、默认(220)
@property (nonatomic,assign)CGFloat animationWalkSpeed;
/// 动画过程中人物跑动速度 默认(300)
@property (nonatomic,assign)CGFloat animationRunSpeed;
/// 实时调用的移动方法 
@property (nonatomic,assign)CGFloat CADisplaySpeed;

/// 攻击力
@property (nonatomic,assign)int attackNumber;
/// 初始血量
@property (nonatomic,assign)int initBlood;
/// 剩余血量
@property (nonatomic,assign)int lastBlood;
/// 当前治疗量
@property (nonatomic,assign)int cureNumber;
/// 增加的治疗量
@property (nonatomic,assign)int realCureNumber;
/// 方向，默认1是向右，-1向左
@property (nonatomic,assign)int direction;



- (void)setBodyArmor:(NSString *)armorName;
- (void)setHipArmor:(NSString *)armorName;


- (void)setLeftArmArmor:(NSString *)armorName;
- (void)setLeftElbowArmor:(NSString *)armorName;
- (void)setLeftHandArmor:(NSString *)armorName;
- (void)setLeftKneeArmor:(NSString *)armorName;
- (void)setleftFootArmor:(NSString *)armorName;
- (void)setLeftHandArmorReal:(NSString *)armorName;

- (void)setRightArmArmor:(NSString *)armorName;
- (void)setRightElbowArmor:(NSString *)armorName;
- (void)setRightHandArmor:(NSString *)armorName;
- (void)setRightFingerArmor:(NSString *)armorName;
- (void)setRightKneeArmor:(NSString *)armorName;
- (void)setRightFootArmor:(NSString *)armorName;

/// 根据model设置装备
- (void)setArmorWithModel:(WDBaseModel *)model;

- (void)setAllArmor:(NSString *)armorName;
- (WDBaseNode *)textureWithKeyName:(NSString *)name;

/// 设置头发
- (void)setHairTexture:(NSString *)name;
/// 设置嘴巴
- (void)setMouthTexture:(NSString *)name;
/// 设置眉毛
- (void)setEyeBrowsTexture:(NSString *)name;
/// 设置眼睛
- (void)setEyeTexture:(NSString *)name;
/// 设置帽子
- (void)setHemletTexture:(NSString *)name;
/// 设置武器（左）
- (void)setLeftWeapon:(NSString *)weaponName;
/// 设置武器（右）
- (void)setRightWeapon:(NSString *)weaponName;
/// 设置右手盾牌
- (void)setRightShield:(NSString *)shieldName;
/// 设置弓箭
- (void)setBow:(NSString *)bowName;


///实时更新状态
- (void)upDataAction;
///创建裸体人物
- (void)createUserNodeWithScale:(CGFloat)scale;
///设置选中箭头
- (void)setArrowNodeWithPosition:(CGPoint)point
                           scale:(CGFloat)scale;



- (void)skill1Action;
- (void)skill2Action;
- (void)skill3Action;
- (void)skill4Action;
- (void)skill5Action;

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
- (void)beAttackAction:(WDBaseNode *)enemyNode
          attackNumber:(int)attackNumber;
/// 被治疗
- (void)beCureAction:(WDBaseNode *)cureNode;

/// 死亡动画
- (void)deadAction;

/// 仇恨增加
- (void)addHateNumberWithAttackNode:(WDBaseNode *)node;

///创建血条
- (void)createBlood:(CGFloat)scale;
///
- (void)setBloodYPosition:(CGFloat)yPage;


/// 普通选中状态
- (void)selectSpriteAction;

/// 治愈选中状态
- (void)cureSelectSpriteAction;

#pragma mark - 一些判断方法 -
/// 暂停走、跑
- (void)pauseWalkOrRun;

/// 删除所有Body方法
- (void)removeAllBodyAction;

@end









NS_ASSUME_NONNULL_END
