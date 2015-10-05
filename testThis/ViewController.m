//
//  ViewController.m
//  testThis
//
//  Created by James Golz on 9/22/15.
//  Copyright © 2015 James Golz. All rights reserved.
//

#import "ViewController.h"
#import "SecondController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .1;
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    self.numCyclesGpsReadings = 1;
    self.numCyclesTelemetryReadings = 1;
    self.isGpsOn = NO;
    self.tractionCircleView.backgroundColor = [UIColor clearColor];
    //[self.tractionCircleView drawCircle];
    //[self.tractionCircleView drawCorneringDot:0.0 yValue:0.0];
    
    [self startCarTelemetry:nil];

   

}

-(void)viewDidLayoutSubviews{
    [self.tractionCircleView drawCircle];
    [self.tractionCircleView drawCorneringDot:0.0 yValue:0.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //TODO: repurpose at some point
    SecondController *secondController = [segue destinationViewController];
    secondController.stringSecondController = @"THIS WORKED";
    [self.locationManager stopUpdatingLocation];
}


- (IBAction)startCarTelemetry:(id)sender {

    if(self.motionManager.isDeviceMotionActive == NO){
        [self.buttonStartCarTelemetry setTitle:@"Telemetry started" forState:UIControlStateNormal];
        
        [UIApplication sharedApplication].idleTimerDisabled = YES;
        
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {

            
            [self.tractionCircleView drawCorneringDot:motion.gravity.x yValue:motion.gravity.z];
            
            //Record Max Values
        if (fabs(motion.userAcceleration.x) > self.maxCorneringGs) {
            self.maxCorneringGs = fabs(motion.userAcceleration.x);
        }

        //Record Averages
        self.averageCorneringGsAccumulator += fabs(motion.userAcceleration.x);
        self.averageCorneringGs = (self.averageCorneringGsAccumulator / self.numCyclesTelemetryReadings);
            
        //Present values
        self.labelCorneringGs.text = [NSString stringWithFormat:@"%.2f",fabs(motion.userAcceleration.x)];
        self.labelMaxCorneringGs.text = [NSString stringWithFormat:@"%.2f", self.maxCorneringGs];
        self.labelAvgCorneringGs.text = [NSString stringWithFormat:@"%0.2f", self.averageCorneringGs];
            
        self.labelLongitudinalGs.text = [NSString stringWithFormat:@"%.2f",fabs(motion.userAcceleration.z)];
        
        //Increment cycle counter for averages computation®
        self.numCyclesTelemetryReadings++;
//            self.alignMark.transform = CGAffineTransformMakeRotation( atan2(motion.gravity.y, motion.gravity.x) );
        }];
    } else {
        [self.motionManager stopDeviceMotionUpdates];
        [UIApplication sharedApplication].idleTimerDisabled = NO;
        [self.buttonStartCarTelemetry setTitle:@"Start Car Telemetry" forState:UIControlStateNormal];

    }
}

- (IBAction)startGpsData:(id)sender {
    [self.locationManager requestWhenInUseAuthorization];
    
    if (self.isGpsOn == NO) {
        [self.locationManager startUpdatingLocation];
        [self.buttonStartGpsRecording setTitle:@"Stop GPS Data" forState:UIControlStateNormal];
        self.isGpsOn = YES;
    } else {
        [self.buttonStartGpsRecording setTitle:@"Start GPS Data" forState:UIControlStateNormal];
        [self.locationManager stopUpdatingLocation];
        self.isGpsOn = NO;
    }
}



-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *crnLoc = [locations lastObject];
   
    //Update max speed
    if ([self speedInKmh:crnLoc.speed] > self.maxSpeed) {
        //self.maxSpeed = ((crnLoc.speed / 1000) * 3600 );
        self.maxSpeed = [self speedInKmh:crnLoc.speed];
    }
    
    //Update average speed
    self.averageSpeedAccumulator += [self speedInKmh:crnLoc.speed];
    self.averageSpeed = self.averageSpeedAccumulator / self.numCyclesGpsReadings;
    
    self.labelSpeed.text = [NSString stringWithFormat:@"%0.1f km/h", [self speedInKmh:crnLoc.speed]];
    self.labelMaxSpeed.text = [NSString stringWithFormat:@"%0.1f km/h", self.maxSpeed];
    self.labelAvgSpeed.text = [NSString stringWithFormat:@"%0.1f km/h", self.averageSpeed];
    
    self.numCyclesGpsReadings++;
}

-(void)stopAllAppServices:(NSNotification *)notification{
    
    
}

-(void)startAppServices:(NSNotification *)notification{
    
}

-(double)speedInKmh:(double)speedUnit{
    int convertedSpeed = ((speedUnit / 1000) * 3600 );
    return convertedSpeed;
}
@end