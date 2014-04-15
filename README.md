## KTCustomSlider

<p align=“left” >
  <img src="http://imgur.com/gXBE9zx" alt=“KTCustomSlider” title=“KT”CustomSlider>
</p>

KTCustomSlider is a simple slider control for iOS and Mac OS X. It provides additional features not available in UISlider.

## Usage

```objective-c
KTSliderControl *slider = [[KTSliderControl alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
slider.maxSliderValue = 100;
slider.minSliderValue = 0;
slider.relativeControlValue = 35;
slider.barInnerColorLeft = [UIColor yellowColor];
slider.barInnerColorRight = [UIColor greenColor];
```

## Maintainer

- [Khanh Tran](http://github.com/ktran03) ([@khanhvinhtran](https://twitter.com/KhanhVinhTran)) 

## License
KTCustomSlider is available under the MIT license. See license file for more info.