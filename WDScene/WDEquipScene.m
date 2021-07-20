//
//  WDEquipScene.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/19.
//

#import "WDEquipScene.h"

@implementation WDEquipScene

- (void)didMoveToView:(SKView *)view{
    

    self.knight.position = CGPointMake(-self.size.width / 2.0 / 2.0, 0);
    self.knight.xScale = 2.0;
    self.knight.yScale = 2.0;
    
    self.selectNode = self.knight;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeEquip:) name:kNotificationForChangeEquip object:nil];
}

/// 换装通知
- (void)changeEquip:(NSNotification *)notification{

    NSLog(@"%@",notification);
    
    NSDictionary *dic = notification.object;
    if ([dic[dic.allKeys[0]] isKindOfClass:[NSString class]]) {
        
        /// 这个是盔甲类
        NSString *armor = dic.allKeys[0];
        NSString *name = dic[armor];
        if ([name isEqualToString:kBody]) {
            [self.selectNode setBodyArmor:armor];
        }
        
        
    }else{
        
        NSString *armor = dic.allKeys[0];
        int value = [dic[armor]intValue];
        
        if(value == Equip_helmet){
            /// 这个是武器头盔
            [self.selectNode setHemletTexture:armor];
        }else if(value == Equip_sword1h){
            
            ///单手武器
            [self.selectNode setLeftWeapon:armor];
            
        }
        
    }
    
}



/// 开始触碰
- (void)touchDownAtPoint:(CGPoint)pos {}
/// 手指移动
- (void)touchMovedToPoint:(CGPoint)pos {}
/// 触碰结束
- (void)touchUpAtPoint:(CGPoint)pos {}
   

@end
