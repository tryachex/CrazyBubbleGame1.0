//
//  WordDetailView.m
//  CrazyBubble
//
//  Created by apple on 14-4-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "WordDetailView.h"

@implementation WordDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.4 green: 0.6 blue: 0.8 alpha: 1];
    UIColor* color2 = [UIColor colorWithRed: 0.6 green: 0.8 blue: 1 alpha: 1];
    UIColor* color3 = [UIColor colorWithRed: 0.4 green: 0.8 blue: 0.8 alpha: 1];
    
    //// Gradient Declarations
    NSArray* gradient4Colors = [NSArray arrayWithObjects:
                                (id)color.CGColor,
                                (id)color3.CGColor,
                                (id)color2.CGColor, nil];
    CGFloat gradient4Locations[] = {0, 0.49, 1};
    CGGradientRef gradient4 = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradient4Colors, gradient4Locations);
    
    //// Rounded Rectangle 2 Drawing
    UIBezierPath* roundedRectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 240, 278) cornerRadius: 12];
    CGContextSaveGState(context);
    [roundedRectangle2Path addClip];
    CGContextDrawLinearGradient(context, gradient4, CGPointMake(120, -0), CGPointMake(120, 278), 0);
    CGContextRestoreGState(context);
    
    //// Cleanup
    CGGradientRelease(gradient4);
    CGColorSpaceRelease(colorSpace);
    self.alpha = 0.5;
    self.textColor = [UIColor blueColor];
}


@end
