//
//  WDTextureManager.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/28.
//

#import "WDTextureManager.h"
static WDTextureManager *textureManager = nil;
@implementation WDTextureManager

+ (WDTextureManager *)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!textureManager) {
            textureManager = [[WDTextureManager alloc] init];
        }
    });
    
    return textureManager;
}


#pragma mark - getter -
- (SKTexture *)arrowTexture
{
    if (!_arrowTexture) {
        _arrowTexture = [SKTexture textureWithImage:[UIImage imageNamed:@"selectArrow"]];
    }
    
    return _arrowTexture;;
}

- (SKTexture *)skeletonHead
{
    if (!_skeletonHead) {
        _skeletonHead = [SKTexture textureWithImage:[UIImage imageNamed:@"Head_Skeleton"]];
    }
    
    return _skeletonHead;
}

- (SKTexture *)humanHead
{
    if (!_humanHead) {
        _humanHead = [SKTexture textureWithImage:[UIImage imageNamed:@"Head"]];
    }
    
    return _humanHead;
}

- (SKTexture *)male_eye
{
    if (!_male_eye) {
        _male_eye = [SKTexture textureWithImage:[UIImage imageNamed:@"Eye_Male"]];
    }
    
    return _male_eye;
}


- (SKTexture *)normalEyeBrows
{
    if (!_normalEyeBrows) {
        _normalEyeBrows = [SKTexture textureWithImage:[UIImage imageNamed:@"EyeBrows_Eyebrows"]];
        
    }
    
    return _normalEyeBrows;;
}


- (SKTexture *)normalMouth
{
    if (!_normalMouth) {
        _normalMouth = [SKTexture textureWithImage:[UIImage imageNamed:@"Mouth_Normal"]];
    }
    
    return _normalMouth;
}

- (SKTexture *)normalEar
{
    if (!_normalEar) {
        _normalEar = [SKTexture textureWithImage:[UIImage imageNamed:@"Ears_HumanEar"]];
    }
    
    return _normalEar;;
}

- (NSArray *)bloodHit3Arr
{
    
    if (!_bloodHit3Arr) {
        
        _bloodHit3Arr = [self getHitArr:[UIImage imageNamed:@"blood_hit_03"]];
        
    }
    
    return _bloodHit3Arr;
}

- (NSArray *)bloodHit4Arr
{
    if (!_bloodHit4Arr) {
        _bloodHit4Arr = [self getHitArr:[UIImage imageNamed:@"blood_hit_04"]];
    }
    
    return _bloodHit4Arr;
}


- (NSArray *)bloodHitArr
{
    if (!_bloodHitArr) {
        
        NSMutableArray *ar = [NSMutableArray arrayWithCapacity:8];
        for (int i = 0; i < 8; i ++) {
            NSString *imageName = [NSString stringWithFormat:@"blood_hit_%02d",i+1];
            NSArray *arr = [self getHitArr:[UIImage imageNamed:imageName]];
            [ar addObject:arr];
        }
        
        _bloodHitArr = [ar copy];
    }
    
    return _bloodHitArr;
}

- (NSArray *)getHitArr:(UIImage *)image
{
    CGImageRef imageRef = image.CGImage;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 16; i ++) {
        
        CGFloat x = (i % 4) * 128.f;
        CGFloat y = i / 4 * 128;
        
        CGImageRef imageR = CGImageCreateWithImageInRect(imageRef, CGRectMake(x, y, 128, 128));
        UIImage *image = [UIImage imageWithCGImage:imageR];
        SKTexture *texture = [SKTexture textureWithImage:image];
        [arr addObject:texture];
    }
    
    return [arr copy];
}

#pragma mark - 小怪出场光效 -
- (NSArray<SKTexture *> *)smokeArr
{
    if (!_smokeArr) {
        _smokeArr = [self loadWithImageName:@"smoke_" count:14];
    }
    return _smokeArr;
}

- (NSMutableArray *)loadWithImageName:(NSString *)name
                                count:(NSInteger)count
{
    NSMutableArray *muAr = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        NSString *nameS = [NSString stringWithFormat:@"%@%d",name,i+1];
        SKTexture *texture1 = [SKTexture textureWithImage:[UIImage imageNamed:nameS]];
        [muAr addObject:texture1];
    }
    
    return muAr;
}

@end
