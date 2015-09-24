//
//  SecondController.h
//  testThis
//
//  Created by James Golz on 9/23/15.
//  Copyright © 2015 James Golz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondController : UIViewController
@property (weak, nonatomic) NSString *stringSecondController;
@property (weak, nonatomic) IBOutlet UILabel *secondControllerTextLabel;

@property (weak, nonatomic) NSMutableArray *jsonDataArray;
@end
