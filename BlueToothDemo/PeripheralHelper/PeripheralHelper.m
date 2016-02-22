//
//  PeripheralHelper.m
//  BlueToothDemo
//
//  Created by Morris on 2/22/16.
//  Copyright © 2016 wola. All rights reserved.
//

#import "PeripheralHelper.h"
static PeripheralHelper* sharedHelper;
@implementation PeripheralHelper




+(PeripheralHelper *)shared
{
    if(!sharedHelper)
    {
        sharedHelper = [[PeripheralHelper alloc]init];
    }
    return sharedHelper;
}
@end
