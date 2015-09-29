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

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonTest;

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (weak, nonatomic) IBOutlet UIView *alignMark;

@property (weak, nonatomic) NSString *jsonExample;
@property (weak, nonatomic) NSDictionary *dictRoot;

@property (strong, nonatomic) NSMutableArray *jsonObjectArrayFirstController;
@property CLLocationManager *locationManager;

@property double cyclesCount;
@property float gyroReadingAccumulator;

-(void)stopAllAppServices:(NSNotification *)notification;
-(void)startAppServices:(NSNotification *)notification;
- (IBAction)testAction:(id)sender;

@end

