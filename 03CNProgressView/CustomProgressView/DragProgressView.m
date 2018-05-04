//
//  DragProgressView.m
//  03CNProgressView
//
//  Created by CN on 2018/5/2.
//  Copyright © 2018年 com.cn.progressView. All rights reserved.
//

#import "DragProgressView.h"

@interface DragProgressView()
@property (nonatomic, assign) CGFloat currentProgressValue;
@property (nonatomic, strong) UILabel *currentLabel;
@property (nonatomic, strong) UIImageView *headerImgView;
@end

@implementation DragProgressView

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
    self.backgroundColor = [UIColor whiteColor];
    self.currentLabel = [[UILabel alloc] init];
    self.currentLabel.font = [UIFont systemFontOfSize:15];
    self.currentLabel.textColor = [UIColor blueColor];
    self.currentLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview: self.currentLabel];
    
    self.headerImgView = [[UIImageView alloc] init];
    [self addSubview: self.headerImgView];
    self.headerImgView.image = [self drawImage];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.currentLabel.frame = self.bounds;
    
    CGFloat angle = self.currentProgressValue*2*M_PI + -M_PI_2;
    CGFloat centerX = self.bounds.size.width/2;
    CGFloat centerY = self.bounds.size.width/2;
    CGFloat r = (self.bounds.size.width-10)/2;
    CGFloat imageCenterX = centerX + r*cos(angle);
    CGFloat imageCenterY = centerY + r*sin(angle);
    self.headerImgView.frame = CGRectMake(0, 0, 10, 10);
    self.headerImgView.center = CGPointMake(imageCenterX, imageCenterY);
}

- (void)setProgress:(CGFloat)progress {
    self.currentProgressValue = progress;
    self.currentLabel.text = [NSString stringWithFormat:@"%0.1f", progress * 100];
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"不断绘制才能出效果哦!");
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat centerX = self.bounds.size.width * 0.5;
    CGFloat centerY = self.bounds.size.width * 0.5;
    CGFloat lineWidth = 10;
    CGFloat radius = (self.bounds.size.height - lineWidth) * 0.5;
    CGContextAddArc(context, centerX, centerY, radius, 0, 2 * M_PI, 0);
    CGContextSetLineWidth(context, lineWidth);
    [[UIColor lightGrayColor] setStroke];
    CGContextStrokePath(context);
    
    CGFloat starAngle = -M_PI_2;  // -90度
    CGFloat distanceAngle = 2 * M_PI * self.currentProgressValue;
    // 累加
    CGContextAddArc(context, centerX, centerY, radius, starAngle, starAngle + distanceAngle, 0);
    CGContextSetLineWidth(context, lineWidth);
    [[UIColor redColor] setStroke];
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextStrokePath(context);
    
    // 扇形
    CGContextMoveToPoint(context, centerX, centerY);
    CGContextAddArc(context, centerX, centerY, radius-5, starAngle, starAngle + distanceAngle, 0);
    [[UIColor blackColor] setFill];
    CGContextFillPath(context);
}

- (UIImage *)drawImage {
    UIGraphicsBeginImageContext(CGSizeMake(20, 20));
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextAddArc(currentContext, 10, 10, 10, 0, 2*M_PI, 0);
    [[UIColor blackColor] set];
    CGContextFillPath(currentContext);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
