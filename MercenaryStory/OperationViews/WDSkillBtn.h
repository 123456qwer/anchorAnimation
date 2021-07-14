//
//  WDSkillBtn.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDSkillBtn : UIButton


@property (nonatomic,strong)UILabel *timeLabel;


/// 初始化时间
- (void)reloadAction;
- (void)setTime:(CGFloat)time;


@end

NS_ASSUME_NONNULL_END
