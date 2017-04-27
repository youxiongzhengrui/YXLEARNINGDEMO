//
//  YXDrawingViewController.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 16/9/7.
//  Copyright © 2016年 ~YXzr~. All rights reserved.
//

#import "YXDrawingViewController.h"
#import "YXShowViewController.h"
#import "YXCGContextViewController.h"
#import "YXDrawingViewOne.h"
#import "YXDemoViewController.h"

@interface YXDrawingViewController () {

}
@property (nonatomic, strong) YXDrawingViewOne *drawingViewOne;
@end

@implementation YXDrawingViewController

/*
 // 根据我们的需要任意定制样式，可以画任何我们想画的图形
 + (instancetype)bezierPath;
 
 // 根据一个矩形画贝塞尔曲线
 + (instancetype)bezierPathWithRect:(CGRect)rect;
 
 // 这个工厂方法根据一个矩形画内切曲线。通常用它来画圆或者椭圆
 + (instancetype)bezierPathWithOvalInRect:(CGRect)rect;
 
 // 第一个工厂方法是画矩形，但是这个矩形是可以画圆角的。第一个参数是矩形，第二个参数是圆角大小
 + (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;
 
 // 可以指定某一个角画成圆角。像这种我们就可以很容易地给UIView扩展添加圆角的方法了
 + (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
 
 //  这个工厂方法用于画弧，参数说明如下：
     center: 弧线中心点的坐标
     radius: 弧线所在圆的半径
     startAngle: 弧线开始的角度值
     endAngle: 弧线结束的角度值
     clockwise: 是否顺时针画弧线
 + (instancetype)bezierPathWithArcCenter:(CGPoint)center
                                  radius:(CGFloat)radius
                              startAngle:(CGFloat)startAngle
                                endAngle:(CGFloat)endAngle
                               clockwise:(BOOL)clockwise;
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view from its nib.
    self.drawingViewOne = [[YXDrawingViewOne alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.drawingViewOne.backgroundColor = [UIColor whiteColor];
//    self.drawingViewOne.startColor = [UIColor yellowColor];
//    self.drawingViewOne.boundsColor=[UIColor blueColor];
//    self.drawingViewOne.value = 0.5;
    [self.view addSubview:self.drawingViewOne];
    
    UIButton *myButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    myButton.frame = CGRectMake(50, 300, 100, 44);
    [myButton setTitle:@"展示" forState:(UIControlStateNormal)];
    [myButton addTarget:self action:@selector(goToShow) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:myButton];
    
    UIButton *contextButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    contextButton.frame = CGRectMake(110, 300, 150, 44);
    [contextButton setTitle:@"Context绘图" forState:(UIControlStateNormal)];
    [contextButton addTarget:self action:@selector(goToContextView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:contextButton];
}

- (void)goToShow {
    YXShowViewController *showVC =[[ YXShowViewController alloc] init];
    [self.navigationController pushViewController:showVC animated:YES];
}

- (void)goToContextView {
    YXDemoViewController *contextVC = [[YXDemoViewController alloc] init];
    [self.navigationController pushViewController:contextVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- dra

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
