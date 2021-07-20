//
//  WDEquipButtonCollectionView.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/20.
//

#import "WDEquipButtonCollectionView.h"
#import "WDEquipBtnCell.h"

@implementation WDEquipButtonCollectionView
{
    NSArray *_btnArr;
    BOOL _isSelect[12];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        _isSelect[0] = YES;
        _btnArr = @[@"Helmet",@"Armor",@"Pauldrons",@"Gloves",@"Belt",@"Boots",@"Shield",@"Sword1H",@"Sword2H",@"Bow",@"Mask",@"Glasses"];
    }
    
    return self;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 12;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    WDEquipBtnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WDEquipBtnCell class]) forIndexPath:indexPath];
    cell.equipImageView.image = [UIImage imageNamed:_btnArr[indexPath.row]];
    if (_isSelect[indexPath.row]) {
        cell.bgImageView.image = [UIImage imageNamed:@"ButtonG"];
    }else{
        cell.bgImageView.image = [UIImage imageNamed:@"Button"];
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_isSelect[indexPath.row]) {
        for (int i = 0; i < _btnArr.count; i ++) {
            _isSelect[i] = NO;
        }
    }
    
    _isSelect[indexPath.row] = YES;
    [self reloadData];
    
    _changeEquipBlock(indexPath.row);
}

@end
