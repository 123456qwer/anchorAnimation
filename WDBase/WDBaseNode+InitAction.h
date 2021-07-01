//
//  WDBaseNode+InitAction.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/24.
//

#import "WDBaseNode.h"

NS_ASSUME_NONNULL_BEGIN
@class WDBaseScene;
@interface WDBaseNode (InitAction)
/// 初始化方法
+ (id)initActionWithName:(NSString *)spriteName
               superNode:(WDBaseScene *)superNode;

@end

NS_ASSUME_NONNULL_END
