//
//  WDBaseNode+Emoji.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/22.
//

#import "WDBaseNode+Emoji.h"

@implementation WDBaseNode (Emoji)
#pragma mark - 表情 -
///正常
- (void)normalFaceState{
    
    [self.balloonNode removeAllActions];
    self.balloonNode.hidden = YES;
    self.mouth.texture = self.defaultMouthTexture;
    self.eyeBrows.texture = self.defaultEyesBrowsTexture;
    self.eye.texture = self.defaultEyeTexture;
}

///生气
- (void)angleFaceState{
    
    self.mouth.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"Mouth_Angry"]];
    self.eyeBrows.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"EyeBrows_Angry"]];
}

///生气,带眼睛
- (void)angleFaceStateWithEye{
    
    [self angleFaceState];
    self.eye.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"Eye_Angry"]];
    [self.balloonNode setBalloonWithLine:Balloon_angry hiddenTime:0];
}

///死亡
- (void)deadFaceState
{
    [self setTextureWithName:@"Dead"];
}

///omg
- (void)omgFaceState{
    [self setTextureWithName:@"OMG"];
}

///疑问
- (void)fishyFaceState{
    [self setTextureWithName:@"Fishy"];
    
}

/// ❤️~
- (void)loveFaceState{
    [self setTextureWithName:@"love"];
}

/// 伤心
- (void)sadFaceState{
    [self setTextureWithName:@"Sad"];
}


- (void)setTextureWithName:(NSString *)name{
    
    NSString *mouth = [NSString stringWithFormat:@"Mouth_%@",name];
    NSString *eye = [NSString stringWithFormat:@"Eye_%@",name];
    NSString *eyeBrows = [NSString stringWithFormat:@"EyeBrows_%@",name];

    self.mouth.texture = [SKTexture textureWithImage:[UIImage imageNamed:mouth]];
    self.eye.texture = [SKTexture textureWithImage:[UIImage imageNamed:eye]];
    self.eyeBrows.texture = [SKTexture textureWithImage:[UIImage imageNamed:eyeBrows]];
    
}

@end
