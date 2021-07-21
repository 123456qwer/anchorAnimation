//
//  WDEquipView.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDEquipView : UIView

@property (nonatomic,copy)void (^confirmBlock)(void);

- (instancetype)initWithFrame:(CGRect)frame;

- (void)reloadDataWithName:(NSString *)name;
- (void)cancelConfirmBtn;

@end

NS_ASSUME_NONNULL_END
