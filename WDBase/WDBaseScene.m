//
//  WDBaseScene.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import "WDBaseScene.h"
#import "WDBaseScene+ContactLogic.h"


@implementation WDBaseScene

- (void)didMoveToView:(SKView *)view
{
    self.physicsWorld.contactDelegate = self;
    self.scaleMode = SKSceneScaleModeAspectFill;

    //屏幕适配
    CGFloat screenWidth = kScreenWidth * 2.0;
    CGFloat screenHeight = kScreenHeight * 2.0;
    self.size = CGSizeMake(screenWidth, screenHeight);
    
    self.bgNode = (SKSpriteNode *)[self childNodeWithName:@"bgNode"];
    CGFloat yScale = self.size.height / self.bgNode.size.height;
    self.bgNode.yScale = yScale;
    self.bgNode.xScale = yScale;
}


#pragma mark - 操作 -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchDownAtPoint:[t locationInNode:self.bgNode]];}
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}

- (void)update:(NSTimeInterval)currentTime
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForUpData object:nil];
}

#pragma mark - getter -
/// 操作线
- (WDBaseNode *)selectLine
{
    if (!_selectLine) {
        _selectLine = [WDBaseNode spriteNodeWithColor:UICOLOR_RGB(255, 227, 132, 1) size:CGSizeMake(50, 50)];
        _selectLine.anchorPoint = CGPointMake(0, 0);
        _selectLine.name = @"selectLine";
        _selectLine.zPosition = 10;
        [self.bgNode addChild:_selectLine];
    }
    
    return _selectLine;
}


#pragma mark - 操作 -
/// 开始触碰
- (void)touchDownAtPoint:(CGPoint)pos {
   
    //[self.selectNode deadAction];
}

/// 手指移动
- (void)touchMovedToPoint:(CGPoint)pos {
    
    //return;
    self.selectLine.position = CGPointMake(self.selectNode.position.x, self.selectNode.position.y);
    ///引导线
    //斜边
    CGFloat width = [WDCalculateTool distanceBetweenPoints:pos seconde:self.selectLine.position];
    self.selectLine.size = CGSizeMake(width, 10);
    self.selectLine.hidden = NO;
    //角度
    self.selectLine.zRotation = [WDCalculateTool angleForStartPoint:self.selectLine.position EndPoint:pos];
    //NSLog(@"%lf",self.selectLine.zRotation);
    //[self.selectLine createLinePhyBody];

}

/// 触碰结束
- (void)touchUpAtPoint:(CGPoint)pos {
    
    NSLog(@"屏宽 :%lf bg宽 :%lf",kScreenWidth,self.bgNode.size.width);
    NSLog(@"x: %lf %lf",pos.x,pos.y);
    
    NSArray *nodes = [self nodesAtPoint:pos];
    CGFloat distance = 10000;
    WDEnemyNode *enemy = nil;
    WDUserNode  *user = nil;
    
    /// 牧师或其他治疗拖动治疗的情况，只考虑选中玩家，忽略敌人
    if ([self.selectNode.name isEqualToString:kPriest] && self.selectLine.hidden == NO) {
        
        /// 获取离点击点最近位置友军
        for (SKSpriteNode *node in nodes) {
            if([node isKindOfClass:[WDUserNode class]]){
                CGFloat dis = [WDCalculateTool distanceBetweenPoints:pos seconde:node.position];
                 if (dis < distance && dis <= node.size.width) {
                     user = (WDUserNode *)node;
                     distance = dis;
                     enemy = nil;
                 }
            }
        }
        
    }else{
        
        /// 获取离点击点最近位置的敌人
        for (SKSpriteNode *node in nodes) {
            if ([node isKindOfClass:[WDEnemyNode class]]) {
               CGFloat dis = [WDCalculateTool distanceBetweenPoints:pos seconde:node.position];
                if (dis < distance && dis <= node.size.width) {
                    enemy = (WDEnemyNode *)node;
                    distance = dis;
                    user = nil;
                }
            }else if([node isKindOfClass:[WDUserNode class]]){
                CGFloat dis = [WDCalculateTool distanceBetweenPoints:pos seconde:node.position];
                 if (dis < distance && dis <= node.size.width) {
                     user = (WDUserNode *)node;
                     distance = dis;
                     enemy = nil;
                 }
            }
        }
        
    }
    
    
    
    
    
    if (user) {
        
        ///选中user的情况
        [self changeOrCureUser:user];

    }else if(enemy){
    
        ///选中敌人
        [self clickEneny:enemy];
        
    }else{
        
        ///单纯移动
        self.selectNode.targetNode = enemy;
        [self.selectNode moveAction:pos];

    }
    

    self.selectLine.hidden = YES;
    self.selectLine.size = CGSizeMake(0, 0);
    
}

/// 点击到人物（切换人物或者治疗）
- (void)changeOrCureUser:(WDUserNode *)user{
    
    /// 以后可能增加治疗者（引导线存在的情况下，选中人物是加血状态）
    if ([self.selectNode.name isEqualToString:kPriest] && self.selectLine.hidden == NO) {
        
        self.selectNode.cureNode = user;
        self.selectNode.targetNode = nil;
        
    }else{
        
        self.selectNode.arrowNode.hidden = YES;
        self.selectNode = user;
        self.selectNode.arrowNode.hidden = NO;
    }
}

/// 点击到敌人
- (void)clickEneny:(WDEnemyNode *)enemy{
    
    if ([self.selectNode.targetNode isEqualToNode:enemy]) {
        return;
    }
    
    /// 重置攻击状态
    if (self.selectNode.state & Sprite_attack) {
        self.selectNode.state = self.selectNode.state ^ Sprite_attack;
    }
    
    self.selectNode.targetNode = enemy;
    self.selectNode.cureNode   = nil;
    [self.selectNode removeAllActions];
    [self.selectNode pauseWalkOrRun];

    
    CGFloat dis = [WDCalculateTool distanceBetweenPoints:enemy.position seconde:self.selectNode.position];
    
    if (dis <= self.selectNode.size.width || self.selectNode.attackDistance > 0) {
        [self.selectNode attackAction:enemy];
    }else{
        CGPoint movePoint = [WDCalculateTool calculateNodeMovePosition:self.selectNode enemy:enemy];
        [_selectNode moveAction:movePoint];
    }
}

#pragma mark - 物理检测 -
- (void)didBeginContact:(SKPhysicsContact *)contact{
    [self contactLogicAction:contact];
}
- (void)didEndContact:(SKPhysicsContact *)contact{
}

@end
