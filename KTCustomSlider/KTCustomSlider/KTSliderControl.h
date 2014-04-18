//
//  KTSliderControl.h
//  KTCustomSlider
//
//  Created by khanh tran on 2014-04-13.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTSliderControl : UIControl

@property(assign)double lastPoint;

@property(assign)double controlValue;
@property(assign)double maxSliderValue;
@property(assign)double minSliderValue;

@property(strong,nonatomic)UIColor *barInnerColorLeft;
@property(strong,nonatomic)UIColor *barInnerColorRight;

@property(assign)double barMargin;
@property(assign)double triangleSize;
@property(assign)double knobSize;

-(void)updateDisplay;

@end
