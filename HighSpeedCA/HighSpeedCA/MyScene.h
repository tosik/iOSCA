//
//  MyScene.h
//  HighSpeedCA
//

//  Copyright (c) 2014年 tosik. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "OuterTotalisticCA.h"
#import "GenerationOuterTotalisticCA.h"

class ConwaysGameOfLife
: public BitboardCA::OuterTotalisticCA
{
public:
    ConwaysGameOfLife(std::size_t size_x, std::size_t size_y)
    : OuterTotalisticCA(size_x, size_y)
    {
    }
    
protected:
    BitboardCA::Bitboard Rule(
                       BitboardCA::Bitboard board,
                       BitboardCA::Bitboard s0, BitboardCA::Bitboard s1, BitboardCA::Bitboard s2,
                       BitboardCA::Bitboard s3, BitboardCA::Bitboard s4, BitboardCA::Bitboard s5,
                       BitboardCA::Bitboard s6, BitboardCA::Bitboard s7, BitboardCA::Bitboard s8 )
    {
        return ( ~board & s3 ) | ( board & ( s2 | s3 ) );
    }
};

class InnerCAForStarwars
: public BitboardCA::OuterTotalisticCA
{
public:
    InnerCAForStarwars(std::size_t size_x, std::size_t size_y)
    : BitboardCA::OuterTotalisticCA(size_x, size_y)
    {
    }
    
protected:
    BitboardCA::Bitboard Rule(
                       BitboardCA::Bitboard board,
                       BitboardCA::Bitboard s0, BitboardCA::Bitboard s1, BitboardCA::Bitboard s2,
                       BitboardCA::Bitboard s3, BitboardCA::Bitboard s4, BitboardCA::Bitboard s5,
                       BitboardCA::Bitboard s6, BitboardCA::Bitboard s7, BitboardCA::Bitboard s8 )
    {
        // starwars
        return ( board & ( s3 | s4 | s5 ) ) | ( ~board & s2 );
    }
};

@interface MyScene : SKScene
{
    //ConwaysGameOfLife * ca;
    BitboardCA::GenerationOuterTotalisticCA * ca;
    NSMutableData * buffer;
}

@end
