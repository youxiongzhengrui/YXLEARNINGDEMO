//
//  YXGesturePasswordViewController.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/2/27.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import "YXGesturePasswordViewController.h"

@interface YXGesturePasswordViewController ()
@property (nonatomic, strong) NSMutableArray *buttonArr; //全部手势按键的数组
@property (nonatomic, strong) NSMutableArray *selectButtonArr; //选中的手势按钮的数组
@property (nonatomic, assign) CGPoint startPoint; //记录开始选中的按键坐标
@property (nonatomic, assign) CGPoint endPoint; //记录结束时的手势坐标
@property (nonatomic, strong) UIImageView *imageView; //画图用的imageview
@end

@implementation YXGesturePasswordViewController

#pragma mark - 懒加载

- (NSMutableArray *)buttonArr {
    if (_buttonArr == nil) {
        self.buttonArr = [[NSMutableArray alloc] initWithCapacity:9];
    }
    return _buttonArr;
}

- (NSMutableArray *)selectButtonArr {
    if (_selectButtonArr == nil) {
        self.selectButtonArr = [NSMutableArray array];
    }
    return _selectButtonArr;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [self.view addSubview:self.imageView];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手势密码";
    [self initNineButton];
}


/**
    初始化九个按钮
 */
- (void)initNineButton {
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(ScreenWidth / 12 + ScreenWidth / 3 * j, ScreenHeight / 3 + ScreenWidth / 3 * i, ScreenWidth / 6, ScreenWidth / 6);
            [button setImage:[UIImage imageNamed:@"button_normal"] forState:(UIControlStateNormal)];
            [button setImage:[UIImage imageNamed:@"button_highlighted"] forState:(UIControlStateHighlighted)];
            button.userInteractionEnabled = NO;
            [self.buttonArr addObject:button];
            [self.imageView addSubview:button];
        }
    }
}

//
/**
    根据手势画线
 */
- (UIImage *)drawLine {
    UIImage *image = nil;
    UIColor *lineColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    UIGraphicsBeginImageContext(self.imageView.frame.size);//设置画图的大小为imageview的大小
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextMoveToPoint(context, self.startPoint.x, self.startPoint.y); //设置画线起点
    //从起点画线到选中的按键中心，并切换画线的起点
    for (UIButton *button in self.selectButtonArr) {
        CGPoint btnPo = button.center;
        CGContextAddLineToPoint(context, btnPo.x, btnPo.y);
        CGContextMoveToPoint(context, btnPo.x, btnPo.y);
    }
    //画移动中的最后一条线
    CGContextAddLineToPoint(context, self.endPoint.x, self.endPoint.y);
    CGContextStrokePath(context);
    image = UIGraphicsGetImageFromCurrentImageContext();//画图输出
    UIGraphicsEndImageContext();//结束画线
    return image;
}

// 开始手势
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject]; //保存所有触摸事件
    if (touch) {
        for (UIButton *button in self.buttonArr) {
            CGPoint point = [touch locationInView:button]; //记录按键坐标
            if ([button pointInside:point withEvent:nil]) { //判断按键坐标是否在手势开始范围内,是则为选中的开始按键
                [self.selectButtonArr addObject:button];
                button.highlighted = YES;
                self.startPoint = button.center; //保存起始坐标
            }
        }
    }
}

//移动中触发，画线过程中会一直调用画线方法
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch) {
        self.endPoint = [touch locationInView:self.imageView];
        for (UIButton *button in self.buttonArr) {
            CGPoint point = [touch locationInView:button];
            if ([button pointInside:point withEvent:nil]) {
                BOOL isAdd = YES;//记录是否为重复按键
                for (UIButton *selectButton in self.selectButtonArr) {
                    if (selectButton == button) {
                        isAdd = NO;//已经是选中过的按键，不再重复添加
                        break;
                    }
                }
                if (isAdd) {//未添加的选中按键，添加并修改状态
                    [self.selectButtonArr addObject:button];
                    button.highlighted = YES;
                }
            }
        }
    }
    //每次移动过程中都要调用这个方法，把画出的图输出显示
    self.imageView.image = [self drawLine];
}

//手势结束触发
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.imageView.image = nil;
    self.selectButtonArr = nil;
    for (UIButton *btn in self.buttonArr) {
        btn.highlighted = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
