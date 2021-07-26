//
//  WDEquipView.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/16.
//

#import "WDEquipView.h"
#import "WDEquipCell.h"
#import "WDEquipBtnCell.h"
#import "WDEquipCollectionView.h"
#import "WDEquipButtonCollectionView.h"

@implementation WDEquipView
{
    WDEquipButtonCollectionView *_equipButtonCollectionView;
    WDEquipCollectionView *_equipCollectionView;
    
    CGFloat _bgWidth;
    CGFloat _bgHeight;
    
    NSDictionary *_allEquipDic;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
  
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.backgroundColor = [UIColor orangeColor];
        [self bgView];
        [self createEquipButtonCollctionView];
        [self createEquipCollectionView];
    }
    
    return self;
}

- (void)cancelConfirmBtn{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(-120 + kScreenWidth / 2.0, _bgHeight - 50, 50, 50)];
    [btn setImage:[UIImage imageNamed:@"confirm"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 25.f;
    btn.backgroundColor = [UIColor whiteColor];
    [self.superview addSubview:btn];
    
}

- (void)confirmAction:(UIButton *)sender{
    
    [sender removeFromSuperview];
    [_equipCollectionView reloadHaveChangeArr];
    self.hidden = YES;
    
    _confirmBlock();
}



- (void)reloadDataWithName:(NSString *)name {
    
    
    [WDDataManager shareManager].userName = name;
    _equipButtonCollectionView.userName = name;
    [_equipButtonCollectionView reloadAction];
    
    NSString *key = [NSString stringWithFormat:@"%@_user",name];
    WDBaseModel *model = [[WDDataManager shareManager]searchData:key];
    
    NSArray *helmets = @[model.Equip_helmet];
    NSDictionary *armors = @{kBody:model.Equip_armor};
    NSDictionary *leftArm = @{kLeftArm:model.Equip_pauldrons};
    NSDictionary *gloves = @{kLeftHandAro:model.Equip_gloves};
    NSDictionary *hip = @{kHip:model.Equip_belt};
    NSDictionary *foot = @{kFoot:model.Equip_boots};
    
    NSArray *shield   = @[model.Equip_shield];
    NSArray *weapon1s = @[model.Equip_sword1h];
    
    _allEquipDic = @{@"1":helmets,@"2":armors,@"3":leftArm,@"4":gloves,@"5":hip,@"6":foot,@"7":shield,@"8":weapon1s};
    [self changeEquip:Equip_helmet - 1 name:name];
}


- (void)bgView{
    
    UIImage *bg = [UIImage imageNamed:@"Panel"];
    UIImage *newBg = [bg stretchableImageWithLeftCapWidth:32 topCapHeight:32];
    
    _bgWidth  = kScreenWidth / 2.0 - 10;
    _bgHeight = kScreenHeight - 20;
    
    UIImageView *bgImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth / 2.0 - 10, kScreenHeight - 20)];
    bgImageV.image = newBg;
    [self addSubview:bgImageV];
}

- (void)createEquipButtonCollctionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    // 设置item的行间距和列间距
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;

    // 设置item的大小
    CGFloat itemW = (_bgWidth - 5 * 7.f - 20) / 6.0 ;
    layout.itemSize = CGSizeMake(itemW, itemW);

    // 设置每个分区的 上左下右 的内边距
    layout.sectionInset = UIEdgeInsetsMake(5, 5 ,5, 5);

    // 设置区头和区尾的大小
//    layout.headerReferenceSize = CGSizeMake(kScreenWidth, 65);
//    layout.footerReferenceSize = CGSizeMake(kScreenWidth, 65);

    // 设置分区的头视图和尾视图 是否始终固定在屏幕上边和下边
    layout.sectionFootersPinToVisibleBounds = YES;

    // 设置滚动条方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
  
    _equipButtonCollectionView = [[WDEquipButtonCollectionView alloc] initWithFrame:CGRectMake(10, 45,_bgWidth - 20,itemW * 2.0 + 10 ) collectionViewLayout:layout];
    _equipButtonCollectionView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
    _equipButtonCollectionView.showsVerticalScrollIndicator = NO;   //是否显示滚动条
    _equipButtonCollectionView.scrollEnabled = YES;  //滚动使能
    
    //3、添加到控制器的view
    [self addSubview:_equipButtonCollectionView];
    
    _equipButtonCollectionView.delegate = _equipButtonCollectionView;
    _equipButtonCollectionView.dataSource = _equipButtonCollectionView;
    
    [_equipButtonCollectionView registerNib:[UINib nibWithNibName:@"WDEquipBtnCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([WDEquipBtnCell class])];
    
    __weak typeof(self)weakSelf = self;
    [_equipButtonCollectionView setChangeEquipBlock:^(NSInteger row, NSString * _Nonnull userName) {
        [weakSelf changeEquip:row name:userName];
    }];
  
}

- (void)createEquipCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    // 设置item的行间距和列间距
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;

    // 设置item的大小
    CGFloat itemW = (_bgWidth - 5 * 6.f - 20) / 5.0 ;
    layout.itemSize = CGSizeMake(itemW, itemW);

    // 设置每个分区的 上左下右 的内边距
    layout.sectionInset = UIEdgeInsetsMake(5, 5 ,5, 5);

    // 设置区头和区尾的大小
//    layout.headerReferenceSize = CGSizeMake(kScreenWidth, 65);
//    layout.footerReferenceSize = CGSizeMake(kScreenWidth, 65);

    // 设置分区的头视图和尾视图 是否始终固定在屏幕上边和下边
    layout.sectionFootersPinToVisibleBounds = YES;

    // 设置滚动条方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
  
    _equipCollectionView = [[WDEquipCollectionView alloc] initWithFrame:CGRectMake(10, _equipButtonCollectionView.bottom + 10, _bgWidth - 20,_bgHeight -  _equipButtonCollectionView.bottom - 10 - 10) collectionViewLayout:layout];
    _equipCollectionView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
    _equipCollectionView.showsVerticalScrollIndicator = NO;   //是否显示滚动条
    _equipCollectionView.scrollEnabled = YES;  //滚动使能
    
    //3、添加到控制器的view
    [self addSubview:_equipCollectionView];
    
    _equipCollectionView.delegate = _equipCollectionView;
    _equipCollectionView.dataSource = _equipCollectionView;
    
    [_equipCollectionView registerNib:[UINib nibWithNibName:@"WDEquipCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([WDEquipCell class])];
}


#pragma mark - 操作 -
/// 更换选中的装备位置
- (void)changeEquip:(EquipType)index name:(NSString *)userName{
    
    
    
    NSString *key = [NSString stringWithFormat:@"%ld",index + 1];
    id value = _allEquipDic[key];
    if ([value isKindOfClass:[NSArray class]]) {
        [_equipCollectionView reloadDataWithArr:_allEquipDic[key] index:index name:userName];
    }else{
        [_equipCollectionView reloadDataWithDic:_allEquipDic[key] index:index name:userName];
    }
    
}

@end
