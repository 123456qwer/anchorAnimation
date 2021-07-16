//
//  WDCalculateTool.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import "WDCalculateTool.h"
#import "WDEnemyNode.h"
#import "WDUserNode.h"

@implementation WDCalculateTool

#pragma mark - 计算相关 -
+ (CGFloat)distanceBetweenPoints:(CGPoint)first
                         seconde:(CGPoint)second{
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY );
}

+ (CGFloat)angleForStartPoint:(CGPoint)startPoint
                     EndPoint:(CGPoint)endPoint{
    
    CGPoint Xpoint = CGPointMake(startPoint.x + 100, startPoint.y);
    
    CGFloat a = endPoint.x - startPoint.x;
    CGFloat b = endPoint.y - startPoint.y;
    CGFloat c = Xpoint.x - startPoint.x;
    CGFloat d = Xpoint.y - startPoint.y;
    
    CGFloat rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    
    if (startPoint.y>endPoint.y) {
        rads = -rads;
    }
    return rads;
}

+ (CGPoint)calculateNodeMovePosition:(WDBaseNode *)attackNode
                               enemy:(WDBaseNode *)targetNode{
    
    int x = 0;
    CGFloat y = targetNode.position.y;
    
    /// 确定哪个是玩家
    WDUserNode *user = nil;
    WDEnemyNode *enemy = nil;
    
    if ([attackNode isKindOfClass:[WDUserNode class]]) {
        user = (WDUserNode *)attackNode;
        enemy = (WDEnemyNode *)targetNode;
    }else{
        user = (WDUserNode *)targetNode;
        enemy = (WDEnemyNode *)attackNode;
    }
    
    
    
    if (attackNode.position.x > targetNode.position.x) {
        x = targetNode.position.x + attackNode.attackMaxSize + targetNode.attackMaxSize;
    }else{
        x = targetNode.position.x - attackNode.attackMaxSize - targetNode.attackMaxSize;
    }
    
    /// 同一个位置不占人
    if ([attackNode isKindOfClass:[WDEnemyNode class]]) {
        if (![user.targetNode isEqualToNode:attackNode]) {
            if (user.xScale > 0) {
                x = user.position.x - user.size.width - enemy.randomAttackX;
            }else{
                x = user.position.x + user.size.width + enemy.randomAttackX;
            }
        }
    }
    
    y = targetNode.position.y + enemy.randomAttackY;
    return CGPointMake(x, y);
}

+ (CGPoint)calculateNodeMovePositionForBow:(WDBaseNode *)attackNode
                                     enemy:(WDBaseNode *)targetNode{
    
    int x = 0;
    CGFloat y = targetNode.position.y;
    
    /// 确定哪个是玩家
    WDUserNode *user = nil;
    WDEnemyNode *enemy = nil;
    
    if ([attackNode isKindOfClass:[WDUserNode class]]) {
        user = (WDUserNode *)attackNode;
        enemy = (WDEnemyNode *)targetNode;
    }else{
        user = (WDUserNode *)targetNode;
        enemy = (WDEnemyNode *)attackNode;
    }
    
    CGFloat dis = attackNode.size.width * 2.0;
    
    if (attackNode.position.x > targetNode.position.x) {
        x = targetNode.position.x + targetNode.size.width + enemy.randomAttackX + dis;
    }else{
        x = targetNode.position.x - targetNode.size.width - enemy.randomAttackX - dis;
    }
    
    /// 同一个位置不占人
    if ([attackNode isKindOfClass:[WDEnemyNode class]]) {
        if (![user.targetNode isEqualToNode:attackNode]) {
            if (user.xScale > 0) {
                x = user.position.x - user.size.width - enemy.randomAttackX - dis;
            }else{
                x = user.position.x + user.size.width + enemy.randomAttackX + dis;
            }
        }
    }
    
    CGFloat wi = attackNode.parent.frame.size.width / 2;
    
    if (x > wi - enemy.size.width) {
        x = wi - enemy.size.width;
    }else if(x < -wi + enemy.size.width){
        x = -wi + enemy.size.width;
    }
    
    y = targetNode.position.y + enemy.randomAttackY;
    return CGPointMake(x, y);
}

