//
//  MyScene.m
//  CrazyBubble
//
//  Created by admin on 14-4-4.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "MyScene.h"
#import "WonScene.h"
#import "lostScene.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "MainScenescene.h"

 static BOOL result=YES;
static BOOL check=YES;
static inline CGPoint rwAdd(CGPoint a,CGPoint b)
{
    return CGPointMake(a.x+b.x, a.y+b.y);
}
static inline CGPoint rwSub(CGPoint a, CGPoint b)
{
    return CGPointMake(a.x-b.x, a.y-b.y);
}
static inline CGPoint rwMult(CGPoint a, float b)
{
    return CGPointMake(a.x*b, a.y*b);
}
static inline float rwLength(CGPoint a)
{
    return sqrtf(a.x*a.x+a.y*a.y);
}

static inline CGPoint rwNormalize(CGPoint a)
{
    float length=rwLength(a);
    return  CGPointMake(a.x/length, a.y/length);
}
typedef enum  SKRoleCategory
{
    SkRoleCategorybubble,
    SkRoleCategoryplayerDrogon,
    SkRoleCategorymeBubble
}  SkRoleCategory;
@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        //self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        //SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        /*myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];*/
        
        /* SKEmitterNode *spark=[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"]];
        spark.position=CGPointMake(self.size.width/2,self.size.height/2);
        [self addChild:spark];*/
        
        result=YES;
        [self initBackground];
        [self initPhysiceWorld];
        [self initPlayerDrogon];
        [self initScore];
        [self creatBubbles];
        [self creatBubbleMeBubble];
        [self initbutton];
        _jishu=0;
        _bubbledestoryed=0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restart) name:@"restartNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(useCrazy) name:@"binggo" object:nil];
    }
    return self;
}
-(void) restart
{
    [self removeAllActions];
    [self removeAllChildren];
    [self initBackground];
    [self initPlayerDrogon];
    [self initScore];
    [self creatBubbleMeBubble];
    [self creatBubbles];
    [self initbutton];
    result=YES;
}
-(void) initbutton
{
    _button1=[SKSpriteNode spriteNodeWithImageNamed:@"BurstAircraftPause"];
    _button1.position=CGPointMake(300, 60);
    _button1.zRotation=1;
    [self addChild:_button1];
    _button1.name=@"leftButton";
    _button3=[SKSpriteNode spriteNodeWithImageNamed:@"5"];
    _button3.position=CGPointMake(50, 520);
    _button3.zPosition=1;
    _button3.name=@"goout";
    [self addChild:_button3];
   /* _button2=[SKSpriteNode spriteNodeWithImageNamed:@"23333"];
    _button2.position=CGPointMake(50, 60);
    _button2.zPosition=1;
    _button2.name=@"rightButton";
    [self addChild:_button2];*/
}
-(void)pause
{
    ((SKView*) self.view).paused=YES;
    
    UIView *pauseView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];
    UIButton *button1=[[UIButton alloc] init];
    [button1 setFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-100, 50, 200, 30)];
    [button1 setTitle:@"continue" forState:UIControlStateNormal];
    [button1 setTitleColor:[SKColor blueColor] forState:UIControlStateNormal];
    [button1.layer setBorderWidth:2.0];
    [button1.layer setCornerRadius:15.0];
    [button1.layer setBorderColor:[[UIColor grayColor] CGColor]];
    
    [button1 addTarget:self action:@selector(continueGame:) forControlEvents:UIControlEventTouchUpInside];
    [pauseView addSubview:button1];
    
    UIButton *button2=[[UIButton alloc] init];
    [button2 setFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-100,100,200,30)];
    [button2 setTitle:@"try again" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button2.layer setBorderWidth:2.0];
    [button2.layer setCornerRadius:15.0];
    [button2.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [button2 addTarget:self action:@selector(restart:) forControlEvents:UIControlEventTouchUpInside];
    [pauseView addSubview:button2];
    
    pauseView.center=self.view.center;
    [self.view addSubview:pauseView];
    
}

