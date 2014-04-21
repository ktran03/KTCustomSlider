//
//  KTSliderControl.m
//  KTCustomSlider
//
//  Created by khanh tran on 2014-04-13.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTSliderControl.h"

#define barWidth (self.frame.size.width - (self.barMargin*2))
#define barWidthMid (barWidth/2)
#define verticalCenter self.frame.size.height/2
#define controlPointXCoord ((((self.controlValue-self.minSliderValue)/(self.maxSliderValue-self.minSliderValue))*(barWidth))+self.barMargin)

@implementation KTSliderControl{
    int lastPoint;
    UIColor *glowColor;
    UIColor *glowColorKnob;
    int undertoneFirstPoint;
    BOOL isInTrackingMode;
    UIBezierPath *trianglePath;
}

@synthesize controlValue = _controlValue;

/**
 *  Initialization method. Call this method to begin initialization of a KTSliderControl
 *
 *  @param idinitWithFrame:CGRect The frame used to draw.
 *
 *  @return id
 */
#pragma mark - Initializers
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.minLabel = [[UILabel alloc] init];
        self.minLabel.textColor = [UIColor grayColor];
        self.minLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
        self.minLabel.textAlignment = NSTextAlignmentCenter;
        [self.minLabel setFrame:CGRectMake(0, 0, 40, 40)];
        [self addSubview:self.minLabel];
        
        self.maxLabel = [[UILabel alloc] init];
        self.maxLabel.textColor = [UIColor grayColor];
        self.maxLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
        self.maxLabel.textAlignment = NSTextAlignmentCenter;
        [self.maxLabel setFrame:CGRectMake(0, 0, 40, 40)];
        [self addSubview:self.maxLabel];
        
        self.currValueLabel = [[UILabel alloc] init];
        self.currValueLabel.textColor = [UIColor grayColor];
        self.currValueLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
        self.currValueLabel.textAlignment = NSTextAlignmentCenter;
        [self.currValueLabel setFrame:CGRectMake(0, 0, 40, 40)];
        [self addSubview:self.currValueLabel];
        
        glowColorKnob = [UIColor grayColor];

    }
    return self;
}

/**
 *  Call this method to refresh calculations and update display
 */
-(void)updateDisplay{
    lastPoint = controlPointXCoord;
    [self calculateCurrentValue];
    [self update];
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

/**
 *  Calls from updateDisplay, completes necessary value update for refresh
 */
-(void)update{
    int endcapLength = 2;
    int minMaxFromVerticalCenter = 15;

    self.backgroundColor = [UIColor clearColor];
    self.barColor = self.barColor ? : [UIColor lightGrayColor];
    self.barUndertoneLeft = self.barUndertoneLeft ? : [UIColor yellowColor];
    self.barUndertoneRight = self.barUndertoneRight ? : [UIColor greenColor];
    self.minSliderValue = self.minSliderValue ? : 0;
    self.maxSliderValue = self.maxSliderValue ? : 100;
    self.controlValue = self.controlValue ? : 50;
    
    trianglePath = self.isControlValueOptionOn ? [self createBezierPathForTriangle] : nil;
    undertoneFirstPoint = self.isControlValueOptionOn ? controlPointXCoord : self.barMargin - endcapLength;
    [self.minLabel setCenter:CGPointMake(self.barMargin, verticalCenter+(self.barHeight/2)+minMaxFromVerticalCenter)];
    [self.maxLabel setCenter:CGPointMake(self.barMargin+barWidth, verticalCenter+(self.barHeight/2)+minMaxFromVerticalCenter)];
    
    [self updateValueLabels];
}

/**
 *  Method to draw triangle (only used when controlValueOption set to YES)
 *
 *  @return the triangle path
 */
-(UIBezierPath*)createBezierPathForTriangle{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat triangleWidth = self.triangleSize;
    CGPoint firstPoint = CGPointZero;
    int pad2 = 10;
    firstPoint.x = controlPointXCoord;
    firstPoint.y = verticalCenter+pad2;
    [path moveToPoint:firstPoint];
    [path addLineToPoint:CGPointMake(firstPoint.x+(triangleWidth/2.0), firstPoint.y+self.triangleSize)];
    [path addLineToPoint:CGPointMake(firstPoint.x-(triangleWidth/2.0), firstPoint.y+self.triangleSize)];
    [path closePath];
    return path;
}

/**
 *  Update the value labels
 */
-(void)updateValueLabels{
    [self.currValueLabel setCenter:CGPointMake(lastPoint, verticalCenter)];
    self.currValueLabel.text = [NSString stringWithFormat:@"%i", self.currentValue];
    self.minLabel.text = [NSString stringWithFormat:@"%d", (int)self.minSliderValue];
    self.maxLabel.text = [NSString stringWithFormat:@"%d", (int)self.maxSliderValue];
}

-(void)layoutSubviews{
    [self updateValueLabels];
}

-(void)calculateCurrentValue{
    _currentValue = ceil((((lastPoint-self.barMargin)/barWidth)*(self.maxSliderValue-self.minSliderValue))+self.minSliderValue);
}


#pragma mark - UIControl Methods
/**
 *  Tracking method begin
 *
 *  @param
 *
 *  @return return YES to begin tracking
 */
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    glowColorKnob = [UIColor lightGrayColor];
    [self prepareForTrackingWithTouch:touch withEvent:event];
    return YES;
}

