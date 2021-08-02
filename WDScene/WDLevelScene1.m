//
//  WDLevelScene1.m
//  MercenaryStory
//
//  Created by Mac on 2021/8/2.
//

#import "WDLevelScene1.h"

@implementation WDLevelScene1

- (void)didMoveToView:(SKView *)view{
    
    [super didMoveToView:view];
    
    self.archer.position = CGPointMake(0, 0);
    self.knight.position = CGPointMake(-200, 0);
    self.priest.position = CGPointMake(200, 0);
    
    
}



@end
