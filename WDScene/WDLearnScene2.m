//
//  WDLearnScene2.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/21.
//

#import "WDLearnScene2.h"

@implementation WDLearnScene2
- (void)didMoveToView:(SKView *)view{
    
    [super didMoveToView:view];
    
    self.bgNode.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"LearnScene.jpg"]];
    
}
@end
