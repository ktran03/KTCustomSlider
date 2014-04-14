//
//  KTSliderControl.m
//  KTCustomSlider
//
//  Created by khanh tran on 2014-04-13.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTSliderControl.h"

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
        self.lastPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
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

    //draw bar
    [[UIColor grayColor] set];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx,self.frame.size.height/4);
    CGContextMoveToPoint(ctx,10.0f,self.frame.size.height/2);
    CGContextAddLineToPoint(ctx,self.frame.size.width-10.0f, self.frame.size.height/2);
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 2, [UIColor blackColor].CGColor);
    CGContextStrokePath(ctx);
    
    //draw knob
    CGContextSaveGState(ctx);
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 2, [UIColor blackColor].CGColor);
    CGRect handleRect = CGRectMake(self.lastPoint.x-10.0f,self.frame.size.height/2-10.0f, 20.0f, 20.0f);
    [[UIColor colorWithWhite:1.0 alpha:0.7]set];
    CGContextFillEllipseInRect(ctx, handleRect);
    CGContextRestoreGState(ctx);
}

@end
