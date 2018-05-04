//
//  GradientView.m
//  03CNProgressView
//
//  Created by CN on 2018/5/3.
//  Copyright © 2018年 com.cn.progressView. All rights reserved.
//

#import "GradientView.h"

@interface GradientView()
@property (nonatomic, strong) CAGradientLayer *upLayer;
@property (nonatomic, strong) CAGradientLayer *downLayer;
@property (nonatomic, strong) CAShapeLayer *contentLayer;  // 用来遮挡的Layer
@end
@implementation GradientView

- (instancetype)init {
    if (self = [super init]) {
        [self setupInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupInit];
    }
    return self;
}

- (void)setupInit {
    self.backgroundColor = [UIColor clearColor];
//    self.contentLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:self.upLayer];
    [self.layer addSublayer:self.downLayer];
    [self.layer addSublayer:self.contentLayer];
    
//    transform.rotation.z
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = @(0.0);
    animation.toValue = @(2 * M_PI);
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    [self.layer addAnimation:animation forKey:nil];
}

- (void)setColors:(NSArray *)colors {
    self.upLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor yellowColor].CGColor];
    self.downLayer.colors = @[(id)[UIColor blueColor].CGColor, (id)[UIColor greenColor].CGColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    // 剪切之后初效果
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = width/2;

    self.upLayer.frame = CGRectMake(0, 0, width, height/2);
    self.downLayer.frame = CGRectMake(0, height/2, width, height/2);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, width-2*10, height-2*10)];
    self.contentLayer.path = path.CGPath;
}

- (CAShapeLayer *)contentLayer {
    if (!_contentLayer) {
        _contentLayer = [CAShapeLayer layer];
        _contentLayer.fillColor = [UIColor lightGrayColor].CGColor;
    }
    return _contentLayer;
}

- (CAGradientLayer *)upLayer {
    if (!_upLayer) {
        _upLayer = [CAGradientLayer layer];
        // 坐标，左上角(0,0) 右下角(1,1)
        _upLayer.startPoint = CGPointMake(0, 0);
        _upLayer.endPoint = CGPointMake(1, 0);
    }
    return _upLayer;
}

- (CAGradientLayer *)downLayer {
    if (!_downLayer) {
        _downLayer = [[CAGradientLayer alloc] init];
        _downLayer.startPoint = CGPointMake(0, 0);
        _downLayer.endPoint = CGPointMake(1, 0);
    }
    return _downLayer;
}

@end
