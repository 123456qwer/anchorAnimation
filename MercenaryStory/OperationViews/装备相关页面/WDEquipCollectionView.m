//
//  WDEquipCollectionView.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/20.
//

#import "WDEquipCollectionView.h"
#import "WDEquipCell.h"

@implementation WDEquipCollectionView
{
    NSArray *_equipArr;
    NSDictionary *_equipDic;
    BOOL _isSelect[30];
    NSMutableDictionary *_selectDic;
    NSString *_equipType; //EquipType
    NSString *_userName;
    NSMutableArray *_haveChangeArr;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
       
        /// 所有装备是否选中的判断
        _selectDic = [NSMutableDictionary dictionary];
        /// 是否由更改过的判断
        _haveChangeArr = [NSMutableArray array];
        
        for (int i = 0; i < 12; i ++) {
            NSMutableArray *arr = [NSMutableArray array];
            for (int j = 0; j < 20; j ++) {
                [arr addObject:@(0)];
            }
            NSString *key = [NSString stringWithFormat:@"%d",i];
            [_selectDic setObject:arr forKey:key];
            
            [_haveChangeArr addObject:@(0)];
        }
    }
    
    return self;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 20;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
   
    WDEquipCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WDEquipCell class]) forIndexPath:indexPath];
    
    if (_equipArr) {
        [self loadWithArr:cell indexPath:indexPath];
    }else if(_equipDic){
        [self loadWithDic:cell indexPath:indexPath];
    }else{
        cell.equipImageView.image = nil;
    }
    
    NSMutableArray *arr = _selectDic[_equipType];
    if ([arr[indexPath.row] intValue] == 1) {
        cell.bgImageView.image = [UIImage imageNamed:@"Blue"];
    }else{
        cell.bgImageView.image = [UIImage imageNamed:@"Brown"];
    }
    
    return cell;
}

/// 帽子之类的直接加载
- (void)loadWithArr:(WDEquipCell *)cell indexPath:(NSIndexPath *)indexPath{
    
    NSString *dataString = _equipArr[0];
    NSArray *data = [dataString componentsSeparatedByString:@","];
    if (indexPath.row < data.count) {
        
        NSString *equipStr = data[indexPath.row];
        equipStr = [self subArr:equipStr][0];
      
        if ([_equipType intValue] == Equip_bow) {
            equipStr = [NSString stringWithFormat:@"%@的副本",equipStr];
        }
        
        cell.equipImageView.image = [UIImage imageNamed:equipStr];
        cell.yConstraint.constant = 25;
        cell.widthConstraint.constant = 200;
        cell.heightConstraint.constant = 200;
    }else{
        cell.equipImageView.image = nil;
    }
   
}

- (NSArray *)subArr:(NSString *)str{
    return [str componentsSeparatedByString:@"_"];
}

