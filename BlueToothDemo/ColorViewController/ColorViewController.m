//
//  ColorViewController.m
//  BlueToothDemo
//
//  Created by Morris on 2/22/16.
//  Copyright © 2016 wola. All rights reserved.
//

#import "ColorViewController.h"
#import "BTConstant.h"
#import "PeripheralHelper.h"
@interface ColorViewController ()

@end
@implementation ColorViewController
{
    int redValue;
    int blueValue;
    int greenValue;
    float lightValue;
    NSMutableSet* lightEnableSet;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    
    }
    return self;
}
-(void)viewDidLoad
{
    redValue = 0;
    greenValue = 0;
    blueValue = 0;
    lightValue = 0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceConnected) name:NOTIFICATION_DEVICE_CONNECTED object:nil];
    lightEnableSet = [NSMutableSet set];
}
-(void)deviceConnected
{
    self.tabBarItem.enabled = YES;
}
- (IBAction)redSliderChanged:(UISlider *)sender
{
    int value = sender.value*255;
    [self writeDataWithcolorIndex:1 andValue:value];
    redValue = value;
}
- (IBAction)greenSliderChanged:(UISlider *)sender
{
    int value = sender.value*255;
    [self writeDataWithcolorIndex:2 andValue:value];
    greenValue = value;

}
- (IBAction)blueSliderChanged:(UISlider *)sender
{
    int value = sender.value*255;
    [self writeDataWithcolorIndex:3 andValue:value];
    blueValue = value;

}
- (IBAction)lightSliderChanged:(UISlider *)sender
{
    lightValue = sender.value;
    [self writeDataWithcolorIndex:1 andValue:redValue*lightValue];
    [self writeDataWithcolorIndex:2 andValue:greenValue*lightValue];
    [self writeDataWithcolorIndex:3 andValue:blueValue*lightValue];

}
- (IBAction)switchChanged:(UISwitch *)sender {
    if(sender.isOn)
    {
        [lightEnableSet addObject:sender];
    }
    else
    {
        [lightEnableSet removeObject:sender];
    }
}

-(void)writeDataWithcolorIndex:(int)colorIndex andValue:(int)value;
{
    
    for(UISwitch* thisSwitch in lightEnableSet.allObjects)
    {
        int li = thisSwitch.tag;
        NSString* lightNum = [NSString stringWithFormat:@"%02x",li];
        int colorValue = value*lightValue;
        NSString* valueString = [NSString stringWithFormat:@"%02x",colorValue];
        
        NSString* message = @"~D011ff!";
        NSData* thisData = [message dataUsingEncoding:nil];
        NSMutableArray* enableLight = [NSMutableArray array];
        
        NSString* dataString = [NSString stringWithFormat:@"~D%@%d%@!",lightNum,colorIndex,valueString] ;
        // NSString* message = @"~D011ff!";
        
        [[PeripheralHelper shared].currentPeripheral writeValue:[dataString dataUsingEncoding:nil] forCharacteristic:[PeripheralHelper shared].currentCharacteric type:CBCharacteristicWriteWithoutResponse];

    }
  }
@end
