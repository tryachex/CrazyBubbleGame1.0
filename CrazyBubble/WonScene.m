//
//  WonScene.m
//  CrazyBubble
//
//  Created by admin on 14-4-5.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "WonScene.h"
#import "MyScene.h"

@implementation WonScene
-(id) initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        _background=[[SKSpriteNode alloc] initWithImageNamed:@"bg1"];
        // _background=[[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:self.size];
        _background.position=CGPointMake(self.size.width/2, 0);
        _background.anchorPoint=CGPointMake(0.5, 0);
        _background.zPosition=0;
        [self addChild:_background];
        SKEmitterNode *wonderful=[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"fire" ofType:@"sks"]];
         wonderful.position=CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:wonderful];
        // self.backgroundColor=[SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        NSString *message=@"You Won";
        SKLabelNode *label=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text=message;
        label.fontSize=40;
        label.position=CGPointMake(self.size.width/2, self.size.height/2);
        label.fontColor=[SKColor blackColor];
        [self addChild:label];
        
        [self runAction:[SKAction sequence:@[[SKAction waitForDuration:2.1],[SKAction runBlock:^{
            SKTransition *reveal=[SKTransition fadeWithDuration:1.3];
            SKScene *myScene=[[MyScene alloc] initWithSize:size];
            [self.view presentScene:myScene transition:reveal];
        }]]]];
    }
    return  self;
}
@end
