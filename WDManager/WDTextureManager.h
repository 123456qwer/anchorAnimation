//
//  WDTextureManager.h
//  MercenaryStory
//
//  Created by Mac on 2021/6/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDTextureManager : NSObject

@property (nonatomic,copy)NSDictionary *humamDic;
@property (nonatomic,copy)NSDictionary *skeletonDic;


/// 选中的人物箭头
@property (nonatomic,strong)SKTexture *arrowTexture;
/// 骷髅头
@property (nonatomic,strong)SKTexture *skeletonHead;

/// 出血动画3
@property (nonatomic,copy)NSArray *bloodHit3Arr;
/// 出血动画4
@property (nonatomic,copy)NSArray *bloodHit4Arr;

/// 出血动画
@property (nonatomic,copy)NSArray *bloodHitArr;

/// 人头
@property (nonatomic,strong)SKTexture *humanHead;
/// 男性人眼
@property (nonatomic,strong)SKTexture *male_eye;
/// 普通眉毛
@property (nonatomic,strong)SKTexture *normalEyeBrows;
/// 普通嘴
@property (nonatomic,strong)SKTexture *normalMouth;
/// 普通耳朵
@property (nonatomic,strong)SKTexture *normalEar;


/** 小怪出场光效 */
@property (nonatomic,copy)NSArray <SKTexture *>*smokeArr;

+ (WDTextureManager *)shareManager;

@end

NS_ASSUME_NONNULL_END
