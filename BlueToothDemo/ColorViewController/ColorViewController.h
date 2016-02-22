//
//  ColorViewController.h
//  BlueToothDemo
//
//  Created by Morris on 2/22/16.
//  Copyright © 2016 wola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *GreenSlider;
@property (weak, nonatomic) IBOutlet UISlider *BlueSlider;
@property (weak, nonatomic) IBOutlet UISlider *lightSlider;

@end
