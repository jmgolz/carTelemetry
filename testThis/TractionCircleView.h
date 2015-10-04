//
//  TractionCircleView.h
//  testThis
//
//  Created by James Golz on 10/4/15.
//  Copyright © 2015 James Golz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TractionCircleView : UIView
@property CAShapeLayer *tractionCircleLayer;
@property UIBezierPath *tractionCircle;

@property CAShapeLayer *corneringDotLayer;
@property UIBezierPath *corneringDot;

-(void)drawCircle;
-(void)drawCorneringDot:(double)xValue yValue:(double)yValue;
@end
