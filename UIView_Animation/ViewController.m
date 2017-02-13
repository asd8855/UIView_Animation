//
//  ViewController.m
//  UIView_Animation
//
//  Created by libo on 2017/2/13.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

/*
 1.大小动画(frame)
 2.拉伸动画(bounds)
 3.中心位置动画(center)
 4.旋转动画(transform)
 5.透明变化(alpha)
 6.背景颜色变化(background color)
 7.Spring 动画
 8.旋转动画(transition)
 
 */

/*
 UIViewAnimationOptions 
  
 UIViewAnimationOptionLayoutSubviews            = 1 <<  0, 进行动画时布局子空间
 UIViewAnimationOptionAllowUserInteraction      = 1 <<  1, // turn on user interaction while animating 进行动画时允许用户交互
 UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2, // start all views from current value, not initial value 从当前状态开始动画
 UIViewAnimationOptionRepeat                    = 1 <<  3, // repeat animation indefinitely 无限重复执行动画
 UIViewAnimationOptionAutoreverse               = 1 <<  4, // if repeat, run animation back and forth 执行动画回路
 UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5, // ignore nested duration 忽略嵌套动画的执行时间设置
 UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // ignore nested curve 忽略嵌套动画的曲线设置
 UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // animate contents (applies to transitions only) 转场:进行动画时重绘视图
 UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8, // flip to/from hidden state instead of adding/removing 转场:移除(添加和移除图层的)动画效果
 UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9, // do not inherit any options or animation type 不继承父动画设置
 
 UIViewAnimationOptionCurveEaseInOut  时间曲线,慢进慢出(默认值)          = 0 << 16, // default
 UIViewAnimationOptionCurveEaseIn  时间曲线,慢进             = 1 << 16,
 UIViewAnimationOptionCurveEaseOut 时间曲线,慢出            = 2 << 16,
 UIViewAnimationOptionCurveLinear  时间曲线,均匀             = 3 << 16,
 
 UIViewAnimationOptionTransitionNone  转场,不使用动画          = 0 << 20, // default
 UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20, 转场,从左向右旋转翻页
 UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20, 转场,从右向左旋转翻页
 UIViewAnimationOptionTransitionCurlUp          = 3 << 20, 转场,下往上卷曲翻页
 UIViewAnimationOptionTransitionCurlDown        = 4 << 20, 转场,从上往下卷曲翻页
 UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20, 转场,交叉消失和出现
 UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20, 转场,从上向下旋转翻页
 UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20, 转场,从下向上旋转翻页
 */

/*
 UIViewKeyframeAnimationOptions
 
 UIViewAnimationOptionLayoutSubviews           //进行动画时布局子控件
 UIViewAnimationOptionAllowUserInteraction     //进行动画时允许用户交互
 UIViewAnimationOptionBeginFromCurrentState    //从当前状态开始动画
 UIViewAnimationOptionRepeat                   //无限重复执行动画
 UIViewAnimationOptionAutoreverse              //执行动画回路
 UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套动画的执行时间设置
 UIViewAnimationOptionOverrideInheritedOptions //不继承父动画设置
 UIViewKeyframeAnimationOptionCalculationModeLinear     //运算模式 :连续
 UIViewKeyframeAnimationOptionCalculationModeDiscrete   //运算模式 :离散
 UIViewKeyframeAnimationOptionCalculationModePaced      //运算模式 :均匀执行
 UIViewKeyframeAnimationOptionCalculationModeCubic      //运算模式 :平滑
 UIViewKeyframeAnimationOptionCalculationModeCubicPaced //运算模式 :平滑均匀
 */

/*
 总结和扩展
 1.UIView动画主要是变化UIView的自带属性
 2.UIView动画可以有很多种方式实现同一效果
 3.Spring动画iOS 7.0以上才有
 4.UIViewKeyframeAnimationOptions用着Keyframes动画,其余都用UIViewAnimationOptions枚举
*/
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIButton *showButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)animationAction:(id)sender {
    
//    self.showButton.enabled = NO;
//    [self changeframe];
//    [self changeBounds];
//    [self changeTransform];
//    [self changeAlpha];
//    [self changeBackground];
//    [self spingAnimation];
    [self transitionAnimation];
}


/**
 大小动画(frame)
 */
- (void)changeframe {

    //双击会出现 坐标错误的问题
    CGRect origianlRect = self.myView.frame;
    CGRect rect = CGRectMake(self.myView.frame.origin.x-20, self.myView.frame.origin.y-120, 160, 80);
    [UIView animateWithDuration:1.0 animations:^{
        self.myView.frame = rect;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            self.myView.frame = origianlRect;
            self.showButton.enabled = YES;
        }];
    }];
    
}


