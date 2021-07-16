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
@property (nonatomic,strong)WDUserNode *selectNode;

/// 指示箭头
@property (nonatomic,strong)WDBaseNode *arrowNode;
@property (nonatomic,strong)WDBaseNode *locationNode;
/// 纹理管理器
@property (nonatomic,strong)WDTextureManager *textureManager;

/// 背景
@property (nonatomic,strong)SKSpriteNode *bgNode;
/// 管理怪物
@property (nonatomic,strong)NSMutableArray *monsterArr;
/// 仇恨列表名称
@property (nonatomic,copy)NSArray *hateNameArr;
/// 向下指示手势
@property (nonatomic,strong)SKSpriteNode *clickNode;

#pragma mark - 玩家，根据玩家自己选择的人物初始化 -
@property (nonatomic,strong)WDKknightNode *knight;
@property (nonatomic,strong)WDArcherNode  *archer;
@property (nonatomic,strong)WDPriestNode  *priest;
@property (nonatomic,strong)WDWizardNode  *wizard;


/// 技能
- (void)skill1Action;
- (void)skill2Action;
- (void)skill3Action;
- (void)skill4Action;
- (void)skill5Action;

/// 触碰结束
- (void)touchUpAtPoint:(CGPoint)pos;

#pragma mark - 指示箭头 -
- (void)hiddenArrow;
- (void)arrowMoveActionWithPos:(CGPoint)pos;

@end

NS_ASSUME_NONNULL_END
