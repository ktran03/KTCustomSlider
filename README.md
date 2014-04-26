## KTCustomSlider

<p align=“left” >
  <img src="http://i.imgur.com/tWAAlEw.gif" alt=“KTCustomSlider” title=“KT”CustomSlider>
</p>

KTCustomSlider is an iOS slider with an added functionality, a control point. The control point is used to compare the current value to a previously selected value (set by the control point). The bar highlight colour changes around the control point.

## Usage

```objective-c
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
```

## Maintainer

- [Khanh Tran](http://github.com/ktran03) ([@khanhvinhtran](https://twitter.com/KhanhVinhTran)) 

## Questions - Comments - Suggestions

Contact above, fire away. 

## License
KTCustomSlider is available under the MIT license. See license file for more info.