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
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:kIsHaveName]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeName) name:kNotificationForChangeName object:nil];
    }
    
    
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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger skill2 = [defaults integerForKey:kKinght_skill_2];
    if (skill2 == 0) {
        [defaults setInteger:10 forKey:kKinght_skill_2];
    }
    
    NSInteger skill3 = [defaults integerForKey:kKinght_skill_3];
    if (skill3 == 0) {
        [defaults setInteger:10 forKey:kKinght_skill_3];
    }
    
    NSInteger skill4 = [defaults integerForKey:kKinght_skill_4];
    if (skill4 == 0) {
        [defaults setInteger:10 forKey:kKinght_skill_4];
    }
    
    NSInteger skill5 = [defaults integerForKey:kKinght_skill_5];
    if (skill5 == 0) {
        [defaults setInteger:60 forKey:kKinght_skill_5];
    }
    
    /// 初始化骑士自身穿戴的装备
    [manager openDBwithName:kKinght];
    [manager insterData:0 name:@[@"n",@"n",@"n",@"n",@"n",@"n",@"n",@"FamilySword_3",@"n",@"n",@"n",@"n"] userName:kKinght];
    
    /// 初始化骑士拥有的装备
    NSString *allArmor = [NSString stringWithFormat:@"%@_user",kKinght];
    [manager openDBwithName:allArmor];
    [manager insterData:0 name:@[@"n",@"n",@"n",@"n",@"n",@"n",@"n",@"FamilySword_3",@"n",@"n",@"n",@"n"] userName:allArmor];
}


#pragma mark - 初始化牧师装备 -
- (void)priestData:(WDDataManager *)manager{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger skill1 = [defaults integerForKey:kPriest_skill_1];
    if (skill1 == 0) {
        [defaults setInteger:10 forKey:kPriest_skill_1];
    }
    
    NSInteger skill3 = [defaults integerForKey:kPriest_skill_3];
    if (skill3 == 0) {
        [defaults setInteger:10 forKey:kPriest_skill_3];
    }
    
    NSInteger skill4 = [defaults integerForKey:kPriest_skill_4];
    if (skill4 == 0) {
        [defaults setInteger:5 forKey:kPriest_skill_4];
    }
    
    /// 初始化牧师自身穿戴的装备
    [manager openDBwithName:kPriest];
    [manager insterData:0 name:@[@"PriestHelm_1",@"PriestArmor_1",@"PriestArmor_1",@"PriestArmor_1",@"PriestArmor_1",@"PriestArmor_1",@"n",@"ClericWand1_5",@"n",@"n",@"n",@"n"] userName:kPriest];
    
    /// 初始化牧师拥有的装备
    NSString *allArmor = [NSString stringWithFormat:@"%@_user",kPriest];
    [manager openDBwithName:allArmor];
    [manager insterData:0 name:@[@"PriestHelm_1",@"PriestArmor_1",@"PriestArmor_1",@"PriestArmor_1",@"PriestArmor_1",@"PriestArmor_1",@"n",@"ClericWand1_5",@"n",@"n",@"n",@"n"] userName:allArmor];
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
    [manager insterData:0 name:@[@"BowmanHelm_1",@"ArcherArmor_2",@"ArcherArmor_2",@"ArcherArmor_2",@"ArcherArmor_2",@"ArcherArmor_2",@"n",@"n",@"n",@"FamilyBow_5",@"n",@"n"] userName:kArcher];
    
    /// 初始化牧师拥有的装备
    NSString *allArmor = [NSString stringWithFormat:@"%@_user",kArcher];
    [manager openDBwithName:allArmor];
    [manager insterData:0 name:@[@"BowmanHelm_1",@"ArcherArmor_2",@"ArcherArmor_2",@"ArcherArmor_2",@"ArcherArmor_2",@"ArcherArmor_2",@"n",@"n",@"n",@"FamilyBow_5",@"n",@"n"] userName:allArmor];
}



#pragma mark - 设置自己的名字 -
- (void)changeName{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake((kScreenWidth - kScreenWidth / 2.0) / 2.0, 30, kScreenWidth / 2.0, 50)];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 50 / 2.0;
    textField.tag = 1234567;
    [self.view addSubview:textField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification   object:nil];
    
    [textField becomeFirstResponder];
    
   
    
}

- (void)keyboardWillShow:(NSNotification *)aNotification{
    //获取键盘的高度
     NSDictionary *userInfo = [aNotification userInfo];
     NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
     CGRect keyboardRect = [aValue CGRectValue];
     int height = keyboardRect.size.height;   //height 就是键盘的高度
     
        
    UITextField *t = (UITextField *)[self.view viewWithTag:1234567];
    t.frame = CGRectMake(t.origin.x, height - 50 - 100, t.size.width, 50);
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:3211];
    if (!btn) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0 - 44 / 2.0 , t.bottom + 20, 44, 44)];
        [btn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"confirm"] forState:UIControlStateNormal];
        btn.tag = 3211;
        [self.view addSubview:btn];
    }
    
    
    
}

- (void)confirmAction:(UIButton *)sender
{
    UITextField *t = (UITextField *)[self.view viewWithTag:1234567];
    if (t.text.length == 0) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"请输入姓名~" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:vc animated:YES completion:^{
                    
        }];
        [self dismiss:vc];
        
    }else if(t.text.length < 2){
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"名字太短了~" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:vc animated:YES completion:^{
                    
        }];
        [self dismiss:vc];
        
    }else if(t.text.length > 6){
        
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"名字太长了~" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:vc animated:YES completion:^{
                    
        }];
        [self dismiss:vc];
        
    }else{
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:kIsHaveName];
        [[NSUserDefaults  standardUserDefaults]setObject:t.text forKey:kUserName];
        [t resignFirstResponder];
        [t removeFromSuperview];
        UIButton *btn = (UIButton *)[self.view viewWithTag:3211];
        [btn removeFromSuperview];
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForChangeNameAlready object:nil];
    }
}



- (void)dismiss:(UIAlertController *)vc{
    __weak typeof(self)weakSelf = self;
    [vc dismissViewControllerAnimated:YES completion:^{
        UITextField *t = (UITextField *)[weakSelf.view viewWithTag:1234567];
        [t becomeFirstResponder];
    }];
}



@end
