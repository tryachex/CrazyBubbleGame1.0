//
//  NewWordViewController.h
//  CrazyBubble
//
//  Created by apple on 14-4-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRNNewWordCell.h"
#import "LearnWordViewController.h"

@interface DRNNewWordViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *nWordList;
@property (strong, nonatomic) NSMutableArray *nWordMeaning;

@property (strong, nonatomic)  NSMutableArray *allNewWords;
@property (strong, nonatomic) NSMutableArray *allNewWordMeanings;



@end