/// 盔甲类的需要截取
- (void)loadWithDic:(WDEquipCell *)cell indexPath:(NSIndexPath *)indexPath{
    
    NSString *bodyName = _equipDic.allKeys[0];
    NSString *armors = _equipDic[bodyName];
    NSArray *armorArr = [armors componentsSeparatedByString:@","];
    
    if (indexPath.row < armorArr.count) {
      
        NSString *armor = armorArr[indexPath.row];
        armor = [self subArr:armor][0];
        if ([armor isEqualToString:@"n"]) {
            cell.equipImageView.image = nil;
            return;
        }
        
        NSDictionary *dic2 = [WDCalculateTool userArmorImageDic:[UIImage imageNamed:armor]];
        UIImage *image = dic2[bodyName];
        cell.equipImageView.image = image;
        cell.yConstraint.constant = 0;
        if (image.size.width < 150) {
            cell.widthConstraint.constant = image.size.width;
            cell.heightConstraint.constant = image.size.height;
        }else{
            cell.widthConstraint.constant = 150;
            cell.heightConstraint.constant = 150;
        }
        
    }else{
        cell.equipImageView.image = nil;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *arr = _selectDic[_equipType];
    
    /// 选中不同的数据
    if ([arr[indexPath.row]intValue] == 0) {
        for (int i = 0; i < arr.count; i ++) {
            arr[i] = @(0);
        }
        
        if (_equipArr) {
           
            NSString *dataString = _equipArr[0];
            NSArray *data = [dataString componentsSeparatedByString:@","];
            
            if (indexPath.row < data.count) {
                NSInteger ke = [_equipType integerValue];
                NSString *na = data[indexPath.row];
                //na = [self subArr:na][0];
                [WDNotificationManager changeEquip:@{na:@(ke)}];
            }
            
        }else{
            
            NSString *bodyName = _equipDic.allKeys[0];
            NSString *armors = _equipDic[bodyName];
            NSArray *armorArr = [armors componentsSeparatedByString:@","];
            
            if (indexPath.row < armorArr.count) {
                
                NSString *armor = armorArr[indexPath.row];
                //armor = [self subArr:armor][0];
                [WDNotificationManager changeEquip:@{armor:bodyName}];
                
            }
        }
        
        
        arr[indexPath.row] = @(1);
        [self reloadData];
        
    }else{
        /// 选中相同的数据了
        for (int i = 0; i < arr.count; i ++) {
            arr[i] = @(0);
        }
        
        if (_equipArr) {
            
            NSString *dataString = _equipArr[0];
            NSArray *data = [dataString componentsSeparatedByString:@","];
            
            if (indexPath.row < data.count) {
                NSInteger ke = [_equipType integerValue];
                [WDNotificationManager changeEquip:@{@"n":@(ke)}];
            }
            
            if (indexPath.row < _equipArr.count) {
                NSInteger ke = [_equipType integerValue];
                [WDNotificationManager changeEquip:@{@"n":@(ke)}];
            }
            
        }else{
            
            NSString *bodyName = _equipDic.allKeys[0];
            NSString *armors = _equipDic[bodyName];
            NSArray *armorArr = [armors componentsSeparatedByString:@","];
            
            if (indexPath.row < armorArr.count) {
                
                [WDNotificationManager changeEquip:@{@"n":bodyName}];
            }
          
        }
        
        arr[indexPath.row] = @(0);
        [self reloadData];
    }
    
   
}



/// 数组类，帽子、武器之类不需要切割的
- (void)reloadDataWithArr:(NSArray *)equipArr
                    index:(NSInteger)index
                     name:(NSString *)userName{
    
    _userName = userName;
    
    _equipType = [NSString stringWithFormat:@"%ld",index + 1];
    _equipDic = nil;
    _equipArr = equipArr;
    
    NSMutableArray *arr = _selectDic[_equipType];
    
    BOOL haveChangeData = NO;
    
    if([_haveChangeArr[index]intValue] == 1){
        haveChangeData = YES;
    }
    
    /// 如果没有改变过数据，在进行遍历，避免用户选中以后在重新遍历
    if (!haveChangeData) {
        NSString *dataString = _equipArr[0];
        NSArray *data = [dataString componentsSeparatedByString:@","];
        
        
        WDBaseModel *model = [[WDDataManager shareManager] searchData:userName];
        NSDictionary *dic = [model properties_aps];
        
        NSString *value = dic[[self modelKey:index]];
        [WDNotificationManager changeEquip:@{value:@([_equipType intValue])}];

        
        for (int i = 0; i < arr.count; i ++) {
            arr[i] = @(0);
        }
        
        for (int i = 0; i < data.count; i ++) {
            NSString *armor = data[i];
            if ([armor isEqualToString:value]) {
                arr[i] = @(1);
                break;
            }else{
                arr[i] = @(0);
            }
        }
        
        _haveChangeArr[index] = @(1);
    }
    
    
    [self reloadData];
}

/// 需要图片切割的装备，需要知道切割部位
- (void)reloadDataWithDic:(NSDictionary *)equipDic
                    index:(NSInteger)index
                     name:(NSString *)userName{
    
    _userName = userName;
    _equipType = [NSString stringWithFormat:@"%ld",index + 1];
    _equipArr = nil;
    _equipDic = equipDic;
    
    NSMutableArray *arr = _selectDic[_equipType];
    
    BOOL haveChangeData = NO;
    
    if([_haveChangeArr[index]intValue] == 1){
        haveChangeData = YES;
    }
    
    /// 如果没有改变过数据，在进行遍历，避免用户选中以后在重新遍历
    if (!haveChangeData) {
        
        NSString *bodyName = _equipDic.allKeys[0];
        NSString *armors = _equipDic[bodyName];
        NSArray *data = [armors componentsSeparatedByString:@","];
        
        WDBaseModel *model = [[WDDataManager shareManager] searchData:userName];
        NSDictionary *dic = [model properties_aps];
        
        NSString *value = dic[[self modelKey:index]];
        [WDNotificationManager changeEquip:@{value:@([_equipType intValue])}];

        
        for (int i = 0; i < arr.count; i ++) {
            arr[i] = @(0);
        }
        
        for (int i = 0; i < data.count; i ++) {
            NSString *armor = data[i];
            if ([armor isEqualToString:value]) {
                arr[i] = @(1);
                break;
            }else{
                arr[i] = @(0);
            }
        }
        
        _haveChangeArr[index] = @(1);
    }
    
    
    [self reloadData];
}


- (NSString *)modelKey:(NSInteger)index{
    NSArray *dataArr = @[@"Equip_helmet",@"Equip_armor",@"Equip_pauldrons",@"Equip_gloves",@"Equip_belt",@"Equip_boots",@"Equip_shield",@"Equip_sword1h",@"Equip_sword2h",@"Equip_bow",@"Equip_mask",@"Equip_glasses"];
    return dataArr[index];
}

- (void)reloadHaveChangeArr{
    for (int i = 0; i < _haveChangeArr.count; i++) {
        _haveChangeArr[i] = @(0);
    }
}

@end
