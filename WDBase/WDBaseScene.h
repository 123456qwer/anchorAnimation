//
//  WDBaseScene.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDBaseScene : SKScene<SKPhysicsContactDelegate>

/// 选中的线
@property (nonatomic,strong)WDBaseNode *selectLine;

/// 选中的人物
@property (nonatomic,strong)WDUserNode *selectNode;


/// 背景
@property (nonatomic,strong)SKSpriteNode *bgNode;

@end

NS_ASSUME_NONNULL_END
