//
//  KTSliderControl.h
//  KTCustomSlider
//
//  Created by khanh tran on 2014-04-13.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTSliderControl : UIControl

@property(assign)CGPoint lastPoint;

//
@property(assign)int relativeControlValue;
@property(assign)int maxSliderValue;
@property(assign)int minSliderValue;

@end
