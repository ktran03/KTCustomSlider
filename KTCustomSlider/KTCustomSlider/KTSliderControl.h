//
//  KTSliderControl.h
//  KTCustomSlider
//
//  Created by khanh tran on 2014-04-13.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTSliderControl : UIControl

/**
 *  Returns the current value of the slider (read only)
 */
@property(assign,readonly)int currentValue;

/**
 *  If controlValueOption is set to YES, then controlValue is the value which appears the control triangle and the point of alternating undertone colors.
 */
@property(assign)double controlValue;

/**
 *  The maximum value for the slider
 */
@property(assign)double maxSliderValue;

/**
 *  The minimum value for the slider
 */
@property(assign)double minSliderValue;

/**
 *  A pointer to the minimum value label. Label can be set to hidden, or various other of its properties could be adjusted
 */
@property(strong,nonatomic)UILabel *minLabel;

/**
 *  A pointer to the maximum value label. Label can be set to hidden, or various other of its properties could be adjusted
 */
@property(strong,nonatomic)UILabel *maxLabel;

/**
 *  A pointer to the current value label inside the knob. Label can be set to hidden, or various other of its properties could be adjusted
 */
@property(strong,nonatomic)UILabel *currValueLabel;

/**
 *  This property sets the undertone color left to the control point. Note if a control point is not used, barUndertoneRight should be set to the same color.
 */
@property(strong,nonatomic)UIColor *barUndertoneLeft;

/**
 *  This property sets the undertone color left to the control point. Note if a control point is not used, barUndertoneLeft should be set to the same color.
 */@property(strong,nonatomic)UIColor *barUndertoneRight;

/**
 *  The color of the slider's bar
 */
@property(strong,nonatomic)UIColor *barColor;

/**
 *  The height of the slider's bar
 */
@property(assign)double barHeight;

/**
 *  The left and right margin of the slider's bar
 */
@property(assign)double barMargin;

/**
 *  Determines both the height and base of the control point triangle
 */@property(assign)double triangleSize;

/**
 *  The size of the knob (radius)
 */
@property(assign)double knobSize;

/**
 *  If this property is set to YES, a control point triangle will be drawn, and undertone colors will alternate at this point
 */
@property(assign)BOOL isControlValueOptionOn;


/**
 *  Call this method after setting all the properties to update slider's display
 */
-(void)updateDisplay;

@end
