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

+ (void)changeUser:(NSString *)userName{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForChangeUser object:userName userInfo:nil];
}

/// 是否隐藏技能框(1不隐藏，0隐藏)
+ (void)hiddenSkillView:(NSInteger)index{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForHiddenSkill object:@(index)];

}

@end
