//
//  AAClockHandsView.m
//  RomanClock
//
//  Created by Kyle Oba on 10/15/13.
//  Copyright (c) 2013 Kyle Oba. All rights reserved.
//

#import "AAClockHandsView.h"

@implementation AAClockHandsView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self drawHandForSeconds:self.seconds];
}

- (void)setSeconds:(CGFloat)seconds
{
    _seconds = seconds;
    [self setNeedsDisplay];
}

- (void)drawHandForSeconds:(CGFloat)seconds
{
    CGFloat degrees = 360.0 + 90.0 - seconds/60.0*360.0;
    [self drawHandForDegree:degrees];
}

- (void)drawHandForDegree:(CGFloat)degree
{
    CGFloat clockWidth = self.bounds.size.width;
    CGFloat clockHeight = self.bounds.size.height;
    
    CGPoint clockCenter = CGPointMake(clockWidth/2.0, clockHeight/2.0);
    
    // Convert degrees to radians
    // Convert polar coordinates (r, theta) to cartesian (x, y)
    
    CGFloat theta = degree * 3.14159 * 2.0 / 360.0;
    CGFloat r = clockWidth/2.0;
    
    CGFloat x = r * cos(theta);
    CGFloat y = -r * sin(theta);
    x = x + clockWidth/2.0;
    y = y + clockHeight/2.0;
    
    // Drawing code
    [[UIColor brownColor] set];
    
    /* Get the current graphics context */
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    /* Set the width for the line */
    CGContextSetLineWidth(currentContext,5.0f);
    
    /* Start the line at this point */
    CGContextMoveToPoint(currentContext, clockCenter.x, clockCenter.y);
    
    /* And end it at this point */
    CGContextAddLineToPoint(currentContext, x, y);
    
    /* Use the context's current color to draw the line */
    CGContextStrokePath(currentContext);
}

@end
