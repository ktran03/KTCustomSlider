//
//  KTSliderControl.m
//  KTCustomSlider
//
//  Created by khanh tran on 2014-04-13.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTSliderControl.h"

#define midBarHeight self.frame.size.height/2
#define midBarWidth self.frame.size.width/2

#define controlPointXCoord ((self.relativeControlValue-self.minSliderValue)/(self.maxSliderValue-self.minSliderValue))*(self.frame.size.width)

#define convertLastPointToValue ((self.lastPoint.x/(self.frame.size.width-20.0))*(self.maxSliderValue-self.minSliderValue))


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
        self.backgroundColor = [UIColor clearColor];
        self.relativeControlValue = 30; //have to change these to user settable
        self.minSliderValue = 0;
        self.maxSliderValue = 100;
        self.lastPoint = CGPointMake(controlPointXCoord, midBarHeight);
        if (!self.barInnerColorLeft) {
            self.barInnerColorLeft = [UIColor yellowColor];
        }
        if (!self.barInnerColorRight) {
            self.barInnerColorRight = [UIColor greenColor];
        }
        
        minLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, midBarHeight, 40, 40)];
        minLabel.textColor = [UIColor grayColor];
        minLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
        minLabel.textAlignment = NSTextAlignmentLeft;
        minLabel.text = [NSString stringWithFormat:@"%d", (int)self.minSliderValue];
        [self addSubview:minLabel];
        
        maxLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-40.0, midBarHeight, 40, 40)];
        maxLabel.textColor = [UIColor grayColor];
        maxLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
        maxLabel.textAlignment = NSTextAlignmentRight;
        maxLabel.text = [NSString stringWithFormat:@"%d", (int)self.maxSliderValue];
        [self addSubview:maxLabel];
        
        currValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [currValueLabel setCenter:CGPointMake(controlPointXCoord, midBarHeight)];
        currValueLabel.textColor = [UIColor grayColor];
        currValueLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:10.0];
        currValueLabel.textAlignment = NSTextAlignmentCenter;
        currValueLabel.text = [NSString stringWithFormat:@"%f", self.relativeControlValue];
        [self addSubview:currValueLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [currValueLabel setCenter:CGPointMake(self.lastPoint.x, midBarHeight)];
    currValueLabel.text = [NSString stringWithFormat:@"%i", (int)convertLastPointToValue];
}

#pragma mark - UIControl Methods
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    CGPoint lastPointUserTouched = [touch locationInView:self];
    self.lastPoint = lastPointUserTouched;
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
    
    CGFloat controlPointX = (self.maxSliderValue-self.minSliderValue);
    controlPointX = (self.relativeControlValue - self.minSliderValue) / controlPointX;
    controlPointX = controlPointX * self.frame.size.width;

    //draw bar
    [[UIColor grayColor] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,midBarHeight/2);
    CGContextMoveToPoint(context,10.0f,midBarHeight);
    CGContextAddLineToPoint(context,self.frame.size.width-10.0f, midBarHeight);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 2, [UIColor blackColor].CGColor);
    CGContextStrokePath(context);
    
    //draw undertone color
    if (self.lastPoint.x>controlPointX) {
        [self.barInnerColorRight set];
    }else{
        [self.barInnerColorLeft set];
    }
    CGContextSetLineWidth(context, self.frame.size.height/4);
    CGContextMoveToPoint(context, controlPointX, midBarHeight);
    CGContextAddLineToPoint(context, self.lastPoint.x, midBarHeight);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 2, [UIColor blackColor].CGColor);
    CGContextStrokePath(context);
    
    //draw control triangle
    UIBezierPath *trianglePath = [[UIBezierPath alloc] init];
    CGFloat triangleHeight = 15;
    CGFloat triangleWidth = triangleHeight;

    CGPoint firstPoint = CGPointZero;
    firstPoint.x = controlPointX;
    firstPoint.y = midBarHeight+5;
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
    
    //draw knob
    CGContextSaveGState(context);
    {
        CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 2, [UIColor blackColor].CGColor);
        CGRect handleRect = CGRectMake(self.lastPoint.x-10.0f,midBarHeight-10.0f, 20.0f, 20.0f);
        [[UIColor colorWithWhite:1.0 alpha:0.7]set];
        CGContextFillEllipseInRect(context, handleRect);
    }
    
    CGContextRestoreGState(context);
}

@end
