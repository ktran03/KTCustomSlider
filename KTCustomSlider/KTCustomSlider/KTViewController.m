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
    
    KTSliderControl *slider = [[KTSliderControl alloc]initWithFrame:CGRectMake(10, 50, 280, 30)];
    
    slider.barInnerColorLeft = [UIColor purpleColor];
    slider.barInnerColorRight = [UIColor redColor];
    
    slider.maxSliderValue = 87654;
    slider.minSliderValue = 999;
    slider.relativeControlValue = @3467;
    
    [self.view addSubview:slider];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
