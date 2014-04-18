//
//  KTSliderControl.h
//  KTCustomSlider
//
//  Created by khanh tran on 2014-04-13.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTSliderControl : UIControl

@property(assign)float lastPoint;
@property(assign)float currentValue;


@property(strong,nonatomic)NSNumber *relativeControlValue;
@property(assign)float maxSliderValue;
@property(assign)float minSliderValue;

@property(strong,nonatomic)UIColor *barInnerColorLeft;
@property(strong,nonatomic)UIColor *barInnerColorRight;

@end
