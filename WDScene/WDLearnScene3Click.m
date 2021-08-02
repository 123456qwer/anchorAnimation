//
//  WDLearnScene3Click.m
//  MercenaryStory
//
//  Created by Mac on 2021/7/23.
//

#import "WDLearnScene3Click.h"
#import "WDBaseNode+Emoji.h"

@implementation WDLearnScene3Click
{
    bool _part[1000];
}


- (void)didMoveToView:(SKView *)view{
    
    [super didMoveToView:view];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setNameSuccess:) name:kNotificationForChangeNameAlready object:nil];
    
    self.priest.position = CGPointMake(-kScreenWidth - self.knight.size.width / 2.0, 0);
    self.knight.position = CGPointMake(-kScreenWidth - self.priest.size.width * 2.0, 0);
  
    __weak typeof(self)weakSelf = self;
    [self.priest moveAction:CGPointMake(self.knight.size.width * 2.5, 0) moveFinishBlock:^{
        [weakSelf changeSelectNode:weakSelf.priest];
        [weakSelf changeSelectNodeDirection:-1 node:weakSelf.priest];
        [weakSelf setTextAction:@"到了，这里就是我们的临时营地。"];
        [weakSelf setPart1];
    }];
    
    [self runAction:[SKAction waitForDuration:0.3] completion:^{
        [weakSelf.knight moveAction:CGPointMake(0, 0)];
    }];
}

- (void)setPart1{
    _part[0] = YES;
}

/// 开始触碰
- (void)touchDownAtPoint:(CGPoint)pos {}

/// 手指移动
- (void)touchMovedToPoint:(CGPoint)pos{}

