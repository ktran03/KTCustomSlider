## KTCustomSlider

<p align=“left” >
  <img src="http://i.imgur.com/tWAAlEw.gif" alt=“KTCustomSlider” title=“KT”CustomSlider>
</p>

KTCustomSlider is a highly customizable slider control for iOS and Mac OS X. It can be made to look exactly like UISlider, or any other way you like. It also has a ‘control value option’ that displays a triangle at the control value, and alternate undertone colours. 

## Usage

```objective-c
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
```

## Maintainer

- [Khanh Tran](http://github.com/ktran03) ([@khanhvinhtran](https://twitter.com/KhanhVinhTran)) 

## License
KTCustomSlider is available under the MIT license. See license file for more info.