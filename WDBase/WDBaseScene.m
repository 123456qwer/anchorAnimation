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
    for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self.bgNode]];}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self.bgNode]];}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self.bgNode]];}
}

- (void)update:(NSTimeInterval)currentTime
{
    
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
- (void)touchDownAtPoint:(CGPoint)pos {
   
    self.selectNode.isRunState = !self.selectNode.isRunState;
    
}

// 移动
- (void)touchMovedToPoint:(CGPoint)pos {
    
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

// 触碰结束
- (void)touchUpAtPoint:(CGPoint)pos {
    
    NSArray *nodes = [self.bgNode nodesAtPoint:pos];
    CGFloat distance = 10000;
    WDEnemyNode *enemy = nil;
    /// 获取离点击点最近位置的敌人
    for (SKSpriteNode *node in nodes) {
        if ([node isKindOfClass:[WDEnemyNode class]]) {
           CGFloat dis = [WDCalculateTool distanceBetweenPoints:self.selectNode.position seconde:node.position];
            if (dis < distance) {
                enemy = (WDEnemyNode *)node;
                distance = dis;
            }
        }
    }
    
    self.selectNode.targetNode = enemy;
    
    //选中敌人的情况
    if (enemy) {

        if (distance <= self.selectNode.size.width) {
            [self.selectNode attackAction:enemy];
        }else{
            CGPoint movePoint = [WDCalculateTool calculateNodeMovePosition:self.selectNode enemy:enemy];
            [_selectNode moveAction:movePoint];
        }

    }else{
        [_selectNode moveAction:pos];
    }
    
    self.selectLine.hidden = YES;
    self.selectLine.size = CGSizeMake(0, 0);
}




@end
