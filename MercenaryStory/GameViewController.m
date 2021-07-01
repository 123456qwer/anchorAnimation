//
//  GameViewController.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import "GameViewController.h"
#import "WDTestScene.h"

@implementation GameViewController

dispatch_queue_t queue;
dispatch_group_t group;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    group = dispatch_group_create();
    queue = dispatch_get_global_queue(0, 0);
    
//    CGFloat a = [UIScreen mainScreen].scale;
//    NSLog(@"%lf",a);
    // Load the SKScene from 'GameScene.sks'
    WDTestScene *scene = (WDTestScene *)[WDTestScene nodeWithFileNamed:@"WDTestScene"];
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    //skView.ignoresSiblingOrder = YES;
    skView.showsPhysics = YES;
    
    for (int i = 0; i < 10 ; i ++) {
        [self atomicTest:i];
    }
}


- (void)atomicTest:(int)i{
    
    
    
    dispatch_group_async(group, queue, ^{
        NSString *str = [NSString stringWithFormat:@"这是一串很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的字符串-->%d",i];
        self.atomicString = str;
        
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"赋值 --> %@",self.atomicString);
    });
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
