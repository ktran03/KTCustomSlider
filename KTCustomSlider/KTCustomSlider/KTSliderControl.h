//
//  KTSliderControl.h
//  KTCustomSlider
//
//  Created by khanh tran on 2014-04-13.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTSliderControl : UIControl

@property(assign,readonly)int currentValue;

@property(assign)double controlValue;
@property(assign)double maxSliderValue;
@property(assign)double minSliderValue;

@property(strong,nonatomic)UILabel *minLabel;
@property(strong,nonatomic)UILabel *maxLabel;
@property(strong,nonatomic)UILabel *currValueLabel;

@property(strong,nonatomic)UIColor *barUndertoneLeft;
@property(strong,nonatomic)UIColor *barUndertoneRight;
@property(strong,nonatomic)UIColor *barColor;

@property(assign)double barHeight;
@property(assign)double barMargin;
@property(assign)double triangleSize;
@property(assign)double knobSize;

@property(assign)BOOL isControlValueOptionOn;

-(void)updateDisplay;

@end
