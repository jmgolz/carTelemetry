//
//  ViewController.h
//  testThis
//
//  Created by James Golz on 9/22/15.
//  Copyright © 2015 James Golz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>

//Remove?
@property (weak, nonatomic) IBOutlet UIView *alignMark;

//Core location and motion service objects
@property CLLocationManager *locationManager;
@property (strong, nonatomic) CMMotionManager *motionManager;

//Cornering Gs text output labels
@property (weak, nonatomic) IBOutlet UILabel *labelCorneringGs;
@property (weak, nonatomic) IBOutlet UILabel *labelMaxCorneringGs;
@property (weak, nonatomic) IBOutlet UILabel *labelAvgCorneringGs;

//Braking and accel labels
@property (weak, nonatomic) IBOutlet UILabel *labelLongitudinalGs;
@property (weak, nonatomic) IBOutlet UILabel *labelMaxLongitudinalGs;
@property (weak, nonatomic) IBOutlet UILabel *labelAvgLongitudinalGs;

//GPS labels
@property (weak, nonatomic) IBOutlet UILabel *labelMaxSpeed;
@property (weak, nonatomic) IBOutlet UILabel *labelSpeed;
@property (weak, nonatomic) IBOutlet UILabel *labelAvgSpeed;

//Action buttons
@property (weak, nonatomic) IBOutlet UIButton *buttonStartCarTelemetry;
@property (weak, nonatomic) IBOutlet UIButton *buttonStartGpsRecording;

//Data storage vars
@property double averageCorneringGs;
@property double averageCorneringGsAccumulator;
@property double maxCorneringGs;

@property double averageLongitudinalGs;
@property double maxLongitudinalGs;

@property double averageSpeed;
@property double averageSpeedAccumulator;
@property double maxSpeed;


//Misc
@property int numCyclesTelemetryReadings;
@property int numCyclesGpsReadings;
@property int isGpsOn;

-(void)stopAllAppServices:(NSNotification *)notification;
-(void)startAppServices:(NSNotification *)notification;

- (IBAction)startCarTelemetry:(id)sender;
- (IBAction)startGpsData:(id)sender;



@end

