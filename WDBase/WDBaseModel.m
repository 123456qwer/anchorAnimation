//
//  WDBaseModel.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/20.
//

#import "WDBaseModel.h"

@implementation WDBaseModel

- (NSDictionary *)properties_aps

{
   NSMutableDictionary *props = [NSMutableDictionary dictionary];

   unsigned int outCount, i;

   objc_property_t *properties = class_copyPropertyList([self class], &outCount);

   for (i = 0; i<outCount; i++)

    {

       objc_property_t property = properties[i];

       const char* char_f =property_getName(property);

       NSString *propertyName = [NSString stringWithUTF8String:char_f];

       id propertyValue = [self valueForKey:(NSString *)propertyName];

       if (propertyValue) [props setObject:propertyValue forKey:propertyName];

    }

   free(properties);

   return props;

}

- (void)appendDataWithModel:(WDBaseModel *)model
                       name:(NSString *)userName{
   
    self.Equip_shield = [NSString stringWithFormat:@"%@,%@",self.Equip_shield,model.Equip_shield];
    self.Equip_helmet = [NSString stringWithFormat:@"%@,%@",self.Equip_helmet,model.Equip_helmet];
    self.Equip_armor = [NSString stringWithFormat:@"%@,%@",self.Equip_armor,model.Equip_armor];
    self.Equip_pauldrons = [NSString stringWithFormat:@"%@,%@",self.Equip_pauldrons,model.Equip_pauldrons];
    self.Equip_gloves = [NSString stringWithFormat:@"%@,%@",self.Equip_gloves,model.Equip_gloves];
    self.Equip_belt = [NSString stringWithFormat:@"%@,%@",self.Equip_belt,model.Equip_belt];
    self.Equip_boots = [NSString stringWithFormat:@"%@,%@",self.Equip_boots,model.Equip_boots];
    
    [self removeN];
    
    [[WDDataManager shareManager]changeDataWithModel:self userName:userName];
}

- (void)removeN{
   
    self.Equip_shield    = [self haveN:self.Equip_shield];
    self.Equip_helmet    = [self haveN:self.Equip_helmet];
    self.Equip_armor     = [self haveN:self.Equip_armor];
    self.Equip_pauldrons = [self haveN:self.Equip_pauldrons];
    self.Equip_gloves    = [self haveN:self.Equip_gloves];
    self.Equip_belt      = [self haveN:self.Equip_belt];
    self.Equip_boots     = [self haveN:self.Equip_boots];
}

- (NSString *)haveN:(NSString *)str{
    
    if ([str rangeOfString:@"n,"].location != NSNotFound) {
        
        return [str substringWithRange:NSMakeRange(2, str.length - 2)];
    }else{
        return str;
    }
}

@end
