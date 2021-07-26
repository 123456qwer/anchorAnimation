//
//  WDBoss1Node.h
//  BattleHeartNew
//
//  Created by Mac on 2021/3/10.
//  Copyright © 2021 Macdddd. All rights reserved.
//

#import "WDEnemyNode.h"
#import "Boss1Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDBoss1Node : WDEnemyNode
@property (nonatomic,strong)Boss1Model *boss1Model;
@property (nonatomic,strong)WDBaseNode *clickNode;
@property (nonatomic,assign)BOOL isMoveAnimation;
@property (nonatomic,assign)CGSize realSize;

@property (nonatomic,copy)void (^completeBlock)(BOOL isComplete);
+ (instancetype)initWithModel:(Boss1Model *)model;
- (void)moveToTheMap:(void (^)(BOOL isComplete))complete;
- (void)endAction:(void (^)(BOOL isComplete))complete;
@end

NS_ASSUME_NONNULL_END
