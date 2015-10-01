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
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .1;
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    [self.locationManager requestWhenInUseAuthorization];
    //[self.locationManager startUpdatingLocation];
    

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


- (IBAction)testAction:(id)sender {
    self.textLabel.text = [NSString stringWithFormat:@"TESTING"];
    [self.buttonTest setTitle:@"DONE CLICKED THIS" forState:UIControlStateNormal];

    if(self.motionManager.isDeviceMotionActive == NO){
        [UIApplication sharedApplication].idleTimerDisabled = YES;
        
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            
            self.textLabel.text = [NSString stringWithFormat:@"Lat G:%.02f",fabs(motion.gravity.x)];
            self.alignMark.transform = CGAffineTransformMakeRotation( atan2(motion.gravity.y, motion.gravity.x) );
        }];
    } else {
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
