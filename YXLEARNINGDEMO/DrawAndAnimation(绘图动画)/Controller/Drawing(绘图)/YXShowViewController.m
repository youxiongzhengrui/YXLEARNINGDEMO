//
//  YXShowViewController.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 16/9/13.
//  Copyright © 2016年 ~YXzr~. All rights reserved.
//

#import "YXShowViewController.h"
#import "YXSixTypeDrawingView.h"

@interface YXShowViewController () {
    DrawLayerDelegate *_layerDelegate;
    CALayer *_threeLayer;
}
    
@end

@implementation YXShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 第一种UIKit框架drawRect:
//    [self setUpViewWithDrawRect];
    // 第三种UIKit框架inContext:
    [self setUpLayer];
//    [self setUpDrawingWithDelegate];
    // 第五种
//    [self setUpDrawingWithFiveMethod];
    // 第六种
//    [self setUpDrawingWithSixMethod];
    
}

// 第一种  第二种 UIKit框架drawRect:
- (void)setUpViewWithDrawRect {
    YXSixTypeDrawingView *drawingView = [[YXSixTypeDrawingView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    drawingView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:drawingView];
}

// 第三种UIKit框架inContext: 直接在self.view 的layer上添加子layer
// 1、直接声明
- (void)setUpLayer {
    TestLayer *testLayer = [TestLayer layer];
    testLayer.backgroundColor = [UIColor yellowColor].CGColor;
    testLayer.frame = CGRectMake(0, 0, 200, 200);
    [testLayer setNeedsDisplay];
    [self.view.layer addSublayer:testLayer];
}

// 2、代理

- (void)setUpDrawingWithDelegate {
    _layerDelegate = [[DrawLayerDelegate alloc] init];
    _threeLayer = [CALayer layer];
    _threeLayer.backgroundColor = [UIColor redColor].CGColor;
    _threeLayer.frame = CGRectMake(50, 50, 100, 100);
    _threeLayer.delegate = _layerDelegate;
    [_threeLayer setNeedsDisplay];
    [self.view.layer addSublayer:_threeLayer];
}

// 第五种UIKit框架UIGraphicsBeginImageContextWithOptions
- (void)setUpDrawingWithFiveMethod {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 97, 97)];
    [[UIColor blueColor] setFill];
    [[UIColor redColor] setStroke];
    path.lineWidth = 3;
    [path fill];
    [path stroke];
    UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [imageView setImage:im];
    [self.view addSubview:imageView];
}


// 第六种Core Graphics框架UIGraphicsBeginImageContextWithOptions

- (void)setUpDrawingWithSixMethod {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0);
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(con, CGRectMake(0, 0, 100, 100));
    CGContextSetFillColorWithColor(con, [UIColor blueColor].CGColor);
    CGContextFillPath(con);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [imageView setImage:image];
    [self.view addSubview:imageView];
    
}

- (void)dealloc {
    _threeLayer.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
