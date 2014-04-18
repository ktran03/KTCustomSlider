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
    [self slider2];
    [self slider3];
    [self slider4];
    [self slider5];
    
}

-(void)sliderValue:(KTSliderControl*)slider{
    NSLog(@"Current value = %d", slider.currentValue);
    [self.displayLabel setText:[NSString stringWithFormat:@"%d", slider.currentValue]];
}

-(void)slider1{
    KTSliderControl *slider = [[KTSliderControl alloc]initWithFrame:CGRectMake(10, 100, 300, 50)];
    
    slider.minSliderValue = 0;
    slider.maxSliderValue = 10;
    slider.controlValue = 5;
    slider.isControlValueOptionOn = NO;
    
    slider.barHeight = 2;
    slider.barMargin = 30;
    slider.triangleSize = 10;
    slider.knobSize = 27;
    
    slider.barColor = [UIColor lightGrayColor];
    slider.barUndertoneLeft = [UIColor blueColor];
    slider.barUndertoneRight = [UIColor blueColor];
    
    slider.minLabel.hidden = YES;
    slider.maxLabel.hidden = YES;
    slider.currValueLabel.hidden = YES;
    
    [slider updateDisplay];
    [slider addTarget:self action:@selector(sliderValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

-(void)slider2{
    KTSliderControl *slider = [[KTSliderControl alloc]initWithFrame:CGRectMake(10, 170, 300, 50)];
    
    slider.minSliderValue = 0;
    slider.maxSliderValue = 100;
    slider.controlValue = 33;
    slider.isControlValueOptionOn = NO;
    
    slider.barHeight = 2;
    slider.barMargin = 30;
    slider.triangleSize = 10;
    slider.knobSize = 27;
    
    slider.barColor = [UIColor lightGrayColor];
    slider.barUndertoneLeft = [UIColor blueColor];
    slider.barUndertoneRight = [UIColor blueColor];
    
    slider.minLabel.hidden = YES;
    
    [slider updateDisplay];
    [slider addTarget:self action:@selector(sliderValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

-(void)slider3{
    KTSliderControl *slider = [[KTSliderControl alloc]initWithFrame:CGRectMake(10, 250, 300, 50)];
    
    slider.minSliderValue = 49;
    slider.maxSliderValue = 2370;
    slider.controlValue = 1986;
    slider.isControlValueOptionOn = NO;
    
    slider.barHeight = 7;
    slider.barMargin = 30;
    slider.triangleSize = 10;
    slider.knobSize = 27;
    
    slider.currValueLabel.hidden = YES;
    
    slider.barColor = [UIColor lightGrayColor];
    slider.barUndertoneLeft = [UIColor greenColor];
    slider.barUndertoneRight = [UIColor greenColor];
    
    [slider updateDisplay];
    [slider addTarget:self action:@selector(sliderValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

-(void)slider4{
    KTSliderControl *slider = [[KTSliderControl alloc]initWithFrame:CGRectMake(10, 350, 300, 50)];
    
    slider.minSliderValue = 299;
    slider.maxSliderValue = 1000;
    slider.controlValue = 500;
    slider.isControlValueOptionOn = YES;
    
    slider.barHeight = 7;
    slider.barMargin = 30;
    slider.triangleSize = 5;
    slider.knobSize = 45;
    
    slider.minLabel.font = [UIFont fontWithName:@"Ariel-Bold" size:17.0f];
    slider.minLabel.textColor = [UIColor purpleColor];
    slider.maxLabel.font = [UIFont fontWithName:@"Ariel-Bold" size:17.0f];
    slider.maxLabel.textColor = [UIColor cyanColor];

    slider.barColor = [UIColor lightGrayColor];
    slider.barUndertoneLeft = [UIColor purpleColor];
    slider.barUndertoneRight = [UIColor cyanColor];
    
    [slider updateDisplay];
    [slider addTarget:self action:@selector(sliderValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

-(void)slider5{
    KTSliderControl *slider = [[KTSliderControl alloc]initWithFrame:CGRectMake(10, 450, 300, 80)];
    
    slider.minSliderValue = 0;
    slider.maxSliderValue = 9999;
    slider.controlValue = 4983;
    slider.isControlValueOptionOn = YES;
    
    slider.barHeight = 20;
    slider.barMargin = 45;
    slider.triangleSize = 10;
    slider.knobSize = 65;
    
    slider.currValueLabel.font = [UIFont fontWithName:@"Arial-Bold" size:25.0f];
    
    slider.minLabel.font = [UIFont fontWithName:@"Ariel-Bold" size:29.0f];
    slider.minLabel.textColor = [UIColor yellowColor];
    slider.maxLabel.font = [UIFont fontWithName:@"Ariel-Bold" size:29.0f];
    slider.maxLabel.textColor = [UIColor magentaColor];
    
    slider.barColor = [UIColor lightGrayColor];
    slider.barUndertoneLeft = [UIColor yellowColor];
    slider.barUndertoneRight = [UIColor magentaColor];
    
    [slider updateDisplay];
    [slider addTarget:self action:@selector(sliderValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
