//
//  MainScenescene.m
//  CrazyBubble
//
//  Created by admin on 14-4-6.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "MainScenescene.h"
#import "MyScene.h"
#import "TwoPeople.h"

@implementation MainScenescene
-(id) initWithSize:(CGSize)size
{
    if (self=[super initWithSize:size]) {
        SKSpriteNode *background=[SKSpriteNode spriteNodeWithImageNamed:@"bg2"];
        background.position=CGPointMake(self.size.width/2, 0);
        background.anchorPoint=CGPointMake(0.5, 0);
        background.zPosition=0;
        [self addChild:background];
    SKLabelNode *label=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    NSString *message=@"Hello Bubble!";
    label.text=message;
    label.fontSize=40;
    label.position=CGPointMake(self.size.width/2, self.size.height/2+100);
    label.fontColor=[SKColor blueColor];
    [self addChild:label];
    
        _button1=[[SKLabelNode alloc] init];
        _button2=[[SKLabelNode alloc] init];
    _button1.text=@"One";
    _button1.position=CGPointMake(self.size.width/2, self.size.height/2-50);
    _button1.name=@"One";
    [self addChild:_button1];
    _button2.text=@"Two";
    _button2.name=@"Two";
    _button2.position=CGPointMake(self.size.width/2, self.size.height/2-100);
    [self addChild:_button2];
        _button3=[SKSpriteNode spriteNodeWithImageNamed:@"2"];
        _button3.position=CGPointMake(50, 530);
        [self addChild:_button3];
        _button3.name=@"golong";
    }
    return  self;
    
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint positionInScene=[touch locationInNode:self];
    SKSpriteNode *touchedNode=(SKSpriteNode*) [self nodeAtPoint:positionInScene];
    if ([[touchedNode name] isEqualToString:@"One"]) {
        SKEmitterNode *emitter=[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"smokebutton1" ofType:@"sks"]];
        emitter.position=_button1.position;
        emitter.zPosition=1;
        [self addChild:emitter];

        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            SKTransition *zhuan=[SKTransition fadeWithDuration:1.3];
            SKScene *myScene=[[MyScene alloc] initWithSize:self.size];
        [self.view presentScene:myScene transition:zhuan];
 
        });
                
  
    }
    if ([[touchedNode name] isEqualToString:@"Two"]) {
        SKTransition *ozhuan=[SKTransition flipHorizontalWithDuration:1.3];
        SKScene *twoScene=[[TwoPeople alloc] initWithSize:self.size];
        [self.view presentScene:twoScene transition:ozhuan];
    }
    /*if ([[touchedNode name] isEqualToString:@"golong"]) {
        [self.view pre]
    }*/
}


@end