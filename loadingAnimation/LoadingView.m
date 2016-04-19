//
//  LoadingView.m
//  loadingAnimation
//
//  Created by 王斌 on 16/3/22.
//  Copyright © 2016年 Changhong electric Co., Ltd. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) NSMutableArray *labelArray;

@property (assign, nonatomic) BOOL animating;

@end

@implementation LoadingView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (id)init{
    self = [super init];
    
    if (self) {
        self.bounds = CGRectMake(0, 0, 70, 70);
        self.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
        
        //设置图片
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 2, 18, 20)];
        self.imageView.image = [UIImage imageNamed:@"LOADING"];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.hidden = YES;//默认隐藏
        [self addSubview:self.imageView];
        
        //设置Label，一个字符为一个label
        NSArray *textArray = @[@"L", @"o", @"a", @"d", @"i", @"n", @"g",@".", @".", @"."];
        
        UIColor *textTintColor;
        if (!self.textTintColor) {
            
            textTintColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]; //默认白色
        } else {
            textTintColor = self.textTintColor;
        }
        self.labelArray = [NSMutableArray arrayWithCapacity:10];
        CGFloat totalWidth = 0.0;
        
        for (int i = 0; i < 10; i ++) {
            
            //获取字符宽度
            NSString *contentString = textArray[i]; //目标字符串
            CGRect rect = [contentString boundingRectWithSize:CGSizeMake(MAXFLOAT, 15.0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil] ;
            
            CGFloat charWidth = CGRectGetWidth(rect);
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(3 + totalWidth, 55, charWidth, 15)];
            label.text = textArray[i];
            label.font = [UIFont systemFontOfSize:14.0];
            label.textAlignment = NSTextAlignmentCenter;
            if (i == 3) {
                label.textAlignment = NSTextAlignmentLeft;
                
            }
            label.textColor = textTintColor;
            label.layer.opacity = 0.0f;
            
            totalWidth += charWidth;
            
            [self.labelArray addObject:label];
            [self addSubview:label];
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        //        self.bounds = CGRectMake(0, 0, 70, 70);
        //        self.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
        
        self.frame = frame;
        
        //设置图片
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 2, 18, 20)];
        self.imageView.image = [UIImage imageNamed:@"LOADING"];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.hidden = YES;//默认隐藏
        [self addSubview:self.imageView];
        
        //设置Label，一个字符为一个label
        NSArray *textArray = @[@"L", @"o", @"a", @"d", @"i", @"n", @"g",@".", @".", @"."];
        UIColor *textTintColor;
        if (!self.textTintColor) {
            
            textTintColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1]; //默认白色
        } else {
            textTintColor = self.textTintColor;
        }
        self.labelArray = [NSMutableArray arrayWithCapacity:10];
        CGFloat totalWidth = 0.0;
        
        for (int i = 0; i < 10; i ++) {
            
            //获取字符宽度
            NSString *contentString = textArray[i]; //目标字符串
            CGRect rect = [contentString boundingRectWithSize:CGSizeMake(MAXFLOAT, 15.0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil] ;
            
            CGFloat charWidth = CGRectGetWidth(rect);

            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(3 + totalWidth, 55, charWidth, 15)];
            label.text = textArray[i];
            label.font = [UIFont systemFontOfSize:14.0];
            label.textAlignment = NSTextAlignmentCenter;
            if (i == 3) {
                label.textAlignment = NSTextAlignmentLeft;
                
            }
            label.textColor = textTintColor;
            label.layer.opacity = 0.0f;
            
            totalWidth += charWidth;
            
            [self.labelArray addObject:label];
            [self addSubview:label];
        }
    }
    
    [self startAnimate];
    
    return self;
}

#pragma mark - Animation Control

/**
 *  自动开始动画
 */
- (void)startAnimate{
    
    if (self.animating) {
        return;
    }
    self.animating = YES;
    
    self.alpha = 0.0f;
    self.imageView.hidden = NO;
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.alpha = 1.0f;
    }];
    
    [self.imageView.layer addAnimation:[self imageAnimation:self.imageView] forKey:@"imageMove"];
    
    for (int i = 0; i < 10; i ++) {
        UILabel *label = self.labelArray[i];
        CAAnimationGroup *group = [self labelAnimation:label delay:i * 0.16];
        [group setValue:[NSString stringWithFormat:@"%d",i] forKey:@"name"];
        
        [label.layer addAnimation:group forKey:@"labelAppear"];
    }
}

/**
 *  结束动画
 */
- (void)stopAnimate{
    
    if (!self.animating) {
        return;
    }
    
    self.animating = NO;
    
    self.alpha = 1.0;
    
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        [self.imageView.layer removeAllAnimations];
        self.imageView.hidden = YES;
        for (int i = 0; i < 10; i ++) {
            UILabel *label = self.labelArray[i];
            [label.layer removeAllAnimations];
        }
        
//        [self removeFromSuperview];
    }];
    
}

#pragma mark - Animation Configuration

/**
 *  图片的动画
 *
 *  @param imageView 需要动画的图片视图对象
 *
 *  @return CAAnimationGroup
 */
