//
//  bubble.h
//  CrazyBubble
//
//  Created by admin on 14-4-4.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
typedef enum  BubbleType
{
    bubble1,
    bubbleBoss
} BubbleType;
@interface Bubble : SKLabelNode
@property (nonatomic) BubbleType type;
@property (nonatomic,assign) int hp;
@property (nonatomic) SKSpriteNode *bgpng;
@property  (nonatomic) SKEmitterNode *Emittertry;
+(instancetype) creatbubble;
+(instancetype) creatbubbleBoss;

@end