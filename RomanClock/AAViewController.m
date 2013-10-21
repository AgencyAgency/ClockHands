//
//  AAViewController.m
//  RomanClock
//
//  Created by Kyle Oba on 10/15/13.
//  Copyright (c) 2013 Kyle Oba. All rights reserved.
//

#import "AAViewController.h"
#import "AAClockHandsView.h"
#import <QuartzCore/QuartzCore.h>

@interface AAViewController ()
@property (strong, nonatomic) CADisplayLink *displayLink;
@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;
@property (weak, nonatomic) IBOutlet AAClockHandsView *clockHandsView;
@end

@implementation AAViewController

- (void)tick:(CADisplayLink *)sender
{
    // Calculate seconds of current minute with better than millisecond accuracy.
    // 1/1,000,000th accuracy, I guess.
    double secsDouble = [NSDate timeIntervalSinceReferenceDate];
    int secsInt = (int)secsDouble;
    int secPart = secsInt % 60;
    double milliPart = secsDouble - secsInt;
    double s = secPart + milliPart;
    
    self.secondsLabel.text = [NSString stringWithFormat:@":%02.03f", s];
    
    [self.clockHandsView setSeconds:s];
//    CGFloat percentage = s / 60.0;
//    [self.secondsColorView changeColorForPercentage:percentage];
//    [self.rgbColorView changeColorForPercentage:percentage];
//    [self.grayscaleColorView changeColorForPercentage:percentage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    self.displayLink.frameInterval = 5; // 30 is about every half second.
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.displayLink invalidate];
    self.displayLink = nil;
}
@end
