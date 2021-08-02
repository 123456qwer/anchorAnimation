//
//  Boss1Node.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/27.
//

#import "WDEnemyNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface Boss1Node : WDEnemyNode
@property (nonatomic,copy)void (^deadBlock)(void);
@end

NS_ASSUME_NONNULL_END
