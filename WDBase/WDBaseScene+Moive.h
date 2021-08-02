//
//  WDBaseScene+Moive.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/30.
//

#import "WDBaseScene.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDBaseScene (Moive)

- (void)bossDeadActionMovie;
- (void)moveActionForClick:(void (^)(void))completeBlock;

@end

NS_ASSUME_NONNULL_END
