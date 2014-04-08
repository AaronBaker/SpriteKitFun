//
//  MyScene.m
//  SpriteKitFun
//
//  Created by Aaron Baker on 4/7/14.
//  Copyright (c) 2014 Aaron Baker. All rights reserved.
//

#import "MyScene.h"

@interface MyScene ()
@property SKEmitterNode *emitter;
@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        NSString *particlePath = [[NSBundle mainBundle] pathForResource:@"FIRESTORM" ofType:@"sks"];
        _emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:particlePath];
        
        _emitter.particlePosition = CGPointMake(300.0, 500.0);
        _emitter.particleBirthRate = 0.0;
        
        [self addChild:_emitter];


    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        _emitter.particlePosition = location;
        _emitter.particleBirthRate = 1000.0;
        
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        _emitter.particlePosition = location;

        
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        _emitter.particlePosition = location;
        _emitter.particleBirthRate = 0.0;
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
