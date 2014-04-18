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
#define barHeightMid self.frame.size.height/2

#define controlPointXCoord (((([self.controlValue intValue]-self.minSliderValue)/(self.maxSliderValue-self.minSliderValue))*(barWidth))+self.barMargin)


#define convertLastPointToValue ceil((((self.lastPoint-self.barMargin)/barWidth)*(self.maxSliderValue-self.minSliderValue))+self.minSliderValue)


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
        [self performInitialization];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]) {
        [self performInitialization];
    }
    return self;
}

-(void)performInitialization{
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
    if (!self.controlValue) { self.controlValue = @50;
    }
    
    self.lastPoint = controlPointXCoord;
    
    [self configureValueLabels];
}

-(void)configureValueLabels{
    currValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [currValueLabel setCenter:CGPointMake(controlPointXCoord, barHeightMid)];
    NSLog(@"%@", NSStringFromCGRect(currValueLabel.frame));
    currValueLabel.textColor = [UIColor grayColor];
    currValueLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:10.0];
    currValueLabel.textAlignment = NSTextAlignmentCenter;
    currValueLabel.text = [NSString stringWithFormat:@"%i", (int)convertLastPointToValue];
    [self addSubview:currValueLabel];
    
}

-(void)layoutSubviews{
    NSLog(@"lastpoint=%i", (int)self.lastPoint);
    [currValueLabel setCenter:CGPointMake(self.lastPoint, barHeightMid)];
    NSLog(@"%@", NSStringFromCGRect(currValueLabel.frame));
    currValueLabel.text = [NSString stringWithFormat:@"%i", (int)convertLastPointToValue];
}

#pragma mark - Setters/Getters

-(void)setcontrolValue:(NSNumber *)controlValue{
    _controlValue = controlValue;
    self.lastPoint = controlPointXCoord;
    [self setNeedsDisplay];
    [self setNeedsLayout];
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
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    [self setNeedsDisplay];
    [self setNeedsLayout];
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
    CGContextSetLineWidth(context,barHeightMid/2);
    CGContextMoveToPoint(context,self.barMargin,barHeightMid);
    CGContextAddLineToPoint(context,self.frame.size.width-self.barMargin, barHeightMid);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 2, [UIColor blackColor].CGColor);
    CGContextStrokePath(context);
}

-(void)drawUndertone:(CGContextRef)context{
    if (self.lastPoint>controlPointXCoord) {
        [self.barInnerColorRight set];
    }else{
        [self.barInnerColorLeft set];
    }
    CGContextSetLineWidth(context, self.frame.size.height/4);
    CGContextMoveToPoint(context, controlPointXCoord, barHeightMid);
    CGContextAddLineToPoint(context, self.lastPoint, barHeightMid);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 2, [UIColor blackColor].CGColor);
    CGContextStrokePath(context);
}

-(void)drawControlTriangle:(CGContextRef)context{
    UIBezierPath *trianglePath = [[UIBezierPath alloc] init];
    CGFloat triangleWidth = self.triangleSize;
    
    CGPoint firstPoint = CGPointZero;
    firstPoint.x = controlPointXCoord;
    firstPoint.y = barHeightMid+5;
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
        CGRect handleRect = CGRectMake(xCoord,barHeightMid-(self.knobSize/2), self.knobSize, self.knobSize);
        [[UIColor colorWithWhite:1.0 alpha:0.55]set];
        CGContextFillEllipseInRect(context, handleRect);
    }
    
    CGContextRestoreGState(context);
}

#pragma mark - Helper Methods

@end
