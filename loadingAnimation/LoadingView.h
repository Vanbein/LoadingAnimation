//
//  LoadingView.h
//  loadingAnimation
//
//  Created by 王斌 on 16/3/22.
//  Copyright © 2016年 Changhong electric Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

/**
 *  Loading 文字颜色
 */
@property(nonatomic, strong)UIColor *textTintColor;

@property(nonatomic, strong)NSString *loadingText;

- (id)initWithFrame:(CGRect)frame;

/**
 *  add到superView后会自动开始动画，也可以在stop后手动重新开始动画
 */
- (void)startAnimate;

/**
 *  停止动画，停止后会从superView移除
 */
- (void)stopAnimate;

@end
