//
//  WDEquipScene.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/19.
//

#import "WDEquipScene.h"

@implementation WDEquipScene

- (void)didMoveToView:(SKView *)view{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeEquip:) name:kNotificationForChangeEquip object:nil];
}

- (void)changeSelectNodeWithName:(NSString *)name{
    
    if ([name isEqualToString:kArcher]) {
        self.selectNode = self.archer;
    }else if([name isEqualToString:kKinght]){
        self.selectNode = self.knight;
    }else if([name isEqualToString:kPriest]){
        self.selectNode = self.priest;
    }else if([name isEqualToString:kWizard]){
        self.selectNode = self.wizard;
    }
    
    self.selectNode.position = CGPointMake(-self.size.width / 2.0 / 2.0, 0);
    self.selectNode.xScale = 2.0;
    self.selectNode.yScale = 2.0;
    
}

/// 换装通知
- (void)changeEquip:(NSNotification *)notification{

    NSDictionary *dic = notification.object;
   
    WDDataManager *manager = [WDDataManager shareManager];
    NSString *user = manager.userName;
    
    WDBaseModel *model = [manager searchData:user];
    
    if ([dic[dic.allKeys[0]] isKindOfClass:[NSString class]]) {
        /// 这个是盔甲类
        NSString *armor = dic.allKeys[0];
        NSString *name = dic[armor];
        if ([name isEqualToString:kBody]) {
            
            model.Equip_armor = armor;
            [self.selectNode setBodyArmor:armor];
            
        }else if([name isEqualToString:kLeftArm]){
            
            model.Equip_pauldrons = armor;
            
            [self.selectNode setLeftElbowArmor:armor];
            [self.selectNode setLeftArmArmor:armor];
            [self.selectNode setRightArmArmor:armor];
            [self.selectNode setLeftArmArmor:armor];
            
        }else if([name isEqualToString:kLeftHandAro]){
            
            model.Equip_gloves = armor;
            
            [self.selectNode setRightElbowArmor:armor];
            [self.selectNode setLeftHandArmor:armor];
            [self.selectNode setRightHandArmor:armor];
            [self.selectNode setRightFingerArmor:armor];
            [self.selectNode setLeftHandArmorReal:armor];

            
        }else if([name isEqualToString:kFoot]){
            
            model.Equip_boots = armor;
            
            [self.selectNode setleftFootArmor:armor];
            [self.selectNode setLeftKneeArmor:armor];
            [self.selectNode setRightKneeArmor:armor];
            [self.selectNode setRightFootArmor:armor];
            
        }else if([name isEqualToString:kHip]){
            
            model.Equip_belt = armor;
            
            [self.selectNode setHipArmor:armor];
        }
        
        
    }else{
        
        NSString *armor = dic.allKeys[0];
        int value = [dic[armor]intValue];
        
        if(value == Equip_helmet){
            
            model.Equip_helmet = armor;
            /// 这个是武器头盔
            [self.selectNode setHemletTexture:armor];
        }else if(value == Equip_sword1h){
            model.Equip_sword1h = armor;
            ///单手武器
            [self.selectNode setLeftWeapon:armor];
        }else if(value == Equip_shield){
            model.Equip_shield = armor;
            ///盾牌
            [self.selectNode setRightShield:armor];
        }
        
    }
    
    [manager changeDataWithModel:model userName:user];

    
}



/// 开始触碰
- (void)touchDownAtPoint:(CGPoint)pos {}
/// 手指移动
- (void)touchMovedToPoint:(CGPoint)pos {}
/// 触碰结束
- (void)touchUpAtPoint:(CGPoint)pos {}
   

@end
