//
//  WordLabel.m
//  CrazyBubble
//
//  Created by apple on 14-4-5.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "WordLabel.h"
#import "EmitterView.h"

@implementation WordLabel{
    CAEmitterLayer *fireEmitter; //1
    UIView *emitterView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib
{
 //   self.backgroundColor = [UIColor blackColor];
    emitterView = [[EmitterView alloc] initWithFrame:CGRectZero];
    [self addSubview:emitterView];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //// General Declarations
    

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.repeatCount = MAXFLOAT;
    animation.path = path;
    [emitterView.layer addAnimation:animation forKey:@"test"];
}

@end
