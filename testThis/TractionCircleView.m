//
//  TractionCircleView.m
//  testThis
//
//  Created by James Golz on 10/4/15.
//  Copyright © 2015 James Golz. All rights reserved.
//

#import "TractionCircleView.h"

@implementation TractionCircleView

-(void)drawCircle{
    CGColorRef ref = [[UIColor clearColor] CGColor];
    CGPoint dotCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    

    self.tractionCircleLayer = [CAShapeLayer layer];
    //self.tractionCircle = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    
    self.tractionCircle = [UIBezierPath bezierPathWithArcCenter:dotCenter radius:self.bounds.size.width / 2 startAngle:0 endAngle:2*M_PI clockwise:NO];
    
    self.tractionCircle.lineWidth = 5.0;
    [self.tractionCircleLayer setFillColor:ref];
    [self.tractionCircleLayer setStrokeColor:[[UIColor redColor] CGColor]];
     
    
    [self.tractionCircleLayer setPath:[self.tractionCircle CGPath]];
    [[self layer] addSublayer:self.tractionCircleLayer];
}

-(void)drawCorneringDot:(double)xValue yValue:(double)yValue{
    
    double corneringDotX = self.bounds.size.width - (self.bounds.size.width * xValue);
    double corneringDotY = self.bounds.size.height - (self.bounds.size.height * yValue);
    
    //NSLog(@"orientation X:%.2f Y:%.2f", xValue, yValue);
    //NSLog(@"orientation X:%.2f FrameW:%.2f calculated: %.2f", xValue, self.bounds.size.width, corneringDotX);
    NSLog(@"orientation X:%.2f FrameW:%.2f calculated: %.2f", yValue, self.bounds.size.height, corneringDotY);
    
    CGPoint dotCenter = CGPointMake(corneringDotX, corneringDotY);
    
    self.corneringDotLayer = [CAShapeLayer layer];
//    self.corneringDot      = [UIBezierPath bezierPathWithArcCenter:self.center radius:10.0 startAngle:0 endAngle:2*M_PI clockwise:NO];
    self.corneringDot      = [UIBezierPath bezierPathWithArcCenter:dotCenter radius:10.0 startAngle:0 endAngle:2*M_PI clockwise:NO];
    
    
    [self.corneringDotLayer setFillColor:[[UIColor redColor] CGColor]];
    [self.corneringDotLayer setStrokeColor:[[UIColor redColor] CGColor]];
    self.corneringDot.lineWidth = 2.0;
    
//    CGAffineTransform moveDot = CGAffineTransformMakeTranslation(corneringDotX, corneringDotY);
//    self.corneringDotLayer.transform = moveDot;
    CGAffineTransformTranslate(self.transform, corneringDotX, corneringDotY);
    
    //[self.corneringDot stroke];
    //[self.corneringDot fill];
    
    [self.corneringDotLayer setPath:[self.corneringDot CGPath]];
    [[self layer] addSublayer:self.corneringDotLayer];
    
    
}



@end
