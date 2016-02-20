//
//  ViewController.m
//  BlueToothDemo
//
//  Created by Morris on 2/5/16.
//  Copyright © 2016 wola. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>



@interface ViewController ()  <CBPeripheralDelegate, CBCentralManagerDelegate>
@property (nonatomic, strong) CBPeripheral* connectingPeripheral;
@end

@implementation ViewController
{
    CBCentralManager* cbm;
   // CBUUID* uuid;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    cbm = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
  //  uuid = [CBUUID UUIDWithString:@"00002902-0000-1000-8000-00805f9b34fb"];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSString* name = [advertisementData objectForKey:@"kCBAdvDataLocalName"];
    NSLog([NSString stringWithFormat:@"%@",[advertisementData description]]);
    if(name)
    {
        self.title = name;
    }
    
   // [peripheral discoverServices:nil];
  //  NSString* message = @"~D011ff!";
  //  NSData* thisData = [message dataUsingEncoding:nil];
    
//    CBMutableCharacteristic* myCharacteristic =
//    [[CBMutableCharacteristic alloc] initWithType:uuid
//                                       properties:CBCharacteristicPropertyRead
//                                            value:message permissions:CBAttributePermissionsWriteable];
//    
//    [peripheral writeValue:thisData forCharacteristic:myCharacteristic type:CBCharacteristicWriteWithoutResponse];
    if([name isEqualToString:@"Seraphim01"])
    {
       
        self.connectingPeripheral = peripheral;
        self.connectingPeripheral.delegate = self;
        [cbm connectPeripheral:self.connectingPeripheral options:nil];
       // [self.connectingPeripheral discoverServices:@[@"FFE0"]];
    }
   
    
    
}
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    [peripheral discoverServices:nil];
}
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    
}
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (!error) {
        // printf("Services of peripheral with UUID : %s found\r\n",[self UUIDToString:peripheral.UUID]);
        [self getAllCharacteristicsFromKeyfob:peripheral];
    }
    else {
        printf("Service discovery was unsuccessfull !\r\n");
    }
}
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (!error)
    {
        for(int i=0; i < service.characteristics.count; i++)
        {
            CBService *s = [peripheral.services objectAtIndex:(peripheral.services.count - 1)];
           
        }
    }
    NSString* message = @"~D011ff!";
    NSData* thisData = [message dataUsingEncoding:nil];

    [peripheral writeValue:thisData forCharacteristic:[service.characteristics objectAtIndex:0] type:CBCharacteristicWriteWithoutResponse];

}

-(void) getAllCharacteristicsFromKeyfob:(CBPeripheral *)p{
    for (int i=0; i <  [p.services count]; i++) {
        
        CBService *s = [p.services objectAtIndex:i];
        [p discoverCharacteristics:nil forService:s];
    }
}
-(void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals{
    NSLog(@"This is it!");
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    ;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    NSString *messtoshow;
    
    switch (central.state) {
        case CBCentralManagerStateUnknown:
        {
            messtoshow=[NSString stringWithFormat:@"State unknown, update imminent."];
            break;
        }
        case CBCentralManagerStateResetting:
        {
            messtoshow=[NSString stringWithFormat:@"The connection with the system service was momentarily lost, update imminent."];
            break;
        }
        case CBCentralManagerStateUnsupported:
        {
            messtoshow=[NSString stringWithFormat:@"The platform doesn't support Bluetooth Low Energy"];
            break;
        }
        case CBCentralManagerStateUnauthorized:
        {
            messtoshow=[NSString stringWithFormat:@"The app is not authorized to use Bluetooth Low Energy"];
            break;
        }
        case CBCentralManagerStatePoweredOff:
        {
            messtoshow=[NSString stringWithFormat:@"Bluetooth is currently powered off."];
            break;
        }
        case CBCentralManagerStatePoweredOn:
        {
            messtoshow=[NSString stringWithFormat:@"Bluetooth is currently powered on and available to use."];
          //  [cbm scanForPeripheralsWithServices:nil options:nil];
            
            //[mgr retrieveConnectedPeripherals];
            
            //--- it works, I Do get in this area!
            
            break;
        }   
            
    }
    NSLog(messtoshow); 
}

- (IBAction)lickButtonPressed:(UIButton *)sender {
    NSDictionary *scanOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    
    // Tell the central manager (cm) to scan for the heart rate service
    [cbm scanForPeripheralsWithServices:nil options:nil];

}

@end
