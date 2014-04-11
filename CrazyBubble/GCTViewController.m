//
//  ViewController.m
//  CrazyBubble
//
//  Created by admin on 14-4-4.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "GCTViewController.h"
#import "MyScene.h"
#import "MainScenescene.h"

@implementation GCTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [MainScenescene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    self.navigationController.navigationBarHidden=YES;
    
}
    /*UIImage *image=[UIImage imageNamed:@"BurstAircraftPause"];
    UIButton *button1=[[UIButton alloc] init];
    [button1 setFrame:CGRectMake(250, 400, image.size.width, image.size.height)];
    [button1 setBackgroundImage:image  forState:UIControlStateNormal];
    [button1  addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button2=[[UIButton alloc] init];
    UIImage *image2=[UIImage imageNamed:@"23333"];
    [button2 setFrame:CGRectMake(20,400, image2.size.width, image2.size.height)];
    [button2 setBackgroundImage:image2 forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(win) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    [self.view addSubview:button2];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOver) name:@"gameOverNotification" object:nil];

}
-(void) gameOver
{
    UIView *backgroundView=[[UIView alloc] initWithFrame:self.view.bounds];
    
    UIButton *button=[[UIButton alloc ] init];
    [button setBounds:CGRectMake(0, 0, 200, 30)];
    [button setCenter:backgroundView.center];
    [button setTitle:@"start again" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button.layer setBorderWidth:2.0];
    [button.layer setCornerRadius:15.0];
    [button.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [button addTarget:self  action:@selector(restart:) forControlEvents:UIControlEventTouchUpInside];
    
    [backgroundView addSubview:button];
    [backgroundView setCenter:self.view.center];
    
    [self.view addSubview:backgroundView];
    
}
-(void) win
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"binggo" object:nil];
}

-(void)pause
{
    ((SKView*) self.view).paused=YES;
    
    UIView *pauseView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];
    UIButton *button1=[[UIButton alloc] init];
    [button1 setFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-100, 50, 200, 30)];
    [button1 setTitle:@"continue" forState:UIControlStateNormal];
    [button1 setTitleColor:[SKColor blueColor] forState:UIControlStateNormal];
    [button1.layer setBorderWidth:2.0];
    [button1.layer setCornerRadius:15.0];
    [button1.layer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [button1 addTarget:self action:@selector(continueGame:) forControlEvents:UIControlEventTouchUpInside];
    [pauseView addSubview:button1];
    
    UIButton *button2=[[UIButton alloc] init];
    [button2 setFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-100,100,200,30)];
    [button2 setTitle:@"try again" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button2.layer setBorderWidth:2.0];
    [button2.layer setCornerRadius:15.0];
    [button2.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [button2 addTarget:self action:@selector(restart:) forControlEvents:UIControlEventTouchUpInside];
    [pauseView addSubview:button2];
    
    pauseView.center=self.view.center;
    [self.view addSubview:pauseView];
}
-(void) restart:(UIButton *)button
{
    [button.superview removeFromSuperview];
    ((SKView*)self.view).paused=NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"restartNotification" object:nil];
}
-(void) continueGame:(UIButton*)button
{
    [button.superview removeFromSuperview ];
    ((SKView*)self.view).paused=NO;
}
*/

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
-(BOOL) prefersStatusBarHidden
{
    return YES;
}

@end
