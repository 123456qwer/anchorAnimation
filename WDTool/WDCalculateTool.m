//
//  WDCalculateTool.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import "WDCalculateTool.h"

@implementation WDCalculateTool


+ (NSDictionary *)userArmorImageDic:(UIImage *)image
{
    
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
    
    //胯部
    UIImage *hipImage  = [UIImage imageWithCGImage:hipRef];
    
    //右手
    UIImage *rightHand = [UIImage imageWithCGImage:rightHandRef];
    
    //右手关节
    UIImage *rightArmKnee = [UIImage imageWithCGImage:rightArmKneeRef];
    
    // 右手指头
    UIImage *rightFinger  = [UIImage imageWithCGImage:rightFingerRef];
    //膝盖
    UIImage *knee      = [UIImage imageWithCGImage:kneeRef];
    
    //脚
    UIImage *foot      = [UIImage imageWithCGImage:footRef];
    
    //左手
    UIImage *leftHand  = [UIImage imageWithCGImage:leftHandRef];
    
    //左胳膊
    UIImage *leftArm   = [UIImage imageWithCGImage:leftArmRef];
    
    //右胳膊
    UIImage *rightArm  = [UIImage imageWithCGImage:rightArmRef];
    
    //左胳膊肘
    UIImage *leftArmKnee = [UIImage imageWithCGImage:leftArmKneeRef];
    
    NSDictionary *dic = @{kBody:bodyImage,kHip:hipImage,kRightHand:rightHand,kRightElbow:rightArmKnee,kRightFinger:rightFinger,kKnee:knee,kFoot:foot,kLeftHand:leftHand,kLeftArm:leftArm,kRightArm:rightArm,kLeftElbow:leftArmKnee};
    return dic;
}

+ (NSDictionary *)userImageDic
{
    UIImage *image = [UIImage imageNamed:@"Human"];
    
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
    
    //胯部
    UIImage *hipImage  = [UIImage imageWithCGImage:hipRef];
    
    //右手
    UIImage *rightHand = [UIImage imageWithCGImage:rightHandRef];
    
    //右手关节
    UIImage *rightArmKnee = [UIImage imageWithCGImage:rightArmKneeRef];
    
    // 右手指头
    UIImage *rightFinger  = [UIImage imageWithCGImage:rightFingerRef];
    //膝盖
    UIImage *knee      = [UIImage imageWithCGImage:kneeRef];
    
    //脚
    UIImage *foot      = [UIImage imageWithCGImage:footRef];
    
    //左手
    UIImage *leftHand  = [UIImage imageWithCGImage:leftHandRef];
    
    //左胳膊
    UIImage *leftArm   = [UIImage imageWithCGImage:leftArmRef];
    
    //右胳膊
    UIImage *rightArm  = [UIImage imageWithCGImage:rightArmRef];
    
    //左胳膊肘
    UIImage *leftArmKnee = [UIImage imageWithCGImage:leftArmKneeRef];
    
    NSDictionary *dic = @{kBody:bodyImage,kHip:hipImage,kRightHand:rightHand,kRightElbow:rightArmKnee,kRightFinger:rightFinger,kKnee:knee,kFoot:foot,kLeftHand:leftHand,kLeftArm:leftArm,kRightArm:rightArm,kLeftElbow:leftArmKnee};
    return dic;
}

+ (NSArray *)curUserImage:(UIImage *)image
{
    image = [UIImage imageNamed:@"Human"];
    
    CGImageRef imageRef = [image CGImage];
    
    CGImageRef bodyRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 0, 235, 230));
    CGImageRef hipRef  = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 230, 235, 160));
    CGImageRef rightHandRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 388, 115, 124));
    CGImageRef kneeRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(115, 388, 120, 124));
    CGImageRef footRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(237, 388, 114, 124));
    CGImageRef leftHandRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(235, 285, 114, 103));
    CGImageRef leftArmRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(235, 0, 138, 160));
    CGImageRef rightArmRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(375, 0, 138, 160));
    CGImageRef leftArmKneeRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(235, 160, 114, 125));
    CGImageRef rightArmKneeRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(375, 160, 161, 161));
    CGImageRef rightFingerRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(425, 321, 32, 32));
    
    //身体
    UIImage *bodyImage = [UIImage imageWithCGImage:bodyRef];
    
    //胯部
    UIImage *hipImage  = [UIImage imageWithCGImage:hipRef];
    
    //右手
    UIImage *rightHand = [UIImage imageWithCGImage:rightHandRef];
    
    //右手关节
    UIImage *rightArmKnee = [UIImage imageWithCGImage:rightArmKneeRef];
    
    // 右手指头
    UIImage *rightFinger  = [UIImage imageWithCGImage:rightFingerRef];
    //膝盖
    UIImage *knee      = [UIImage imageWithCGImage:kneeRef];
    
    //脚
    UIImage *foot      = [UIImage imageWithCGImage:footRef];
    
    //左手
    UIImage *leftHand  = [UIImage imageWithCGImage:leftHandRef];
    
    //左胳膊
    UIImage *leftArm   = [UIImage imageWithCGImage:leftArmRef];
    
    //右胳膊
    UIImage *rightArm  = [UIImage imageWithCGImage:rightArmRef];
    
    //左胳膊肘
    UIImage *leftArmKnee = [UIImage imageWithCGImage:leftArmKneeRef];
  
    
    return @[bodyImage,hipImage,rightHand,rightArmKnee,rightFinger,knee,foot,leftHand,leftArm,rightArm,leftArmKnee];
    
}


+ (SKTexture *)textureWithArmorKeyName:(NSString *)name armorName:(NSString *)armor
{
    NSDictionary *dic = [WDCalculateTool userArmorImageDic:[UIImage imageNamed:armor]];
    UIImage *image = dic[name];
    SKTexture *texture = [SKTexture textureWithImage:image];
    return texture;
}

+ (WDBaseNode *)textureWithKeyName:(NSString *)name
{
    NSDictionary *dic = [WDCalculateTool userImageDic];
    UIImage *image = dic[name];
    SKTexture *texture = [SKTexture textureWithImage:image];
    WDBaseNode *node = [WDBaseNode spriteNodeWithTexture:texture];
    node.name = name;
    return node;
}

@end
