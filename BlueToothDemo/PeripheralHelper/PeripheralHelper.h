//
//  PeripheralHelper.h
//  BlueToothDemo
//
//  Created by Morris on 2/22/16.
//  Copyright © 2016 wola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTConstant.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface PeripheralHelper : NSObject

@property CBPeripheral* currentPeripheral;
@property CBCharacteristic* currentCharacteric;


+(PeripheralHelper*)shared;

@end
