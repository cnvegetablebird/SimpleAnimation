//
//  ViewController.m
//  03CNProgressView
//
//  Created by CN on 2018/5/2.
//  Copyright © 2018年 com.cn.progressView. All rights reserved.
//

#import "ViewController.h"
#import "DragProgressView.h"
#import "GradientView.h"
#import "CircleView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (nonatomic, strong) DragProgressView *progressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 进度view
    self.progressView = [[DragProgressView alloc] init];
    [self.view addSubview: self.progressView];
    self.progressView.frame = CGRectMake(100, 100, 100, 100);
    
    // 渐变view
    GradientView *gradientView = [[GradientView alloc] init];
    [self.view addSubview: gradientView];
    gradientView.frame = CGRectMake(100, 250, 100, 100);
    gradientView.colors = nil;
    
    // 追赶圆环
    CircleView *circleView = [[CircleView alloc] initWithFrame:CGRectMake(100, 400, 100, 100)];
    [self.view addSubview:circleView];
}


- (IBAction)sliderAction:(UISlider *)sender {
    self.progressView.progress = sender.value;
    
}

@end
