//
//  WDTestScene.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import "WDBaseScene.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDTestScene : WDBaseScene<SKPhysicsContactDelegate>
@property (nonatomic,strong)WDBaseNode *rightKnee;
@property (nonatomic,strong)WDBaseNode *rightFoot;

@property (nonatomic,strong)WDBaseNode *leftKnee;
@property (nonatomic,strong)WDBaseNode *leftFoot;
@end

NS_ASSUME_NONNULL_END
