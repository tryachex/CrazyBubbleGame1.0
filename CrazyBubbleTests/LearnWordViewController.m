//
//  ViewController.m
//  CrazyBubble
//
//  Created by apple on 14-4-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LearnWordViewController.h"

@interface UIViewController ()

@property BOOL result;
@property NSUInteger tryTime;
@property (strong, nonatomic) NSMutableArray *backWord;


@end

@implementation LearnWordViewController{
    BOOL _getNextWord;
    double _delayInSeconds;
    BOOL _holdWord;


}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib
    NSArray *text = @[@"right",@"我",@"你",@"他",@"Automated Stock Panels Need a quick-and-dirty solution for your app introduction? MYBlurIntroductionView comes with customizable stock panels that make writing an introduction a walk in the park. Stock panels come with optional blurring (iOS 7) and background image. A full panel is just one method away!"];
    
    self.meaningList = text;
    self.navigationController.navigationBarHidden = NO;
    [self prefersStatusBarHidden];
    _holdWord = NO;
    [self getNextWord];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)shake:(UIView *)view
{
    // when select wrong meaning, the label will shake.
    CGRect frame = view.frame;
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef shakePath = CGPathCreateMutable();
    CGPathMoveToPoint(shakePath, NULL, frame.origin.x+frame.size.width/2, frame.origin.y+frame.size.height/2);
    int index;
    for (index = 3; index >=0; --index)
    {
        CGPathAddLineToPoint(shakePath, NULL, frame.origin.x+frame.size.width/2 - frame.size.width * 0.02f * index, frame.origin.y+frame.size.height/2);
        CGPathAddLineToPoint(shakePath, NULL, frame.origin.x+frame.size.width/2 + frame.size.width * 0.02f * index, frame.origin.y+frame.size.height/2);
    }
    CGPathCloseSubpath(shakePath);
    
    shakeAnimation.path = shakePath;
    shakeAnimation.duration = 0.5f;
    shakeAnimation.removedOnCompletion = YES;

    [view.layer addAnimation:shakeAnimation forKey:nil];
    CFRelease(shakePath);
}

- (void)getNextWord
{
    if (_holdWord == NO) {
        self.wordLabel.text = @"You";
        self.wordDetail.text = @"";
        // init the button name
        NSArray *buttonName = @[@"A",@"B",@"C",@"D"];
        for (int i = 0; i < 4; ++i) {
            [_buttonCollection[i] setTitle:buttonName[i] forState:UIControlStateNormal];
        }
        
        // distribute the correct meaning to a titleText
        NSUInteger index = [self getRandomNumber:1 to:4];
        SelectedButton *rightButton = _buttonCollection[index - 1];
        NSString *buttonContent = [rightButton.titleLabel.text substringToIndex:1];
        buttonContent = [buttonContent stringByAppendingFormat:@" %@",_meaningList[0]];
        [rightButton setTitle:buttonContent forState:UIControlStateNormal];
        
        // distribute the other three meaning to the button.
        for (int i = 1, count = 1 ; i < 5; ++i) {
            SelectedButton *originButton = _buttonCollection[i - 1];
            if (index != i) {
                NSString *originText = [originButton.titleLabel.text substringToIndex:1];
                [originButton setTitle:[originText stringByAppendingFormat:@" %@",_meaningList[count]] forState:UIControlStateNormal];
                count ++;
            }
        }
        for (int i = 0 ; i < 4; ++i) {
            SelectedButton *allButton = (SelectedButton *)_buttonCollection[i];
            allButton.enabled = YES;
        }

        self.holdButton.hidden = YES;
    }
}

- (IBAction)doSelect:(UIButton *)sender
{
    if ([[sender.titleLabel.text substringFromIndex:2] isEqualToString:_meaningList[0]]) {
        // the select is right
        self.wordDetail.text = @"";

        self.holdButton.hidden = NO;
        NSLog(@"doSelect: Select Right");
        for (int i = 0 ; i < 4; ++i) {
            SelectedButton *allButton = (SelectedButton *)_buttonCollection[i];
            allButton.enabled = NO;
        }

        _delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self getNextWord];
            
        });
        
    }
    else {
        self.wordDetail.text = @"";
        NSLog(@"doSelect: Select Wrong!");
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [self shake:sender];
    }
}

- (IBAction)holdWord:(id)sender
{
    // 使屏幕暂停, 点击 Do you want to see the detail? 按钮之后, title 变成next

    _holdWord = YES;
    [sender setTitle:@"Next" forState:UIControlStateNormal];
    SelectedButton *button = (SelectedButton *)sender;
    if ([button.titleLabel.text isEqualToString:@"Next"]) {
        _holdWord = NO;
        [self getNextWord];
        [sender setTitle:@"Do you want to see the detail?" forState:UIControlStateNormal];
    }
    self.wordDetail.text = self.meaningList[4];

}

-(NSUInteger)getRandomNumber:(int)from to:(int)to
{
    NSUInteger index = (NSUInteger)(from + (arc4random() % (to - from + 1))); //result is [from to]
    NSLog(@"%d is right",index);
    return index;
}

@end
