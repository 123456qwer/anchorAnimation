//
//  WDSkillView.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDSkillView : UIView

@property (nonatomic,strong)NSMutableDictionary *skillViewDic;
@property (nonatomic,copy)void (^skillActionBlock)(NSInteger tag);
//设置技能按钮图片
- (void)setSkillViewWithUserName:(NSString *)name;
/// 初始化时间
- (void)reloadAction;

@end

NS_ASSUME_NONNULL_END
