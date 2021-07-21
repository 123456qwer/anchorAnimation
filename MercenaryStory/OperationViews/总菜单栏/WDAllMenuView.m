//
//  WDAllMenuView.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/21.
//

#import "WDAllMenuView.h"

@implementation WDAllMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.backgroundColor = [UIColor orangeColor];
        [self createBackPack];
    }
    return self;
}

- (void)createBackPack{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0 - 100 / 2.0, -20, 100, 100)];
    [btn addTarget:self action:@selector(backPackAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"backpack"] forState:UIControlStateNormal];
    [self addSubview:btn];
}

- (void)backPackAction:(UIButton *)sender{
    _openBackPack();
}

@end
