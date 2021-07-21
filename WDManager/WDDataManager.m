//
//  WDDataManager.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/20.
//

#import "WDDataManager.h"


static WDDataManager *dataManager = nil;

@implementation WDDataManager
+ (WDDataManager *)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!dataManager) {
            dataManager = [[WDDataManager alloc] init];
        }
    });
    
    return dataManager;
}


- (void)openDBwithName:(NSString *)userName{
    
    NSString *path = [self pathForName:userName];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        FMDatabase *db = [FMDatabase databaseWithPath:[self pathForName:userName]];
    
        if ([db open]) {
            
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE '%@' ('Equip_helmet' VARCHAR,'Equip_armor' VARCHAR,'Equip_pauldrons' VARCHAR,'Equip_gloves' VARCHAR,'Equip_belt' VARCHAR,'Equip_boots' VARCHAR,'Equip_shield' VARCHAR,'Equip_sword1h' VARCHAR,'Equip_sword2h' VARCHAR,'Equip_bow' VARCHAR,'Equip_mask' VARCHAR,'Equip_glasses' VARCHAR)",userName];
            BOOL res = [db executeUpdate:sql];
            if (res) {
                NSLog(@"create table success");
            }else{
                NSLog(@"create table error");
            }
                
            [db close];
            
        }else{
            NSLog(@"db 出错了！ ");
        }
    }

}

- (WDBaseModel *)searchData:(NSString *)userName{
    
    NSString *path = [self pathForName:userName];
    FMDatabase * db = [FMDatabase databaseWithPath:path];
    WDBaseModel *model = [[WDBaseModel alloc]init];
    if ([db open]) {
        NSArray *dataArr = @[@"Equip_helmet",@"Equip_armor",@"Equip_pauldrons",@"Equip_gloves",@"Equip_belt",@"Equip_boots",@"Equip_shield",@"Equip_sword1h",@"Equip_sword2h",@"Equip_bow",@"Equip_mask",@"Equip_glasses"];
        NSString *sql = [NSString stringWithFormat:@"select * from %@",userName];
        FMResultSet *rs = [db executeQuery:sql];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        while ([rs next]) {
            
            
            for (int i = 0; i < dataArr.count; i ++) {
                NSString *str = [rs stringForColumn:dataArr[i]];
                [dic setObject:str forKey:dataArr[i]];
            }
            
        }
        
        [model setValuesForKeysWithDictionary:dic];
        
        [db close];
    }
    
    return model;
}

- (void)changeDataWithModel:(WDBaseModel *)model
                   userName:(NSString *)userName{
    
    
    
    NSString *path = [self pathForName:userName];
    FMDatabase * db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        NSDictionary *dic = [model properties_aps];
        NSArray *dataArr = @[@"Equip_helmet",@"Equip_armor",@"Equip_pauldrons",@"Equip_gloves",@"Equip_belt",@"Equip_boots",@"Equip_shield",@"Equip_sword1h",@"Equip_sword2h",@"Equip_bow",@"Equip_mask",@"Equip_glasses"];
        NSMutableArray *values = [NSMutableArray arrayWithCapacity:dataArr.count];
        for (int i = 0; i < dataArr.count; i ++) {
            NSString *key = dataArr[i];
            [values addObject:dic[key]];
        }
        
        NSMutableString *str = [NSMutableString string];
        for (int i = 0; i < dataArr.count; i ++) {
            if (i == dataArr.count - 1) {
                [str appendString:[NSString stringWithFormat:@"%@ = '%@'",dataArr[i],values[i]]];
            }else{
                [str appendString:[NSString stringWithFormat:@"%@ = '%@',",dataArr[i],values[i]]];
            }
        }
        
        NSString *sql = [NSString stringWithFormat:@"update %@ set %@",userName,str];
        BOOL res = [db executeUpdate:sql];
        if (res) {
            NSLog(@"修改成功");
        }else{
            NSLog(@"修改失败");
        }
        
        [db close];
    }
    
}



- (void)changeData:(NSInteger )index
              name:(NSArray *)values
          userName:(NSString *)userName{
    
    
    NSString *path = [self pathForName:userName];
    FMDatabase * db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        NSArray *dataArr = @[@"Equip_helmet",@"Equip_armor",@"Equip_pauldrons",@"Equip_gloves",@"Equip_belt",@"Equip_boots",@"Equip_shield",@"Equip_sword1h",@"Equip_sword2h",@"Equip_bow",@"Equip_mask",@"Equip_glasses"];
    
        NSMutableString *str = [NSMutableString string];
        for (int i = 0; i < dataArr.count; i ++) {
            if (i == dataArr.count - 1) {
                [str appendString:[NSString stringWithFormat:@"%@ = '%@'",dataArr[i],values[i]]];
            }else{
                [str appendString:[NSString stringWithFormat:@"%@ = '%@',",dataArr[i],values[i]]];
            }
        }
        
        NSString *sql = [NSString stringWithFormat:@"update %@ set %@",userName,str];
        BOOL res = [db executeUpdate:sql];
        if (res) {
            NSLog(@"修改成功");
        }else{
            NSLog(@"修改失败");
        }
        
        [db close];
    }
}

- (void)insterData:(NSInteger )index
              name:(NSArray *)values
          userName:(NSString *)userName{
    
    NSString *path = [self pathForName:userName];
    FMDatabase * db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (Equip_helmet,Equip_armor,Equip_pauldrons,Equip_gloves,Equip_belt,Equip_boots,Equip_shield,Equip_sword1h,Equip_sword2h,Equip_bow,Equip_mask,Equip_glasses) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",userName,values[0],values[1],values[2],values[3],values[4],values[5],values[6],values[7],values[8],values[9],values[10],values[11]];
        BOOL res = [db executeUpdate:sql];
        if (res) {
            NSLog(@"插入成功");
        }else{
            NSLog(@"插入失败");
        }
        
        [db close];
    }
}

//获得指定名字的文件的全路径
- (NSString *)pathForName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths lastObject];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:name];
    return dbPath;
}

@end
