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
    
    WDDataManager *manager = [WDDataManager shareManager];
    
    [self knightData:manager];
    [self priestData:manager];
    
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsFirstLogin];
}

#pragma mark - 初始化骑士装备 -
- (void)knightData:(WDDataManager *)manager{
    
    /// 初始化骑士自身穿戴的装备
    [manager openDBwithName:kKinght];
    [manager insterData:0 name:@[@"n",@"n",@"n",@"n",@"n",@"n",@"n",@"FamilySword",@"n",@"n",@"n",@"n"] userName:kKinght];
    
    /// 初始化骑士拥有的装备
    NSString *kinghtAllArmor = [NSString stringWithFormat:@"%@_user",kKinght];
    [manager openDBwithName:kinghtAllArmor];
    [manager insterData:0 name:@[@"n",@"n",@"n",@"n",@"n",@"n",@"n",@"FamilySword,FamilySword",@"n",@"n",@"n",@"n"] userName:kinghtAllArmor];
}


#pragma mark - 初始化牧师装备 -
- (void)priestData:(WDDataManager *)manager{
    
    /// 初始化牧师自身穿戴的装备
    [manager openDBwithName:kPriest];
    [manager insterData:0 name:@[@"PriestHelm",@"PriestArmor",@"PriestArmor",@"PriestArmor",@"PriestArmor",@"PriestArmor",@"n",@"ClericWand1",@"n",@"n",@"n",@"n"] userName:kPriest];
    
    /// 初始化牧师拥有的装备
    NSString *priestAllArmor = [NSString stringWithFormat:@"%@_user",kPriest];
    [manager openDBwithName:priestAllArmor];
    [manager insterData:0 name:@[@"PriestHelm",@"PriestArmor",@"PriestArmor",@"PriestArmor",@"PriestArmor",@"PriestArmor",@"n",@"ClericWand1",@"n",@"n",@"n",@"n"] userName:priestAllArmor];
}

@end