+ (CGPoint)calculateMaxMovePosition:(CGPoint)movePoint
                               node:(WDBaseNode *)node{
    
    CGFloat x = movePoint.x;
    CGFloat y = movePoint.y;
    
    if (x > kScreenWidth - node.size.width) {
        x = kScreenWidth - node.size.width;
    }else if(x < -kScreenWidth + node.size.width + node.size.width / 2.0){
        x = -kScreenWidth + node.size.width + node.size.width / 2.0;
    }
    
    if (y > kScreenHeight - node.size.height) {
        y = kScreenHeight - node.size.height;
    }else if(y < -kScreenHeight + node.size.height){
        y = -kScreenHeight + node.size.height;
    }
    
    
    return CGPointMake(x, y);
}


#pragma mark - 图片相关 -
+ (NSDictionary *)userArmorImageDic:(UIImage *)image{
    
    CGImageRef imageRef = [image CGImage];
    
    CGImageRef bodyRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 0, 235, 230));
    CGImageRef hipRef  = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 230, 235, 160));
    CGImageRef rightHandRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 388, 115, 124));
    CGImageRef kneeRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(115, 388, 120, 124));
    CGImageRef footRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(235, 388, 120, 124));
    CGImageRef leftHandRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(235, 285, 114, 103));
    CGImageRef leftArmRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(235, 0, 138, 160));
    CGImageRef rightArmRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(375, 0, 138, 160));
    CGImageRef leftArmKneeRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(235, 160, 114, 125));
    CGImageRef rightArmKneeRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(375, 160, 161, 161));
    CGImageRef rightFingerRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(425, 321, 32, 32));
    
    //身体
    UIImage *bodyImage = [UIImage imageWithCGImage:bodyRef];
    CGImageRelease(bodyRef);
    //胯部
    UIImage *hipImage  = [UIImage imageWithCGImage:hipRef];
    CGImageRelease(hipRef);

    //右手
    UIImage *rightHand = [UIImage imageWithCGImage:rightHandRef];
    CGImageRelease(rightHandRef);

    //右手关节
    UIImage *rightArmKnee = [UIImage imageWithCGImage:rightArmKneeRef];
    CGImageRelease(rightArmKneeRef);

    // 右手指头
    UIImage *rightFinger  = [UIImage imageWithCGImage:rightFingerRef];
    CGImageRelease(rightFingerRef);

    //膝盖
    UIImage *knee = [UIImage imageWithCGImage:kneeRef];
    CGImageRelease(kneeRef);

    //脚
    UIImage *foot = [UIImage imageWithCGImage:footRef];
    CGImageRelease(footRef);

    //左手
    UIImage *leftHand = [UIImage imageWithCGImage:leftHandRef];
    CGImageRelease(leftHandRef);

    //左胳膊
    UIImage *leftArm  = [UIImage imageWithCGImage:leftArmRef];
    CGImageRelease(leftArmRef);

    //右胳膊
    UIImage *rightArm  = [UIImage imageWithCGImage:rightArmRef];
    CGImageRelease(rightArmRef);

    //左胳膊肘
    UIImage *leftArmKnee = [UIImage imageWithCGImage:leftArmKneeRef];
    CGImageRelease(leftArmKneeRef);
    
    NSDictionary *dic = @{kBody:bodyImage,kHip:hipImage,kRightHand:rightHand,kRightElbow:rightArmKnee,kRightFinger:rightFinger,kKnee:knee,kFoot:foot,kLeftHand:leftHand,kLeftArm:leftArm,kRightArm:rightArm,kLeftElbow:leftArmKnee};
    return dic;
}

+ (NSDictionary *)userDic{
    UIImage *image = [UIImage imageNamed:@"Human"];
    NSDictionary *userDic = [self curWithImage:image];
    [WDTextureManager shareManager].humamDic = userDic;
    return userDic;
}

+ (NSDictionary *)skeletonDic{
    UIImage *image = [UIImage imageNamed:@"Skeleton"];
    NSDictionary *skeletonDic = [self curWithImage:image];
    [WDTextureManager shareManager].skeletonDic = skeletonDic;
    return [self curWithImage:image];
}

