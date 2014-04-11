//
//  SelectFuctionViewController.m
//  CrazyBubble
//
//  Created by apple on 14-4-5.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "SelectFuctionViewController.h"

@interface SelectFuctionViewController ()

@end

@implementation SelectFuctionViewController
{
    BOOL _isFirst;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isFirst = YES;

}

-(void)viewWillAppear:(BOOL)animated{
    //Calling this methods builds the intro and adds it to the screen. See below.
    [self buildIntro];
    [self prefersStatusBarHidden];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


#pragma mark - Build MYBlurIntroductionView

-(void)buildIntro{
    // introduction 
    //Create Stock Panel with header
    if (_isFirst) {
        self.navigationController.navigationBarHidden = YES;
        UIView *headerView = [[NSBundle mainBundle] loadNibNamed:@"TestHeader" owner:nil options:nil][0];
        MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Welcome to Crazy Bubble" description:@"This is an app to help you to memorize word." image:[UIImage imageNamed:@"HeaderImage.png"] header:headerView];
        
        //Create Stock Panel With Image
        MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Functions" description:@"You could use this app to memorize words with a game" image:[UIImage imageNamed:@"ForkImage.png"]];
        
        //Create Panel From Nib
        
        //Create custom panel with events
        MYCustomPanel *panel3 = [[MYCustomPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) nibNamed:@"MYCustomPanel"];
        
        //Add panels to an array
        NSArray *panels = @[panel1, panel2, panel3];
        
        //Create the introduction view and set its delegate
        MYBlurIntroductionView *introductionView = [[MYBlurIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        introductionView.delegate = self;
        introductionView.BackgroundImageView.image = [UIImage imageNamed:@"Toronto, ON.jpg"];
        //introductionView.LanguageDirection = MYLanguageDirectionRightToLeft;
        
        //Build the introduction with desired panels
        [introductionView buildIntroductionWithPanels:panels];
        
        //Add the introduction to your view
        [self.view addSubview:introductionView];
        _isFirst = NO;
    }
}

#pragma mark - MYIntroduction Delegate

-(void)introduction:(MYBlurIntroductionView *)introductionView didChangeToPanel:(MYIntroductionPanel *)panel withIndex:(NSInteger)panelIndex{
    NSLog(@"Introduction did change to panel %d", panelIndex);
    
    //You can edit introduction view properties right from the delegate method!
    //If it is the first panel, change the color to green!
    if (panelIndex == 0) {
        [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:1]];
    }
    //If it is the second panel, change the color to blue!
    else if (panelIndex == 1){
        [introductionView setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:79.0f/255.0f blue:133.0f/255.0f alpha:1]];
    }
    
}

-(void)introduction:(MYBlurIntroductionView *)introductionView didFinishWithType:(MYFinishType)finishType {
    NSLog(@"Introduction did finish");
    self.navigationController.navigationBarHidden = NO;
}



@end
