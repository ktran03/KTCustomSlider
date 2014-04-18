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
    UILabel *minLabel;
    UILabel *maxLabel;
    UILabel *currValueLabel;
    UIColor *glowColor;
    UIColor *glowColorKnob;
    int undertoneFirstPoint;
    BOOL isInTrackingMode;
    UIBezierPath *trianglePath;
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
        currValueLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
        currValueLabel.textAlignment = NSTextAlignmentCenter;
        [currValueLabel setFrame:CGRectMake(0, 0, 40, 40)];
        [self addSubview:currValueLabel];
        
        glowColorKnob = [UIColor grayColor];

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
    [minLabel setCenter:CGPointMake(self.barMargin, verticalCenter+(self.barHeight/2)+minMaxFromVerticalCenter)];
    [maxLabel setCenter:CGPointMake(self.barMargin+barWidth, verticalCenter+(self.barHeight/2)+minMaxFromVerticalCenter)];
    
    [self updateValueLabels];
}

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
    glowColorKnob = [UIColor lightGrayColor];
    [self prepareForTrackingWithTouch:touch withEvent:event];
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    [self prepareForTrackingWithTouch:touch withEvent:event];
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
    glowColorKnob = [UIColor grayColor];
    [self prepareForTrackingWithTouch:touch withEvent:event];
}

-(void)prepareForTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
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
}

#pragma mark - Draw Methods
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawBar:context];
    [self drawControlTriangle:context];
    if (isInTrackingMode) {
        [self drawUndertone:context];
    }

    [self drawKnob:context];
}

-(void)drawBar:(CGContextRef)context{
    [self.barColor set];
    CGContextSetLineWidth(context,self.barHeight);
    CGContextSetLineCap(context,kCGLineCapRound);
    CGContextMoveToPoint(context,self.barMargin,verticalCenter);
    CGContextAddLineToPoint(context,self.frame.size.width-self.barMargin, verticalCenter);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 0, [UIColor grayColor].CGColor);
    CGContextStrokePath(context);
}

-(void)drawUndertone:(CGContextRef)context{
    if (self.lastPoint>controlPointXCoord) {
        [self.barUndertoneRight set];
    }else{
        [self.barUndertoneLeft set];
    }
    CGContextSetLineCap(context,0);
    CGContextMoveToPoint(context, undertoneFirstPoint, verticalCenter);
    CGContextAddLineToPoint(context, self.lastPoint, verticalCenter);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 0, glowColor.CGColor);
    CGContextStrokePath(context);
}

-(void)drawControlTriangle:(CGContextRef)context{
    CGContextSaveGState(context);
    {
        CGContextAddPath(context, trianglePath.CGPath);
        CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
        CGContextFillPath(context);
    }
    
    CGContextRestoreGState(context);
}

-(void)drawKnob:(CGContextRef)context{
    
    float xCoord;
    xCoord = isInTrackingMode ? (self.lastPoint - (self.knobSize/2)) : (controlPointXCoord - (self.knobSize/2));
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
