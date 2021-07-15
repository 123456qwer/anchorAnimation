//
//  GameViewController.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import "GameViewController.h"

#import "WDTestScene.h"
#import "WDLearnScene1.h"


#import "WDSkillView.h"


@implementation GameViewController
{
    WDSkillView *_skillView;
    WDBaseScene *_selectScene;
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

/// 玩家技能以及辅助选中界面
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

- (void)viewDidLoad {
    [super viewDidLoad];
        
    //[self createSkillView];
    
//    CGFloat a = [UIScreen mainScreen].scale;
//    NSLog(@"%lf",a);
    // Load the SKScene from 'GameScene.sks'

    WDLearnScene1 *scene = (WDLearnScene1 *)[WDLearnScene1 nodeWithFileNamed:@"WDLearnScene1"];
   // WDTestScene *scene = (WDTestScene *)[WDTestScene nodeWithFileNamed:@"WDTestScene"];
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    //skView.ignoresSiblingOrder = YES;
    skView.showsPhysics = YES;
    
    _selectScene = scene;
}







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
