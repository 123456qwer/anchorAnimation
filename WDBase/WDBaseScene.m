//
//  WDBaseScene.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import "WDBaseScene.h"

@implementation WDBaseScene

- (void)didMoveToView:(SKView *)view
{
    self.physicsWorld.contactDelegate = self;
    self.scaleMode = SKSceneScaleModeAspectFill;

    //屏幕适配
    CGFloat screenWidth = kScreenWidth * 2.0;
    CGFloat screenHeight = kScreenHeight * 2.0;
    self.size = CGSizeMake(screenWidth, screenHeight);
}

@end
