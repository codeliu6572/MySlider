//
//  MySlider.h
//  MySlider
//
//  Created by 刘浩浩 on 16/7/21.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MySlider : UIView
/**
 *  值
 */
@property(nonatomic,assign)CGFloat value;
/**
 *  值为0时slider颜色
 */
@property(nonatomic,strong)UIColor *preBackgroundColor;
/**
 *  有值时显示的颜色
 */
@property(nonatomic,strong)UIColor *lastBackgroundColor;
/**
 *  20 >= 高度 >＝ 5
 */
@property(nonatomic,assign)CGFloat slHeight;
/**
 *  滑块图片
 */
@property(nonatomic,strong)UIImage *slImage;
/**
 *  滑块大小
 */
@property(nonatomic,assign)CGFloat widthSameHeight;
/**
 *  滑块颜色
 */
@property(nonatomic,strong)UIColor *sliderBackgroundColor;

/**
 *  进度条setter方法
 *
 *  @param value 进度
 */
- (void)setValue:(CGFloat)value;

/**
 *  设置进度条底色
 *
 *  @param preBackgroundColor 颜色
 */
- (void)setPreBackgroundColor:(UIColor *)preBackgroundColor;

/**
 *  设置进度颜色
 *
 *  @param lastBackgroundColor 颜色
 */
- (void)setLastBackgroundColor:(UIColor *)lastBackgroundColor;

/**
 *  设置进度条高度
 *
 *  @param slHeight  高度
 */
- (void)setSlHeight:(CGFloat)slHeight;   // 20 >= slHeight >= 2

/**
 *  设置滑块按钮背景图
 *
 *  @param slImage 图片
 */
- (void)setSlImage:(UIImage *)slImage;

/**
 *  设置按钮大小
 *
 *  @param widthSameHeight 宽高
 */
- (void)setWidthSameHeight:(CGFloat)widthSameHeight;
/**
 *  设置滑块颜色
 *
 *  @param sliderBackgroundColor 颜色
 */
- (void)setSliderBackgroundColor:(UIColor *)sliderBackgroundColor;
@end
