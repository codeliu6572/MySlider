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
    
    MySlider *slider = [[MySlider alloc]initWithFrame:CGRectMake(10, 100, WIDTH - 20, 50)];
    slider.value = 0.2;
    slider.slHeight = 5;
    slider.widthSameHeight = 20;
    slider.preBackgroundColor = [UIColor blackColor];
    slider.lastBackgroundColor = [UIColor orangeColor];
    slider.sliderBackgroundColor = [UIColor greenColor];
    [self.view addSubview:slider];
    


    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
