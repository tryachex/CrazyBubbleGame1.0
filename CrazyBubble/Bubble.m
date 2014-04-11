//
//  bubble.m
//  CrazyBubble
//
//  Created by admin on 14-4-4.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "Bubble.h"
#import "MyScene.h"

@implementation Bubble
+(instancetype) creatbubble
{
    Bubble *abubble=(Bubble*) [Bubble labelNodeWithFontNamed:@""];
    abubble.hp=1;
    abubble.type=bubble1;
    abubble.name = @"Bubble";
    return  abubble;
}
+(instancetype) creatbubbleBoss
{
    Bubble *abubbleBoss=(Bubble *) [Bubble labelNodeWithFontNamed:@""];
    abubbleBoss.hp=3;
    abubbleBoss.type=bubbleBoss;
    return abubbleBoss;
}

@end
