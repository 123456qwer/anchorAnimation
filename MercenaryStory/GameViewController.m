//
//  GameViewController.m
//  MercenaryStory
//
//  Created by Mac on 2021/6/16.
//

#import "GameViewController.h"
#import "WDTestScene.h"

@implementation GameViewController


- (void)viewDidLoad {
    [super viewDidLoad];
        
    
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
