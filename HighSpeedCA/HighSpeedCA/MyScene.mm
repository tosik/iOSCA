//
//  MyScene.m
//  HighSpeedCA
//
//  Created by hirooka on 2014/01/16.
//  Copyright (c) 2014年 tosik. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

const unsigned long SIZE_X = 1000;
const unsigned long SIZE_Y = 1000;


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        ca = new BitboardCA::GenerationOuterTotalisticCA(SIZE_X, SIZE_Y, 4);
        ca->SetInnerCAInstance(new InnerCAForStarwars(ca->GetSizeX(), ca->GetSizeY()));
        ca->Randomize();

        buffer = [NSMutableData dataWithCapacity:(SIZE_X * SIZE_Y * 4)];

        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKTexture * texture = [SKTexture textureWithData:buffer size:CGSizeMake(SIZE_X, SIZE_Y) rowLength:SIZE_Y alignment:0];
        SKSpriteNode * sprite = [SKSpriteNode spriteNodeWithTexture:texture];
        sprite.name = @"cell sprite";
        sprite.position = CGPointMake(0, 0);
        [self addChild:sprite];
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    ca->Step();

    CGSize size = CGSizeMake(SIZE_X, SIZE_Y);
    unsigned int * bufferPointer = (unsigned int *)[buffer mutableBytes];
    
    for (uint y = 0 ; y < SIZE_Y ; y ++)
    {
        for (uint x = 0 ; x < SIZE_X ; x ++)
        {
            uint colorByte;
            switch (ca->GetCellState(x, y))
            {
                case 0:
                    colorByte = 0x00000000;
                    break;
                case 1:
                    colorByte = 0xff0000ff;
                    break;
                case 2:
                    colorByte = 0xff0000ff;
                    break;
                case 3:
                    colorByte = 0xff00ffff;
                    break;
                default:
                    colorByte = 0xff00ffff;
                    break;
            }
            
            bufferPointer[x + y * SIZE_X] = colorByte;
        }
    }
    
    SKTexture * texture = [SKTexture textureWithData:buffer size:size];
    
    SKSpriteNode * sprite = (SKSpriteNode *)[self childNodeWithName:(@"cell sprite")];
    sprite.texture = texture;
}

-(void)dealloc
{
    delete ca;
}

/*

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}
*/

@end
