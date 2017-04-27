//
//  YXGestureView.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/2/27.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import "YXGestureView.h"

static const NSInteger kbuttonCount = 9;
static const CGFloat kwidth = 74; //按钮宽度
static const CGFloat kheight = 74; //高度
static const NSInteger kcolCount = 3; //列数

@interface YXGestureView ()
@property (nonatomic, strong) NSMutableArray *selectedButtonArr; //选中的button
@property (nonatomic, assign) CGPoint currentPoint;
@end

@implementation YXGestureView

#pragma mark - 懒加载

- (NSMutableArray *)selectedButtonArr {
    if (_selectedButtonArr == nil) {
        _selectedButtonArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _selectedButtonArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self addNineButton];
    }
    return self;
}

- (void)addNineButton {
    for (int i = 0; i < kbuttonCount; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.userInteractionEnabled = NO;
        [button setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        // 绑定tag 后面方便获取用户滑动后的密码
        button.tag = i;
        // 设置位置
        CGFloat row = i / kcolCount; //行数
        CGFloat col = i % kcolCount; //列数
        // 间距
        CGFloat space = (self.frame.size.width - kwidth * 3) / (kcolCount + 1);
        CGFloat but_X = col * (kwidth + space) + space;
        CGFloat but_Y = row * (kheight + space);
        button.frame = CGRectMake(but_X, but_Y, kwidth, kheight);
        [self addSubview:button];
    }
}

// 点击选中按钮
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self buttonSelectedWithTouch:touches withEvent:event];
}

// 移动可 选中按钮
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self buttonSelectedWithTouch:touches withEvent:event];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 记录密码
    NSMutableString *strM = [NSMutableString string];
    // 让所有选中按钮恢复成正常状态
    for (UIButton *selBtn in self.selectedButtonArr) {
        selBtn.selected = NO;
        // 拼接密码字符串
        [strM appendFormat:@"%ld",selBtn.tag];
    }
    
    NSLog(@"%@",strM);
    
    // 清空选中按钮数组
    [self.selectedButtonArr removeAllObjects];
    
    [self setNeedsDisplay];
}

- (void)buttonSelectedWithTouch:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint currentPoint = [touch locationInView:self];
    // 记录当前选中的点
    self.currentPoint = currentPoint;
    for (UIButton *button in self.subviews) {
        CGPoint btnPoint = [self convertPoint:currentPoint toView:button];
        if ([button pointInside:btnPoint withEvent:event] && button.selected == NO) {
            button.selected = YES;
            // 记录选中的按钮
            [self.selectedButtonArr addObject:button];
        }
    }
}

#pragma mark - 划线
- (void)drawRect:(CGRect)rect{
    
    if (self.selectedButtonArr.count == 0) return;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    int i = 0;
    for (UIButton *button in self.selectedButtonArr) {
        if (i == 0) { // 第0个按钮的center为起点
            [path moveToPoint:button.center];
        }else {
            [path addLineToPoint:button.center];
        }
        i++;
    }
    [path addLineToPoint:self.currentPoint];
    
    //    [[UIColor colorWithRed:57 green:146 blue:255 alpha:0.9] set];
    [[UIColor whiteColor] set];
    path.lineWidth = 5;
    path.lineJoinStyle = kCGLineJoinRound;
    
    [path stroke];
}


@end