+ (NSArray *)cutBow:(UIImage *)image{
    
    CGImageRef imageRef = [image CGImage];
    
    CGImageRef bowMiddleRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 0, image.size.width / 2.0, 335));
    CGImageRef bowRef       = CGImageCreateWithImageInRect(imageRef, CGRectMake(image.size.width / 2.0, 0, image.size.width / 2.0, 335));
    CGImageRef arrowRef     = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 335, image.size.width, image.size.height - 335));
    
    SKTexture *bowMiddle = [SKTexture textureWithImage:[UIImage imageWithCGImage:bowMiddleRef]];
    
    SKTexture *bow       = [SKTexture textureWithImage:[UIImage imageWithCGImage:bowRef]];
    
    SKTexture *arrow     = [SKTexture textureWithImage:[UIImage imageWithCGImage:arrowRef]];
    
    return @[bowMiddle,bow,arrow];
}

+ (NSDictionary *)curWithImage:(UIImage *)image{
   
    CGImageRef imageRef = [image CGImage];
   
    CGImageRef bodyRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 0, 235, 230));
    CGImageRef hipRef  = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 230, 235, 160));
    CGImageRef rightHandRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 388, 115, 124));
    CGImageRef kneeRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(115, 388, 120, 124));
    CGImageRef footRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(235, 388, 120, 124));
    CGImageRef leftHandRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(235, 285, 114, 103));
    CGImageRef leftArmRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(235, 0, 138, 160));
    CGImageRef rightArmRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(375, 0, 138, 160));
    CGImageRef leftArmKneeRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(235, 160, 114, 125));
    CGImageRef rightArmKneeRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(375, 160, 161, 161));
    CGImageRef rightFingerRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(425, 321, 32, 32));
    
    //身体
    UIImage *bodyImage = [UIImage imageWithCGImage:bodyRef];
    CGImageRelease(bodyRef);
    //胯部
    UIImage *hipImage  = [UIImage imageWithCGImage:hipRef];
    CGImageRelease(hipRef);

    //右手
    UIImage *rightHand = [UIImage imageWithCGImage:rightHandRef];
    CGImageRelease(rightHandRef);

    //右手关节
    UIImage *rightArmKnee = [UIImage imageWithCGImage:rightArmKneeRef];
    CGImageRelease(rightArmKneeRef);

    // 右手指头
    UIImage *rightFinger  = [UIImage imageWithCGImage:rightFingerRef];
    CGImageRelease(rightFingerRef);

    //膝盖
    UIImage *knee = [UIImage imageWithCGImage:kneeRef];
    CGImageRelease(kneeRef);

    //脚
    UIImage *foot = [UIImage imageWithCGImage:footRef];
    CGImageRelease(footRef);

    //左手
    UIImage *leftHand = [UIImage imageWithCGImage:leftHandRef];
    CGImageRelease(leftHandRef);

    //左胳膊
    UIImage *leftArm  = [UIImage imageWithCGImage:leftArmRef];
    CGImageRelease(leftArmRef);

    //右胳膊
    UIImage *rightArm  = [UIImage imageWithCGImage:rightArmRef];
    CGImageRelease(rightArmRef);

    //左胳膊肘
    UIImage *leftArmKnee = [UIImage imageWithCGImage:leftArmKneeRef];
    CGImageRelease(leftArmKneeRef);

    
    
    
    NSDictionary *dic = @{kBody:[SKTexture textureWithImage:bodyImage],
                          kHip:[SKTexture textureWithImage:hipImage],
                          kRightHand:[SKTexture textureWithImage:rightHand],
                          kRightElbow:[SKTexture textureWithImage:rightArmKnee],
                          kRightFinger:[SKTexture textureWithImage:rightFinger],
                          kKnee:[SKTexture textureWithImage:knee],
                          kFoot:[SKTexture textureWithImage:foot],
                          kLeftHand:[SKTexture textureWithImage:leftHand],
                          kLeftArm:[SKTexture textureWithImage:leftArm],
                          kRightArm:[SKTexture textureWithImage:rightArm],
                          kLeftElbow:[SKTexture textureWithImage:leftArmKnee]};
    
    return dic;
}



