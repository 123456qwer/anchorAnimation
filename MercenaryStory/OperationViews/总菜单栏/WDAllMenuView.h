//
//  WDAllMenuView.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDAllMenuView : UIView
@property (nonatomic,copy)void (^openBackPack)(void);
@property (nonatomic,copy)void (^openSkillPack)(void);


- (void)showSkillBtn;

@end

NS_ASSUME_NONNULL_END
