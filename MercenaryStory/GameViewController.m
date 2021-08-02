//
//  GameViewController.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import "GameViewController.h"
#import "GameViewController+Data.h"
#import "MapSelectViewController.h"
#import "LearnSkillViewController.h"

#import "WDEquipScene.h"


#import "WDSkillView.h"
#import "WDEquipView.h"
#import "WDAllMenuView.h"



@implementation GameViewController
{
    WDSkillView *_skillView;
    WDBaseScene *_selectScene;
    WDEquipView *_equipView;
    WDAllMenuView *_allMenuView;
    NSString *_userName;
}



- (void)viewDidLoad {
    [super viewDidLoad];
        
    /// 第一次进入初始化数据
    [self initDataAction];
    
    [self createSkillView];
    [self createEquipView];
    [self createMenuView];
    
    
    NSString *sceneStr = @"";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//
    if (![defaults boolForKey:kLearnPass1]) {
        sceneStr = @"WDLearnScene1";
    }else if(![defaults boolForKey:kLearnPass2]){
        sceneStr = @"WDLearnScene2";
    }else if(![defaults boolForKey:kLearnPass3]){
        sceneStr = @"WDLearnScene3Click";
    }else{
        sceneStr = @"WDFirstCampsiteScene";
        //[self showMenuView];
        self.userName = kKinght;
    }
    
    [self createSceneWithName:sceneStr];

//    CGFloat a = [UIScreen mainScreen].scale;
  
}



#pragma mark - 主要菜单栏 -
- (void)createMenuView{
    
    _allMenuView = [[WDAllMenuView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 80)];
    [self.view addSubview:_allMenuView];
    
    __weak typeof(self)weakSelf = self;
    [_allMenuView setOpenBackPack:^{
        [weakSelf showEquipView:weakSelf.userName];
    }];
    
    [_allMenuView setOpenSkillPack:^{
        [weakSelf showSkillView:weakSelf.userName];
    }];
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
    //_skillView.backgroundColor = [UIColor orangeColor];
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
    
    __weak typeof(self)weakSelf = self;
    [_equipView setConfirmBlock:^{
        [weakSelf presentSelectScene];
    }];
}

- (void)presentSelectScene{
    SKView *skView = (SKView *)self.view;
    [skView presentScene:_selectScene];
}


#pragma mark - 创建场景 (根据场景名称) -
- (void)createSceneWithName:(NSString *)sceneName{

     //sceneName = @"WDTestScene";
     //sceneName = @"WDLearnScene4";

     Class class = NSClassFromString(sceneName);
     WDBaseScene *scene = [class nodeWithFileNamed:sceneName];
     
    
     SKView *skView = (SKView *)self.view;
     SKTransition *tr = [SKTransition fadeWithDuration:1];
     [skView presentScene:scene transition:tr];

//     skView.showsFPS = YES;
//     skView.showsNodeCount = YES;
//     //skView.ignoresSiblingOrder = YES;
//     skView.showsPhysics = YES;

     _selectScene = scene;
    
    __weak typeof(self)weakSelf = self;
    /// 展示主菜单(切换装备)
    [_selectScene setPrenestMenuForArmorBlock:^(NSString * _Nonnull userName) {
        weakSelf.userName = userName;
        [weakSelf showMenuViewForArmor];
    }];
    
    /// 学习技能
    [_selectScene setPrenestMenuForSkillBlock:^(NSString * _Nonnull userName) {
        weakSelf.userName = userName;
        [weakSelf showMenuViewForSkill];
    }];
    
    /// 隐藏主菜单
    [_selectScene setHiddenMenuBlock:^(NSString * _Nonnull userName) {
        [weakSelf hiddenMenuView];
    }];
    
    /// 切换场景
    [_selectScene setChangeSceneBlock:^(NSString * _Nonnull sceneName) {
        [weakSelf createSceneWithName:sceneName];
    }];
    
    /// 选择地图
    [_selectScene setShowMapSelectBlock:^{
        [weakSelf showMapSelectViewController];
    }];
}


//////////////////  操作相关 //////////////////////////
#pragma mark - 展示主菜单栏 -
- (void)showMenuView{
    
    if (_allMenuView.frame.origin.y == kScreenHeight) {
        //__weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:0.5 animations:^{
            self ->_allMenuView.frame = CGRectMake(0, kScreenHeight - 80, kScreenWidth, 80);
        }];
    }
}

- (void)showMenuViewForSkill{
    
    [self showSkillView:self.userName];
}

- (void)showMenuViewForArmor{
    [self showMenuView];
}

- (void)hiddenMenuView{
    [UIView animateWithDuration:0.3 animations:^{
        self->_allMenuView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 80);
    }];
}


#pragma mark - 展示换装页面 -
- (void)showEquipView:(NSString *)userName{
   
    
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        self->_allMenuView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 80);
    } completion:^(BOOL finished) {
        if (userName) {
            SKView *skView = (SKView *)self.view;
            WDEquipScene *equipScene = (WDEquipScene *)[WDEquipScene nodeWithFileNamed:@"WDEquipScene"];
            [skView presentScene:equipScene];
            [equipScene changeSelectNodeWithName:weakSelf.userName];
            [self->_equipView reloadDataWithName:userName];
            [self->_equipView cancelConfirmBtn];
            self->_equipView.hidden = NO;
        }else{
            NSLog(@"还没选中人物");
        }
    }];
    
    
    
}

#pragma mark - 展示技能选择页面 -
- (void)showSkillView:(NSString *)userName{
    
    LearnSkillViewController *vc = [[LearnSkillViewController alloc] init];
    vc.userName = userName;
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

#pragma mark - 展示地图选择器 -
- (void)showMapSelectViewController
{
    MapSelectViewController *vc = [[MapSelectViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
    __weak typeof(self)weakSelf = self;
    [vc setSelectSceneBlock:^(NSString * _Nonnull sceneName) {
        [weakSelf hiddenMenuView];
        [weakSelf createSceneWithName:sceneName];
    }];
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
