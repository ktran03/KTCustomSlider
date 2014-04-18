//
//  KTSliderControl.h
//  KTCustomSlider
//
//  Created by khanh tran on 2014-04-13.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTSliderControl : UIControl

@property(assign)int lastPoint;
@property(assign)int currentValue;

@property(assign)double controlValue;
@property(assign)double maxSliderValue;
@property(assign)double minSliderValue;

@property(strong,nonatomic)UIColor *barInnerColorLeft;
@property(strong,nonatomic)UIColor *barInnerColorRight;

@property(assign)double barHeight;
@property(assign)double barMargin;
@property(assign)double triangleSize;
@property(assign)double knobSize;

@property(assign)BOOL isControlValueOptionOn;

-(void)updateDisplay;

@end