/**
 拉伸动画(bounds)
 */
- (void)changeBounds {

    CGRect originalBounds = self.myView.bounds;
    //尽管这个rect的x,y跟原始的不同,动画也只是改变了宽高
    CGRect rect = CGRectMake(0, 0, 300, 120);
    [UIView animateWithDuration:1 animations:^{
        self.myView.bounds = rect;
    } completion:^(BOOL finished) {
       [UIView animateWithDuration:1 animations:^{
           self.myView.bounds = originalBounds;
       }];
    }];
}


/**
 中心位置动画(center)
 */
- (void)changeCenter {

    CGPoint originalPoint = self.myView.center;
    CGPoint point = CGPointMake(self.myView.center.x, self.myView.center.y-170);
    [UIView animateWithDuration:0.3 animations:^{
        self.myView.center = point;
    } completion:^(BOOL finished) {
       [UIView animateWithDuration:1 animations:^{
           self.myView.center = originalPoint;
       }];
    }];
}


/**
 旋转动画(transform)
 */
- (void)changeTransform {

    CGAffineTransform originalTransform = self.myView.transform;
    [UIView animateWithDuration:2 animations:^{
//        self.myView.transform = CGAffineTransformMakeRotation(4.0f); //旋转
//        self.myView.transform = CGAffineTransformMakeScale(0.6, 0.6);//缩放
//        self.myView.transform = CGAffineTransformMakeTranslation(-60, -60);//平移
        self.myView.transform = CGAffineTransformScale(self.myView.transform, 0.6, 0.6);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            self.myView.transform = originalTransform;
        }];
    }];
}


/**
 透明度动画(改变alpha)
 */
- (void)changeAlpha {

    [UIView animateWithDuration:2 animations:^{
        self.myView.alpha = 0.3;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            self.myView.alpha = 1.0;
        }];
    }];
}


/**
 背景颜色变化(background color)
 */
- (void)changeBackground {

    UIColor *color = self.myView.backgroundColor;
    [UIView animateKeyframesWithDuration:9.0 delay:0.0f options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        //StartTime 开始时间 relativeDuration 持续时间
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:1.0/4 animations:^{
            self.myView.backgroundColor = [UIColor colorWithRed:0.9475 green:0.1921 blue:0.1746 alpha:1.0];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:1.0 / 4 relativeDuration:1.0 / 4 animations:^{
            self.myView.backgroundColor = [UIColor colorWithRed:0.1064 green:0.6052 blue:0.0334 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:2.0 / 4 relativeDuration:1.0 / 4 animations:^{
            self.myView.backgroundColor = [UIColor colorWithRed:0.1366 green:0.3017 blue:0.8411 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:3.0 / 4 relativeDuration:1.0 / 4 animations:^{
            self.myView.backgroundColor = [UIColor colorWithRed:0.619 green:0.037 blue:0.6719 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:3.0 / 4 relativeDuration:1.0 / 4 animations:^{
            self.myView.backgroundColor = [UIColor whiteColor];
        }];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            self.myView.backgroundColor = color;
        }];
    }];
}


/**
 Spring 动画
 */
- (void)spingAnimation {

    CGRect originalRect = self.myView.frame;
    CGRect rect = CGRectMake(self.myView.frame.origin.x - 80, self.myView.frame.origin.y, 120, 120);
    /*usingSpringWithDamping 的范围为0.0f 到 1.0f,数值越小【弹簧】的震动效果越明显。
     initialSpringVelocity 则表示初始的速度,数值越大一开始移动越快
     */
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
        self.myView.frame = rect;
    } completion:^(BOOL finished) {
       [UIView animateWithDuration:1 delay:1 usingSpringWithDamping:0.5 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
           self.myView.frame = originalRect;
       } completion:^(BOOL finished) {
           
       }];
    }];
}


/**
 transition 动画
 */
- (void)transitionAnimation {

//    [UIView setAnimationRepeatCount:INFINITY]; //重复次数
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //动画曲线类型
//    [UIView setAnimationRepeatAutoreverses:YES]; //是否执行动画回路

    [UIView transitionWithView:self.myView duration:2.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{

    } completion:^(BOOL finished) {
       [UIView transitionWithView:self.myView duration:2.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
           
       } completion:^(BOOL finished) {
           
       }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
