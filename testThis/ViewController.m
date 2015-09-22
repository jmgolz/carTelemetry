//
//  ViewController.m
//  testThis
//
//  Created by James Golz on 9/22/15.
//  Copyright © 2015 James Golz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .2;
    [self.motionManager stopAccelerometerUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testAction:(id)sender {
    self.textLabel.text = [NSString stringWithFormat:@"TESTING"];
    [self.buttonTest setTitle:@"DONE CLICKED THIS" forState:UIControlStateNormal];

    //self.alignMark.transform = CGAffineTransformMakeRotation(10.0);
    
    
    if(self.motionManager.isAccelerometerActive == NO){
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelData, NSError *error){
            NSLog(@"x: %f, y: %f, z: %f", accelData.acceleration.x, accelData.acceleration.y, accelData.acceleration.z);
            self.alignMark.transform = CGAffineTransformMakeRotation(atan2(accelData.acceleration.y, accelData.acceleration.x));
        }];
    } else {
        [self.motionManager stopAccelerometerUpdates];
        NSLog(@"Accel Off");
    }
}




@end