- (void)touchUpAtPoint:(CGPoint)pos{
    
    if (_part[0]) {
        
        [self setTextAction:@"虽然现在什么还没有，但会慢慢好起来的！"];
        [self setNoIndex:0 yesIndex:1];
        
    }else if (_part[1]) {
        
        [self setTextAction:@"我计划找一个技能修炼师，\n在找一个武器盔甲师！"];
        [self setNoIndex:1 yesIndex:2];

        
    }else if (_part[2]) {
        
        [self setTextAction:@"说到这个，我倒是有个合适的人选。\n不过...她性格比较难搞~"];
        [self changeSelectNode:self.knight];
        [self setNoIndex:2 yesIndex:3];

       
    }else if(_part[3]){
        
        [self setTextAction:@"先不说这个，你不是说还有一个人么？"];
        [self setNoIndex:3 yesIndex:4];
        
    }else if(_part[4]){
        
        [self setTextAction:@"估计那个笨蛋，又在哪里迷路了！"];
        [self changeSelectNode:self.priest];
        [self.priest angleFaceStateWithEye];
       
        [self.knight fishyFaceState];
        [self.knight.balloonNode setBalloonWithLine:Balloon_awkward hiddenTime:0];
        
        [self setNoIndex:4 yesIndex:5];
    
    }else if(_part[5]){
        
        [self setTextAction:@"<艾琳>小姐姐，我来啦我来啦！"];

        
        /// 弓箭手现身
        [self.priest normalFaceState];
        [self.knight normalFaceState];
        
        
        self.archer.position = CGPointMake(-kScreenWidth - self.archer.size.width / 2.0, 0);
        [self changeSelectNodeDirection:-1 node:self.knight];
        [self changeSelectNode:self.archer];
        __weak typeof(self)weakSelf = self;
        [self.archer moveAction:CGPointMake(-self.archer.size.width  * 2.5, 0) moveFinishBlock:^{
            [weakSelf.archer omgFaceState];
            [self setNoIndex:5 yesIndex:6];
        }];
        
        _part[5] = NO;
        [self.archer.balloonNode setBalloonWithLine:3 hiddenTime:0];

    }else if(_part[6]){
        
        [self.knight fishyFaceState];
        [self.knight.balloonNode setBalloonWithLine:Balloon_awkward hiddenTime:0];
        
        [self.archer angleFaceStateWithEye];
        [self setTextAction:@"<艾琳>小姐姐？他是谁！！\n你是不是移情别恋了！"];
        [self setNoIndex:6 yesIndex:7];
        
    }else if(_part[7]){
        
        [self.archer fishyFaceState];
        [self.archer.balloonNode setBalloonWithLine:Balloon_awkward hiddenTime:0];
        [self.knight normalFaceState];
        
        [self changeSelectNode:self.priest];
        [self.priest angleFaceStateWithEye];
        [self setTextAction:@"别恋个屁，他是来代替前任骑士的！"];
        [self setNoIndex:7 yesIndex:8];
        
    }else if(_part[8]){
        
        [self changeSelectNodeDirection:1 node:self.knight];
        [self.priest normalFaceState];
        [self setTextAction:@"别看他跟个傻子是的\n战斗起来还是蛮可靠的。"];
        
        [self setNoIndex:8 yesIndex:9];

    }else if(_part[9]){
        
        [self setTextAction:@"好了，还没自我介绍\n我叫艾琳，是个初级治疗牧师"];
        [self setNoIndex:9 yesIndex:10];
        
    }else if(_part[10]){
        
        [self setTextAction:@"你旁边那个叫傻子~"];
        [self.knight.balloonNode setBalloonWithLine:Balloon_awkward hiddenTime:0];
        [self.knight fishyFaceState];
        [self.archer omgFaceState];
        
        [self setNoIndex:10 yesIndex:11];

        
    }else if(_part[11]){
        
        [self changeSelectNode:self.archer];
        [self setTextAction:@"小姐姐太过分了吧！！\n我只是有点路盲，不是傻！"];
        
        [self setNoIndex:11 yesIndex:12];

    }else if(_part[12]){
        
        [self.knight normalFaceState];
        [self changeSelectNodeDirection:-1 node:self.knight];
        [self.archer normalFaceState];
        [self setTextAction:@"你好，我叫克林。\n初级弓箭手,以后请多指教！"];
        
        [self setNoIndex:12 yesIndex:13];

    }else if(_part[13]){
        
        [self changeSelectNode:self.priest];
        [self changeSelectNodeDirection:1 node:self.knight];
        [self setTextAction:@"你叫什么名字？"];
        
        [self setNoIndex:13 yesIndex:14];
        
    }else if(_part[14]){
        
        _part[14] = NO;
        [self changeSelectNode:self.knight];
        [self setTextAction:@"我的名字是....."];
        [self performSelector:@selector(setName) withObject:nil afterDelay:1.5];
        
       
        /// 测试用，正式必须注掉
        ///[self setNoIndex:15 yesIndex:16];
        
    }else if(_part[15]){
        
        [self changeSelectNode:self.priest];
        NSString *text = [NSString stringWithFormat:@"好的，%@，带我们去找你说的那位师傅吧？",self.userName];
        [self setTextAction:text];
        [self setNoIndex:15 yesIndex:16];

    }else if(_part[16]){
        
        [self changeSelectNode:self.knight];
        [self setTextAction:@"提前做好心理准备啊！"];
        [self setNoIndex:16 yesIndex:17];
        
    }else if(_part[17]){
        
        [self changeSelectNode:self.priest];
        [self setTextAction:@"对了，这是我之前捡到的技能书\n他能有效影响怪物心智，使他们只攻击你"];
        [self setNoIndex:17 yesIndex:18];
        
    }else if(_part[18]){
        
        [self setTextAction:@"可能在以后的战斗中会用到，你先拿去"];
        [self setNoIndex:18 yesIndex:19];
        
    
        SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"Knight_0"]]];
        node.position = CGPointMake(self.knight.size.width * 2.5, 0);
        node.zPosition = 10000;
        node.alpha = 0.8;
        node.size = CGSizeMake(110 * allScale, 110 * allScale);
        [self addChild:node];
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddArc(path, 0, -self.knight.size.width * 2.5 / 2.0, 0, -self.knight.size.width * 2.5 / 2.0, M_PI, 0, NO);
        SKAction *a = [SKAction followPath:path speed:700];
        SKAction *al = [SKAction fadeAlphaTo:0 duration:0.3];
        SKAction *remo = [SKAction removeFromParent];
        SKAction *seq = [SKAction sequence:@[a,al,remo]];
        __weak typeof(self)weakSelf = self;
        [node runAction:seq completion:^{
            [weakSelf give];
        }];
        
    }else if(_part[19]){
        
        [self setTextAction:@"我作为一个初阶牧师\n也学习了群体治疗的技能\n实战的时候体会下吧！"];
        [self setNoIndex:19 yesIndex:20];
        
    }else if(_part[20]){
        [self setTextAction:@"准备准备，就可以出发了！"];
        [self setNoIndex:20 yesIndex:21];
    }else if(_part[21]){
        [self overAndOver];
    }
    
}

- (void)give{
    [self setNoIndex:18 yesIndex:19];
}

- (void)setName{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationForChangeName object:nil];
}

- (void)setNoIndex:(NSInteger)index1
          yesIndex:(NSInteger)index2{
    _part[index1] = NO;
    _part[index2] = YES;
}

- (void)setNameSuccess:(NSNotification *)no{
    
    self.userName = [[NSUserDefaults standardUserDefaults]objectForKey:kUserName];
    NSString *na = [NSString stringWithFormat:@"我的名字是<%@>",self.userName];
    [self setTextAction:na];
    
    [self setNoIndex:14 yesIndex:15];
  
}

- (void)overAndOver{
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:kLearnPass3];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"下一章！");
    [self changeSceneWithName:@"WDFirstCampsiteScene"];
}

@end
