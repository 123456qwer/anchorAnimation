//
//  WDLevelScene1.m
//  MercenaryStory
//
//  Created by Mac on 2021/8/2.
//

#import "WDLevelScene1.h"
#import "Boss2Node.h"
@implementation WDLevelScene1
{
    bool _part[1000];
    int  _monsterCount;
}

- (void)didMoveToView:(SKView *)view{
    
    [super didMoveToView:view];
    
    [self setHateNameArrWithNode:@[self.archer,self.knight,self.priest]];

    self.archer.position = CGPointMake(0, 0);
    self.knight.position = CGPointMake(-200, 0);
    self.priest.position = CGPointMake(200, 0);
    
    self.knightHead.position = CGPointMake(kScreenWidth - self.knightHead.realSize.width - 20 , kScreenHeight - self.knightHead.realSize.height - 10);
    self.archerHead.position = CGPointMake(kScreenWidth - self.knightHead.realSize.width * 2 - 40 ,kScreenHeight - self.archerHead.realSize.height - 10);
    self.priestHead.position = CGPointMake(kScreenWidth - self.knightHead.realSize.width * 3 - 60 ,kScreenHeight - self.priestHead.realSize.height - 10);
    
    [self setTextAction:@"右上角添加了辅助头像功能"];
    [self setNoIndex:0 yesIndex:0];
}



/// 手指移动
- (void)touchMovedToPoint:(CGPoint)pos {
    
    //return;
    self.selectLine.position = CGPointMake(self.selectNode.position.x, self.selectNode.position.y);
    ///引导线
    //斜边
    CGFloat width = [WDCalculateTool distanceBetweenPoints:pos seconde:self.selectLine.position];
    self.selectLine.size = CGSizeMake(width, 10);
    self.selectLine.hidden = NO;
    //角度
    self.selectLine.zRotation = [WDCalculateTool angleForStartPoint:self.selectLine.position EndPoint:pos];
    //NSLog(@"%lf",self.selectLine.zRotation);
    //[self.selectLine createLinePhyBody];

}

/// 触碰结束
- (void)touchUpAtPoint:(CGPoint)pos {
    
    if (_part[0]) {
        [self setNoIndex:0 yesIndex:1];
    }else if(_part[1]){
        [self setTextAction:@"可点击切换角色。\n治疗角色可直接拖拽至头像治疗"];
        [self setNoIndex:1 yesIndex:2];
    }else if(_part[2]){
        
        [self changeSelectNode:self.priest];
        [self setTextAction:@"听说最近有骷髅兵出没\n大家小心应对！"];
        [self setNoIndex:2 yesIndex:3];

    }else if(_part[3]){
        
        [self setNoIndex:3 yesIndex:4];
        [self stopTalk];
        
        [WDBaseNode initActionWithName:kBoss2 superNode:self position:CGPointMake(0.1, 0)];
//        [WDBaseNode initActionWithName:kSolider1 superNode:self position:CGPointMake(0, 0)];
//        [WDBaseNode initActionWithName:kSolider1 superNode:self position:CGPointMake(0, 0)];
//        [WDBaseNode initActionWithName:kSolider2 superNode:self position:CGPointMake(0, 0)];
//        [WDBaseNode initActionWithName:kSolider2 superNode:self position:CGPointMake(0, 0)];
//        [WDNotificationManager hiddenSkillView:1];
        
        _monsterCount = 4;
        
    }else{
        
        [super touchUpAtPoint:pos];
        
    }
    
    self.selectLine.hidden = YES;
    self.selectLine.size = CGSizeMake(0, 0);
}

- (void)setNoIndex:(NSInteger)index1
          yesIndex:(NSInteger)index2{
    _part[index1] = NO;
    _part[index2] = YES;
}


/// 死亡通知
- (void)deadAction:(NSNotification *)notification{
    
    
    WDBaseNode *node = (WDBaseNode *)notification.object;
    
    if ([node isKindOfClass:[WDUserNode class]]) {
        
        [self.userArr removeObject:node];
        [self deadForRelease:node];
        
        if ([node.name isEqualToString:self.selectNode.name]) {
            [self changeSelectNode:self.userArr.firstObject];
        }
        
        if (self.userArr.count == 0) {
         
          
            
        }
        
        
        
    }else if([node isKindOfClass:[WDEnemyNode class]]){
        
        NSLog(@"敌人：%@ 死亡了",node.name);
        [self.monsterArr removeObject:node];
        _monsterCount ++;
        
        if (_monsterCount < 5) {
            
            if ([node.name isEqualToString:kSolider1]) {
                [WDBaseNode initActionWithName:kSolider1 superNode:self position:CGPointMake(0, 0)];
            }else{
                [WDBaseNode initActionWithName:kSolider2 superNode:self position:CGPointMake(0, 0)];
            }
            
        }else{
            
            [WDBaseNode initActionWithName:kBoss2 superNode:self position:CGPointMake(0.1, 0)];
            NSLog(@"BOSS!");
        }
        
        
        
        if (self.monsterArr.count == 0) {
            self.knight.state = self.knight.state | Sprite_movie;
            self.archer.state = self.archer.state | Sprite_movie;
            self.priest.state = self.priest.state | Sprite_movie;
        }
    }
    
}


@end
