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
    self.motionManager.accelerometerUpdateInterval = .2;
    
    self.dictRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"jsonData" ofType:@"plist"]];
    
    self.jsonExample = [NSString stringWithString:[self.dictRoot objectForKey:@"jsonStringData"]];
    
    //test object from json data
    NSError *error = nil;
//    id jsonobj = [NSJSONSerialization JSONObjectWithData:[self.jsonExample dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
//
    
    self.jsonObjectArrayFirstController = [NSJSONSerialization JSONObjectWithData:[self.jsonExample dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    
    //NSLog(@"Log data: %@", self.jsonExample);
    NSLog(@"Log data: %@", [self.jsonObjectArrayFirstController valueForKey:@"name"]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    SecondController *secondController = [segue destinationViewController];
    //secondController.stringSecondController = self.jsonExample;
    
    NSLog(@"data BEFORE SEGUE: %@", [self.jsonObjectArrayFirstController valueForKey:@"name"]);
    
    secondController.stringSecondController = @"THIS WORKED";
    secondController.jsonDataArray = self.jsonObjectArrayFirstController;
}


- (IBAction)testAction:(id)sender {
    self.textLabel.text = [NSString stringWithFormat:@"TESTING"];
    [self.buttonTest setTitle:@"DONE CLICKED THIS" forState:UIControlStateNormal];

    if(self.motionManager.isAccelerometerActive == NO){
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
        withHandler:^(CMAccelerometerData *accelData, NSError *error){
           NSLog(@"x: %f, y: %f, z: %f", accelData.acceleration.x, accelData.acceleration.y, accelData.acceleration.z);
           self.alignMark.transform = CGAffineTransformMakeRotation( atan2(accelData.acceleration.y, accelData.acceleration.x) );
        }];
    } else {
        [self.motionManager stopAccelerometerUpdates];
        NSLog(@"Accel Off");
    }
}
@end
