//
//  TwoPeople.m
//  CrazyBubble
//
//  Created by admin on 14-4-6.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "TwoPeople.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "MainScenescene.h"
static NSString * const kServiceName = @"multipeer";
static NSString * const kMessageKey = @"message";
@interface  TwoPeople()<MCSessionDelegate,MCBrowserViewControllerDelegate>
@property (nonatomic, strong) MCPeerID *peerID;
@property (nonatomic, strong) MCSession *session;
@property (nonatomic) SKSpriteNode *goToMainScene;

// Browser using provided Apple UI
@property (nonatomic, strong) MCBrowserViewController *browserView;

// Advertiser assistant for declaring intent to receive invitations
@property (nonatomic, strong) MCAdvertiserAssistant *advertiserAssistant;
@property (nonatomic) UIActivityIndicatorView *activityView;
@property (nonatomic) SKLabelNode *lauchAdvertiseButton;
@property (nonatomic) SKLabelNode *sendMessageButton;
@property (nonatomic) SKLabelNode *labelnode;

@end

@implementation TwoPeople
-(id) initWithSize:(CGSize)size
{
    if (self==[super initWithSize:size]) {
        _goToMainScene=[SKSpriteNode spriteNodeWithImageNamed:@"5"];
        _goToMainScene.position=CGPointMake(50, 520);
        _goToMainScene.zPosition=1;
        _goToMainScene.name=@"gotomainscene";
        [self addChild:_goToMainScene];
        SKLabelNode *launchBrowerButton=[[SKLabelNode alloc] initWithFontNamed:@""];
        launchBrowerButton.text=@"LauchBrower";
        launchBrowerButton.position=CGPointMake(self.size.width/2, self.size.height/2-50);
        launchBrowerButton.name=@"lauchBrower";
        launchBrowerButton.zPosition=1;
        [self addChild:launchBrowerButton];
        _lauchAdvertiseButton.text=@"LauchAdverise";
        _lauchAdvertiseButton.position=CGPointMake(self.size.width/2, self.size.height/2-100);
        _lauchAdvertiseButton.name=@"lauchAdvert";
        _sendMessageButton.text=@"SendMessage";
        _sendMessageButton.position=CGPointMake(self.size.width/2, self.size.height/2-150);
        _sendMessageButton.name=@"sendMessage";
       // [self addChild:_sendMessageButton];
        //[self addChild:_lauchAdvertiseButton];
    }
               return self;
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint positionInScene=[touch locationInNode:self];
    SKSpriteNode *touchedNode=(SKSpriteNode *) [self nodeAtPoint:positionInScene];
    if ([[touchedNode name]  isEqualToString:@"lauchBrower"]) {
        _peerID = [[MCPeerID alloc] initWithDisplayName:@"Browser Name"];
        _session = [[MCSession alloc] initWithPeer:_peerID];
        _session.delegate = self;
        _browserView = [[MCBrowserViewController alloc] initWithServiceType:kServiceName
                                                                    session:_session];
        _browserView.delegate = self;
        /*[self.view
         presentViewController:_browserView animated:YES completion:nil];*/
        
        _lauchAdvertiseButton.hidden = YES;
      // _launchBrowerButton.hidden = YES;
    }
    if ([[touchedNode name] isEqualToString:@"gotomainscene"]) {
        SKTransition *trans=[SKTransition flipHorizontalWithDuration:1.3];
        SKScene *mainScene=[[MainScenescene alloc] initWithSize:self.size];
        [self.view presentScene:mainScene transition:trans];
    }
    if ([[touchedNode name] isEqualToString:@"lauchAdvert"]) {
            _peerID = [[MCPeerID alloc] initWithDisplayName:@"Advertiser Name"];
    _session = [[MCSession alloc] initWithPeer:_peerID];
    _session.delegate = self;
    _advertiserAssistant = [[MCAdvertiserAssistant alloc] initWithServiceType:kServiceName
                                                                discoveryInfo:nil
                                                                      session:_session];
    [_advertiserAssistant start];
    
    _lauchAdvertiseButton.hidden = YES;
   //_launchBrowerButton.hidden = YES;
   _activityView.hidden = NO;
        
    }
    if ([[touchedNode name] isEqualToString:@"sendMessage"]) {
       NSString *message = _labelnode.text;
        NSDictionary *dataDict = @{ kMessageKey : message };
        NSData *data = [NSPropertyListSerialization dataWithPropertyList:dataDict
                                                                  format:NSPropertyListBinaryFormat_v1_0
                                                                 options:0
                                                                   error:NULL];
        NSError *error;
        [self.session sendData:data
                       toPeers:[_session connectedPeers]
                      withMode:MCSessionSendDataReliable
                         error:&error];
    }
}
#pragma mark - MCBrowserViewControllerDelegate

- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
        [_browserView.browser stopBrowsingForPeers];
    };


- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController {
   
        [_browserView.browser stopBrowsingForPeers];
        _lauchAdvertiseButton.hidden = NO;
    //    _launchBrowerButton.hidden = NO;
    };

#pragma mark - MCSessionDelegate

// MCSessionDelegate methods are called on a background queue, if you are going to update UI
// elements you must perform the actions on the main queue.

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    switch (state) {
        case MCSessionStateConnected: {
            dispatch_async(dispatch_get_main_queue(), ^{
                _labelnode.hidden=YES;
                _sendMessageButton.hidden = NO;
                _activityView.hidden = YES;
            });
            
            // This line only necessary for the advertiser. We want to stop advertising our services
            // to other browsers when we successfully connect to one.
            [_advertiserAssistant stop];
            break;
        }
        case MCSessionStateNotConnected: {
            dispatch_async(dispatch_get_main_queue(), ^{
                _lauchAdvertiseButton.hidden = NO;
             //   _launchBrowerButton.hidden = NO;
                _labelnode.hidden = YES;
                _sendMessageButton.hidden = YES;
            });
            break;
        }
        default:
            break;
    }
}
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    NSPropertyListFormat format;
    NSDictionary *receivedData = [NSPropertyListSerialization propertyListWithData:data
                                                                           options:0
                                                                            format:&format
                                                                             error:NULL];
    NSString *message = receivedData[kMessageKey];
    if ([message length]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *messageAlert = [[UIAlertView alloc] initWithTitle:@"Received message"
                                                                   message:message
                                                                  delegate:self
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
            [messageAlert show];
        });
    }
}

// Required MCSessionDelegate protocol methods but are unused in this application.

- (void)                      session:(MCSession *)session
    didStartReceivingResourceWithName:(NSString *)resourceName
                             fromPeer:(MCPeerID *)peerID
                         withProgress:(NSProgress *)progress {
    
}

- (void)     session:(MCSession *)session
    didReceiveStream:(NSInputStream *)stream
            withName:(NSString *)streamName
            fromPeer:(MCPeerID *)peerID {
    
}

- (void)                       session:(MCSession *)session
    didFinishReceivingResourceWithName:(NSString *)resourceName
                              fromPeer:(MCPeerID *)peerID
                                 atURL:(NSURL *)localURL
                             withError:(NSError *)error {
    
}

@end
