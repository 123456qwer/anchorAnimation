//
//  WDBaseScene.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import <SpriteKit/SpriteKit.h>
#import "WDBaseNode+InitAction.h"
#import "WDEnemyNode.h"

#import "WDKknightNode.h"
#import "WDArcherNode.h"
#import "WDPriestNode.h"
#import "WDWizardNode.h"

NS_ASSUME_NONNULL_BEGIN
@interface WDBaseScene : SKScene<SKPhysicsContactDelegate>



/// 选中的线
@property (nonatomic,strong)WDBaseNode *selectLine;

/// 选中的人物
@property (nonatomic,strong)WDBaseNode *selectNode;

/// 指示箭头
@property (nonatomic,strong)WDBaseNode *arrowNode;
@property (nonatomic,strong)WDBaseNode *locationNode;
/// 纹理管理器
@property (nonatomic,strong)WDTextureManager *textureManager;

/// 对话框
@property (nonatomic,strong)SKSpriteNode *speakBgNode;
/// 文字
@property (nonatomic,strong)SKLabelNode *speakLabelNode;

/// 确认
@property (nonatomic,strong)SKSpriteNode *confirmNode;
/// 否定
@property (nonatomic,strong)SKSpriteNode *cancelNode;

/// 管理怪物
@property (nonatomic,strong)NSMutableArray *monsterArr;
/// 仇恨列表名称
@property (nonatomic,copy)NSArray *hateNameArr;
/// 向下指示手势
@property (nonatomic,strong)SKSpriteNode *clickNode;
/// 左右指示手势
@property (nonatomic,strong)SKSpriteNode *leftOrRightNode;

/// 聊天自动切换
@property (nonatomic,copy)void (^talkCompleteBlock)(void);

/// 展示装备栏
@property (nonatomic,copy)void (^presentEquipBlock)(NSString *userName);

/// 切换场景
@property (nonatomic,copy)void (^changeSceneBlock)(NSString *sceneName);

#pragma mark - 玩家，根据玩家自己选择的人物初始化 -
@property (nonatomic,strong)WDKknightNode *knight;
@property (nonatomic,strong)WDArcherNode  *archer;
@property (nonatomic,strong)WDPriestNode  *priest;
@property (nonatomic,strong)WDWizardNode  *wizard;

/// 玩家给自己设置的名字
@property (nonatomic,copy)NSString *userName;
/// 技能
- (void)skill1Action;
- (void)skill2Action;
- (void)skill3Action;
- (void)skill4Action;
- (void)skill5Action;

/// 触碰结束
- (void)touchUpAtPoint:(CGPoint)pos;

/// 显示装备栏
- (void)presentEquipScene;

#pragma mark - 切换场景 -
- (void)changeSceneWithName:(NSString *)sceneName;

#pragma mark - 对话相关 -
/// 显示对话栏
- (void)setTextAction:(NSString *)text;
/// 自动隐藏
- (void)setTextAction:(NSString *)text
           hiddenTime:(NSInteger)time
        completeBlock:(void (^)(void))completeBlock;

- (void)stopTalk;

/// 目标转化
- (void)changeSelectNode:(WDBaseNode *)node;

/// 转换目标朝向
- (void)changeSelectNodeDirection:(NSInteger)direction
                             node:(WDBaseNode *)node;

/// 设置点击
- (void)setClickNodePositionWithNode:(WDBaseNode *)node;

/// 展示确定、取消按钮
- (void)showConfirmNodes;
/// 隐藏确定、取消按钮
- (void)hiddenConfirmNodes;

#pragma mark - 指示箭头 -
- (void)hiddenArrow;
- (void)arrowMoveActionWithPos:(CGPoint)pos;

@end

NS_ASSUME_NONNULL_END