-(void) initPhysiceWorld
{
    self.physicsWorld.contactDelegate=self;
    self.physicsWorld.gravity=CGVectorMake(0, 0);
}
-(void) initBackground
{
    _background=[[SKSpriteNode alloc] initWithImageNamed:@"bg1"];
   // _background=[[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:self.size];
     _background.position=CGPointMake(self.size.width/2, 0);
    _background.anchorPoint=CGPointMake(0.5, 0);
    _background.zPosition=0;
    [self addChild:_background];
    //[self runAction:[SKAction repeatActionForever:[SKAction playSoundFileNamed:  waitForCompletion:<#(BOOL)#>]]];
}
-(void) initScore
{
    _scoreLabel=[SKLabelNode labelNodeWithFontNamed:@"Helvetica-Bold"];
    _scoreLabel.text=@"0";
    _scoreLabel.fontSize=500;
    _scoreLabel.position=CGPointMake(CGRectGetMidX(self.frame), 100);
    _scoreLabel.alpha=0.2;
    [self addChild:_scoreLabel];
}
-(void) initPlayerDrogon
{
    if (check) {
    _playerDrogon=[SKSpriteNode spriteNodeWithImageNamed:@"long"];
    _playerDrogon.position=CGPointMake(160, 50);
    _playerDrogon.zPosition=1;
    _playerDrogon.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:_playerDrogon.size];
    _playerDrogon.physicsBody.categoryBitMask=SkRoleCategoryplayerDrogon;
    _playerDrogon.physicsBody.collisionBitMask=SkRoleCategorybubble;
    _playerDrogon.physicsBody.contactTestBitMask=SkRoleCategorybubble;
    _playerDrogon.name=@"player";
    [self addChild:_playerDrogon];
    check=NO;
    }
    else
    {
        _playerDrogon=[SKSpriteNode spriteNodeWithImageNamed:@"long"];
        _playerDrogon.position=CGPointMake(160, 50);
        _playerDrogon.zPosition=1;
        _playerDrogon.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:_playerDrogon.size];
        _playerDrogon.physicsBody.categoryBitMask=SkRoleCategoryplayerDrogon;
        _playerDrogon.physicsBody.collisionBitMask=SkRoleCategorybubble;
        _playerDrogon.physicsBody.contactTestBitMask=SkRoleCategorybubble;
        _playerDrogon.name=@"player";
        [self addChild:_playerDrogon];
        check=YES;
    }
}
-(void) useCrazy
{
    [self.scene enumerateChildNodesWithName:@"Bubble" usingBlock:^(SKNode *node, BOOL *stop){
       
        Bubble *aBubble = (Bubble *)node;
        
        aBubble.hp = 1;
        [self bubbleCollistionAnimaton:aBubble];
        
    }];
    
}
-(void) creatBubbles
{
   
    Bubble *(^creatbubble) (BubbleType)=^(BubbleType type)
    {
        Bubble *abubble=nil;
        switch (type) {
            case 0:
            abubble=[Bubble creatbubble];
            abubble.bgpng=[SKSpriteNode spriteNodeWithImageNamed:@"paopao"];
            //[abubble addChild:abubble.bgpng];
                break;
                case 1:
                abubble=[Bubble creatbubbleBoss];
                abubble.bgpng=[SKSpriteNode spriteNodeWithImageNamed:@"boss"];
                break;
                default:
                break;
        }
          abubble.bgpng.alpha=0.9;
         [abubble addChild:abubble.bgpng];
             abubble.zPosition=1;
            abubble.physicsBody=abubble.bgpng.physicsBody;
        abubble.physicsBody.dynamic=YES;
        abubble.physicsBody.usesPreciseCollisionDetection=YES;
            abubble.physicsBody.categoryBitMask=SkRoleCategorybubble;
            abubble.physicsBody.collisionBitMask=SkRoleCategorymeBubble;
            abubble.physicsBody.contactTestBitMask=SkRoleCategorymeBubble;
            //abubble.position=CGPointMake(x,self.size.height);
             return abubble;
        };
     if (result) {
       int x=32;
       for (int i=5; i>0; i--) {
        Bubble *abubble=creatbubble(bubble1);
        //   NSString *toinbubble=
        abubble.name=@"bubble";
        //NSString *message=
        abubble.text=[NSString stringWithFormat:@"ccc"];
        abubble.position=CGPointMake(x,self.size.height);
        [self addChild:abubble];
        [abubble runAction:[SKAction moveToY:0 duration:15]];
        x=x+64;
    }
        result=NO;
     }
    else
    {
        Bubble *abubble=creatbubble(bubbleBoss);
        abubble.name=@"bubble";
        //NSString *message=
        abubble.text=@"crazyBubble";
        abubble.position=CGPointMake(self.size.width/2, self.size.height);
        [self addChild:abubble];
        [abubble runAction:[SKAction moveToY:0 duration:12]];
    }
}
-(void) changeScore:(BubbleType) type
{
    int score=0;
    switch (type) {
        case 0:
            score=1;
            break;
            case 1:
            score=10;
        default:
            break;
    }
    [_scoreLabel runAction:[SKAction runBlock:^{
        _scoreLabel.text=[NSString stringWithFormat:@"%d",_scoreLabel.text.intValue+score];
    }]];
}
-(void) bubbleCollistionAnimaton:(Bubble*) bubble
{
    if (![bubble actionForKey:@"dieAction"]) {
       /* if (bubble.text  ) {
            _todieLabelNode
        }*/
        NSString *soundFileName=nil;
        switch (bubble.type) {
            case 0:
                bubble.hp--;
                soundFileName=@"";
                break;
            case 1:
                bubble.hp--;
                soundFileName=@"";
            default:
                break;
        }
    }
    if (!bubble.hp) {
        SKEmitterNode *boomEmitter=[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"fire" ofType:@"sks"]];
        boomEmitter.zPosition=1;
                                    boomEmitter.position=bubble.position;
                                    [self addChild:boomEmitter];
           [bubble removeAllActions];
           [bubble removeFromParent];
        [self changeScore:bubble.type];
        _jishu++;
        //[self runAction:[SKAction playSoundFileNamed:  waitForCompletion:]]
        _bubbledestoryed++;
        }
    if (_bubbledestoryed==6) {
        SKTransition *reveal=[SKTransition doorsOpenVerticalWithDuration:1.3];
        SKScene *wonScene=[[WonScene alloc] initWithSize:self.size];
        [self.view presentScene:wonScene transition:reveal];
    }
    
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    /*for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }*/
    UITouch *touch=[touches anyObject];
      CGPoint positionInScene=[touch locationInNode:self];
      SKSpriteNode *touchedNode=(SKSpriteNode*) [self nodeAtPoint:positionInScene];
    if ([[touchedNode name] isEqualToString:@"leftButton"]) {
              SKEmitterNode *emitter=[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"firebutton" ofType:@"sks"]];
              emitter.zPosition=1;
              emitter.position=_button1.position;
              [self addChild:emitter];
        [_button1 runAction:[SKAction moveToY:_button1.position.y duration:0.5] completion:^{
            ((SKView*) self.view).paused=YES;
            
            UIView *pauseView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];
            UIButton *button1=[[UIButton alloc] init];
            [button1 setFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-100, 50, 200, 30)];
            [button1 setTitle:@"continue" forState:UIControlStateNormal];
            [button1 setTitleColor:[SKColor blueColor] forState:UIControlStateNormal];
            [button1.layer setBorderWidth:2.0];
            [button1.layer setCornerRadius:15.0];
            [button1.layer setBorderColor:[[UIColor grayColor] CGColor]];
            
            [button1 addTarget:self action:@selector(continueGame:) forControlEvents:UIControlEventTouchUpInside];
            [pauseView addSubview:button1];
            
            UIButton *button2=[[UIButton alloc] init];
            [button2 setFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-100,100,200,30)];
            [button2 setTitle:@"try again" forState:UIControlStateNormal];
            [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button2.layer setBorderWidth:2.0];
            [button2.layer setCornerRadius:15.0];
            [button2.layer setBorderColor:[[UIColor grayColor] CGColor]];
            [button2 addTarget:self action:@selector(restart:) forControlEvents:UIControlEventTouchUpInside];
            [pauseView addSubview:button2];
            
            pauseView.center=self.view.center;
            [self.view addSubview:pauseView];
        
        }];
    }
    if ([[touchedNode name] isEqualToString:@"rightButton"]) {
        [_button2 runAction:[SKAction moveToY:100 duration:2] completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"binggo" object:nil];
        }];
    }
    if ([[touchedNode name] isEqualToString:@"goout"]) {
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            SKScene *toScene=[[MainScenescene alloc] initWithSize:self.size];
        SKTransition *transtion=[SKTransition flipHorizontalWithDuration:1.3];
        [self.view presentScene:toScene transition:transtion];
        });
        SKEmitterNode *emitter=[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"firebutton" ofType:@"sks"]];
                                emitter.position=_button3.position;
                                emitter.zPosition=1;
                                [self addChild:emitter];
        
    }
         CGPoint location=[touch locationInNode:self];
        double w=location.x-self.size.width/2;
        double h=location.y;
        float angle1=atan(h/w);
        double a=self.size.width/2-_playerDrogon.position.x;
        double b=_playerDrogon.position.y;
        float angle2=atan(b/a);
    
        SKAction *action=[SKAction rotateToAngle:ScalarShortestAngleBetween(angle1, angle2  ) duration:1];
        [_playerDrogon runAction:action];
        
          CGPoint offset=rwSub(location, _todieLabelNode.position);
    
        // if (offset.y<=0) {
        
        
        CGPoint direction=rwNormalize(offset);
     
        CGPoint shootAmount=rwMult(direction, 1000);
    
        CGPoint realDest=rwAdd(shootAmount, _todieLabelNode.position);
        SKAction *actionMove=[SKAction moveTo:realDest duration:1.5];
        SKAction *actionMoveDone=[SKAction removeFromParent];
    SKAction *actionmoveangle=[SKAction rotateByAngle:M_PI duration:1];
      [_todieLabelNode runAction:actionmoveangle];
      [_todieLabelNode runAction:[SKAction sequence:@[actionMove,actionMoveDone]]];
}
-(void) restart:(UIButton *)button
{
    [button.superview removeFromSuperview];
    ((SKView*)self.view).paused=NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"restartNotification" object:nil];
    
}
-(void) continueGame:(UIButton*)button
{
    [button.superview removeFromSuperview ];
    ((SKView*)self.view).paused=NO;
}
-(void) playerCollisionAnimation:(SKSpriteNode *) sprite
{
    [self removeAllActions];
    [self runAction:[SKAction playSoundFileNamed:@"game_over.mp3" waitForCompletion:YES]];
    /*SKLabelNode *label=[SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Thin"];
    label.text=@"Game Over";
    label.zPosition=2;
    label.fontColor=[SKColor redColor];
    label.position=CGPointMake(self.size.width/2, self.size.height*2/3);
    [self addChild:label];*/
    NSLog(@"asdas");
    [self removeAllChildren];
    SKTransition *receals=[SKTransition flipHorizontalWithDuration:1.5];
    SKScene *gameOverScene=[[lostScene alloc] initWithSize:self.size];
    [self.view presentScene:gameOverScene transition:receals];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"gameOverNotification" object:nil];

}
-(void)  creatBubbleMeBubble
{
    Bubble *bulletme=[[Bubble alloc] initWithFontNamed:@""];
    bulletme.bgpng=[SKSpriteNode spriteNodeWithImageNamed:@"paopao"];
    bulletme.bgpng.alpha=0.5;
    //NSString *toinmeBubble=
    //NSMutableArray *bubbletexts=
    //int x=(arc4random()%220)+37;
    //NSString *message=[bubbletes objectAtIndex:
    bulletme.text=[NSString stringWithFormat:@"aaa"];
    [bulletme addChild:bulletme.bgpng];
    bulletme.physicsBody=bulletme.bgpng.physicsBody;
    bulletme.physicsBody.categoryBitMask=SkRoleCategorymeBubble;
    bulletme.physicsBody.collisionBitMask=SkRoleCategorybubble;
    bulletme.physicsBody.contactTestBitMask=SkRoleCategorybubble;
    bulletme.physicsBody.usesPreciseCollisionDetection=YES;
    bulletme.zPosition=1;
    bulletme.name=@"bubbleme";
    //bulletme.Emittertry=emitter;
    SKEmitterNode *emitter=[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"firebubble" ofType:@"sks"]];
    emitter.position=bulletme.position;
    emitter.name=@"emitter";
    [bulletme addChild:emitter];
    bulletme.position=CGPointMake(_playerDrogon.position.x, _playerDrogon.position.y-10);
        _todieLabelNode=bulletme;
     [self addChild:_todieLabelNode];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (_jishu==5) {
        [self creatBubbles];
        _jishu=_jishu+1;
    }
    [self checkCollisions];


}
#pragma  mark -
/*-(void) didBeginContact:(SKPhysicsContact *)contact
{
    if (contact.bodyA.categoryBitMask&SkRoleCategorybubble||contact.bodyB.categoryBitMask&SkRoleCategorybubble) {
        Bubble *bubble1=(contact.bodyA.categoryBitMask&SkRoleCategorybubble)? (Bubble*)  contact.bodyA.node:(Bubble*) contact.bodyB.node;
        if (contact.bodyA.categoryBitMask&SkRoleCategoryplayerDrogon||contact.bodyB.categoryBitMask&SkRoleCategoryplayerDrogon) {
            SKSpriteNode *playDrogon=(contact.bodyA.categoryBitMask&SkRoleCategoryplayerDrogon)?
            (SKSpriteNode *)contact.bodyA.node : (SKSpriteNode*) contact.bodyB.node;
            [self playerCollisionAnimation:playDrogon];
            NSLog(@"sdadsad");
        }
        else
        {
            Bubble *bubbleme=(contact.bodyA.categoryBitMask&SkRoleCategorymeBubble)? (Bubble* )contact.bodyB.node:(Bubble*)contact.bodyA.node;
            [bubbleme removeFromParent];
            [self bubbleCollistionAnimaton:bubble1];
        }
        
    }
}*/
-(void)checkCollisions{
    [self enumerateChildNodesWithName:@"bubble" usingBlock:^(SKNode * node, BOOL * stop) {
        Bubble  *bubble= (Bubble *) node;
        if (CGRectIntersectsRect(bubble.frame,_todieLabelNode.frame)){
           // if (bubble.text isEqualToString:_todieLabelNode.text) {
           // NSString *message=
            //[bubble removeFromParent];
           // if (bubble.text isEqualToString:<#(NSString *)#>) {
            [self bubbleCollistionAnimaton:bubble];
            [_todieLabelNode removeFromParent];
            //[bu]  该数组delete该object
            [self creatBubbleMeBubble];
            NSLog(@"hit");
            return;
        }
        /*else
        {
            [self creatBubbleMeBubble];
        }*/
        if (_todieLabelNode.position.y>self.size.height-10||_todieLabelNode.position.x>self.size.width-5||_todieLabelNode.position.x<5) {
            [self creatBubbleMeBubble];
        }
        if (CGRectIntersectsRect(bubble.frame, _playerDrogon.frame)) {
            [self playerCollisionAnimation:_playerDrogon];
        }
    }];
   /*[self enumerateChildNodesWithName:@"bubble" usingBlock:^(SKNode * node, BOOL * stop) {
        SKSpriteNode * enemy = (SKSpriteNode *) node;
        //CGRect smallerFrame = CGRectInset(enemy.frame,20,20);
        if (CGRectIntersectsRect(enemy.frame,)){
            [enemy removeFromParent];
        }
    }];*/
    //[self creatBubbleMeBubble];
}
@end
