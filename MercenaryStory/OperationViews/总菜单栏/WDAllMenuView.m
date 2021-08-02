//
//  WDAllMenuView.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/21.
//

#import "WDAllMenuView.h"

@implementation WDAllMenuView
{
    UIButton *_armorBtn;
    UIButton *_skillBtn;
}
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
    
//    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0 - 100 / 2.0 + 100 + 20, -20, 100, 100)];
//    [btn2 addTarget:self action:@selector(skillAction:) forControlEvents:UIControlEventTouchUpInside];
//    [btn2 setImage:[UIImage imageNamed:@"tome"] forState:UIControlStateNormal];
//    [self addSubview:btn2];
//
//    if ([[NSUserDefaults standardUserDefaults]objectForKey:kPassCheckPoint1]) {
//        btn2.hidden = NO;
//    }else{
//        btn2.hidden = YES;
//    }
    
    _armorBtn = btn;
    //_skillBtn = btn2;
}

- (void)backPackAction:(UIButton *)sender{
    _openBackPack();
}

- (void)skillAction:(UIButton *)sender{
    _openSkillPack();
}

- (void)showSkillBtn{
    //_skillBtn.hidden = NO;
}

@end
