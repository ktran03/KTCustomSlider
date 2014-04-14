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

@implementation KTSliderControl

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
        self.relativeControlValue = 50; //have to change these to user settable
        self.minSliderValue = 0;
        self.maxSliderValue = 100;
        self.lastPoint = CGPointMake(midBarWidth, midBarHeight);

    }
    return self;
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
        [[UIColor redColor] set];
    }else{
        [[UIColor greenColor] set];
    }
    CGContextSetLineWidth(context, self.frame.size.height/4);
    CGContextMoveToPoint(context, controlPointX, midBarHeight);
    CGContextAddLineToPoint(context, self.lastPoint.x, midBarHeight);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 2, [UIColor blackColor].CGColor);
    CGContextStrokePath(context);
    
    //draw control value triangle
    UIBezierPath *trianglePath = [[UIBezierPath alloc] init];
    CGFloat triangleHeight = self.frame.size.height/3;
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
