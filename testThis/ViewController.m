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
    // Do any additional setup after loading the view, typically from a nib.
    self.cyclesCount = 1;
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .1;
    
    self.dictRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"jsonData" ofType:@"plist"]];
    
    self.jsonExample = [NSString stringWithString:[self.dictRoot objectForKey:@"jsonStringData"]];
    
    //test object from json data
    NSError *error = nil;
    
    self.jsonObjectArrayFirstController = [NSJSONSerialization JSONObjectWithData:[self.jsonExample dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    
    //NSLog(@"Log data: %@", self.jsonExample);
    NSLog(@"Log data: %@", [self.jsonObjectArrayFirstController valueForKey:@"name"]);
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    [self.locationManager requestWhenInUseAuthorization];
    //[self.locationManager startUpdatingLocation];
    
    //Register for notifications from app delegate
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    SecondController *secondController = [segue destinationViewController];

    
    NSLog(@"data BEFORE SEGUE: %@", [self.jsonObjectArrayFirstController valueForKey:@"name"]);
    
    secondController.stringSecondController = @"THIS WORKED";
    secondController.jsonDataArray = self.jsonObjectArrayFirstController;
    [self.locationManager stopUpdatingLocation];
}


- (IBAction)testAction:(id)sender {
    self.textLabel.text = [NSString stringWithFormat:@"TESTING"];
    [self.buttonTest setTitle:@"DONE CLICKED THIS" forState:UIControlStateNormal];

    if(self.motionManager.isDeviceMotionActive == NO){
        [UIApplication sharedApplication].idleTimerDisabled = YES;
        
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            
            self.textLabel.text = [NSString stringWithFormat:@"Lat G:%.02f",fabs(motion.gravity.x)];
            self.alignMark.transform = CGAffineTransformMakeRotation( atan2(motion.gravity.y, motion.gravity.x) );
        }];
    
        

//        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
//        withHandler:^(CMAccelerometerData *accelData, NSError *error){
//           //NSLog(@"x: %f, y: %f, z: %f", accelData.acceleration.x, accelData.acceleration.y, accelData.acceleration.z);
//            self.gyroReadingAccumulator = self.gyroReadingAccumulator + accelData.acceleration.x;
//            float average = self.gyroReadingAccumulator / self.cyclesCount;
//            
//            self.textLabel.text = [NSString stringWithFormat:@"Lateral Gs: %.01f", accelData.acceleration.x];
//            NSLog(@"lateral Gs: %.01f", accelData.acceleration.x);
//            //NSLog(@"lateral Gs: %f", average);
//           self.alignMark.transform = CGAffineTransformMakeRotation( atan2(accelData.acceleration.y, accelData.acceleration.x) );
//            self.cyclesCount++;
//        }];
    } else {
//        [self.motionManager stopAccelerometerUpdates];
//        self.cyclesCount = 1;
//        self.gyroReadingAccumulator = 0;
        
        [self.motionManager stopDeviceMotionUpdates];
        NSLog(@"Accel Off");
        [UIApplication sharedApplication].idleTimerDisabled = NO;

    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *crnLoc = [locations lastObject];
    NSLog(@"OBJ: %@", [crnLoc debugDescription]);
    
    //Can we get zip code?
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:crnLoc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        NSLog(@"ZIP CODE: %@", [[[placemarks objectAtIndex:0] addressDictionary] objectForKey:@"ZIP"]);
        
        NSLog(@"ZIP CODE: %@", [[[placemarks objectAtIndex:0] addressDictionary] debugDescription]);
    }];
    
    //Put here to get single read.
    [self.locationManager stopUpdatingLocation];
    
}

-(void)stopAllAppServices:(NSNotification *)notification{
    
    
}

-(void)startAppServices:(NSNotification *)notification{
    
}

@end
