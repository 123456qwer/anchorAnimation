//
//  WDEquipView.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDEquipView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (void)reloadDataWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
