//
//  MyScene.m
//  SpriteKitFun
//
//  Created by Aaron Baker on 4/7/14.
//  Copyright (c) 2014 Aaron Baker. All rights reserved.
//

#import "MyScene.h"
@import CoreMotion;

@interface MyScene()
@property CMMotionManager *motionManager;
@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        SKNode *wall = [SKNode node];
        
        self.physicsWorld.gravity = CGVectorMake(4.0, 9.8);
        
        wall.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        [self addChild:wall];
        
        self.motionManager = [[CMMotionManager alloc] init];
        
        [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData *data, NSError *error){
            
            self.physicsWorld.gravity = CGVectorMake(data.acceleration.x * 10, data.acceleration.y * 10);
            
            
        }];

        
        

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInNode:self];
        
        UIColor* red = [UIColor colorWithRed:0xFF/255.0f
                                       green:0x41/255.0f
                                        blue:0x36/255.0f alpha:1];
        
        UIColor* yellow = [UIColor colorWithRed:0xFF/255.0f
                                          green:0xDC/255.0f
                                           blue:0x00/255.0f alpha:1];
        
        UIColor* fuchsia = [UIColor colorWithRed:0xF0/255.0f
                                           green:0x12/255.0f
                                            blue:0xBE/255.0f alpha:1];
        
        UIColor* blue = [UIColor colorWithRed:0x00/255.0f
                                        green:0x74/255.0f
                                         blue:0xD9/255.0f alpha:1];
        
        UIColor* lime = [UIColor colorWithRed:0x01/255.0f
                                        green:0xFF/255.0f
                                         blue:0x70/255.0f alpha:1];
        
        NSArray *colors = @[red,yellow,fuchsia,blue,lime];
        
        NSUInteger randomIndex = arc4random() % [colors count];

        UIColor *randomColor = [colors objectAtIndex:randomIndex];
        
        SKSpriteNode *box = [SKSpriteNode
                             spriteNodeWithColor:randomColor
                             size:CGSizeMake(40.0, 40.0)];
        box.texture = [SKTexture textureWithImageNamed:@"box"];
        box.colorBlendFactor = 1.0;
        
        box.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:box.size];
        
        box.position = location;
        
        [self addChild:box];
        
        
        

    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
