//
//  DetailView.m
//  CrazyBubble
//
//  Created by apple on 14-4-5.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LearnWordView.h"

@implementation LearnWordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
#define which 1
#if which == 1
    UIImage *im = [UIImage imageNamed:@"background.jpeg"];
  /*  CIImage *cImage = [[CIImage alloc] initWithImage:im];
    CIFilter *filter = [CIFilter filterWithName:@""];
    [filter setDefaults];
    [filter setValue:cImage forKey:@"inputImage"];
  //  [filter setValue:[NSNumber numberWithFloat:0.5f] forKey:@"inputIntensity"];
    
    CIImage *image = [filter outputImage];
    CIContext *context = [CIContext contextWithOptions:Nil];
    CGImageRef cgImage = [context createCGImage:image fromRect:image.extent];
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    [resultImage drawInRect:[[UIScreen mainScreen] bounds]];*/
    [im drawInRect:self.bounds];
#elif which == 2
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.562 green: 0.343 blue: 1 alpha: 1];
    UIColor* color3 = [UIColor colorWithRed: 0.933 green: 1 blue: 0.8 alpha: 1];
    
    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)color3.CGColor,
                               (id)color.CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(-227.5, -100.5, 0, 0)];
    [[UIColor whiteColor] setFill];
    [rectanglePath fill];
    [[UIColor blackColor] setStroke];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
    
    
    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(-292.5, -131.5, 320, 568)];
    CGContextSaveGState(context);
    [rectangle2Path addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(-132.5, -131.5), CGPointMake(-132.5, 436.5), 0);
    CGContextRestoreGState(context);
    [[UIColor blackColor] setStroke];
    rectangle2Path.lineWidth = 1;
    [rectangle2Path stroke];
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);

#endif
}

@end
