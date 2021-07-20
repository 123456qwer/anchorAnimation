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
    NSString *_key;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
       
        _selectDic = [NSMutableDictionary dictionary];
        for (int i = 0; i < 12; i ++) {
            NSMutableArray *arr = [NSMutableArray array];
            for (int j = 0; j < 20; j ++) {
                [arr addObject:@(0)];
            }
            NSString *key = [NSString stringWithFormat:@"%d",i];
            [_selectDic setObject:arr forKey:key];
        }
    }
    
    return self;
}
//

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
    
    
    NSMutableArray *arr = _selectDic[_key];
    if ([arr[indexPath.row] intValue] == 1) {
        cell.bgImageView.image = [UIImage imageNamed:@"Blue"];
    }else{
        cell.bgImageView.image = [UIImage imageNamed:@"Brown"];
    }
    
    return cell;
}

/// 帽子之类的直接加载
- (void)loadWithArr:(WDEquipCell *)cell indexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < _equipArr.count) {
        cell.equipImageView.image = [UIImage imageNamed:_equipArr[indexPath.row]];
        cell.yConstraint.constant = 25;
        cell.widthConstraint.constant = 200;
        cell.heightConstraint.constant = 200;
    }else{
        cell.equipImageView.image = nil;
    }
   
}

/// 盔甲类的需要截取
- (void)loadWithDic:(WDEquipCell *)cell indexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < _equipDic.allKeys.count) {
        NSString *armor = _equipDic.allKeys[indexPath.row];
        NSString *name = _equipDic[armor];
        
        
        NSDictionary *dic2 = [WDCalculateTool userArmorImageDic:[UIImage imageNamed:armor]];
        UIImage *image = dic2[name];
        cell.equipImageView.image = image;
        cell.yConstraint.constant = 0;
        cell.widthConstraint.constant = 150;
        cell.heightConstraint.constant = 150;
    }else{
        cell.equipImageView.image = nil;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *arr = _selectDic[_key];
    /// 选中不同的数据
    if ([arr[indexPath.row]intValue] == 0) {
        for (int i = 0; i < arr.count; i ++) {
            arr[i] = @(0);
        }
        
        if (_equipArr) {
            
            if (indexPath.row < _equipArr.count) {
                NSInteger ke = [_key integerValue];
                NSString *na = _equipArr[indexPath.row];
                [WDNotificationManager changeEquip:@{na:@(ke)}];
            }
            
        }else{
            
            if (indexPath.row < _equipDic.allKeys.count) {
                NSString *armor = _equipDic.allKeys[indexPath.row];
                NSString *name = _equipDic[armor];
                
                [WDNotificationManager changeEquip:@{armor:name}];
            }
        }
        
        
        
        arr[indexPath.row] = @(1);
        [self reloadData];
        
    }else{
        /// 选中相同的数据了
        
    }
    
   
}

- (void)reloadDataWithArr:(NSArray *)equipArr
{
    
}

- (void)reloadDataWithDic:(NSDictionary *)equipDic{
    
    
}

/// 帽子之类的
- (void)reloadDataWithArr:(NSArray *)equipArr
                    index:(NSInteger)index{
    _key = [NSString stringWithFormat:@"%ld",index + 1];
    _equipDic = nil;
    _equipArr = equipArr;
    [self reloadData];
}
/// 其他装备
- (void)reloadDataWithDic:(NSDictionary *)equipDic
                    index:(NSInteger)index{
    _key = [NSString stringWithFormat:@"%ld",index + 1];
    _equipArr = nil;
    _equipDic = equipDic;
    [self reloadData];
}

@end
