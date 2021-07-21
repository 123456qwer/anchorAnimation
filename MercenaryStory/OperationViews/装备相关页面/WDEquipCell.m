//
//  WDEquipCell.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/19.
//

#import "WDEquipCell.h"

@implementation WDEquipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgImageView.layer.masksToBounds = YES;
    self.bgImageView.layer.cornerRadius  = 10.f;
}

@end
