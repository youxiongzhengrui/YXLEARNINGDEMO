//
//  YXSixTypeDrawingView.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 16/10/10.
//  Copyright © 2016年 ~YXzr~. All rights reserved.
//

#import "YXSixTypeDrawingView.h"

@implementation YXSixTypeDrawingView

- (instancetype)init {
    self = [super init];
    return self;
}


/******************** 第一种UIKit框架drawRect: 直接在view绘图**************************
 重绘操作仍然在drawRect方法中完成，但是苹果不建议直接调用drawRect方法，当然如果你强直直接调用此方法，当然是没有效果的。苹果要求我们调用UIView类中的setNeedsDisplay方法，则程序会自动调用drawRect方法进行重绘。
 */

/*
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    [[UIColor cyanColor] setFill];
    [path fill];
}
*/

/************************ 第二种Core Graphics框架inContext:***************************/
/*
- (void)drawRect:(CGRect)rect{
    //当前上下文及画布为当前view
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(con, CGRectMake(0,0,100,100));
    CGContextSetFillColorWithColor(con, [UIColor blueColor].CGColor);
    CGContextFillPath(con);
}
*/

@end

/************************ 第三种UIKit框架inContext:***************************/
// 1、直接声明一个Layer类
@implementation TestLayer
- (void)drawInContext:(CGContextRef)ctx {
//    UIGraphicsPushContext(ctx);
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
//    [[UIColor blueColor] setFill];
//    [path fill];
//    UIGraphicsPopContext();
    
    // 第四种方法： drawInContext:方法
//    CGContextAddEllipseInRect(ctx, CGRectMake(0,0,100,100));
    CGContextAddArc(ctx, 50, 50, 50, 0, 2*M_PI, 0);
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextFillPath(ctx);
}

- (void)drawLayer:(CALayer*)layer inContext:(CGContextRef)ctx {
    
}

@end

// 2、声明layer代理 drawLayer: inContext:方法
@implementation DrawLayerDelegate

- (void)drawLayer:(CALayer*)layer inContext:(CGContextRef)ctx {
//    UIGraphicsPushContext(ctx);
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
//    [[UIColor greenColor] setFill];
//    [path fill];
//    UIGraphicsPopContext();
    
}

@end





