//
//  WDBaseScene+Moive.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/30.
//

#import "WDBaseScene+Moive.h"

@implementation WDBaseScene (Moive)

- (void)bossDeadActionMovie{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rewardAlready) name:@"RewardAlready" object:nil];
    
    for (WDBaseNode *user in self.userArr) {
        user.state = Sprite_movie;
    }
    
    for (WDBaseNode *node in self.monsterArr) {
        //[node releaseAction];
    }
    [self.monsterArr removeAllObjects];
    
    SKEmitterNode *poison = [SKEmitterNode nodeWithFileNamed:@"poisonFire"];
    [self addChild:poison];
    poison.name = @"poisonFire";
    poison.zPosition = 100;
    poison.targetNode = self;
    poison.position = CGPointMake(0, 0);
    
    CGFloat page = 100;
    
    CGPoint point1 = CGPointMake(-kScreenWidth + page, kScreenHeight - page);
    CGPoint point2 = CGPointMake(kScreenWidth - page, kScreenHeight - page);
    CGPoint point3 = CGPointMake(kScreenWidth - page, -kScreenHeight + page);
    CGPoint point4 = CGPointMake(-kScreenWidth + page, -kScreenHeight + page);
    CGPoint point5 = CGPointMake(-kScreenWidth + page, kScreenHeight - page);
    CGPoint point6 = CGPointMake(0, 0);

    CGFloat distance1 = [WDCalculateTool distanceBetweenPoints:poison.position seconde:point1];
    CGFloat distance2 = [WDCalculateTool distanceBetweenPoints:point1 seconde:point2];
    CGFloat distance3 = [WDCalculateTool distanceBetweenPoints:point2 seconde:point3];
    CGFloat distance4 = [WDCalculateTool distanceBetweenPoints:point3 seconde:point4];
    CGFloat distance5 = [WDCalculateTool distanceBetweenPoints:point4 seconde:point5];
    CGFloat distance6 = [WDCalculateTool distanceBetweenPoints:point5 seconde:point6];

    CGFloat velocity = 3000.f;
    
    NSTimeInterval time1 = distance1 / velocity;
    NSTimeInterval time2 = distance2 / velocity;
    NSTimeInterval time3 = distance3 / velocity;
    NSTimeInterval time4 = distance4 / velocity;
    NSTimeInterval time5 = distance5 / velocity;
    NSTimeInterval time6 = distance6 / velocity;

    SKAction *move1 = [SKAction moveTo:point1 duration:time1];
    SKAction *move2 = [SKAction moveTo:point2 duration:time2];
    SKAction *move3 = [SKAction moveTo:point3 duration:time3];
    SKAction *move4 = [SKAction moveTo:point4 duration:time4];
    SKAction *move5 = [SKAction moveTo:point5 duration:time5];
    SKAction *move6 = [SKAction moveTo:point6 duration:time6];
    SKAction *seq = [SKAction sequence:@[move1,move2,move3,move4,move5,move6,[SKAction waitForDuration:3],[SKAction removeFromParent]]];
    __weak typeof(self)weakSelf = self;
    [poison runAction:seq completion:^{
        [weakSelf createReward];
    }];
}

- (void)createReward{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moveActionForClick) name:kNotificationForClickPrompt object:nil];
    WDBaseNode *reward = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"select_no"]]];
    [self addChild:reward];
    self.rewardNode = reward;
    reward.name = @"click";
    reward.xScale = 0.1;
    reward.yScale = 0.1;
    reward.alpha = 0;
    reward.zPosition = 10000;
    reward.position = CGPointMake(0,0);
    
    SKAction *alphaA = [SKAction fadeAlphaTo:1 duration:0.6];
    SKAction *xS = [SKAction scaleTo:1.0 duration:0.6];
    SKAction *gr = [SKAction group:@[alphaA,xS]];
    
    //self.rewardNode = reward;
    
    __weak typeof(self)weakSelf = self;
    [reward runAction:gr completion:^{
        reward.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"select_yes"]];
        weakSelf.clickNode.hidden = NO;
        weakSelf.clickNode.position = CGPointMake(0, 0 - weakSelf.clickNode.size.height / 2.0 - reward.size.width / 2.0 + 10);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"RewardAlready" object:nil];
        //[weakSelf moveActionForClick];
    }];
}

- (void)moveActionForClick:(void (^)(void))completeBlock{
    CGPoint movePoint = CGPointMake(kScreenWidth - 90, kScreenHeight - 90);
    CGFloat distance = [WDCalculateTool distanceBetweenPoints:movePoint seconde:self.rewardNode.position];
    NSTimeInterval time = distance / 1200;
    SKAction *moveAction = [SKAction moveTo:CGPointMake(kScreenWidth - 90, kScreenHeight - 90) duration:time];
    [self.clickNode removeAllActions];
    [self.clickNode removeFromParent];
    __weak typeof(self)weakSelf = self;
    [self.rewardNode runAction:moveAction completion:^{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:weakSelf.passStr];
        NSInteger ballCount = [defaults integerForKey:kSkillBall];
        ballCount ++;
        [defaults setInteger:ballCount forKey:kSkillBall];
        completeBlock();
    }];
}

@end
