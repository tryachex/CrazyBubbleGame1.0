//
//  MyScene.h
//  CrazyBubble
//

//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Bubble.h"

@interface MyScene : SKScene<SKPhysicsContactDelegate>
@property SKSpriteNode *background;
@property SKLabelNode *scoreLabel;
@property SKSpriteNode *playerDrogon;
@property Bubble *todieLabelNode;
@property int jishu;
@property int bubbleTime;
@property int bubbledestoryed;
@property SKSpriteNode *button1;
@property SKSpriteNode *button2;
@property SKSpriteNode *button3;
@end