/**
 *  Tracking method continuation after begin
 *
 *  @param touch A UITouch object
 *  @param event A UIEvent object
 *
 *  @return return YES for continuous tracking
 */
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    [self prepareForTrackingWithTouch:touch withEvent:event];
    return YES;
}

/**
 *  End tracking
 *
 *  @param touch A UITouch object
 *  @param event A UIEvent object
 */
-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
    glowColorKnob = [UIColor grayColor];
    [self prepareForTrackingWithTouch:touch withEvent:event];
}

/**
 *  Does the necessary preparation before refreshing view for slider
 *
 *  @param touch A UITouch object
 *  @param event A UIEvent object
 */
-(void)prepareForTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    isInTrackingMode = YES;
    
    CGPoint lastPointUserTouched = [touch locationInView:self];
    lastPoint = lastPointUserTouched.x;
    
    if (lastPoint<=(self.barMargin)) {
        lastPoint = self.barMargin;
    }
    
    if (lastPoint>=(self.frame.size.width-(self.barMargin))) {
        lastPoint = self.frame.size.width-(self.barMargin);
    }
    
    [self calculateCurrentValue];
    [self setNeedsDisplay];
    [self setNeedsLayout];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - Draw Methods
/**
 *  Main drawRect method. Used to draw contents to screen
 *
 *  @param rect the rectangle to be drawn to
 */
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawBar:context];
    [self drawControlTriangle:context];
    if (isInTrackingMode || !self.isControlValueOptionOn ) {
        [self drawUndertone:context];
    }

    [self drawKnob:context];
}

/**
 *  Method that draws the bar
 *
 *  @param context the current graphics context
 */
-(void)drawBar:(CGContextRef)context{
    [self.barColor set];
    CGContextSetLineWidth(context,self.barHeight);
    CGContextSetLineCap(context,kCGLineCapRound);
    CGContextMoveToPoint(context,self.barMargin,verticalCenter);
    CGContextAddLineToPoint(context,self.frame.size.width-self.barMargin, verticalCenter);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 0, [UIColor grayColor].CGColor);
    CGContextStrokePath(context);
}

/**
 *  Method that draws the left or right, or singular undertone
 *
 *  @param context the current graphics context
 */
-(void)drawUndertone:(CGContextRef)context{
    if (lastPoint>controlPointXCoord) {
        [self.barUndertoneRight set];
    }else{
        [self.barUndertoneLeft set];
    }
    CGContextSetLineCap(context,0);
    CGContextMoveToPoint(context, undertoneFirstPoint, verticalCenter);
    CGContextAddLineToPoint(context, lastPoint, verticalCenter);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 0, glowColor.CGColor);
    CGContextStrokePath(context);
}

/**
 *  Method that draws the control value triangle
 *
 *  @param context the current graphics context
 */
-(void)drawControlTriangle:(CGContextRef)context{
    CGContextSaveGState(context);
    {
        CGContextAddPath(context, trianglePath.CGPath);
        CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
        CGContextFillPath(context);
    }
    
    CGContextRestoreGState(context);
}

/**
 *  Method that draws the knob
 *
 *  @param context the current graphics context
 */
-(void)drawKnob:(CGContextRef)context{
    
    float xCoord;
    xCoord = isInTrackingMode ? (lastPoint - (self.knobSize/2)) : (controlPointXCoord - (self.knobSize/2));
    CGContextSaveGState(context);
    
    {
        CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 4, glowColorKnob.CGColor);
        CGRect handleRect = CGRectMake(xCoord,verticalCenter-(self.knobSize/2), self.knobSize, self.knobSize);
        [[UIColor colorWithWhite:1.0 alpha:1.0]set];
        CGContextFillEllipseInRect(context, handleRect);
    }
    
    CGContextRestoreGState(context);
}

@end
