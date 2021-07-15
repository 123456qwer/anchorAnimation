//
//  WDRedBatModel.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDRedBatModel : NSObject
/// 站立
@property (nonatomic,copy)NSArray <SKTexture *>*standArr;
/// 攻击1
@property (nonatomic,copy)NSArray <SKTexture *>*attackArr1;
@property (nonatomic,copy)NSArray <SKTexture *>*walkArr;
/// 死亡
@property (nonatomic,copy)NSArray <SKTexture *>*diedArr;
/// 被攻击硬直
@property (nonatomic,copy)NSArray <SKTexture *>*beHurtArr;

- (void)changeArr;
- (void)setNormalTexturesWithName:(NSString *)name
                      standNumber:(int)standNumber
                        runNumber:(int)runNumber
                       walkNumber:(int)walkNumber
                       diedNumber:(int)diedNumber
                    attack1Number:(int)attackNumber;

@end

NS_ASSUME_NONNULL_END
