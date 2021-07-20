//
//  GameViewController.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import "GameViewController.h"

#import "WDTestScene.h"
#import "WDLearnScene1.h"
#import "WDEquipScene.h"


#import "WDSkillView.h"
#import "WDEquipView.h"



@implementation GameViewController
{
    WDSkillView *_skillView;
    WDBaseScene *_selectScene;
    WDEquipView *_equipView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
        

//    CGFloat a = [UIScreen mainScreen].scale;
    
    //[self createSkillView];
    
    [self createEquipView];
    
    [self createSceneWithName:@"WDLearnScene1"];
    
}


/// 初始化起始技能
- (void)initUserSkill{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *key1 = [NSString stringWithFormat:@"%@_0",kKinght];
    NSString *key2 = [NSString stringWithFormat:@"%@_0",kArcher];
    NSString *key3 = [NSString stringWithFormat:@"%@_0",kPriest];
    NSString *key4 = [NSString stringWithFormat:@"%@_0",kWizard];
    
    [defaults setBool:YES forKey:key1];
    [defaults setBool:YES forKey:key2];
    [defaults setBool:YES forKey:key3];
    [defaults setBool:YES forKey:key4];
}

#pragma mark - 创建技能页面 -
- (void)createSkillView
{
    CGFloat page = 0;
//    CGFloat page2 = 20;
//    CGFloat page3 = 20;

    if (IS_IPHONEX) {
        page = 20;
    }
    
    CGFloat width = 4 * 10 + 50 * 5;
    CGFloat x = (kScreenWidth - width) / 2.0;
    
    
    _skillView = [[WDSkillView alloc] initWithFrame:CGRectMake(x,kScreenHeight - 50 - page, width , 50)];
    _skillView.backgroundColor = [UIColor orangeColor];
    _skillView.hidden = YES;
    [self.view addSubview:_skillView];
    __weak typeof(self)weakSelf = self;
    [_skillView setSkillActionBlock:^(NSInteger tag) {
        [weakSelf skillActionWithTag:tag];
    }];
}

#pragma mark - 创建装备选择页面 -
- (void)createEquipView{
    _equipView = [[WDEquipView alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0, 0, kScreenWidth / 2.0, kScreenHeight)];
    _equipView.hidden = YES;
    [self.view addSubview:_equipView];
}


#pragma mark - 创建场景 (根据场景名称) -
- (void)createSceneWithName:(NSString *)sceneName{
    
    
     Class class = NSClassFromString(sceneName);
     WDBaseScene *scene = [class nodeWithFileNamed:sceneName];
     
     SKView *skView = (SKView *)self.view;
 
     [skView presentScene:scene];

     skView.showsFPS = YES;
     skView.showsNodeCount = YES;
     //skView.ignoresSiblingOrder = YES;
     skView.showsPhysics = YES;

     _selectScene = scene;
    
    __weak typeof(self)weakSelf = self;
    /// 切换装备回调
    [_selectScene setPresentEquipBlock:^(NSString * _Nonnull userName) {
        [weakSelf showEquipView:userName];
    }];
    
}


//////////////////  操作相关 //////////////////////////

#pragma mark - 展示换装页面 -
- (void)showEquipView:(NSString *)userName{
   
    SKView *skView = (SKView *)self.view;
    WDEquipScene *equipScene = (WDEquipScene *)[WDEquipScene nodeWithFileNamed:@"WDEquipScene"];
    [skView presentScene:equipScene];
    _equipView.hidden = NO;
}



#pragma mark - 释放技能 -
- (void)skillActionWithTag:(NSInteger)tag{
   
    if (tag == 100) {
        
        [_selectScene skill1Action];
        //NSLog(@"技能1");
        
    }else if(tag == 101){
        
        [_selectScene skill2Action];
        //NSLog(@"技能2");
        
    }else if(tag == 102){
        
        [_selectScene skill3Action];
        //NSLog(@"技能3");
        
    }else if(tag == 103){
        
        [_selectScene skill4Action];
        //NSLog(@"技能4");
        
    }else if(tag == 104){
        
        [_selectScene skill5Action];
        //NSLog(@"技能5");
        
    }
}














#pragma mark - system -

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
