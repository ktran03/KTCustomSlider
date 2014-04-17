//
//  KTSliderControl.m
//  KTCustomSlider
//
//  Created by khanh tran on 2014-04-13.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTSliderControl.h"

#define barWidth (self.frame.size.width - (paddingGeneral*2))
#define barWidthMid (barWidth/2)

#define barHeightMid self.frame.size.height/2

#define controlPointXCoord ((((self.relativeControlValue-self.minSliderValue)/(self.maxSliderValue-self.minSliderValue))*(barWidth)))
#define convertLastPointToValue ((self.lastPoint/barWidth)*(self.maxSliderValue-self.minSliderValue))

#define paddingGeneral 10.0f

@implementation KTSliderControl{
    UILabel *minLabel;
    UILabel *maxLabel;
    UILabel *currValueLabel;
}

#pragma mark - Initializers
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
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
    self.relativeControlValue = 40; //have to change these to user settable
    self.minSliderValue = 0;
    self.maxSliderValue = 100;
    self.lastPoint = controlPointXCoord;
    if (!self.barInnerColorLeft) {
        self.barInnerColorLeft = [UIColor yellowColor];
    }
    if (!self.barInnerColorRight) {
        self.barInnerColorRight = [UIColor greenColor];
    }
    
    [self configureValueLabels];
}

-(void)configureValueLabels{
    minLabel = [[UILabel alloc] initWithFrame:CGRectMake(paddingGeneral, barHeightMid, 40, 40)];
    minLabel.textColor = [UIColor grayColor];
    minLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
    minLabel.textAlignment = NSTextAlignmentLeft;
    minLabel.text = [NSString stringWithFormat:@"%d", (int)self.minSliderValue];
    [self addSubview:minLabel];
    
    maxLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-45.0, barHeightMid, 40, 40)];
    maxLabel.textColor = [UIColor grayColor];
    maxLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
    maxLabel.textAlignment = NSTextAlignmentRight;
    maxLabel.text = [NSString stringWithFormat:@"%d", (int)self.maxSliderValue];
    [self addSubview:maxLabel];
    
    currValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [currValueLabel setCenter:CGPointMake(controlPointXCoord, barHeightMid)];
    currValueLabel.textColor = [UIColor grayColor];
    currValueLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:10.0];
    currValueLabel.textAlignment = NSTextAlignmentCenter;
    currValueLabel.text = [NSString stringWithFormat:@"%f", self.relativeControlValue];
    [self addSubview:currValueLabel];
}

-(void)layoutSubviews{
    [currValueLabel setCenter:CGPointMake(self.lastPoint, barHeightMid)];
    currValueLabel.text = [NSString stringWithFormat:@"%d", (int)convertLastPointToValue];
}

#pragma mark - UIControl Methods
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    
    CGPoint lastPointUserTouched = [touch locationInView:self];
    self.lastPoint = lastPointUserTouched.x;
    
    if (convertLastPointToValue>self.maxSliderValue || convertLastPointToValue<self.minSliderValue) {
        return NO;
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
    CGContextMoveToPoint(context,paddingGeneral,barHeightMid);
    CGContextAddLineToPoint(context,self.frame.size.width-paddingGeneral, barHeightMid);
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
    CGFloat triangleHeight = 15;
    CGFloat triangleWidth = triangleHeight;
    
    CGPoint firstPoint = CGPointZero;
    firstPoint.x = controlPointXCoord;
    firstPoint.y = barHeightMid+5;
    [trianglePath moveToPoint:firstPoint];
    [trianglePath addLineToPoint:CGPointMake(firstPoint.x+(triangleWidth/2.0), firstPoint.y+triangleHeight)];
    [trianglePath addLineToPoint:CGPointMake(firstPoint.x-(triangleWidth/2.0), firstPoint.y+triangleHeight)];
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
    CGContextSaveGState(context);
    {
        CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 2, [UIColor blackColor].CGColor);
        CGRect handleRect = CGRectMake(self.lastPoint-paddingGeneral,barHeightMid-paddingGeneral, 20.0f, 20.0f);
        [[UIColor colorWithWhite:1.0 alpha:0.7]set];
        CGContextFillEllipseInRect(context, handleRect);
    }
    
    CGContextRestoreGState(context);
}

@end
