//
//  WDTestScene.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import "WDTestScene.h"

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
    WDBaseNode *_person;
    
    int a;
    int b;
}

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
  

    CGFloat scale = 0.7;
    
    SKSpriteNode *bgNode = (SKSpriteNode *)[self childNodeWithName:@"bgNode"];
    [bgNode setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"gogogo.jpg"]]];
    bgNode.position = CGPointMake(0, 0);
    
    _person = [WDBaseNode spriteNodeWithColor:[UIColor orangeColor] size:CGSizeMake(110, 200)];
    _person.mode = Attack_singleHand;
    _person.state = Sprite_walk;
    [bgNode addChild:_person];

    [_person createUserNodeWithScale:scale];
    [_person setLeftWeapon:@"FamilySword"];
    [self phyWithNode:_person];
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



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
//    a += 15;
//    b -= 15;
//    int f = arc4random() % 2;
//    if (f == 0) {
//        [_person standAction];
//    }else{
//        [_person walkAction];
//    }
    [_person attackAction];
   
    _rightArm.zRotation = DEGREES_TO_RADIANS(a);
}

@end
