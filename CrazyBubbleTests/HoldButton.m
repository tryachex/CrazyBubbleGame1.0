//
//  HoldButton.m
//  CrazyBubble
//
//  Created by apple on 14-4-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HoldButton.h"

@implementation HoldButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [self setTintColor:[UIColor colorWithRed: 0.2 green: 0.6 blue: 0.8 alpha: 1]];
    self.titleLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:17];
}


- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 0.4 blue: 0.4 alpha: 1];
    UIColor* color2 = [UIColor colorWithRed: 1 green: 1 blue: 0 alpha: 1];
    UIColor* color3 = [UIColor colorWithRed: 0.2 green: 0.6 blue: 0.8 alpha: 1];
    
    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)color.CGColor,
                               (id)color2.CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 280, 30) cornerRadius: 4];
    CGContextSaveGState(context);
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(104.5, 0), CGPointMake(104.5, 30), 0);
    CGContextRestoreGState(context);
    [color3 setStroke];
    roundedRectanglePath.lineWidth = 1;
    [roundedRectanglePath stroke];
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}


@end