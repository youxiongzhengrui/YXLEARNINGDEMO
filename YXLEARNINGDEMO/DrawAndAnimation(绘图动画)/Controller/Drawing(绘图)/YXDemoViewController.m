//
//  YXDemoViewController.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/1/19.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import "YXDemoViewController.h"
#import "YXFlowerView.h"

@interface YXDemoViewController ()
@property (nonatomic,strong)UIImageView *imageview;
@property (nonatomic,assign)CGPoint prePoint;
    
@end

@implementation YXDemoViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.imageview = [[UIImageView alloc] initWithFrame:self.view.frame];
//    self.imageview.backgroundColor = [UIColor lightGrayColor];
    YXFlowerView *myView = [[YXFlowerView alloc] initWithFrame:self.view.frame];
    myView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview: myView];
}
    
    
- (UIImage *)drawLineWithColor:(UIColor *)color width:(CGFloat)width startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    UIImage *image = nil;
    
    UIGraphicsBeginImageContext(self.imageview.frame.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, width);
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    
    CGContextStrokePath(context);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
    
//#pragma mark - deal touch
//-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesBegan");
//    //下面两句知道手指在屏幕上的点的信息
//    UITouch* touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self.imageview];
//    
//    if (touch) {
//        self.prePoint = point;
//    }
//    NSLog(@"x=%f,y=%f",point.x,point.y);
//}
//    
//- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesMoved");
//    UITouch* touch = [touches anyObject];
//    if (touch) {
//        CGPoint point = [touch locationInView:self.imageview];
//        UIImageView *imageviews = [[UIImageView alloc] initWithFrame:self.view.frame];
//        [self.view addSubview:imageviews];
//        imageviews.image = [self drawLineWithColor:[UIColor redColor] width:3.0f startPoint:self.prePoint endPoint:point];
//        self.prePoint = point;
//        
//    }
//}

@end
