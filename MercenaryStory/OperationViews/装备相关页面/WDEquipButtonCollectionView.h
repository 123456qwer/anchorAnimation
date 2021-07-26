//
//  WDEquipButtonCollectionView.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDEquipButtonCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)void (^changeEquipBlock)(NSInteger row,NSString *userName);

- (void)reloadAction;

@end

NS_ASSUME_NONNULL_END
