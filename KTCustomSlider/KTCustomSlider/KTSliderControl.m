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
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];    
}

#pragma mark - Draw Methods
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];

    [[UIColor grayColor] set];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx,self.frame.size.height/4);
    CGContextMoveToPoint(ctx,10.0f,self.frame.size.height/2);
    CGContextAddLineToPoint(ctx,self.frame.size.width-10.0f, self.frame.size.height/2);
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 2, [UIColor blackColor].CGColor);
    CGContextStrokePath(ctx);
    
    [self drawHandle:ctx];
}

-(void)drawHandle:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 2, [UIColor blackColor].CGColor);
    CGRect handleRect = CGRectMake(self.frame.size.width/2-10.0f, self.frame.size.height/2-10.0f, 20.0f, 20.0f);
    [[UIColor colorWithWhite:1.0 alpha:0.7]set];
    CGContextFillEllipseInRect(ctx, handleRect);
    
    CGContextRestoreGState(ctx);
}


@end
