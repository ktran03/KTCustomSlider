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
#define convertLastPointToValue


@implementation KTSliderControl{
    UILabel *minLabel;
    UILabel *maxLabel;
    UILabel *currValueLabel;
    
    BOOL isInTrackingMode;
}

@synthesize controlValue = _controlValue;

#pragma mark - Initializers
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        minLabel = [[UILabel alloc] init];
        minLabel.textColor = [UIColor grayColor];
        minLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
        minLabel.textAlignment = NSTextAlignmentCenter;
        [minLabel setFrame:CGRectMake(0, 0, 40, 40)];
        [self addSubview:minLabel];
        
        maxLabel = [[UILabel alloc] init];
        maxLabel.textColor = [UIColor grayColor];
        maxLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
        maxLabel.textAlignment = NSTextAlignmentCenter;
        [maxLabel setFrame:CGRectMake(0, 0, 40, 40)];
        [self addSubview:maxLabel];
        
        currValueLabel = [[UILabel alloc] init];
        currValueLabel.textColor = [UIColor grayColor];
        currValueLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13.0];
        currValueLabel.textAlignment = NSTextAlignmentCenter;
        [currValueLabel setFrame:CGRectMake(0, 0, 40, 40)];
        [self addSubview:currValueLabel];
    }
    return self;
}

-(void)updateDisplay{
    self.lastPoint = controlPointXCoord;
    [self calculateCurrentValue];
    [self update];
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

-(void)update{
    self.backgroundColor = [UIColor clearColor];
    if (!self.barInnerColorLeft) {
        self.barInnerColorLeft = [UIColor yellowColor];
    }
    if (!self.barInnerColorRight) {
        self.barInnerColorRight = [UIColor greenColor];
    }
    
    if (!self.minSliderValue) { self.minSliderValue = 0;
    }
    if (!self.maxSliderValue) { self.maxSliderValue = 100;
    }
    if (!self.controlValue) { self.controlValue = 50;
    }
    
    int pad = 15;
    [minLabel setCenter:CGPointMake(self.barMargin, verticalCenter+(self.barHeight/2)+pad)];
    [maxLabel setCenter:CGPointMake(self.barMargin+barWidth, verticalCenter+(self.barHeight/2)+pad)];

    [self updateValueLabels];
}

-(void)updateValueLabels{
    [currValueLabel setCenter:CGPointMake(self.lastPoint, verticalCenter)];
    currValueLabel.text = [NSString stringWithFormat:@"%i", self.currentValue];
    minLabel.text = [NSString stringWithFormat:@"%d", (int)self.minSliderValue];
    maxLabel.text = [NSString stringWithFormat:@"%d", (int)self.maxSliderValue];
}

-(void)layoutSubviews{
    [self updateValueLabels];
}

-(void)calculateCurrentValue{
    self.currentValue = ceil((((self.lastPoint-self.barMargin)/barWidth)*(self.maxSliderValue-self.minSliderValue))+self.minSliderValue);
}

#pragma mark - UIControl Methods
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    isInTrackingMode = YES;
    
    CGPoint lastPointUserTouched = [touch locationInView:self];
    self.lastPoint = lastPointUserTouched.x;

    if (self.lastPoint<=(self.barMargin)) {
        self.lastPoint = self.barMargin;
    }
    
    if (self.lastPoint>=(self.frame.size.width-(self.barMargin))) {
        self.lastPoint = self.frame.size.width-(self.barMargin);
    }
    
    [self calculateCurrentValue];
    [self setNeedsDisplay];
    [self setNeedsLayout];
    [self sendActionsForControlEvents:UIControlEventValueChanged];

    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];    
}

#pragma mark - Draw Methods
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawBar:context];
    [self drawUndertone:context];
    [self drawControlTriangle:context];
    [self drawKnob:context];
}

-(void)drawBar:(CGContextRef)context{
    [[UIColor grayColor] set];
    CGContextSetLineWidth(context,self.barHeight);
    CGContextSetLineCap(context,kCGLineCapRound);
    CGContextMoveToPoint(context,self.barMargin,verticalCenter);
    CGContextAddLineToPoint(context,self.frame.size.width-self.barMargin, verticalCenter);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 2, [UIColor blackColor].CGColor);
    CGContextStrokePath(context);
}

-(void)drawUndertone:(CGContextRef)context{
    if (self.lastPoint>controlPointXCoord) {
        [self.barInnerColorRight set];
    }else{
        [self.barInnerColorLeft set];
    }
    CGContextSetLineCap(context,0);
    CGContextMoveToPoint(context, controlPointXCoord, verticalCenter);
    CGContextAddLineToPoint(context, self.lastPoint, verticalCenter);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 2, [UIColor blackColor].CGColor);
    CGContextStrokePath(context);
}

-(void)drawControlTriangle:(CGContextRef)context{
    UIBezierPath *trianglePath = [[UIBezierPath alloc] init];
    CGFloat triangleWidth = self.triangleSize;
    
    CGPoint firstPoint = CGPointZero;
    int pad = 5;
    firstPoint.x = controlPointXCoord;
    firstPoint.y = verticalCenter+pad;
    [trianglePath moveToPoint:firstPoint];
    [trianglePath addLineToPoint:CGPointMake(firstPoint.x+(triangleWidth/2.0), firstPoint.y+self.triangleSize)];
    [trianglePath addLineToPoint:CGPointMake(firstPoint.x-(triangleWidth/2.0), firstPoint.y+self.triangleSize)];
    [trianglePath closePath];
    CGContextSaveGState(context);
    {
        CGContextAddPath(context, trianglePath.CGPath);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextFillPath(context);
    }
    
    CGContextRestoreGState(context);
}

-(void)drawKnob:(CGContextRef)context{
    
    float xCoord;
    xCoord = isInTrackingMode ? (self.lastPoint - (self.knobSize/2)) : (controlPointXCoord - (self.knobSize/2));
    CGContextSaveGState(context);
    
    {
        CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 2, [UIColor blackColor].CGColor);
        CGRect handleRect = CGRectMake(xCoord,verticalCenter-(self.knobSize/2), self.knobSize, self.knobSize);
        [[UIColor colorWithWhite:1.0 alpha:0.55]set];
        CGContextFillEllipseInRect(context, handleRect);
    }
    
    CGContextRestoreGState(context);
}

#pragma mark - Helper Methods

@end
