//
//  WDBaseScene+ContactLogic.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/25.
//

#import "WDBaseScene.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDBaseScene (ContactLogic)

- (void)contactLogicAction:(SKPhysicsContact *)contact;

@end

NS_ASSUME_NONNULL_END
