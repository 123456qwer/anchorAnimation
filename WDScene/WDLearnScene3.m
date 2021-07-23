//
//  WDLearnScene3.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/22.
//

#import "WDLearnScene3.h"
#import "WDBaseNode+Emoji.h"
@implementation WDLearnScene3
{
    BOOL _part1;
    BOOL _part2;
    BOOL _part3;
    BOOL _part4;
    BOOL _part5;
}

- (void)didMoveToView:(SKView *)view{
    
    [super didMoveToView:view];
    
    _part1 = YES;
    
    self.priest.position = CGPointMake(-kScreenWidth - self.knight.size.width / 2.0, 0);
    self.knight.position = CGPointMake(-kScreenWidth - self.priest.size.width * 2.0, 0);
    
    __weak typeof(self)weakSelf = self;
    [self.priest moveAction:CGPointMake(self.knight.size.width * 2.5, 0) moveFinishBlock:^{
        [weakSelf changeSelectNode:weakSelf.priest];
        [weakSelf changeSelectNodeDirection:-1 node:weakSelf.priest];
        [weakSelf setTextAction:@"到了，这里就是我们目前的临时营地！" hiddenTime:2 completeBlock:^{
            
            [weakSelf setTextAction:@"虽然现在什么还没有，但会慢慢好起来" hiddenTime:2 completeBlock:^{
                [weakSelf setTextAction:@"我计划找个做盔甲武器的师傅" hiddenTime:2 completeBlock:^{
                    [weakSelf changeSelectNode:weakSelf.knight];
                    [weakSelf setTextAction:@"说到这个，我倒是有个合适的人选。\n不过...他性格比较难搞~" hiddenTime:3 completeBlock:^{
                        [weakSelf setTextAction:@"先不说这个，你不是说还有一个人么？" hiddenTime:2 completeBlock:^{
                        
                            [weakSelf changeSelectNode:weakSelf.priest];
                            [weakSelf.priest angleFaceStateWithEye];
                            [weakSelf setTextAction:@"估计那个笨蛋，又在哪里迷路了！" hiddenTime:2 completeBlock:^{
                                [weakSelf.knight.balloonNode setBalloonWithLine:6 hiddenTime:2 completeBlock:^{
                                    [weakSelf archerAppear];
                                }];
                                
                            }];
                            
                        }];
                        
                    }];
                }];
            }];
            
        }];
    }];
    
    [self runAction:[SKAction waitForDuration:0.3] completion:^{
        [weakSelf.knight moveAction:CGPointMake(0, 0)];
    }];
}


/// 弓箭手现身
- (void)archerAppear{
    
    [self.priest normalFaceState];
    self.archer.position = CGPointMake(-kScreenWidth - self.archer.size.width / 2.0, 0);
    [self changeSelectNode:self.archer];
    
    [self changeSelectNodeDirection:-1 node:self.priest];
    [self changeSelectNodeDirection:-1 node:self.knight];
    
    __weak typeof(self)weakSelf = self;
    [self.archer moveAction:CGPointMake(-self.archer.size.width  * 2.5, 0) moveFinishBlock:^{
        [weakSelf.archer omgFaceState];
        [weakSelf.archer.balloonNode setBalloonWithLine:1 hiddenTime:2 completeBlock:^{
            
            [weakSelf.archer angleFaceStateWithEye];
            [weakSelf setTextAction:@"<艾琳>小姐姐？他是谁！！\n你是不是移情别恋了！！" hiddenTime:2 completeBlock:^{
                [weakSelf changeSelectNode:weakSelf.priest];
                [weakSelf.priest angleFaceStateWithEye];
                
                [weakSelf.priest.balloonNode setBalloonWithLine:5 hiddenTime:2 completeBlock:^{
                                    
                }];
                
                [weakSelf setTextAction:@"别恋个屁，他是来代替前任骑士的" hiddenTime:2 completeBlock:^{
                    [weakSelf.archer normalFaceState];
                    [weakSelf.archer.balloonNode removeAllActions];
                    weakSelf.archer.balloonNode.hidden = YES;
                    
                    [weakSelf.priest normalFaceState];
                    [weakSelf changeSelectNodeDirection:1 node:weakSelf.knight];
                    [weakSelf setTextAction:@"别看他跟个傻子是的\n战斗起来还是蛮可靠的。" hiddenTime:2 completeBlock:^{
                        [weakSelf introduce];
                    }];
                    
                }];
            }];
            

            [weakSelf.archer.balloonNode setBalloonWithLine:5 hiddenTime:0];
        }];
    }];
    
    
    [self.archer.balloonNode setBalloonWithLine:3 hiddenTime:0];
    [self setTextAction:@"<艾琳>小姐姐，我来啦我来啦！"];
}


- (void)introduce{
    
    __weak typeof(self)weakSelf = self;
    [self setTextAction:@"好了，还没自我介绍\n我叫艾琳，是个初级治疗牧师" hiddenTime:2 completeBlock:^{
        
        [weakSelf changeSelectNodeDirection:-1 node:weakSelf.knight];
        [weakSelf.knight.balloonNode setBalloonWithLine:6 hiddenTime:2 completeBlock:^{
        }];
        
        [weakSelf setTextAction:@"你旁边那是个傻子弓箭手" hiddenTime:2 completeBlock:^{
            
            
            [weakSelf changeSelectNode:weakSelf.archer];
            [weakSelf.archer omgFaceState];
            [weakSelf setTextAction:@"小姐姐太过分了吧！！" hiddenTime:2 completeBlock:^{
                
                [weakSelf.archer normalFaceState];
                [weakSelf setTextAction:@"你好，我叫克林。\n初级弓箭手,以后请多指教！" hiddenTime:2 completeBlock:^{
                    
                    [weakSelf changeSelectNode:weakSelf.priest];
                    [weakSelf changeSelectNodeDirection:1 node:weakSelf.knight];
                    [weakSelf setTextAction:@"你叫什么名字？" hiddenTime:2 completeBlock:^{
                        
                        [weakSelf changeSelectNode:weakSelf.knight];
                        [weakSelf.knight.balloonNode setBalloonWithLine:8 hiddenTime:2
                                            completeBlock:^{
                                                
                        }];
                        
                        [weakSelf setTextAction:@"我叫......." hiddenTime:2 completeBlock:^{
                            [weakSelf changeSelectNode:weakSelf.priest];
                            
                        }];
                        
                    }];
                    
                }];
            }];
            
        }];
        
    }];
    
}



/// 开始触碰
- (void)touchDownAtPoint:(CGPoint)pos {
}

/// 手指移动
- (void)touchMovedToPoint:(CGPoint)pos {
    
    if (!_part1) {
        return;
    }
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


- (void)touchUpAtPoint:(CGPoint)pos{
    
    if (_part1) {
        return;
    }
    
    [super touchUpAtPoint:pos];
    
}


@end
