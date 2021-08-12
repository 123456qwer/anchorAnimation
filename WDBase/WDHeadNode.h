//
//  WDHeadNode.h
//  MercenaryStory
//
//  Created by Mac on 2021/8/2.
//

#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDHeadNode : SKSpriteNode

@property (nonatomic,strong)WDBaseNode *eye;
@property (nonatomic,strong)WDBaseNode *eyeBrows;
@property (nonatomic,strong)WDBaseNode *ear;
@property (nonatomic,strong)WDBaseNode *mouth;
@property (nonatomic,strong)WDBaseNode *hair;
@property (nonatomic,strong)WDBaseNode *hemlet;
@property (nonatomic,strong)WDBaseNode *beard;
@property (nonatomic,strong)WDBaseNode *glass;

@property (nonatomic,assign)CGSize realSize;
@property (nonatomic,assign)CGPoint realPoint;

///默认嘴的纹理
@property (nonatomic,strong)SKTexture *defaultMouthTexture;
///默认眼睛的纹理
@property (nonatomic,strong)SKTexture *defaultEyeTexture;
///默认眉毛的纹理
@property (nonatomic,strong)SKTexture *defaultEyesBrowsTexture;


///创建脑袋、脸等
- (void)createFaceWithName:(NSString *)name;



@end


NS_ASSUME_NONNULL_END
