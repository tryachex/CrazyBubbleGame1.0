
#ifndef AH_RETAIN
#if __has_feature(objc_arc)
#define AH_RETAIN(x) (x)
#define AH_RELEASE(x) (void)(x)
#define AH_AUTORELEASE(x) (x)
#define AH_SUPER_DEALLOC (void)(0)
#else
#define __AH_WEAK
#define AH_WEAK assign
#define AH_RETAIN(x) [(x) retain]
#define AH_RELEASE(x) [(x) release]
#define AH_AUTORELEASE(x) [(x) autorelease]
#define AH_SUPER_DEALLOC [super dealloc]
#endif
#endif

//  ARC Helper ends


#import <UIKit/UIKit.h>


@interface FXLabel : UILabel

@property (nonatomic, assign) CGFloat shadowBlur;
@property (nonatomic, assign) CGSize innerShadowOffset;
@property (nonatomic, strong) UIColor *innerShadowColor;
@property (nonatomic, strong) UIColor *gradientStartColor;
@property (nonatomic, strong) UIColor *gradientEndColor;
@property (nonatomic, copy) NSArray *gradientColors;
@property (nonatomic, assign) CGPoint gradientStartPoint;
@property (nonatomic, assign) CGPoint gradientEndPoint;
@property (nonatomic, assign) NSUInteger oversampling;
@property (nonatomic, assign) UIEdgeInsets textInsets;

@end
