//
//  KTViewController.m
//  KTCustomSlider
//
//  Created by khanh tran on 2014-04-13.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTViewController.h"
#import "KTSliderControl.h"

@interface KTViewController ()

@end

@implementation KTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self slider1];
}

-(void)sliderValue:(KTSliderControl*)slider{
    NSLog(@"Current value = %d", slider.currentValue);
    [self.displayLabel setText:[NSString stringWithFormat:@"%d", slider.currentValue]];
}

-(void)slider1{
    KTSliderControl *slider = [[KTSliderControl alloc]initWithFrame:CGRectMake(10, 200, 300, 50)];
    
    slider.minSliderValue = 0;
    slider.maxSliderValue = 100;
    slider.controlValue = 65;
    slider.isControlValueOptionOn = YES;
    
    slider.barHeight = 10;
    slider.barMargin = 30;
    slider.triangleSize = 10;
    slider.knobSize = 27;
    
    slider.barColor = [UIColor lightGrayColor];
    slider.barUndertoneLeft = [UIColor cyanColor];
    slider.barUndertoneRight = [UIColor greenColor];
    
    slider.minLabel.hidden = YES;
    slider.maxLabel.hidden = YES;
    slider.currValueLabel.hidden = YES;
    
    [slider updateDisplay];
    [slider addTarget:self action:@selector(sliderValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
