//
//  ViewController.h
//  CrazyBubble
//
//  Created by apple on 14-4-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYBlurIntroductionView.h"
#import "MYCustomPanel.h"
#import "SelectedButton.h"
#import "HoldButton.h"
#import "WordLabel.h"
#import "DRNNewWordViewController.h"
#import "AppDelegate.h"
#import "WordDetailView.h"

@interface LearnWordViewController : UIViewController

@property (strong, nonatomic) NSString *selectedMeaning; // the meaning you selected
@property (strong, nonatomic) NSArray *meaningList;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonCollection;

@property (weak, nonatomic) IBOutlet HoldButton *holdButton;
@property (weak, nonatomic) IBOutlet WordLabel *wordLabel;
@property (weak, nonatomic) IBOutlet WordDetailView *wordDetail;



@end
