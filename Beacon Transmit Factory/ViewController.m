//
//  ViewController.m
//  Beacon Transmit Factory
//
//  Created by Robert Miller on 9/1/14.
//  Copyright (c) 2014 Robert Miller. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#define DEFAULT_UUID @"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /* Left side of the UI  Start transmit and current settings */
    _transmitButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 45, 360, 20)];
    [_transmitButton setTitle:@"Transmit" forState:UIControlStateNormal];
    [_transmitButton addTarget:self action:@selector(transmitBeacon) forControlEvents:UIControlEventTouchUpInside];
    [_transmitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _uuidLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 75, 360, 20)];
    _uuidLabel.text = DEFAULT_UUID;
    
    _majorLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 105, 360, 20)];
    _majorLabel.text = @"1";
    
    _minorLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 135, 360, 20)];
    _minorLabel.text = @"1";
    
    _identityLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 165, 360, 20)];
    _identityLabel.text = @"com.rm.myRegion";
    
    _changeFieldsButton = [[UIButton alloc] initWithFrame:CGRectMake(370, 45, 360, 20)];
    [_changeFieldsButton setTitle:@"Update Fields" forState:UIControlStateNormal];
    [_changeFieldsButton addTarget:self action:@selector(UpdateFields) forControlEvents:UIControlEventTouchUpInside];
    [_changeFieldsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _uuidField = [[UITextField alloc] initWithFrame:CGRectMake(370, 75, 360, 20)];
    _majorField = [[UITextField alloc] initWithFrame:CGRectMake(370, 105, 360, 20)];
    _minorField = [[UITextField alloc] initWithFrame:CGRectMake(370, 135, 360, 20)];
    
    [self.view addSubview:_transmitButton];
    [self.view addSubview:_uuidLabel];
    [self.view addSubview:_minorLabel];
    [self.view addSubview:_majorLabel];
    [self.view addSubview:_identityLabel];
    
    [self.view addSubview:_changeFieldsButton];
    [self.view addSubview:_uuidField];
    [self.view addSubview:_majorField];
    [self.view addSubview:_minorField];
    
    [self initBeacon];
}

-(void)UpdateFields
{
    _uuidLabel.text = _uuidField.text;
    _majorLabel.text = _majorField.text;
    _minorLabel.text = _minorField.text;
    
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:_uuidLabel.text];
    
    _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:[_majorField.text integerValue] minor:[_minorField.text integerValue] identifier:@"com.rm.myRegion"];
}

- (void)initBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:DEFAULT_UUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:1
                                                                minor:1
                                                           identifier:@"com.rm.myRegion"];
}

- (IBAction)transmitBeacon {
    if ([_transmitButton.titleLabel.text isEqualToString:@"Transmit"]) {
        [_transmitButton setTitle:@"Stop Transmit" forState:UIControlStateNormal];
    }
    else {
        [_transmitButton setTitle:@"Transmit" forState:UIControlStateNormal];
    }
    
    self.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Powered On");
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Powered Off");
        [self.peripheralManager stopAdvertising];
    }
}

- (void)setLabels {
    self.uuidLabel.text = self.beaconRegion.proximityUUID.UUIDString;
    self.majorLabel.text = [NSString stringWithFormat:@"%@", self.beaconRegion.major];
    self.minorLabel.text = [NSString stringWithFormat:@"%@", self.beaconRegion.minor];
    self.identityLabel.text = self.beaconRegion.identifier;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
