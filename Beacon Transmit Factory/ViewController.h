//
//  ViewController.h
//  Beacon Transmit Factory
//
//  Created by Robert Miller on 9/1/14.
//  Copyright (c) 2014 Robert Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController <CBPeripheralManagerDelegate>

@property (nonatomic, retain) UIButton *transmitButton;
@property (nonatomic, retain) UIButton *changeFieldsButton;
@property (nonatomic, retain) UILabel *uuidLabel;
@property (nonatomic, retain) UILabel *majorLabel;
@property (nonatomic, retain) UILabel *minorLabel;
@property (nonatomic, retain) UILabel *identityLabel;
@property (nonatomic, retain) UITextField *majorField;
@property (nonatomic, retain) UITextField *minorField;
@property (nonatomic, retain) UITextField *uuidField;

@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

@end

