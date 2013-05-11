//
//  TestCube.h
//  MCGame
//
//  Created by kwan terry on 12-10-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MCMobileObject.h"
#import "MCRay.h"
#import "CubeFace.h"
@class MCParticleSystem;
@class MCCollider;

@interface Cube :MCMobileObject{
    MCParticleSystem * particleEmitter;
    NSMutableArray *cube6faces;
    //CubeFace *faces[6];
    int index;
    
}

@property (assign) int index;
@property (nonatomic,retain)NSMutableArray *cube6faces;
-(id)init;
- (id) initWithState:(NSDictionary*)states;
- (void) dealloc;
- (void)awake;
- (void)update;
-(void)render;

@end
