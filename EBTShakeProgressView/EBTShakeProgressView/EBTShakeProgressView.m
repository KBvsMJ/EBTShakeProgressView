//
//  EBTShakeProgressView.m
//  EBTShakeProgressView
//
//  Created by ebaotong on 15/7/22.
//  Copyright (c) 2015年 com.csst. All rights reserved.
//

#import "EBTShakeProgressView.h"
#define kMargin 5.f
#define kFirstContant 0.2f
#define kSecondContant 0.3f
#define kThirdContant 0.4f
#define kFourContant 0.5f
@interface EBTShakeProgressView ()
{
    UIView *containerView;//四个进度view的父视图
    UIView *firstView;   //第一个视图view
    UIView *secondView;  //第二个视图view
    UIView *thirldView; //第三个视图view
    UIView *fourView;   //第四个视图view
    CGFloat totalHeigt ;//view的高度
}
@end
@implementation EBTShakeProgressView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    [self setUp];
    
}

- (void)setUp
{
    
   
    totalHeigt = self.bounds.size.height;
  /**创建containerView*/
    containerView = [[UIView alloc]init];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:containerView];
    NSArray *containerView_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|"
                                                                       options:0 metrics:nil
                                                                         views:NSDictionaryOfVariableBindings(containerView)];
    NSArray *containerView_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]|"
                                                                       options:0 metrics:nil
                                                                         views:NSDictionaryOfVariableBindings(containerView)];
    [self addConstraints:containerView_H];
    [self addConstraints:containerView_V];
    
    /**创建第一个view*/
    firstView = [[UIView alloc]init];
    firstView.backgroundColor = [UIColor clearColor];
    firstView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:firstView];
    
    
     /**创建第二个view*/
    secondView = [[UIView alloc]init];
    secondView.backgroundColor = [UIColor clearColor];
    secondView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:secondView];
    
    
     /**创建第三个view*/
    thirldView = [[UIView alloc]init];
    thirldView.backgroundColor = [UIColor clearColor];
    thirldView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:thirldView];
    
    
     /**创建第四个view*/
    fourView = [[UIView alloc]init];
    fourView.backgroundColor = [UIColor whiteColor];
    fourView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:fourView];
    
    
    /**实现四个view等宽*/
    NSDictionary *dic_binds = NSDictionaryOfVariableBindings(firstView,secondView,thirldView,fourView);
    NSDictionary *dic_Constraint = @{
                                     @"margin":@(kMargin)
                                     };
    NSArray *allView_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[firstView]-margin-[secondView(firstView)]-margin-[thirldView(secondView)]-margin-[fourView(thirldView)]-margin-|"
                                                                 options:0
                                                                 metrics:dic_Constraint views:dic_binds];
    
    
    [containerView addConstraints:allView_H];
    
    

}
- (void)setProgress:(CGFloat)progress
{
    if (progress<=0) {
        _progress = 0.4f;
    }
    else if (progress<=1.f)
    {
        _progress = progress;
    }
    else
    {
        _progress = 1.f;
    }
    [self allViewHeightConstraints:_progress];
}
/**
 *  给四个view分别添加垂直方向上的约束
 *
 *  @param progress 进度值
 */
- (void)allViewHeightConstraints:(CGFloat)progress
{
        /**第一个view添加垂直方向的约束*/
        NSString *firstView_Height = [NSString stringWithFormat:@"V:[firstView(%f)]-0-|",totalHeigt*progress*kFirstContant];
        NSArray *firstView_V = [NSLayoutConstraint constraintsWithVisualFormat:firstView_Height
                                                                       options:0 metrics:nil
                                                                         views:NSDictionaryOfVariableBindings(firstView
                                                                                                              )];
        /**第二个view添加垂直方向的约束*/
        NSString *secondView_Height = [NSString stringWithFormat:@"V:[secondView(%f)]-0-|",totalHeigt*progress*kSecondContant];
        NSArray *secondView_V = [NSLayoutConstraint constraintsWithVisualFormat:secondView_Height
                                                                        options:0 metrics:nil
                                                                          views:NSDictionaryOfVariableBindings(secondView)];
        
        
        /**第三个view添加垂直方向的约束*/
        NSString *thirldView_Height = [NSString stringWithFormat:@"V:[thirldView(%f)]-0-|",totalHeigt*progress*kThirdContant];
        NSArray *thirldView_V = [NSLayoutConstraint constraintsWithVisualFormat:thirldView_Height
                                                                        options:0 metrics:nil
                                                                          views:NSDictionaryOfVariableBindings(thirldView)];
        
        
        /**第四个view添加垂直方向的约束*/
        NSString *fourView_Height = [NSString stringWithFormat:@"V:[fourView(%f)]-0-|",totalHeigt*progress*kFourContant];
        NSArray *fourView_V = [NSLayoutConstraint constraintsWithVisualFormat:fourView_Height
                                                                      options:0 metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(fourView)];
        
        [containerView addConstraints:firstView_V];
        [containerView addConstraints:secondView_V];
        [containerView addConstraints:thirldView_V];
        [containerView addConstraints:fourView_V];
        [containerView layoutIfNeeded];
         /**分别延时显示*/
        [self addAnimationToView:firstView progress:totalHeigt*progress*kFirstContant];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addAnimationToView:secondView progress:totalHeigt*progress*kSecondContant];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addAnimationToView:thirldView progress:totalHeigt*progress*kThirdContant];
        });
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self addAnimationToView:fourView progress:totalHeigt*progress*kFourContant];
        });
    
}
/**
 *  给四个view添加bounds动画
 *
 *  @param layerView view
 *  @param progress  进度值
 */
- (void)addAnimationToView :(UIView *)layerView progress:(CGFloat)progress
{
    /**设置view的随机颜色*/
    layerView.backgroundColor = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1.0];
    /**为bounds添加动画*/
    CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    basicAnimation.fromValue = [
                                NSValue valueWithCGRect:
                                CGRectMake(0, self.bounds.origin.y+self.bounds.size.height,(self.bounds.size.width - 5*kMargin)/4.f,0)
                                ];
    basicAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, self.bounds.origin.y+self.bounds.size.height, (self.bounds.size.width - 5*kMargin)/4.f, -(_progress*15 ))];
    basicAnimation.repeatCount = MAXFLOAT;
    basicAnimation.additive = YES;
    NSString *keyName = [NSString stringWithFormat:@"%@Animation",layerView];
    [layerView.layer addAnimation:basicAnimation forKey:keyName];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self stopAnimate:layerView keyName:keyName];
        
        
    });
    
}
/**
 *  移动动画
 *
 *  @param layerView view
 *  @param keyName   动画的keyNamem名称
 */
- (void)stopAnimate:(UIView *)layerView keyName:(NSString *)keyName
{
   [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
       
       [layerView.layer removeAnimationForKey:keyName];
    
   } completion:^(BOOL finished) {
       
       [layerView removeFromSuperview];
       [self removeFromSuperview];
   }];
}
@end
