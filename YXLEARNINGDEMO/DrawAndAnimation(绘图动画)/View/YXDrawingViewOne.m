//
//  YXDrawingViewOne.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 16/9/12.
//  Copyright © 2016年 ~YXzr~. All rights reserved.
//

#import "YXDrawingViewOne.h"
#define th M_PI/180


@interface YXDrawingViewOne ()<CALayerDelegate> {
    
}

@property (strong, nonatomic) MyLayerDelegate *delegate;
@end

@implementation YXDrawingViewOne

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CALayer *myLayer = [CALayer layer];
        self.delegate = [[MyLayerDelegate alloc]init];
        myLayer.delegate = self.delegate;
        myLayer.backgroundColor = [UIColor brownColor].CGColor;
        myLayer.frame = CGRectMake(0, 0, 100, 100);
//        myLayer.anchorPoint = CGPointZero;
//        myLayer.position = CGPointMake(50, 50);
//        myLayer.cornerRadius = 20;
//        myLayer.shadowColor = [UIColor blackColor].CGColor;
//        myLayer.shadowOffset = CGSizeMake(10, 20);
//        myLayer.shadowOpacity = 0.6;
        
        [myLayer setNeedsDisplay]; // 调用此方法，drawLayer: inContext:方法才会被调用。
        [self.layer addSublayer:myLayer];
    }
    return self;
}

//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
//    [[UIColor blueColor] setFill];
//    [bezierPath fill];
//    
//    UIBezierPath *bezierPath1 = [UIBezierPath bezierPath];
//    // 添加路径[1条点(100,100)到点(200,100)的线段]到path
//    [bezierPath1 moveToPoint:CGPointMake(self.frame.size.width / 2, 10)];
//    [bezierPath1 addLineToPoint:CGPointMake(10, 70)];
//    [bezierPath1 setLineWidth:3.0];  //设置线的宽度
//    [[UIColor blueColor] setStroke];  // 填充线的颜色
//    [bezierPath1 stroke];
//    
//    
//    UIBezierPath *bezierPath2 = [UIBezierPath bezierPath];
//    // 添加路径[1条点(100,100)到点(200,100)的线段]到path
//    [bezierPath2 moveToPoint:CGPointMake(self.frame.size.width / 2, 10)];
//    [bezierPath2 addLineToPoint:CGPointMake(90, 70)];
//    [bezierPath2 setLineWidth:3.0];  //设置线的宽度
//    [[UIColor blueColor] setStroke];  // 填充线的颜色
//    [bezierPath1 stroke];
//
//    UIBezierPath *bezierPath2 = [UIBezierPath bezierPath];
//    // 添加圆到path
//    [bezierPath2 addArcWithCenter:self.center radius:25.0 startAngle:0.0 endAngle:M_PI * 2 clockwise:YES];
//    // 设置描边宽度（为了让描边看上去更清楚）
//    [bezierPath2 setLineWidth:5.0];
//    //设置颜色（颜色设置也可以放在最上面，只要在绘制前都可以）
//    [[UIColor blueColor] setStroke];
//    [[UIColor redColor] setFill];
//    // 描边和填充
//    [bezierPath2 stroke];
//    [bezierPath2 fill];
    
//}
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        CGFloat x = frame.size.width / 2;
//        CGFloat y = frame.size.height / 2;
//        self.radius = x < y ? x:y;
//        self.value = 1;
//        self.startColor = [UIColor yellowColor];
//        //        self.backgroundColor = [UIColor colorWithRed:174/256.0 green:174/256.0 blue:174/256.0 alpha:1];
//        self.backgroundColor=[UIColor clearColor];
//        self.boundsColor = [UIColor blackColor];
//        self.opaque = NO;
//    }
//    return self;
//}
//-(void) setFrame:(CGRect)frame
//{
//    CGFloat x = frame.size.width / 2;
//    CGFloat y = frame.size.height / 2;
//    self.radius = x < y ? x:y;
//    
//    [super setFrame:frame];
//    [self setNeedsDisplay];
//    
//}
//-(id) initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        
//        CGFloat x = self.frame.size.width / 2;
//        CGFloat y = self.frame.size.height / 2;
//        self.radius = x < y ? x:y;
//        self.value = 1;
//        self.startColor = [UIColor yellowColor];
//        self.backgroundColor = [UIColor clearColor];
//        self.boundsColor = [UIColor blackColor];
//        
//    }
//    return self;
//}
//
//
//- (void)drawRect:(CGRect)rect
//{
//    
//    
//    CGFloat centerX = rect.size.width / 2;
//    CGFloat centerY = rect.size.height / 2;
//    
//    CGFloat r0 = self.radius * sin(18 * th)/cos(36 * th); /*计算小圆半径r0 */
//    CGFloat x1[5]={0},y1[5]={0},x2[5]={0},y2[5]={0};
//    
//    for (int i = 0; i < 5; i ++)
//    {
//        x1[i] = centerX + self.radius * cos((90 + i * 72) * th); /* 计算出大圆上的五个平均分布点的坐标*/
//        y1[i]=centerY - self.radius * sin((90 + i * 72) * th);
//        
//        x2[i]=centerX + r0 * cos((54 + i * 72) * th); /* 计算出小圆上的五个平均分布点的坐标*/
//        y2[i]=centerY - r0 * sin((54 + i * 72) * th);
//    }
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGMutablePathRef startPath = CGPathCreateMutable();
//    CGPathMoveToPoint(startPath, NULL, x1[0], y1[0]);
//    
//    
//    for (int i = 1; i < 5; i ++) {
//        
//        
//        CGPathAddLineToPoint(startPath, NULL, x2[i], y2[i]);
//        CGPathAddLineToPoint(startPath, NULL, x1[i], y1[i]);
//    }
//    
//    CGPathAddLineToPoint(startPath, NULL, x2[0], y2[0]);
//    CGPathCloseSubpath(startPath);
//    
//    
//    CGContextAddPath(context, startPath);
//    
//    CGContextSetFillColorWithColor(context, self.startColor.CGColor);
//    
//    CGContextSetStrokeColorWithColor(context, self.boundsColor.CGColor);
//    CGContextStrokePath(context);
//    
//    CGRect range = CGRectMake(x1[1], 0, (x1[4] - x1[1]) * self.value , y1[2]);
//    
//    CGContextAddPath(context, startPath);
//    CGContextClip(context);
//    CGContextFillRect(context, range);
//    
//    
//    CFRelease(startPath);
//    
//    
//    
//}
//
//-(void) setValue:(CGFloat)value
//{
//    if (value < 0) {
//        _value = 0;
//    }
//    else if(value > 1)
//    {
//        _value = 1;
//    }
//    else{
//        _value = value;
//    }
//    
//    [self setNeedsDisplay];
//}





@end


@implementation MyLayerDelegate

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    UIGraphicsPushContext(ctx);
    
    //    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
    //
    //    [[UIColor blueColor] setFill];
    //
    //    [p fill];
    UIBezierPath *bezierPath1 = [UIBezierPath bezierPath];
    // 添加路径[1条点(100,100)到点(200,100)的线段]到path
    [bezierPath1 moveToPoint:CGPointMake(50, 10)];
    [bezierPath1 addLineToPoint:CGPointMake(10, 70)];
    [bezierPath1 setLineWidth:3.0];  //设置线的宽度
    [[UIColor blueColor] setStroke];  // 填充线的颜色
    [bezierPath1 stroke];
    UIGraphicsPopContext();
}

@end









