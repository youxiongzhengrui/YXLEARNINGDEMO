//
//  YXFlowerView.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/1/19.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import "YXFlowerView.h"

@interface YXFlowerView ()
@property (nonatomic, assign) CGMutablePathRef path;    // 可变路径
@end

@implementation YXFlowerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.path = CGPathCreateMutable();
    }
    return self;
}
    
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint position = [touches.anyObject locationInView:self];
    
    CGPathMoveToPoint(self.path, nil, position.x, position.y);
}
    
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint position = [touches.anyObject locationInView:self];
    
    CGPathAddLineToPoint(self.path, nil, position.x, position.y);
    
    [self setNeedsDisplay];
}
    
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(context, self.path);
    CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
    CGContextSetLineWidth(context, 5);
    
    CGContextStrokePath(context);
}

@end
