//
//  WDAttributeManager.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/22.
//

#import "WDAttributeManager.h"

@implementation WDAttributeManager

+ (void)setSpriteAttribute:(WDBaseNode *)node
{
    NSString *selName = [NSString stringWithFormat:@"init%@Attribute:",node.name];
    SEL sel = NSSelectorFromString(selName);
    if ([self respondsToSelector:sel]) {
        [self performSelector:sel withObject:node];
    }
}

/// 初始化骑士数值
+ (void)initKnightAttribute:(WDBaseNode *)node{
    
    node.animationWalkSpeed = 220;
    node.animationRunSpeed  = 300;
}

@end
