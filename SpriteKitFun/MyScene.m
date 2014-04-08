//
//  MyScene.m
//  Sprite Battle
//
//  Created by Aaron Baker on 3/28/14.
//  Copyright (c) 2014 Aaron Baker. All rights reserved.
//

#import "MyScene.h"

@interface MyScene () <SKPhysicsContactDelegate>

@property SKSpriteNode *playerSprite;
@property SKSpriteNode *backgroundSprite;

@end

typedef enum
{
    PlayerCategory  = 1 << 0,
    EnemyCategory   = 1 << 1,
    NotUsedCategory = 1 << 2,
    
} PhysicsCategories;

@implementation MyScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
        self.physicsWorld.contactDelegate = self;
        
        _backgroundSprite = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:self.size];
        _backgroundSprite.position = CGPointMake(self.size.width / 2.0, self.size.height / 2.0);
        

        
        
        
        [self addChild:_backgroundSprite];
        
        
        _playerSprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        [_backgroundSprite addChild:_playerSprite];
        _playerSprite.size = CGSizeMake(40.0, 40.0);
        _playerSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_playerSprite.size];
        _playerSprite.physicsBody.categoryBitMask = PlayerCategory;
        _playerSprite.physicsBody.contactTestBitMask = EnemyCategory;
        
        
        _playerSprite.position = CGPointMake(0.0, -400.0);
        
        
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:_backgroundSprite];
        
        if (location.y < -100.0) {
            
            _playerSprite.position = CGPointMake(location.x, _playerSprite.position.y);
        } else {
            
            
            SKSpriteNode *enemy = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(50.0, 50.0)];
            enemy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:enemy.size];
            enemy.physicsBody.categoryBitMask = EnemyCategory;
            enemy.physicsBody.contactTestBitMask = PlayerCategory;
            enemy.name = @"BADGUY";
            
            enemy.position = location;
            
            SKAction *attack = [SKAction moveToY:-800.0 duration:1.2];
            attack.timingMode = SKActionTimingEaseIn;
            
            [enemy runAction:attack];
            
            SKAction *spin = [SKAction rotateByAngle:3 duration:0.3];
            
            [enemy runAction:[SKAction repeatActionForever:spin]];
            
            
            
            [_backgroundSprite addChild:enemy];
            
        }
        
    }
}


-(void)didBeginContact:(SKPhysicsContact *)contact {
    
    
    NSLog(@"CONTACT A: %@ B: %@",contact.bodyA.node,contact.bodyB.node);
    
    
    SKAction *flip = [SKAction rotateByAngle:M_PI duration:1.0];
    
    SKAction *resetShip = [SKAction runBlock:^{
        _playerSprite.position = CGPointMake(0.0, -400.0);
        _playerSprite.zRotation = 0.0;
    }];
    
    SKAction *flipAndReset = [SKAction sequence:@[flip,resetShip]];
    
    if (![_backgroundSprite hasActions]) {
        [_backgroundSprite runAction:flipAndReset];
    }
    
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:_backgroundSprite];
        
        if (location.y < -100.0) {
            
            _playerSprite.position = CGPointMake(location.x, _playerSprite.position.y);
        }
        
        
        
    }
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
