//
//  ViewController.h
//  testThis
//
//  Created by James Golz on 9/22/15.
//  Copyright © 2015 James Golz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonTest;

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (weak, nonatomic) IBOutlet UIView *alignMark;

@property (weak, nonatomic) NSString *jsonExample;
@property (weak, nonatomic) NSDictionary *dictRoot;

@property (strong, nonatomic) NSMutableArray *jsonObjectArrayFirstController;

@end

