//
//  WDRedBatModel.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/15.
//

#import "WDRedBatModel.h"

@implementation WDRedBatModel
- (void)changeArr
{
    self.beHurtArr = [self stateName:@"hurt" textureName:kRedBat number:8];
}

- (NSMutableArray *)stateName:(NSString *)stateName
                  textureName:(NSString *)name
                       number:(int)number
{
    NSMutableArray *textures = [NSMutableArray arrayWithCapacity:number];
    for (int i = 0; i < number; i ++) {
        NSString *textureName = [NSString stringWithFormat:@"%@_%@_%d",name,stateName,i];
//        NSString *urlPath = [[NSBundle mainBundle]pathForResource:textureName ofType:@"png"];
//        NSData *data = [NSData dataWithContentsOfFile:urlPath];
        UIImage *image = [UIImage imageNamed:textureName];
        //image = [self seacalImageWithData:data withSize:CGSizeMake(image.size.width / 2.0, image.size.height / 2.0) scale:0 orientation:UIImageOrientationUp];
        SKTexture *texture = [SKTexture textureWithImage:image];
        [textures addObject:texture];
        
    }
    
    return textures;
}

- (void)setNormalTexturesWithName:(NSString *)name
                      standNumber:(int)standNumber
                        runNumber:(int)runNumber
                       walkNumber:(int)walkNumber
                       diedNumber:(int)diedNumber
                    attack1Number:(int)attackNumber
{
    
    NSArray *bigArr = @[@(standNumber),@(runNumber),@(walkNumber),@(diedNumber),@(attackNumber)];
    int big = 0;
    for (NSNumber *number in bigArr) {
        if ([number intValue] > big) {
            big = [number intValue];
        }
    }
    
    NSMutableArray *standArr = [NSMutableArray array];
    NSMutableArray *walkArr = [NSMutableArray array];
    NSMutableArray *diedArr = [NSMutableArray array];
    NSMutableArray *attackArr1 = [NSMutableArray array];
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:name];
    for (int i = 0; i < big; i ++) {
        
        /// 站立
        if (i < standNumber) {
            [self createNameWithString:name actionName:@"stand" index:i arr:standArr atlas:atlas];
        }
        
        /// 移动
        if (i < walkNumber) {
            [self createNameWithString:name actionName:@"walk" index:i arr:walkArr atlas:atlas];
        }
        
        /// 死亡
        if (i < diedNumber) {
            [self createNameWithString:name actionName:@"died" index:i arr:diedArr atlas:atlas];
        }
        
        /// 攻击
        if (i < attackNumber) {
            [self createNameWithString:name actionName:@"attack1" index:i arr:attackArr1 atlas:atlas];
        }
        
    }
    
    self.standArr = [standArr copy];
    self.walkArr  = [walkArr copy];
    self.diedArr  = [diedArr copy];
    self.attackArr1 = [attackArr1 copy];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 4; i ++) {
        NSString *reduce = [NSString stringWithFormat:@"reduceSpeed_%d",i];
        SKTexture *texture = [SKTexture textureWithImage:[UIImage imageNamed:reduce]];
        [arr addObject:texture];
    }
    

}

- (void)createNameWithString:(NSString *)name
                  actionName:(NSString *)behaviorName
                       index:(int)index
                         arr:(NSMutableArray *)arr
                       atlas:(SKTextureAtlas *)atlas
{
    NSString *textureName = [NSString stringWithFormat:@"%@_%@_%d",name,behaviorName,index];
    [arr addObject:[atlas textureNamed:textureName]];
}

@end
