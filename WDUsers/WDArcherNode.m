//
//  WDArcherNode.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/24.
//

#import "WDArcherNode.h"
#import "WDBaseNode+Animation.h"

@implementation WDArcherNode
- (void)createUserNodeWithScale:(CGFloat)scale
{
    [super createUserNodeWithScale:scale];
    
    WDBaseModel *model = [[WDDataManager shareManager]searchData:kArcher];
    [self setArmorWithModel:model];
    //Leaky
    [self setHairTexture:@"Hair5"];
    [self setEyeTexture:@"Eyes5"];
    [self setMouthTexture:@"Mouth_Arhcer"];
    [self setEyeBrowsTexture:@"EyeBrows_love"];
    
    [self standAction];

}

- (void)upDataAction
{
    [super upDataAction];
    
    if (self.state & Sprite_walk || self.state & Sprite_dead || self.state & Sprite_run) {
        return;
    }
    
    if (self.targetNode.state & Sprite_dead) {
        self.targetNode = nil;
    }
    

    if (self.targetNode) {
        [self attackAction:self.targetNode];
    }else{
        
        if (!self.targetNode && !(self.state & Sprite_movie)) {
            WDBaseNode *target = [WDCalculateTool searchMonsterNearNode:self];
            if (target) {
                self.targetNode = target;
            }
        }
    }
}

- (void)attackAction:(WDBaseNode *)enemyNode
{
    if (self.position.x > enemyNode.position.x) {
        self.xScale = - fabs(self.xScale);
    }else{
        self.xScale =  fabs(self.xScale);
    }
    
    [super attackAction:enemyNode];

}

#pragma mark - 技能 -
//加速射击技能,持续%d秒
- (void)skill1Action
{
    NSInteger time = [[NSUserDefaults standardUserDefaults]integerForKey:kArcher_skill_1];
    self.skill1 = YES;
    [WDSkillManager endSkillActionWithTarget:self skillType:@"1" time:time];
    
   // [self createSkillEffectWithPosition:CGPointMake(0, 270) skillArr:_archerModel.skill1Arr scale:2];

}


@end
