//
//  WDRedBatNode.h
//  BattleHeartNew
//
//  Created by Mac on 2020/12/11.
//  Copyright © 2020 Macdddd. All rights reserved.
//

#import "WDEnemyNode.h"
#import "WDRedBatModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDRedBatNode : WDEnemyNode

@property (nonatomic,assign)BOOL isBoss;
@property (nonatomic,strong)WDRedBatModel *model;
@property (nonatomic,assign)CGSize realSize;


+ (instancetype)initWithModel:(WDRedBatModel *)model;

@end

NS_ASSUME_NONNULL_END
