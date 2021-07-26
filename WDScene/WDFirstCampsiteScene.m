//
//  WDFirstCampsiteScene.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/26.
//

#import "WDFirstCampsiteScene.h"

@implementation WDFirstCampsiteScene
{
    BOOL _isCreate;
    BOOL _isPassDoor;
}

- (void)didMoveToView:(SKView *)view{
    
    [super didMoveToView:view];
    
    
    
    self.priest.position = CGPointMake(0, 0);
    
    self.archer.position = CGPointMake(self.priest.size.width * 2.5, 0);
    
    self.knight.position = CGPointMake(-self.priest.size.width * 2.5, 0);
    
    if (_isCreate) {
        
        WDBaseModel * model = [[WDDataManager shareManager]searchData:self.selectNode.name];
        [self.selectNode setArmorWithModel:model];
        
    }else{
        self.passDoorNode.position = CGPointMake(kScreenWidth - self.passDoorNode.size.width,100);
        self.passDoorNode.zPosition = 1000;
    }
    
    [self changeSelectNode:nil];
    _isCreate = YES;
    
    [self setTextAction:@"准备齐全后，点击右上角传送门\n随时可以出发"];
}

/// 开始触碰
- (void)touchDownAtPoint:(CGPoint)pos {}

/// 手指移动
- (void)touchMovedToPoint:(CGPoint)pos{}

/// 触碰结束
- (void)touchUpAtPoint:(CGPoint)pos{
    
    pos = [WDCalculateTool calculateMaxMovePosition:pos node:self.selectNode];
    
    NSArray *nodes = [self nodesAtPoint:pos];
    CGFloat distance = 10000;
    
    WDUserNode *user = nil;
    WDBaseNode *passDoor = nil;
    /// 获取离点击点最近位置的敌人
    for (SKSpriteNode *node in nodes) {
        
        if ([node isEqualToNode:self.passDoorNode]) {
            passDoor = (WDBaseNode *)node;
            break;
        }
        
        if([node isKindOfClass:[WDUserNode class]]){
            CGFloat dis = [WDCalculateTool distanceBetweenPoints:pos seconde:node.position];
             if (dis < distance && dis <= node.size.width) {
                 user = (WDUserNode *)node;
                 distance = dis;
             }
        }
        
        
    }
    
    
    /// 切换角色
    if (user && ![user isEqualToNode:self.selectNode]) {
        [self changeSelectNode:user];
        self.presentEquipBlock(self.selectNode.name);
    }else if(passDoor && !_isPassDoor){
        
        NSArray *arr = [self.textureManager.passDoorArr subarrayWithRange:NSMakeRange(1, self.textureManager.passDoorArr.count - 1)];
        SKAction *an = [SKAction animateWithTextures:arr timePerFrame:0.1];
        SKAction *re = [SKAction repeatAction:an count:2];
        _isPassDoor = YES;
        __weak typeof(self)weakSelf = self;
        [passDoor runAction:re completion:^{
            weakSelf.showMapSelectBlock();
            [weakSelf passDoorDown];
            [weakSelf performSelector:@selector(endPass) withObject:nil afterDelay:0.3];
        }];
    }
    
    
}

- (void)endPass{
    self.passDoorNode.texture = self.textureManager.passDoorArr[0];

}

- (void)passDoorDown{
    _isPassDoor = NO;
}

- (WDBaseNode *)passDoorNode
{
    if (!_passDoorNode) {
        _passDoorNode = [WDBaseNode spriteNodeWithTexture:self.textureManager.passDoorArr[0]];
        _passDoorNode.alpha = 1;
        [self addChild:_passDoorNode];
        _passDoorNode.xScale = 1.0;
        _passDoorNode.yScale = 1.0;
        _passDoorNode.name = @"passDoor";
        SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:_passDoorNode.size center:CGPointMake(0, 0)];
        _passDoorNode.physicsBody = body;
        _passDoorNode.physicsBody.affectedByGravity = NO;
        _passDoorNode.physicsBody.allowsRotation = NO;
        _passDoorNode.physicsBody.categoryBitMask = 0;
        _passDoorNode.physicsBody.contactTestBitMask = 1;
        _passDoorNode.physicsBody.collisionBitMask = 0;
        
    }
    
    return _passDoorNode;
}

@end
