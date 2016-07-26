//
//  ViewController.m
//  MySlider
//
//  Created by 刘浩浩 on 16/7/21.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "ViewController.h"
#import "MySlider.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor =[UIColor whiteColor];
    
    MySlider *slider = [[MySlider alloc]init];
    slider.value = 0.2;
    slider.slHeight = 5;
    slider.widthSameHeight = 15;
    slider.preBackgroundColor = [UIColor blackColor];
    slider.lastBackgroundColor = [UIColor orangeColor];
    slider.sliderBackgroundColor = [UIColor greenColor];
    [self.view addSubview:slider];
    
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.view.mas_top).offset(100);
        
    }];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
