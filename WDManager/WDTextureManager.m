//
//  WDTextureManager.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/28.
//

#import "WDTextureManager.h"
static WDTextureManager *textureManager = nil;
@implementation WDTextureManager
{
    NSDictionary  *_balloonDic;
}


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
- (Boss1Model *)boss1Model
{
    if (!_boss1Model) {
        _boss1Model = [[Boss1Model alloc] init];
        [_boss1Model setTextures];
    }
    
    return _boss1Model;
}

- (SKTexture *)speak{
    if (!_speak) {
        _speak = [SKTexture textureWithImage:[UIImage imageNamed:@"speak"]];
    }
    return _speak;;
}

- (SKTexture *)confirm{
    if (!_confirm) {
        _confirm = [SKTexture textureWithImage:[UIImage imageNamed:@"confirm"]];
    }
    return _confirm;
}

- (SKTexture *)cancel{
    if (!_cancel) {
        _cancel = [SKTexture textureWithImage:[UIImage imageNamed:@"cancel"]];
    }
    return _cancel;
}

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

- (NSArray<SKTexture *> *)passDoorArr
{
    if (!_passDoorArr) {
        _passDoorArr = [WDCalculateTool curImageWithImage:[UIImage imageNamed:@"passDoor"] line:5 arrange:1 itemSize:CGSizeMake(256, 128) count:5];
    }
    
    return _passDoorArr;
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

- (WDRedBatModel *)redBatModel
{
    if (!_redBatModel) {
        _redBatModel = [[WDRedBatModel alloc] init];
        [_redBatModel setNormalTexturesWithName:kRedBat standNumber:12 runNumber:0 walkNumber:8 diedNumber:8 attack1Number:7];
    }
    
    return _redBatModel;
}

- (SKTexture *)demageTexture
{
    if (!_demageTexture) {
        _demageTexture = [SKTexture textureWithImage:[UIImage imageNamed:@"demage1"]];
    }
    
    return _demageTexture;
}

#pragma mark - 小怪出场光效 -
- (NSArray<SKTexture *> *)smokeArr
{
    if (!_smokeArr) {
        _smokeArr = [self loadWithImageName:@"smoke_" count:14];
    }
    return _smokeArr;
}

#pragma mark - 手指引导 -
- (NSArray<SKTexture *> *)handClickArr{
   
    if (!_handClickArr) {
        _handClickArr = [WDCalculateTool curImageWithImage:[UIImage imageNamed:@"hand2"] line:1 arrange:2 itemSize:CGSizeMake(128, 128) count:3];
    }
    
    return _handClickArr;
}



#pragma mark - 人物情绪 -
- (NSArray *)balloonTexturesWithLine:(NSInteger)line
{
    if (!_balloonDic) {
        UIImage *image = [UIImage imageNamed:@"Balloon"];
        NSArray *arr = [WDCalculateTool arrWithLine:10 arrange:8 imageSize:CGSizeMake(image.size.width, 48 * 10) subImageCount:80 image:image curImageFrame:CGRectMake(0, 0, image.size.width, 48 * 10)];
        

        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:80];
        for (int i = 0; i < 10; i ++) {
            
            NSArray *subArr = [arr subarrayWithRange:NSMakeRange(i * 8, 8)];
            NSString *key = [NSString stringWithFormat:@"%d",i+1];
            [dic setValue:subArr forKey:key];
        }
        
        _balloonDic = dic;
    }
    
    
    NSString *key = [NSString stringWithFormat:@"%ld",line];
    return _balloonDic[key];
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


- (void)releaseAction{
    _boss1Model   = nil;
    _smokeArr     = nil;
    _redBatModel  = nil;
    _bloodHitArr  = nil;
    _bloodHit3Arr = nil;
    _bloodHit4Arr = nil;
}

@end
