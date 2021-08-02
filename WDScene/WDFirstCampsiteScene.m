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
    SKSpriteNode *_ballNode;
    SKLabelNode *_ballLabel;
}

- (void)didMoveToView:(SKView *)view{
    
    [super didMoveToView:view];
    
    WDBaseModel *model = [[WDDataManager shareManager]searchData:kKinght];
    [model getAllDefines];
    self.priest.position = CGPointMake(0, 0);
    
    self.archer.position = CGPointMake(self.priest.size.width * 2.5, 0);
    
    self.knight.position = CGPointMake(-self.priest.size.width * 2.5, 0);
    
    if (_isCreate) {
        
        WDBaseModel * model = [[WDDataManager shareManager]searchData:self.selectNode.name];
        [self.selectNode setArmorWithModel:model];
        
    }else{
        
        self.passDoorNode.position = CGPointMake(kScreenWidth - self.passDoorNode.size.width,100);
        self.passDoorNode.zPosition = 1000;
        [self changeSelectNode:self.knight];
        __weak typeof(self)weakSelf = self;
        [self setTextAction:@"准备齐全后，点击右上角传送门\n随时可以出发" hiddenTime:2 completeBlock:^{
            [weakSelf stopTalk];
        }];
        
        /// 技能训练师
        [self createSkillLearnNode];
    }
    
    _isCreate = YES;

    
}

- (void)createSkillLearnNode{
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    /// 过了第一关，有技能训练师
    if ([defaults boolForKey:kPassCheckPoint1]) {
        
        [self skillLearnNpc];
        [self createBallAction];
        _ballNode.position = CGPointMake(self.skillLearnNpc.position.x, self.skillLearnNpc.position.y + self.knight.size.height / 2.0 + _ballNode.size.width / 2.0);
    
        _ballLabel.position = CGPointMake(_ballNode.position.x + _ballNode.size.width / 2.0 + _ballLabel.fontSize + 10, _ballNode.position.y );
        
    }
}

- (void)createBallAction{
    
   
    NSInteger ballCount = [[NSUserDefaults standardUserDefaults]integerForKey:kSkillBall];
    
    if (ballCount > 3) {
        ballCount = 3;
    }
    
    UIImage *image = [UIImage imageNamed:@"select_yes"];
    CGFloat width = image.size.width;
    
    CGFloat x = self.skillLearnNpc.position.x;
    if (ballCount % 2 == 0) {
        x = self.skillLearnNpc.position.x - ballCount / 2 * width + width / 2.0;
    }else{
        x = self.skillLearnNpc.position.x - ballCount / 2 * width;
    }
    
   
    CGFloat y = self.skillLearnNpc.position.y + self.knight.size.height / 2.0 + width  / 2.0;
    
    for (int i = 0; i < ballCount; i ++) {
        SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:image]];
        node.zPosition = 100000;
        node.position = CGPointMake(x,y );
        [self addChild:node];
        
        SKAction *alpha = [SKAction fadeAlphaTo:0.7 duration:1.2];
        SKAction *alpha2 = [SKAction fadeAlphaTo:1 duration:1.2];
        SKAction *sca  = [SKAction scaleTo:0.8 duration:1.2];
        SKAction *sca2 = [SKAction scaleTo:1 duration:1.2];
        SKAction *seq1 = [SKAction sequence:@[alpha,alpha2]];
        SKAction *seq2 = [SKAction sequence:@[sca,sca2]];
        SKAction *gr = [SKAction group:@[seq1,seq2]];
        SKAction *rep = [SKAction repeatActionForever:gr];
        [node runAction:rep];

        x = x + width;
    }
 
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
        if ([user.name isEqualToString:kLearnSkillNPC]) {
            self.prenestMenuForSkillBlock(self.selectNode.name);
        }else{
            [self changeSelectNode:user];
            self.prenestMenuForArmorBlock(self.selectNode.name);
        }
        
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
    }else{
        //self.hiddenMenuBlock(self.selectNode.name);
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
