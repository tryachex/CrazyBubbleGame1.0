//
//  lostScene.m
//  CrazyBubble
//
//  Created by admin on 14-4-6.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "lostScene.h"
#import "MyScene.h"

@implementation lostScene
-(id) initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        //self.backgroundColor=[SKColor  colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        SKEmitterNode *lost=[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"snow" ofType:@"sks"]];
        lost.position=CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:lost];
        NSString *message=@"Lost";
        SKLabelNode *label=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text=message;
        label.fontSize=30;
        label.fontColor=[SKColor blackColor];
        label.position=CGPointMake(self.size.width/2, self.size.height/2+30);
        [self addChild:label];
        [self runAction:[SKAction sequence:@[[SKAction waitForDuration:2.0],[SKAction runBlock:^{
            SKTransition *zhuan=[SKTransition flipVerticalWithDuration:0.4];
            SKScene *myScene=[[MyScene alloc] initWithSize:self.size];
            [self.view presentScene:myScene transition:zhuan];
        }]]]];
        
    }
    return self;
}


@end
