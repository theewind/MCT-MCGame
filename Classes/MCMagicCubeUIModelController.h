//
//  MCMagicCubeUIModelController.h
//  MCGame
//
//  Created by kwan terry on 12-11-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPoint.h"
#import "Global.h"
#import "TestCube.h"
@class MCSceneObject;
//旋转速度 帧率无关设计 2秒
#define TIME_PER_ROTATION 1
#define ROTATION_ANGLE 90
#define CUBE_CUBE_GAP 0.3;
@interface MCMagicCubeUIModelController : MCSceneObject{
    NSMutableArray* array27Cube;
//    MCPoint translation;
//	MCPoint rotation;
//	MCPoint scale;
//    MCPoint rotationalSpeed;
    
    TestCube * layerPtr[9];
    BOOL isRotate;
    double rest_rotate_time;
    double rest_rotate_angle;
    AxisType current_rotate_axis;
    LayerRotationDirectionType current_rotate_direction;
    int current_rotate_layer;
    
}
//@property (assign)MCPoint translation,rotation,scale,rotationalSpeed;

-(id)initiate;
- (void) rotateOnAxis : (AxisType)axis onLayer: (int)layer inDirection: (LayerRotationDirectionType)direction;
-(void)awake;
-(void)render;
-(void)update;

-(void)rotateTest;

@end