- (CAAnimationGroup *)imageAnimation:(UIImageView *)imageView{
    
    
    //1. 向下移动
    //imageView.layer.position = (34.0, 12.0)
    CABasicAnimation *moveDownAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveDownAnimation.fromValue = [NSValue valueWithCGPoint:imageView.layer.position];
    moveDownAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(imageView.layer.position.x, 43)];
    moveDownAnimation.fillMode = kCAFillModeForwards;
    moveDownAnimation.duration = 0.4f;
    moveDownAnimation.beginTime = 0.0f;
    moveDownAnimation.removedOnCompletion = NO;
    moveDownAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    //2.1 向上移动
    CABasicAnimation *moveUpAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveUpAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(34.0, 45.0)];
    moveUpAnimation.toValue = [NSValue valueWithCGPoint:imageView.layer.position];
    moveUpAnimation.autoreverses = NO;
    moveUpAnimation.fillMode = kCAFillModeForwards;
    //    moveAnimation.repeatCount = MAXFLOAT;
    moveUpAnimation.duration = 0.4f;
    moveUpAnimation.beginTime = 0.4f;
    moveUpAnimation.removedOnCompletion = NO;
    moveUpAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    //2.2 旋转到180
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotateAnimation.toValue = [NSNumber numberWithFloat: M_PI];
    rotateAnimation.autoreverses = NO;
    rotateAnimation.fillMode = kCAFillModeForwards;
    //    rotateAnimation.repeatCount = MAXFLOAT;
    rotateAnimation.duration = 0.4;
    rotateAnimation.beginTime = 0.4f;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    //3. 向下移动
    CABasicAnimation *moveDownAnimation_2 = [CABasicAnimation animationWithKeyPath:@"position"];
    moveDownAnimation_2.fromValue = [NSValue valueWithCGPoint:imageView.layer.position];
    moveDownAnimation_2.toValue = [NSValue valueWithCGPoint:CGPointMake(imageView.layer.position.x, 43)];
    moveDownAnimation_2.fillMode = kCAFillModeForwards;
    moveDownAnimation_2.duration = 0.4f;
    moveDownAnimation_2.beginTime = 0.8f;
    moveDownAnimation_2.removedOnCompletion = NO;
    moveDownAnimation_2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    //4.1. 向上移动
    CABasicAnimation *moveUpAnimation_2 = [CABasicAnimation animationWithKeyPath:@"position"];
    moveUpAnimation_2.fromValue = [NSValue valueWithCGPoint:CGPointMake(34.0, 45.0)];
    moveUpAnimation_2.toValue = [NSValue valueWithCGPoint:imageView.layer.position];
    moveUpAnimation_2.autoreverses = NO;
    moveUpAnimation_2.fillMode = kCAFillModeForwards;
    moveUpAnimation_2.duration = 0.4f;
    moveUpAnimation_2.beginTime = 1.2f;
    moveUpAnimation_2.removedOnCompletion = NO;
    moveUpAnimation_2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    //4.2 180 旋转到 360
    CABasicAnimation *rotateAnimation_2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation_2.fromValue = [NSNumber numberWithFloat:M_PI];
    rotateAnimation_2.toValue = [NSNumber numberWithFloat: 2 * M_PI];
    rotateAnimation_2.autoreverses = NO;
    rotateAnimation_2.fillMode = kCAFillModeForwards;
    rotateAnimation_2.duration = 0.4;
    rotateAnimation_2.beginTime = 1.2f;
    rotateAnimation_2.removedOnCompletion = NO;
    rotateAnimation_2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[moveDownAnimation, moveUpAnimation, rotateAnimation, moveDownAnimation_2, moveUpAnimation_2, rotateAnimation_2];
    group.duration = 1.6;
    group.repeatCount = MAXFLOAT;
    group.removedOnCompletion = NO;
//    group.autoreverses = NO;
    group.fillMode = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    group.delegate = self;
    
    [group setValue:@"imageAnimation" forKey:@"name"];
    
    return group;
}


/**
 *  文字的动画
 *
 *  @param imageView 需要动画的文字视图对象
 *
 *  @return CAAnimationGroup
 */
- (CAAnimationGroup *)labelAnimation:(UILabel *)label delay:(CGFloat)delay{
    
    //1. 透明度渐变
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.duration = 0.25;
    opacityAnimation.beginTime = 0.0f + delay;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    //2. 向下移动
    CABasicAnimation *moveDownAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveDownAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(label.layer.position.x, 61)];
    moveDownAnimation.toValue = [NSValue valueWithCGPoint:label.layer.position];
    moveDownAnimation.fillMode = kCAFillModeForwards;
    moveDownAnimation.duration = 0.15f;
    moveDownAnimation.beginTime = 0.0 + delay;
    moveDownAnimation.removedOnCompletion = NO;
    moveDownAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[opacityAnimation, moveDownAnimation];
    group.duration = 1.65f;
    group.repeatCount = MAXFLOAT;
    group.removedOnCompletion = NO;
    group.autoreverses = NO;
    group.fillMode = kCAFillModeForwards;
    group.delegate = self;
    
    return group;
    
    
}


#pragma mark - animation delegate

//- (void)animationDidStart:(CAAnimation *)anim{
//    NSLog(@"start");
//}

//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//
//    NSLog(@"stop");
//
//
//    if (self.stop) {
//
//        if ([[anim valueForKey:@"name"] isEqualToString:@"9"]) {
//
//            //loading动画刚好完成，即将进行下一次动画时，移除动画
//            self.alpha = 1.0;
//
//            [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
//                self.alpha = 0.0;
//            } completion:^(BOOL finished) {
//
//                [self.imageView.layer removeAllAnimations];
//
//                for (int i = 0; i < 10; i ++) {
//                    UILabel *label = self.labelArray[i];
//                    [label.layer removeAllAnimations];
//                }
//
//                [self removeFromSuperview];
//            }];
//        }
//    }
//}

@end






