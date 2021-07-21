//
//  WDDataManager.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/20.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@class WDBaseModel;
@interface WDDataManager : NSObject

@property (nonatomic,copy)NSString *userName;

+ (WDDataManager *)shareManager;

- (void)openDBwithName:(NSString *)userName;

- (void)insterData:(NSInteger )index
              name:(NSArray *)values
          userName:(NSString *)userName;

- (WDBaseModel *)searchData:(NSString *)userName;

- (void)changeData:(NSInteger )index
              name:(NSArray *)values
          userName:(NSString *)userName;

- (void)changeDataWithModel:(WDBaseModel *)model
                   userName:(NSString *)userName;


@end

NS_ASSUME_NONNULL_END
