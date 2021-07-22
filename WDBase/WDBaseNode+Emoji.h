//
//  WDBaseNode+Emoji.h
//  MercenaryStory
//
//  Created by Mac on 2021/7/22.
//

#import "WDBaseNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface WDBaseNode (Emoji)

#pragma mark - 表情 -
///正常
- (void)normalFaceState;
///生气
- (void)angleFaceState;

///omg
- (void)omgFaceState;

/// 疑问
- (void)fishyFaceState;

///死亡的表情
- (void)deadFaceState;

/// ❤️~
- (void)loveFaceState;

/// 伤心
- (void)sadFaceState;


@end

NS_ASSUME_NONNULL_END
