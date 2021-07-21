//
//  WDBaseModel.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/20.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDBaseModel : NSObject
/// 头盔
@property (nonatomic,copy)NSString *Equip_helmet;
/// 衣服
@property (nonatomic,copy)NSString *Equip_armor;
/// 肩膀
@property (nonatomic,copy)NSString *Equip_pauldrons;
/// 手套
@property (nonatomic,copy)NSString *Equip_gloves;
/// 腰带
@property (nonatomic,copy)NSString *Equip_belt;
/// 鞋子
@property (nonatomic,copy)NSString *Equip_boots;
/// 盾牌
@property (nonatomic,copy)NSString *Equip_shield;
/// 单手武器
@property (nonatomic,copy)NSString *Equip_sword1h;
/// 双手武器
@property (nonatomic,copy)NSString *Equip_sword2h;
/// 弓
@property (nonatomic,copy)NSString *Equip_bow;
/// 眼罩
@property (nonatomic,copy)NSString *Equip_mask;
/// 眼镜
@property (nonatomic,copy)NSString *Equip_glasses;

/// 获取装备后，拼接到所有装备列表中
- (void)appendDataWithModel:(WDBaseModel *)model
                       name:(NSString *)userName;
- (NSDictionary *)properties_aps;

@end

NS_ASSUME_NONNULL_END
