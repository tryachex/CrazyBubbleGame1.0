//
//  SelectFunctionView.m
//  CrazyBubble
//
//  Created by apple on 14-4-5.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "SelectFunctionView.h"

@implementation SelectFunctionView

- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.562 green: 0.343 blue: 1 alpha: 1];
    UIColor* color3 = [UIColor colorWithRed: 0.933 green: 1 blue: 0.8 alpha: 1];
    
    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)color.CGColor,
                               (id)color3.CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.5, -0.5, 320, 568)];
    [[UIColor whiteColor] setFill];
    [rectanglePath fill];
    [[UIColor blackColor] setStroke];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
    
    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(0.5, -0.5, 320, 568)];
    CGContextSaveGState(context);
    [rectangle2Path addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(160.5, -0.5), CGPointMake(160.5, 567.5), 0);
    CGContextRestoreGState(context);
    [[UIColor blackColor] setStroke];
    rectangle2Path.lineWidth = 1;
    [rectangle2Path stroke];
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);

}

@end
