//
//  WDNotificationManager.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/28.
//

#import "WDNotificationManager.h"

@implementation WDNotificationManager

+ (void)addHateWithNode:(WDBaseNode *)node{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForAddHateNumber object:node userInfo:nil];
}

+ (void)changeEquip:(NSDictionary *)equipDic{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForChangeEquip object:equipDic userInfo:nil];
}


@end
