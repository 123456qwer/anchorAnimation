//
//  WDNotificationManager.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/28.
//

#import <Foundation/Foundation.h>
#import "WDBaseNode.h"
NS_ASSUME_NONNULL_BEGIN

@interface WDNotificationManager : NSObject


/// 治疗等增加仇恨
+ (void)addHateWithNode:(WDBaseNode *)node;


/// 换装
+ (void)changeEquip:(NSDictionary *)equipDic;


@end

NS_ASSUME_NONNULL_END
