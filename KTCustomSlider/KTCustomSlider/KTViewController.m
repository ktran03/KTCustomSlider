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
    
    KTSliderControl *slider = [[KTSliderControl alloc]initWithFrame:CGRectMake(10, 50, 300, 50)];
    
    slider.minSliderValue = 0;
    slider.maxSliderValue = 100;
    slider.controlValue = 74;
    slider.isControlValueOptionOn = YES;
    
    slider.barHeight = 2;
    slider.barMargin = 30;
    slider.triangleSize = 10;
    slider.knobSize = 27;
    
    slider.barColor = [UIColor lightGrayColor];
    slider.barUndertoneLeft = [UIColor yellowColor];
    slider.barUndertoneRight = [UIColor orangeColor];
        
    [slider updateDisplay];
    [slider addTarget:self action:@selector(sliderValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
}

-(void)sliderValue:(KTSliderControl*)slider{
    NSLog(@"Current value = %d", slider.currentValue);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
