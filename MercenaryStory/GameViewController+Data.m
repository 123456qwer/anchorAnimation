//
//  GameViewController+Data.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/21.
//

#import "GameViewController+Data.h"

@implementation GameViewController (Data)

#pragma mark - 第一次进入游戏，初始化一下数据，只调用一次 -
- (void)initDataAction{
    
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:kIsFirstLogin]){
        return;
    }
    
    [self initUserSkill];
    
    WDDataManager *manager = [WDDataManager shareManager];
    
    [self knightData:manager];
    [self priestData:manager];
    [self archerData:manager];
    
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsFirstLogin];
}

/// 初始化起始技能
- (void)initUserSkill{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *key1 = [NSString stringWithFormat:@"%@_0",kKinght];
    NSString *key2 = [NSString stringWithFormat:@"%@_0",kArcher];
    NSString *key3 = [NSString stringWithFormat:@"%@_0",kPriest];
    NSString *key4 = [NSString stringWithFormat:@"%@_0",kWizard];
    
    [defaults setBool:YES forKey:key1];
    [defaults setBool:YES forKey:key2];
    [defaults setBool:YES forKey:key3];
    [defaults setBool:YES forKey:key4];
}

#pragma mark - 初始化骑士装备 -
- (void)knightData:(WDDataManager *)manager{
    
    /// 初始化骑士自身穿戴的装备
    [manager openDBwithName:kKinght];
    [manager insterData:0 name:@[@"n",@"n",@"n",@"n",@"n",@"n",@"n",@"FamilySword",@"n",@"n",@"n",@"n"] userName:kKinght];
    
    /// 初始化骑士拥有的装备
    NSString *allArmor = [NSString stringWithFormat:@"%@_user",kKinght];
    [manager openDBwithName:allArmor];
    [manager insterData:0 name:@[@"n",@"n",@"n",@"n",@"n",@"n",@"n",@"FamilySword",@"n",@"n",@"n",@"n"] userName:allArmor];
}


#pragma mark - 初始化牧师装备 -
- (void)priestData:(WDDataManager *)manager{
    
    /// 初始化牧师自身穿戴的装备
    [manager openDBwithName:kPriest];
    [manager insterData:0 name:@[@"PriestHelm",@"PriestArmor",@"PriestArmor",@"PriestArmor",@"PriestArmor",@"PriestArmor",@"n",@"ClericWand1",@"n",@"n",@"n",@"n"] userName:kPriest];
    
    /// 初始化牧师拥有的装备
    NSString *allArmor = [NSString stringWithFormat:@"%@_user",kPriest];
    [manager openDBwithName:allArmor];
    [manager insterData:0 name:@[@"PriestHelm",@"PriestArmor",@"PriestArmor",@"PriestArmor",@"PriestArmor",@"PriestArmor",@"n",@"ClericWand1",@"n",@"n",@"n",@"n"] userName:allArmor];
}

#pragma mark - 初始化弓箭手装备 -
- (void)archerData:(WDDataManager *)manager{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger skill1 = [defaults integerForKey:kArcher_skill_1];
    if (skill1 == 0) {
        [defaults setInteger:10 forKey:kArcher_skill_1];
    }
    NSInteger skill2 = [defaults integerForKey:kArcher_skill_2];
    if (skill2 == 0) {
        [defaults setInteger:8 forKey:kArcher_skill_2];
    }
    NSInteger skill3 = [defaults integerForKey:kArcher_skill_3];
    if (skill3 == 0) {
        [defaults setInteger:5 forKey:kArcher_skill_3];
    }
    
    NSInteger skill4 = [defaults integerForKey:kArcher_skill_4];
    if (skill4 == 0) {
        [defaults setInteger:5 forKey:kArcher_skill_4];
    }
    
    /// 初始化弓箭手自身穿戴的装备
    [manager openDBwithName:kArcher];
    [manager insterData:0 name:@[@"BowmanHelm",@"ArcherArmor",@"ArcherArmor",@"ArcherArmor",@"ArcherArmor",@"ArcherArmor",@"n",@"n",@"n",@"FamilyBow",@"n",@"n"] userName:kArcher];
    
    /// 初始化牧师拥有的装备
    NSString *allArmor = [NSString stringWithFormat:@"%@_user",kArcher];
    [manager openDBwithName:allArmor];
    [manager insterData:0 name:@[@"BowmanHelm",@"ArcherArmor",@"ArcherArmor",@"ArcherArmor",@"ArcherArmor",@"ArcherArmor",@"n",@"n",@"n",@"FamilyBow",@"n",@"n"] userName:allArmor];
}

@end
