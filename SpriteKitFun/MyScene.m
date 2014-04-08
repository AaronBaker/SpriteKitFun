//
//  MyScene.m
//  SpriteKitFun
//
//  Created by Aaron Baker on 4/7/14.
//  Copyright (c) 2014 Aaron Baker. All rights reserved.
//

#import "MyScene.h"
@import CoreMotion;

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        SKNode *wall = [SKNode node];
        
        wall.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        [self addChild:wall];
        
        CMMotionManager *motionManager = [[CMMotionManager alloc] init];
        
        [motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData *data, NSError *error){
            
            self.physicsWorld.gravity = CGVectorMake(data.acceleration.x * 10, data.acceleration.y * 10);
            
            
        }];

        
        

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *box = [SKSpriteNode
                             spriteNodeWithColor:[UIColor redColor]
                             size:CGSizeMake(40.0, 40.0)];
        
        
        box.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:box.size];
        
        box.position = location;
        
        [self addChild:box];
        
        
        

    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
