//
//  CircleView.m
//  03CNProgressView
//
//  Created by CN on 2018/5/4.
//  Copyright © 2018年 com.cn.progressView. All rights reserved.
//

#import "CircleView.h"

@interface CircleView()
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@end
@implementation CircleView

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
    [self starAnimation];
}

- (void)starAnimation {
    
    // 画圆
    CGFloat width = self.bounds.size.width;
    CGFloat lineWidth = 10;  // 线宽
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(lineWidth/2, lineWidth/2, width - lineWidth, width - lineWidth)];
    self.shapeLayer.path = path.CGPath;
    [self.layer addSublayer:self.shapeLayer];
    
    // 画线，利用 strokeEnd strokeStar
    // 利用两个动画做组合效果，一个是添加，一个遮盖
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @0;
    strokeEndAnimation.toValue = @1;
    strokeEndAnimation.duration = 1;
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *strokeStarAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStarAnimation.fromValue = @0;
    strokeStarAnimation.toValue = @1;
    strokeStarAnimation.duration = 0.5;
    strokeStarAnimation.beginTime = 1;
    strokeStarAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[strokeEndAnimation, strokeStarAnimation];
    groupAnimation.duration = 1.5;
    groupAnimation.repeatCount = MAXFLOAT;
    [self.shapeLayer addAnimation:groupAnimation forKey:nil];
    
    // 旋转动画
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    baseAnimation.fromValue = @0.0;
    baseAnimation.toValue = @(M_PI * 2);
    baseAnimation.duration = 1;
    baseAnimation.repeatCount = MAXFLOAT;
    [self.layer addAnimation:baseAnimation forKey:nil];
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;
        _shapeLayer.lineCap = kCALineCapRound;
        _shapeLayer.lineWidth = 10;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _shapeLayer;
}

@end
