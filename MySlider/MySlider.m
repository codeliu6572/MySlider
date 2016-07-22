//
//  MySlider.m
//  MySlider
//
//  Created by 刘浩浩 on 16/7/21.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "MySlider.h"




@interface MySlider()



@property(nonatomic,strong)UIView *baseView;
/**
 *  slier背景
 */
@property(nonatomic,strong)UIView *preSliderView;
/**
 *  slider覆盖颜色
 */
@property(nonatomic,strong)UIView *lastSliderView;
/**
 *  滑块
 */
@property(nonatomic,strong)UIButton *sliderBtn;
/**
 *  模糊点击区域按钮
 */
@property(nonatomic,strong)UIButton *expandBtn;

@end

@implementation MySlider


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 50)];
    if (self) {
        _value = 0;
        _widthSameHeight = 25;
        [self setSlierUI];
    }
    return self;
}

- (void)setSlierUI
{
    _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview:_baseView];
    
    _preSliderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
    _preSliderView.center = _baseView.center;
    _preSliderView.layer.cornerRadius = 10;
    _preSliderView.backgroundColor = [UIColor grayColor];
    _preSliderView.clipsToBounds = YES;
    [_baseView addSubview:_preSliderView];
    
    
    
    _lastSliderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];
    _lastSliderView.backgroundColor = [UIColor blueColor];
    [_preSliderView addSubview:_lastSliderView];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMoving:)];
    [_preSliderView addGestureRecognizer:tapGes];
    
    
    _sliderBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _sliderBtn.frame = CGRectMake(0, 0, _widthSameHeight, _widthSameHeight);
    _sliderBtn.center = CGPointMake(0, _baseView.center.y);
    _sliderBtn.backgroundColor = [UIColor lightGrayColor];
    if (_slImage == nil) {
        _sliderBtn.layer.borderWidth = 0.5;
        _sliderBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _sliderBtn.backgroundColor = [UIColor lightGrayColor];
    }
    else
    {
        [_sliderBtn setImage:_slImage forState:UIControlStateNormal];
    }
    _sliderBtn.userInteractionEnabled = YES;
    _sliderBtn.layer.cornerRadius = _widthSameHeight / 2;
    
    [_sliderBtn addTarget:self action:@selector(dragMoving:withEvent:)forControlEvents: UIControlEventTouchDragInside];
    [_baseView addSubview:_sliderBtn];
    
    _expandBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _expandBtn.frame = CGRectMake(0, 0, _widthSameHeight * 2, _widthSameHeight * 2);
    _expandBtn.center = _sliderBtn.center;
    [_expandBtn addTarget:self action:@selector(dragMoving:withEvent:)forControlEvents: UIControlEventTouchDragInside];
    [_baseView addSubview:_expandBtn];
    
    
    
}
- (void)tapMoving:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:_preSliderView];
    _sliderBtn.center = CGPointMake(point.x , _baseView.center.y);
    _lastSliderView.frame = CGRectMake(0, 0, point.x, 20);
    _value = point.x / _preSliderView.bounds.size.width;
    
}
- (void)dragMoving: (UIButton *)btn withEvent:(UIEvent *)event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self];
    
    CGFloat x = point.x;
    
    if(x<=0)
        
    {
        point.x = 0;
    }
    
    if(x >= self.bounds.size.width)
        
    {
        
        point.x = self.bounds.size.width;
        
    }
    
    point.y = self.frame.size.height / 2;
    
    
    btn.center = point;
    
    _lastSliderView.frame = CGRectMake(0, 0, point.x, 20);
    _value = point.x / _preSliderView.bounds.size.width;
    
    _sliderBtn.center = point;
    _expandBtn.center = _sliderBtn.center;
    
}


- (void)setValue:(CGFloat)value
{
    _value = value;
    _sliderBtn.center = CGPointMake(_value * _baseView.bounds.size.width , _baseView.center.y);
    _lastSliderView.frame = CGRectMake(0, 0, _sliderBtn.center.x, 20);
    
}

- (void)setSlImage:(UIImage *)slImage
{
    _slImage = slImage;
    [_sliderBtn setImage:_slImage forState:UIControlStateNormal];
}

- (void)setSlHeight:(CGFloat)slHeight
{
    _slHeight = slHeight;
    if (_slHeight >= 2 && _slHeight <= 20) {

        _preSliderView.frame = CGRectMake(0, 0, _baseView.bounds.size.width, _slHeight);
        _preSliderView.center = _baseView.center;
        
    }
}

- (void)setPreBackgroundColor:(UIColor *)preBackgroundColor
{
    _preBackgroundColor = preBackgroundColor;
    _preSliderView.backgroundColor = _preBackgroundColor;
}

- (void)setLastBackgroundColor:(UIColor *)lastBackgroundColor
{
    _lastBackgroundColor = lastBackgroundColor;
    _lastSliderView.backgroundColor = _lastBackgroundColor;
    
}

- (void)setWidthSameHeight:(CGFloat)widthSameHeight
{
    _widthSameHeight = widthSameHeight;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, widthSameHeight * 2);
    _baseView.frame = CGRectMake(0, 0, _baseView.bounds.size.width, widthSameHeight * 2);
    _preSliderView.center = _baseView.center;
    _sliderBtn.frame = CGRectMake(0, 0, _widthSameHeight, _widthSameHeight);
    _sliderBtn.center = CGPointMake(_value * _baseView.bounds.size.width,  _baseView.center.y);
    _sliderBtn.layer.cornerRadius = _widthSameHeight / 2;
    _expandBtn.frame = CGRectMake(0, 0, _widthSameHeight * 2, _widthSameHeight * 2);
    _expandBtn.center = _sliderBtn.center;
    
}

- (void)setSliderBackgroundColor:(UIColor *)sliderBackgroundColor
{
    _sliderBackgroundColor = sliderBackgroundColor;
    _sliderBtn.backgroundColor = _sliderBackgroundColor;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
