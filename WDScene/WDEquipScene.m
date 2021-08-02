//
//  WDEquipScene.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/19.
//

#import "WDEquipScene.h"

@implementation WDEquipScene
{
    SKLabelNode *_ATK;
    SKLabelNode *_DEF;
    SKLabelNode *_HP;
}

- (void)didMoveToView:(SKView *)view{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeEquip:) name:kNotificationForChangeEquip object:nil];
    
    [self createLabels];
}

- (void)createLabels{
    
    ///4ebd00
    NSString *fontName = @"Chalkduster";
    UIColor *color = [UIColor redColor];
 
    _ATK = [SKLabelNode labelNodeWithFontNamed:fontName];
    _ATK.numberOfLines = 0;
    _ATK.text = @"ATK:";
    _ATK.fontColor = color;
    _ATK.zPosition = 100000;
    _ATK.name = @"";
    _ATK.colorBlendFactor = 1;
    _ATK.fontSize = 25;
    //_label.color = [SKColor redColor];
    _ATK.position = CGPointMake(0 - _ATK.fontSize, 0);
    //_ATK.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    [self addChild:_ATK];
    
    color = [UIColor brownColor];
    _DEF = [SKLabelNode labelNodeWithFontNamed:fontName];
    _DEF.numberOfLines = 0;
    _DEF.text = @"ATK:";
    _DEF.fontColor = color;
    _DEF.zPosition = 100000;
    _DEF.name = @"";
    _DEF.colorBlendFactor = 1;
    _DEF.fontSize = 25;
    _DEF.position = CGPointMake(-self.size.width / 2.0 / 2.0, -_ATK.fontSize - 15);
   // _DEF.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;

    [self addChild:_DEF];
    
    color = [UIColor greenColor];
    _HP = [SKLabelNode labelNodeWithFontNamed:fontName];
    _HP.numberOfLines = 0;
    _HP.text = @"ATK:";
    _HP.fontColor = color;
    _HP.zPosition = 100000;
    _HP.name = @"";
    _HP.colorBlendFactor = 1;
    _HP.fontSize = 25;
    //_label.color = [SKColor redColor];
    _HP.position = CGPointMake(-self.size.width / 2.0 / 2.0, _ATK.fontSize + 15);
    //_HP.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    [self addChild:_HP];
    
    
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
    
    self.selectNode.position = CGPointMake(-self.size.width / 2.0 / 2.0 - 50, 0);
    self.selectNode.xScale = 2.0;
    self.selectNode.yScale = 2.0;

    [self setLabelValues];
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
           
            
        }else if([name isEqualToString:kLeftArm]){
            
            model.Equip_pauldrons = armor;
     
            
        }else if([name isEqualToString:kLeftHandAro]){
            
            model.Equip_gloves = armor;
            
       

            
        }else if([name isEqualToString:kFoot]){
            
            model.Equip_boots = armor;
            
      
            
        }else if([name isEqualToString:kHip]){
            
            model.Equip_belt = armor;
       
        }
        
        
    }else{
        
        NSString *armor = dic.allKeys[0];
        int value = [dic[armor]intValue];
        
        if(value == Equip_helmet){
            
            /// 这个是武器头盔
            model.Equip_helmet = armor;
            
        }else if(value == Equip_sword1h){
            
            ///单手武器
            model.Equip_sword1h = armor;
            
        
        }else if(value == Equip_shield){
           
            ///盾牌
            model.Equip_shield = armor;
        
        }else if(value == Equip_bow){
            
            ///弓
            model.Equip_bow = armor;
            
        }
        
    }
    
    [manager changeDataWithModel:model userName:user];
    [self.selectNode setArmorWithModel:model];
    
    
    [self setLabelValues];
}

- (void)setLabelValues{
    
    int atk = self.selectNode.ATK;
    int fl  = self.selectNode.ATK_FLOAT;
    int weapon = self.selectNode.ATK_WEAPON;

    _ATK.text = [NSString stringWithFormat:@"ATK:%d-%d",atk - fl + weapon,atk + fl + weapon];
    _DEF.text = [NSString stringWithFormat:@"DEF:%d",self.selectNode.DEF];
    _HP.text  = [NSString stringWithFormat:@"HP:%d",self.selectNode.BLOOD_INIT];
    
    _ATK.position = CGPointMake(-_ATK.frame.size.width / 2.0 - 20, 0);
    _DEF.position = CGPointMake(-_DEF.frame.size.width / 2.0 - 20, _DEF.position.y);
    _HP.position = CGPointMake(-_HP.frame.size.width / 2.0 - 20, _HP.position.y);
}


/// 开始触碰
- (void)touchDownAtPoint:(CGPoint)pos {}
/// 手指移动
- (void)touchMovedToPoint:(CGPoint)pos {}
/// 触碰结束
- (void)touchUpAtPoint:(CGPoint)pos {}
   

@end
