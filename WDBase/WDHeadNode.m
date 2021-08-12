//
//  WDHeadNode.m
//  MercenaryStory
//
//  Created by Mac on 2021/8/2.
//

#import "WDHeadNode.h"

@implementation WDHeadNode

- (void)createUserAttackPhysicBodyWithPoint:(CGPoint)point
                                       size:(CGSize)size
{
    SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:size center:point];
    body.allowsRotation = NO;
    body.affectedByGravity = NO;
    self.physicsBody = body;
    body.categoryBitMask = 0;
    body.collisionBitMask = 0;
    body.contactTestBitMask = 0;
   
}

///创建脑袋、脸等
- (void)createFaceWithName:(NSString *)name{
    
    self.zPosition = 100000;
    
    self.realSize = CGSizeMake(100, 100);
    self.realPoint = CGPointMake(0, 45);
    
    /// 边框
    SKSpriteNode *border = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"border"]]];
    border.position = CGPointMake(0, 45);
    border.zPosition = -20;
    border.xScale = 1.2;
    border.yScale = 1.2;
    border.alpha = 0.8;
    [self addChild:border];
    
    SKSpriteNode *BlueBg = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"Blue"]]];
    BlueBg.position = CGPointMake(0, 45);
    BlueBg.zPosition = -30;
    BlueBg.size = border.size;
    BlueBg.alpha = 0.8;
    [self addChild:BlueBg];
    
    //头
    [self createUserAttackPhysicBodyWithPoint:self.realPoint size:self.realSize];
    
    
    //眼睛
    _eye = [WDBaseNode spriteNodeWithTexture:[WDTextureManager shareManager].male_eye];
    _eye.zPosition = 1;
    [self addChild:_eye];
    
    self.defaultEyeTexture = _eye.texture;
    
    //眉毛
    _eyeBrows = [WDBaseNode spriteNodeWithTexture:[WDTextureManager shareManager].normalEyeBrows];
    _eyeBrows.zPosition = 1;
    [self addChild:_eyeBrows];
    
    self.defaultEyesBrowsTexture = _eyeBrows.texture;
    
    //嘴
    _mouth = [WDBaseNode spriteNodeWithTexture:[WDTextureManager shareManager].normalMouth];
    _mouth.zPosition = 1;
    [self addChild:_mouth];
    
    self.defaultMouthTexture = _mouth.texture;
    
//    //头发
    UIImage *hairImage = [UIImage imageNamed:@"BuzzCut"];
    
    _hair = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:hairImage]];
    _hair.zPosition = 1;
    [self addChild:_hair];
    
    

    //耳朵
    _ear = [WDBaseNode spriteNodeWithTexture:[WDTextureManager shareManager].normalEar];
    _ear.zPosition = 1;
    [self addChild:_ear];
    
    //头盔
//    _hemlet = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"EliteKnightHelm"]]];
//    _hemlet.zPosition = 0;
//    [_head addChild:_hemlet];
    
//    SKSpriteNode *node = [SKSpriteNode spriteNodeWithColor:[UIColor orangeColor] size:self.size];
//    node.zPosition = -100;
//    [self addChild:node];
   
    SEL sel = NSSelectorFromString(name);
    if ([self respondsToSelector:sel]) {
        [self performSelector:sel];
    }
    
}

#pragma mark - 弓箭手 -
- (void)Archer{
    [self setHairTexture:@"Hair5"];
    [self setEyeTexture:@"Eyes5"];
    [self setMouthTexture:@"Mouth_Arhcer"];
    [self setEyeBrowsTexture:@"EyeBrows_love"];
}

#pragma mark - 牧师 -
- (void)Priest{
    [self setHairTexture:@"ShortPonytail"];
    [self setEyeTexture:@"Eyes10"];
    [self setMouthTexture:@"Mouth_smile"];
    [self setEyeBrowsTexture:@"EyeBrows_love"];
}


#pragma mark - prive -
/// 设置头发
- (void)setHairTexture:(NSString *)name{
    self.hair.texture = [SKTexture textureWithImage:[UIImage imageNamed:name]];
}

/// 设置胡子
- (void)setBeardTexture:(NSString *)name{
    
    if ([name isEqualToString:@"NO"]) {
        self.beard.texture = nil;
    }else{
        if (!_beard) {
            UIImage *beardImage = [UIImage imageNamed:name];
            //胡子
            _beard = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:beardImage]];
            _beard.zPosition = self.zPosition + 1;
            [self addChild:_beard];
        }else{
            self.beard.texture = [SKTexture textureWithImage:[UIImage imageNamed:name]];
        }
        
    }
}

/// 设置眼镜
- (void)setGlassTexture:(NSString *)name{
   
    if ([name isEqualToString:@"NO"]) {
        self.glass.texture = nil;
    }else{
        if (!_glass) {
            UIImage *beardImage = [UIImage imageNamed:name];
            //胡子
            _glass = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:beardImage]];
            _glass.zPosition = 0;
            [self addChild:_glass];
        }else{
            self.glass.texture = [SKTexture textureWithImage:[UIImage imageNamed:name]];
        }
        
    }
}

/// 设置嘴巴
- (void)setMouthTexture:(NSString *)name{
    
    if ([name isEqualToString:@"NO"]) {
        self.mouth.texture = nil;
    }else{
        self.mouth.texture = [SKTexture textureWithImage:[UIImage imageNamed:name]];
        self.defaultMouthTexture = self.mouth.texture;
    }
    
   
}

/// 设置眉毛
- (void)setEyeBrowsTexture:(NSString *)name{
    self.eyeBrows.texture = [SKTexture textureWithImage:[UIImage imageNamed:name]];
    self.defaultEyesBrowsTexture = self.eyeBrows.texture;
}

/// 设置眼睛
- (void)setEyeTexture:(NSString *)name{
    self.eye.texture = [SKTexture textureWithImage:[UIImage imageNamed:name]];
    self.defaultEyeTexture = self.eye.texture;
}

/// 帽子
- (void)setHemletTexture:(NSString *)name{
    
    if ([name isEqualToString:@"n"]) {
        
        if (_hemlet) {
            [_hemlet removeFromParent];
            _hemlet = nil;
        }
        
    }else{
        
        if (!_hemlet) {
            _hemlet = [WDBaseNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"EliteKnightHelm"]]];
            _hemlet.zPosition =  self.zPosition + 1;
            [self addChild:_hemlet];
        }
        
        self.hemlet.texture = [SKTexture textureWithImage:[UIImage imageNamed:name]];
    }
}

@end
