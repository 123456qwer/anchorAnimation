//
//  WDEquipCell.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDEquipCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *equipImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@end

NS_ASSUME_NONNULL_END
