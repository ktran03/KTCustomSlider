//
//  KTViewController.m
//  KTCustomSlider
//
//  Created by khanh tran on 2014-04-13.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTViewController.h"

@interface KTViewController ()

@end

@implementation KTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
KTSliderControl *slider = [[KTSliderControl alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
slider.maxSliderValue = 100;
slider.minSliderValue = 0;
slider.relativeControlValue = 35;
slider.barInnerColorLeft = [UIColor yellowColor];
slider.barInnerColorRight = [UIColor greenColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
