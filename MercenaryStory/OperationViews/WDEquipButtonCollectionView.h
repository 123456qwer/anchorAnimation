//
//  WDEquipButtonCollectionView.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDEquipButtonCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,copy)void (^changeEquipBlock)(NSInteger row);

@end

NS_ASSUME_NONNULL_END
