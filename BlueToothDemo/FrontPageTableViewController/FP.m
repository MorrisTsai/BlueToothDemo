//
//  FP.m
//  BlueToothDemo
//
//  Created by Morris on 2/22/16.
//  Copyright © 2016 wola. All rights reserved.
//

#import "FP.h"

@implementation FP
{
    NSMutableArray* devices;
}
-(UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [self dequeueReusableCellWithIdentifier:@"deviceCell"];
    cell.textLabel.text = @"12345";
  
    return cell;
    
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSections
{
    return 2;
}
@end
