//
//  WDAnimationManager.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/16.
//

#import "WDAnimationManager.h"
#import "WDUserNode.h"
@implementation WDAnimationManager

+ (void)demageAnimation:(WDBaseNode *)node
                  point:(CGPoint)point
                  scale:(CGFloat)scale
              demagePic:(NSString *)imageName
{
    if (node.BLOOD_LAST <= 0) {
        return;
    }
    
    CGFloat rotation = M_PI / 180.0 * (arc4random() % 360);
    WDBaseNode *demageNode = [WDBaseNode spriteNodeWithTexture:[WDTextureManager shareManager].demageTexture];
    demageNode.xScale = scale;
    demageNode.yScale = scale;
    demageNode.position = point;
    demageNode.zRotation = rotation;
    demageNode.name = @"demage";
    demageNode.zPosition = 100;
    [node addChild:demageNode];
    
    SKAction *alphaAction = [SKAction fadeAlphaTo:0 duration:0.3];
    SKAction *removeAction = [SKAction removeFromParent];
    SKAction *seqAction = [SKAction sequence:@[alphaAction,removeAction]];
    [demageNode runAction:seqAction];
}


+ (void)addBloodNumberAnimation:(WDBaseNode *)node
                         number:(int)number{
    
    ///4ebd00
    NSString *fontName = @"Chalkduster";

    SKLabelNode *_label = [SKLabelNode labelNodeWithFontNamed:fontName];
    _label.numberOfLines = 0;
    _label.text = [NSString stringWithFormat:@"+%d",number];
    _label.fontColor = [WDCalculateTool colorFromHexRGB:@"#2E8B57"];
    _label.zPosition = 100000;
    _label.colorBlendFactor = 1;
    _label.fontSize = 35;
    _label.name = @"bloodLabel";
   // _label.color = [SKColor redColor];
    _label.position = CGPointMake(node.position.x,node.position.y + node.size.height / 2.0 - 25);
    [node.parent addChild:_label];
    
    SKAction *scaleAction = [SKAction scaleTo:2 duration:0.15];
    SKAction *scaleAction2 = [SKAction scaleTo:1.5 duration:0.15];
    
    SKAction *seq = [SKAction sequence:@[scaleAction,scaleAction2,[SKAction removeFromParent]]];
    [_label runAction:seq];
}

+ (void)reduceBloodNumberAnimation:(WDBaseNode *)node
                            number:(int)number{
    
    ///4ebd00
    NSString *fontName = @"Chalkduster";
    
    UIColor *color = nil;
    if ([node isKindOfClass:[WDUserNode class]]) {
        color = [UIColor redColor];
    }else{
        color = [WDCalculateTool colorFromHexRGB:@"#FFA500"];
    }

    SKLabelNode *_label = [SKLabelNode labelNodeWithFontNamed:fontName];
    _label.numberOfLines = 0;
    _label.text = [NSString stringWithFormat:@"-%d",number];
    _label.fontColor = color;
    _label.zPosition = 100000;
    _label.name = @"bloodLabel";
    _label.colorBlendFactor = 1;
    _label.fontSize = 35;
    //_label.color = [SKColor redColor];
    _label.position = CGPointMake(node.position.x,node.position.y + node.size.height / 2.0 - 25);
    [node.parent addChild:_label];
    
    SKAction *scaleAction = [SKAction scaleTo:2 duration:0.15];
    SKAction *scaleAction2 = [SKAction scaleTo:1.5 duration:0.15];
    
    SKAction *seq = [SKAction sequence:@[scaleAction,scaleAction2,[SKAction removeFromParent]]];
    [_label runAction:seq];
}

@end
