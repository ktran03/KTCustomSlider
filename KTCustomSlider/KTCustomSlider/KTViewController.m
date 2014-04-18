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
    
    KTSliderControl *slider = [[KTSliderControl alloc]initWithFrame:CGRectMake(10, 50, 280, 50)];
    slider.barInnerColorLeft = [UIColor colorWithRed:0.0f green:100.0f blue:255.0f alpha:1.0];
    slider.barInnerColorRight = [UIColor whiteColor];
    slider.minSliderValue = 39;
    slider.maxSliderValue = 100000;
    slider.controlValue = 23467;
    slider.barMargin = 30;
    slider.triangleSize = 15;
    slider.knobSize = 35;
    
    [slider updateDisplay];
    [self.view addSubview:slider];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
