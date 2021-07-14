//
//  WDBaseScene.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import <SpriteKit/SpriteKit.h>
#import "WDBaseNode+InitAction.h"
#import "WDEnemyNode.h"

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

#pragma mark - 移动结束，隐藏指示箭头 -
- (void)hiddenArrow;

@end

NS_ASSUME_NONNULL_END
