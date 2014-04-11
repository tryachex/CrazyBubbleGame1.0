//
//  Button.m
//  CrazyBubble
//
//  Created by apple on 14-4-5.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "SelectedButton.h"
#import "EmitterView.h"



@implementation SelectedButton
{
    CAEmitterLayer *fireEmitter; //1
    UIView *emitterView;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
   // self.titleLabel.textColor =
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        emitterView = [[EmitterView alloc] initWithFrame:CGRectZero];
        [self addSubview:emitterView];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.114 green: 0.705 blue: 1 alpha: 1];
    UIColor* color3 = [UIColor colorWithRed: 0.571 green: 1 blue: 0.571 alpha: 1];
    
    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)color3.CGColor,
                               (id)color.CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0.5, -0.5, 100, 33) cornerRadius: 6];
    CGContextSaveGState(context);
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(50.5, -0.5), CGPointMake(50.5, 32.5), 0);
    CGContextRestoreGState(context);
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}


@end
