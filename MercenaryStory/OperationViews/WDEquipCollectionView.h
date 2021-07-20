//
//  WDEquipCollectionView.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDEquipCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>


/// 帽子之类的
- (void)reloadDataWithArr:(NSArray *)equipArr
                    index:(NSInteger)index;
/// 其他装备
- (void)reloadDataWithDic:(NSDictionary *)equipDic
                    index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