+ (SKTexture *)textureWithArmorKeyName:(NSString *)name armorName:(NSString *)armor{
    NSDictionary *dic = [WDCalculateTool userArmorImageDic:[UIImage imageNamed:armor]];
    UIImage *image = dic[name];
    SKTexture *texture = [SKTexture textureWithImage:image];
    return texture;
}

+ (WDBaseNode *)textureWithKeyName:(NSString *)name{
  
    NSDictionary *dic = @{};
    if ([WDTextureManager shareManager].humamDic.count > 0) {
        dic = [WDTextureManager shareManager].humamDic;
    }else{
        dic = [WDCalculateTool userDic];
    }
    
    
    SKTexture *texture = dic[name];
    WDBaseNode *node = [WDBaseNode spriteNodeWithTexture:texture];
    node.name = name;
    return node;
}

+ (WDBaseNode *)textureWithKeyNameForSkeleton:(NSString *)name{
    NSDictionary *dic = @{};
    if ([WDTextureManager shareManager].skeletonDic.count > 0) {
        dic = [WDTextureManager shareManager].skeletonDic;
    }else{
        dic = [WDCalculateTool skeletonDic];
    }
    
    SKTexture *texture = dic[name];
    WDBaseNode *node = [WDBaseNode spriteNodeWithTexture:texture];
    node.name = name;
    return node;
}


+ (NSArray *)curImageWithImage:(UIImage *)image
                          line:(NSInteger)line
                       arrange:(NSInteger)arrange
                      itemSize:(CGSize)imageSize
                         count:(NSInteger)count
{
    CGImageRef imageRef1 = [image CGImage];

    
    UIImage *curImage = [UIImage imageWithCGImage:imageRef1];
    
    CGImageRef imageRef = [curImage CGImage];
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    NSMutableArray *imagesArr = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 0; i < count; i ++) {
           
        CGFloat x = i % arrange * width;
        CGFloat y = i / arrange * height;
       
        CGRect frame = CGRectMake(x, y, width, height);
        CGImageRef subImage = CGImageCreateWithImageInRect(imageRef, frame);
        UIImage *newImage = [UIImage imageWithCGImage:subImage];
        SKTexture *texture = [SKTexture textureWithImage:newImage];
        [imagesArr addObject:texture];
           
        dispatch_async(dispatch_get_main_queue(), ^{
            //CGImageRelease(subImage);
        });

    }
    
    
    return imagesArr;
}

+ (NSArray *)arrWithLine:(NSInteger)line
                 arrange:(NSInteger)arrange
               imageSize:(CGSize)imageSize
           subImageCount:(NSInteger)count
                   image:(UIImage *)image
           curImageFrame:(CGRect)frame{
    
   // UIImage *passImage = [UIImage imageNamed:@"chest1"];
    CGImageRef imageRef1 = [image CGImage];

    
    CGImageRef subImage = CGImageCreateWithImageInRect(imageRef1, frame);
    UIImage *curImage = [UIImage imageWithCGImage:subImage];
    
    CGImageRef imageRef = [curImage CGImage];
    
    CGFloat width = imageSize.height / (CGFloat)line;
    CGFloat height = imageSize.width / (CGFloat)arrange;
    
    NSMutableArray *imagesArr = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 0; i < count; i ++) {
           
        CGFloat x = i % arrange * width;
        CGFloat y = i / arrange * height;
       
        CGRect frame = CGRectMake(x, y, width, height);
        CGImageRef subImage = CGImageCreateWithImageInRect(imageRef, frame);
        UIImage *newImage = [UIImage imageWithCGImage:subImage];
        SKTexture *texture = [SKTexture textureWithImage:newImage];
        [imagesArr addObject:texture];
           
        dispatch_async(dispatch_get_main_queue(), ^{
            //CGImageRelease(subImage);
        });

    }
    
    
    return imagesArr;
    
}

@end
