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
        [self loadData];
        [self bgView];
        [self createEquipButtonCollctionView];
        [self createEquipCollectionView];
    }
    
    return self;
}

//#define kBody @"body"  //身体
//#define kHip @"hip"    //胯
//#define kRightHand @"rightHand" //右手
//#define kKnee @"knee"  //膝盖
//#define kFoot @"foot"  //脚
//#define kLeftArm @"leftArm" //左胳膊
//#define kRightArm @"rightArm" //右胳膊
//#define kLeftElbow @"kLeftElbow" //左胳膊肘
//#define kRightElbow @"kRightElbow" //右胳膊肘加手掌
//#define kLeftHand @"leftHand" //左手
//#define kRightFinger @"rightFinger" //右手指

/// 这里加载下数据
- (void)loadData{
    
    
    NSArray *helmets = @[@"EliteKnightHelm",@"LeatherHelm",@"BerserkHelm",@"PriestHelm",@"WizardHelm"];
    NSDictionary *armors = @{@"KnightArmor":kBody,@"Armor1":kBody};
    NSArray *weapon1s = @[@"FamilySword",@"GuardSword1"];
    _allEquipDic = @{@"1":helmets,@"2":armors,@"8":weapon1s};
    
    
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
    [_equipButtonCollectionView setChangeEquipBlock:^(NSInteger row) {
        [weakSelf changeEquip:row];
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
- (void)changeEquip:(EquipType)index{
    
    NSString *key = [NSString stringWithFormat:@"%ld",index + 1];
    id value = _allEquipDic[key];
    if ([value isKindOfClass:[NSArray class]]) {
        [_equipCollectionView reloadDataWithArr:_allEquipDic[key] index:index];
    }else{
        [_equipCollectionView reloadDataWithDic:_allEquipDic[key] index:index];
    }
    
}

@end
