//
//  MySlider.m
//  MySlider
//
//  Created by 刘浩浩 on 16/7/21.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "MySlider.h"




@interface MySlider()
{
    UIView *lastView;
    CGFloat currentX;
    CGPoint clickCenter;
    NSString *type;
}


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


- (id)init {
    self = [super init];
    if (!self) return nil;
//    _widthSameHeight = 25;
//    _slHeight = 15;
//    _value = 0.5;
    [self setSlierUI];
    return self;
}

- (void)setSlierUI
{
    
    lastView = self;
    lastView.backgroundColor = [UIColor redColor];
    _baseView = [[UIView alloc]init];
    [self addSubview:_baseView];
    
    _preSliderView = [[UIView alloc]init];
    _preSliderView.layer.cornerRadius = 10;
    _preSliderView.backgroundColor = [UIColor grayColor];
    _preSliderView.clipsToBounds = YES;
    [_baseView addSubview:_preSliderView];
    
    
    _lastSliderView = [[UIView alloc]init];
    _lastSliderView.backgroundColor = [UIColor blueColor];
    [_preSliderView addSubview:_lastSliderView];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMoving:)];
    [_preSliderView addGestureRecognizer:tapGes];
    
    
    _sliderBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
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
    _expandBtn.center = _sliderBtn.center;
    [_expandBtn addTarget:self action:@selector(dragMoving:withEvent:)forControlEvents: UIControlEventTouchDragInside];
    [_baseView addSubview:_expandBtn];
    
    
    [_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.and.bottom.equalTo(lastView);
    }];
    
    [_preSliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(lastView);
        make.center.equalTo(lastView);
        make.height.mas_equalTo(_slHeight);
        make.width.equalTo(lastView.mas_width);
    }];
    
    
    [_lastSliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(_preSliderView);
        make.height.equalTo(_preSliderView.mas_height);
        make.width.equalTo(_preSliderView.mas_width).multipliedBy(0.5);
        make.centerY.equalTo(_preSliderView.mas_centerY);
    }];
    
    [_sliderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lastSliderView);
        make.width.and.height.mas_equalTo(20);
        make.left.equalTo(_lastSliderView.mas_right).offset(-20 / 2);
    }];

    
    [_expandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lastSliderView);
        make.left.equalTo(_lastSliderView).offset(-20);
        make.width.and.height.mas_equalTo(20 * 2);
    }];
    
    
    
}
- (void)tapMoving:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:_preSliderView];
    currentX = point.x;
    type = @"tap";
    // 告诉self.view约束需要更新
    [self setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self updateConstraintsIfNeeded];
    
    [self layoutIfNeeded];


    
}


- (void)updateConstraints
{

    
    if ([type isEqualToString:@"nottap"]) {
      
        
        [_preSliderView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(lastView);
            make.center.equalTo(lastView);
            make.height.mas_equalTo(_slHeight);
            make.width.equalTo(lastView.mas_width);
        }];
        
        [_lastSliderView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.bottom.equalTo(_preSliderView);
            make.height.equalTo(_preSliderView.mas_height);
            make.width.equalTo(_preSliderView.mas_width).multipliedBy(_value);
            make.centerY.equalTo(_preSliderView.mas_centerY);
        }];
        
        [_sliderBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_lastSliderView);
            make.width.and.height.mas_equalTo(_widthSameHeight);
            make.left.equalTo(_lastSliderView.mas_right).offset(-_widthSameHeight / 2);
        }];
        
        
        [_expandBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_lastSliderView);
            make.width.height.mas_equalTo(_widthSameHeight * 2);
            make.left.equalTo(_lastSliderView.mas_right).offset(-_widthSameHeight);
            
        }];
    }
    if ([type isEqualToString:@"tap"]) {
        [_lastSliderView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.bottom.equalTo(_preSliderView);
            make.height.equalTo(_preSliderView.mas_height);
            make.width.mas_equalTo(currentX);
            make.centerY.equalTo(_preSliderView.mas_centerY);
        }];
        
        [_sliderBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_lastSliderView);
            make.width.and.height.mas_equalTo(_widthSameHeight);
            make.left.mas_equalTo(currentX - _widthSameHeight / 2);
        }];
        
        
        [_expandBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_lastSliderView);
            make.width.and.height.mas_equalTo(_widthSameHeight * 2);
            make.left.mas_equalTo(currentX - _widthSameHeight * 2 / 2);
            
        }];
    }




    
    [super updateConstraints];
}

- (void)dragMoving: (UIButton *)btn withEvent:(UIEvent *)event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self];
    
    CGFloat x = point.x;
    
    if(x <= _widthSameHeight / 2)
        
    {
        point.x = _widthSameHeight / 2;
    }
    
    if(x >= self.bounds.size.width - _widthSameHeight / 2)
        
    {
        
        point.x = self.bounds.size.width - _widthSameHeight / 2;
        
    }
    
    point.y = self.frame.size.height / 2;
    
    currentX = point.x;
    
    type = @"tap";
    
    // 告诉self.view约束需要更新
    [self setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self updateConstraintsIfNeeded];
    
    [self layoutIfNeeded];
    
}


- (void)setValue:(CGFloat)value
{
    _value = value;
    type = @"nottap";
    
    // 告诉self.view约束需要更新
    [self setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self updateConstraintsIfNeeded];
    
    [self layoutIfNeeded];

    
     
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
        type = @"nottap";
        // 告诉self.view约束需要更新
        [self setNeedsUpdateConstraints];
        // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
        [self updateConstraintsIfNeeded];
        
        [self layoutIfNeeded];
        
        
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
    
    type = @"nottap";
    
    _sliderBtn.layer.cornerRadius = _widthSameHeight / 2;

    
    // 告诉self.view约束需要更新
    [self setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self updateConstraintsIfNeeded];
    
    [self layoutIfNeeded];
    
    
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
