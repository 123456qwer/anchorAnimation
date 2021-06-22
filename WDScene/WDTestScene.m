//
//  WDTestScene.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import "WDTestScene.h"
#import "WDKknightNode.h"
@implementation WDTestScene
{
    WDBaseNode *_head;
    WDBaseNode *_body;
    
    WDBaseNode *_leftArm;
    WDBaseNode *_leftElbow;
    WDBaseNode *_leftHand;
    
    WDBaseNode *_rightArm;
    WDBaseNode *_rightElbow;
    WDBaseNode *_rightHand;
    WDBaseNode *_rightFinger;
    
    WDBaseNode *_hip;
    
    WDBaseNode *_rightKnee;
    WDBaseNode *_rightFoot;
    
    WDBaseNode *_leftKnee;
    WDBaseNode *_leftFoot;
    
    NSTimeInterval _walkTime;
    WDKknightNode *_person;
    
    WDBaseNode    *_enemyNode;
    
    int a;
    int b;
}

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
  
    CGFloat bgScale = 2 * kScreenWidth / self.bgNode.size.width;
    self.bgNode.xScale = bgScale;
    self.bgNode.yScale = bgScale;
    
    CGFloat scale = 0.4;
    
    _person = [WDKknightNode spriteNodeWithColor:[[UIColor orangeColor]colorWithAlphaComponent:0.2] size:CGSizeMake(145 * scale, 280 * scale)];
    _person.anchorPoint = CGPointMake(0.5, 0.5);
    [self.bgNode addChild:_person];
    
    _enemyNode = [WDEnemyNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(145 * scale, 280 * scale)];
    _enemyNode.anchorPoint = CGPointMake(0.5, 0.5);
    _enemyNode.name = @"enemy";
    [self.bgNode addChild:_enemyNode];
    
    
    
    
    [_enemyNode createUserNodeWithScale:scale];
    [_person    createUserNodeWithScale:scale];
    
//    SKSpriteNode *aa = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(10, 10)];
//    aa.zPosition = 100;
//    [_person addChild:aa];
//    
//    SKSpriteNode *bb = [SKSpriteNode spriteNodeWithColor:[UIColor grayColor] size:CGSizeMake(10, 10)];
//    bb.zPosition = 105;
//    [_enemyNode addChild:bb];
   
    
    //[_enemyNode standAction];
    self.selectNode = _person;
    [_enemyNode standAction];
}

- (void)update:(NSTimeInterval)currentTime
{
    [super update:currentTime];
    [_enemyNode upDataAction];
    [self.selectNode upDataAction];
}

- (void)phyWithNode:(WDBaseNode *)node
{
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:node.size center:CGPointMake(0, 0)];
    node.physicsBody = body;
    node.physicsBody.affectedByGravity = NO;
    node.physicsBody.allowsRotation = YES;
    node.physicsBody.categoryBitMask = 0;
}

- (WDBaseNode *)textureWithKeyName:(NSString *)name
{
    NSDictionary *dic = [WDCalculateTool userImageDic];
    UIImage *image = dic[name];
    SKTexture *texture = [SKTexture textureWithImage:image];
    WDBaseNode *node = [WDBaseNode spriteNodeWithTexture:texture];
    node.name = name;
    
    return node;
}




@end
