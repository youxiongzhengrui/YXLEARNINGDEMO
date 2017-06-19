//
//  YXBarChartView.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/6/15.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import "YXBarChartView.h"

@interface YXBarChartView ()<CAAnimationDelegate>
@property (nonatomic, assign) CGFloat maxHeight;//峰值
@property (nonatomic, assign) CGFloat maxWidth;//横线最大值
@property (nonatomic, assign) CGFloat perHeight;//
@property (nonatomic, strong) UIScrollView *bgScrollView;//背景图
@property (nonatomic, strong) NSMutableArray *layerArr; //所有图层的数组
@property (nonatomic, strong) NSMutableArray *allBarShowViewArr;//所有的柱状图数组
@property (nonatomic, strong) NSMutableArray *drawLineValueArr;
@property (nonatomic, strong) NSMutableArray *yLineDataArr;//Y轴辅助数据源数组

@end

@implementation YXBarChartView

#pragma mak lazy init
- (NSMutableArray *)layerArr {
    if (!_layerArr) {
        _layerArr = [NSMutableArray array];
    }
    return _layerArr;
}

- (NSMutableArray *)allBarShowViewArr {
    if (!_allBarShowViewArr) {
        _allBarShowViewArr = [NSMutableArray array];
    }
    return _allBarShowViewArr;
}

- (UIScrollView *)bgScrollView {
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_bgScrollView];
    }
    return _bgScrollView;
}

- (NSMutableArray *)drawLineValueArr {
    if (!_drawLineValueArr) {
        _drawLineValueArr = [NSMutableArray array];
    }
    return _drawLineValueArr;
}

- (NSMutableArray *)yLineDataArr {
    if (!_yLineDataArr) {
        _yLineDataArr = [NSMutableArray array];
    }
    return _yLineDataArr;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.needXandYLine = YES;
        self.isShowYLine = YES;
        self.lineChartPathColor = [UIColor blueColor];
        self.lineChartValuePointColor = [UIColor yellowColor];
    }
    return self;
}

- (void)setLineValueArray:(NSArray *)lineValueArray{
    
    if (!_isShowLineChart) {
        return;
    }
    
    _lineValueArray = lineValueArray;
    CGFloat max = _maxHeight;
    
    for (id number in _lineValueArray) {
        
        CGFloat currentNumber = [NSString stringWithFormat:@"%@",number].floatValue;
        if (currentNumber > max) {
            max = currentNumber;
        }
        
    }
    if (max < 5.0) {
        _maxHeight = 5.0;
    }else if (max < 10){
        _maxHeight = 10;
    }else {
        _maxHeight = max;
    }
    
    _maxHeight += 4;
    _perHeight = (CGRectGetHeight(self.frame) - 30 - _originSize.y) / _maxHeight;
}


- (void)setValueArr:(NSArray<NSArray *> *)valueArr {
    _valueArr = valueArr;
    CGFloat max = 0;
    for (NSArray *arr in valueArr) {
        for (id number in arr) {
            CGFloat currentNum = [NSString stringWithFormat:@"%@", number].floatValue;
            if (currentNum > max) {
                max = currentNum;
            }
        }
    }
    if (max < 5) {
        self.maxHeight = 5.0;
    } else if (max < 10) {
        self.maxHeight = 10.0;
    } else {
        self.maxHeight = max;
    }
    self.maxHeight += 4;
    self.perHeight = (CGRectGetHeight(self.frame) - 30 - self.originSize.y) / self.maxHeight;
}

// 动画显示view
- (void)showViewWithAnimation {
    //先移除所有layer和view柱状图
    [self clearAllViewOrLayer];
    [self setUpBaseData];//设置基本数据
    [self setUpXYAndDashLine];
    //绘制X、Y轴线
    
}

//设置基本数据（X轴最大值，峰值，柱状条宽度，柱状条空白间距，背景图横向滑动范围）
- (void)setUpBaseData {
    self.columnWidth = self.columnWidth <= 0 ? 30 : self.columnWidth;
    self.typeSpace = self.typeSpace <= 0 ? 15 : self.typeSpace;
    NSInteger count = self.valueArr.count * self.valueArr.firstObject.count;
    self.maxWidth = self.columnWidth * count + self.valueArr.count * self.typeSpace + self.typeSpace + 40;
    self.bgScrollView.contentSize = CGSizeMake(self.maxWidth, 0);
    self.bgScrollView.backgroundColor = self.bgVewBackgoundColor;
}

//绘制X、Y轴线 虚线辅助图
- (void)setUpXYAndDashLine {
    if (self.needXandYLine) {
        [self setUpXY];
        [self setUpDashLine];
    }
    [self addXShowInfoTextAndColumnView];
}

//X,Y轴线
- (void)setUpXY {
    CAShapeLayer *layer = [CAShapeLayer layer];
    [self.layerArr addObject:layer];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    //移动到坐标原点
    [bezierPath moveToPoint:Point_M(self.originSize.x, CGRectGetHeight(self.frame) - self.originSize.y)];
    //添加X轴线
    [bezierPath addLineToPoint:Point_M(self.maxWidth, CGRectGetHeight(self.frame) - self.originSize.y)];
    //添加Y轴线
    if (self.isShowYLine) {
        [bezierPath moveToPoint:Point_M(self.originSize.x, CGRectGetHeight(self.frame) - self.originSize.y)];
        [bezierPath addLineToPoint:self.originSize];
    }
    
    layer.path = bezierPath.CGPath;
    //x,y轴线填充颜色
    layer.strokeColor = !self.colorForXYLine ? [UIColor blackColor].CGColor : self.colorForXYLine.CGColor;
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //持续时间
    basic.duration = self.isShowYLine ? 1.5 : 0.75;
    basic.fromValue = @0;//起始值
    basic.toValue = @1;//终点值
    //动画执行完,停留下来,不返回原值,需要设置下面的两个属性
    basic.autoreverses = NO;//动画结束时是否执行逆动画
    basic.fillMode = kCAFillModeForwards;
    [layer addAnimation:basic forKey:nil];
    [self.bgScrollView.layer addSublayer:layer];
}

//横向辅助虚线
- (void)setUpDashLine {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    for (int i = 0; i < 5; i++) {
        NSInteger pace = self.maxHeight / 5;
        CGFloat height = self.perHeight * (i + 1) * pace;
        CGFloat point_Y = CGRectGetHeight(self.frame) - self.originSize.y - height;
        [bezierPath moveToPoint:Point_M(self.originSize.x, point_Y)];
        [bezierPath addLineToPoint:Point_M(self.maxWidth, point_Y)];
        //辅助线文字
        CATextLayer *textLayer = [CATextLayer layer];
        
        textLayer.contentsScale = [UIScreen mainScreen].scale;//屏幕分辨率
        NSString *text =[NSString stringWithFormat:@"%ld",(i + 1) * pace];
        CGFloat be = [self sizeOfStringWithMaxSize:XORYLINEMAXSIZE textFont:self.yDescTextFontSize aimString:text].width;
        textLayer.frame = CGRectMake(self.originSize.x - be - 3, CGRectGetHeight(self.frame) - _originSize.y - height - 5, be, 15);
        
        UIFont *font = [UIFont systemFontOfSize:self.yDescTextFontSize];
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        textLayer.font = fontRef;
        textLayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
        
        textLayer.string = text;
        
        textLayer.foregroundColor = (_drawTextColorForX_Y == nil ? [UIColor blackColor].CGColor : _drawTextColorForX_Y.CGColor);
        [self.bgScrollView.layer addSublayer:textLayer];
        [self.layerArr addObject:textLayer];
        
    }
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    layer.strokeColor = !self.dashColor ? [UIColor darkGrayColor].CGColor : self.dashColor.CGColor;
    layer.lineWidth = 0.5;
    [layer setLineDashPattern:@[@3, @3]];
    
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"stokeEnd"];
    basic.duration = 1.5;
    basic.fromValue = @0;
    basic.toValue = @1;
    basic.autoreverses = NO;
    basic.fillMode = kCAFillModeForwards;
    [layer addAnimation:basic forKey:nil];
    [self.bgScrollView.layer addSublayer:layer];
    [self.layerArr addObject:layer];
}

- (void)addXShowInfoTextAndColumnView {
    [self setUpXShowInfoText];
    [self showColumnView];
}

//绘制X轴提示语
- (void)setUpXShowInfoText {
    if (self.xShowInfoText.count == self.valueArr.count && self.xShowInfoText.count > 0) {
        NSInteger count = self.valueArr.firstObject.count;
        for (int i = 0; i < self.xShowInfoText.count; i++) {
            CATextLayer *textLayer = [CATextLayer layer];
            CGFloat wid = count * self.columnWidth;
            CGSize size = [self.xShowInfoText[i] boundingRectWithSize:CGSizeMake(wid, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.xDescTextFontSize]} context:nil].size;
            textLayer.frame = CGRectMake(i * (self.columnWidth * count + self.typeSpace) + self.typeSpace + self.originSize.x, CGRectGetHeight(self.frame) - self.originSize.y + 5, wid, size.height);
            textLayer.string = self.xShowInfoText[i];
            textLayer.contentsScale = [UIScreen mainScreen].scale;
            UIFont *font = [UIFont systemFontOfSize:self.xDescTextFontSize];
            textLayer.fontSize = font.pointSize;
            textLayer.foregroundColor = self.drawTextColorForX_Y.CGColor;
            textLayer.alignmentMode = kCAAlignmentCenter;
            [self.bgScrollView.layer addSublayer:textLayer];
            [self.layerArr addObject:textLayer];
        }
    }
}

//添加柱状图
- (void)showColumnView {
    for (int i = 0; i < self.valueArr.count; i++) {
        NSArray *array = self.valueArr[i];
        for (int j = 0; j < array.count; j++) {
            CGFloat height = [array[j] floatValue] * self.perHeight;
            UIView *itemsView = [UIView new];
            [self.allBarShowViewArr addObject:itemsView];
            itemsView.frame = CGRectMake((i * array.count + j) * _columnWidth + i * _typeSpace + _originSize.x + _typeSpace, CGRectGetHeight(self.frame) - _originSize.y - 1, _columnWidth, 0);
            if (self.isShowLineChart) {
                float valueFloat = [[NSString stringWithFormat:@"%@", self.lineValueArray[i]] floatValue];
                NSValue *lineValue = [NSValue valueWithCGPoint:Point_M(CGRectGetMaxX(itemsView.frame) - _columnWidth / 2, CGRectGetHeight(self.frame) - valueFloat * _perHeight - _originSize.y -1)];
                [self.drawLineValueArr addObject:lineValue];
            }
            
            itemsView.backgroundColor = (UIColor *)(_columnBGcolorsArr.count < array.count ? [UIColor greenColor] : _columnBGcolorsArr[j]);
            [UIView animateWithDuration:1 animations:^{
                itemsView.frame = CGRectMake((i * array.count + j) * _columnWidth + i * _typeSpace + _originSize.x + _typeSpace, CGRectGetHeight(self.frame) - height - _originSize.y - 1, _columnWidth, height);
            } completion:^(BOOL finished) {
                if (finished) {
                    CATextLayer *textLayer = [CATextLayer layer];
                    
                    [self.layerArr addObject:textLayer];
                    NSString *str = [NSString stringWithFormat:@"%@",array[j]];
                    
                    CGSize size = [str boundingRectWithSize:CGSizeMake(_columnWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]} context:nil].size;
                    
                    textLayer.frame = CGRectMake((i * array.count + j) *_columnWidth + i * _typeSpace + _originSize.x + _typeSpace, CGRectGetHeight(self.frame) - height - _originSize.y -3 - size.height, _columnWidth, size.height);
                    
                    textLayer.string = str;
                    
                    textLayer.fontSize = 9.0;
                    
                    textLayer.alignmentMode = kCAAlignmentCenter;
                    textLayer.contentsScale = [UIScreen mainScreen].scale;
                    textLayer.foregroundColor = itemsView.backgroundColor.CGColor;
                    
                    [self.bgScrollView.layer addSublayer:textLayer];
                    //添加折线
                    [self addBrokenLineWithArray:array i:i j:j];
                }
            }];
            [self.bgScrollView addSubview:itemsView];
        }
    }
}

- (void)addBrokenLineWithArray:(NSArray *)arr i:(int)i j:(int)j  {
    if (i == self.valueArr.count - 1 && j == arr.count - 1 && self.isShowLineChart) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        for (int32_t m = 0; m < self.lineValueArray.count; m++) {
            NSLog(@"%@",self.drawLineValueArr[m]);
            if (m==0) {
                [path moveToPoint:[self.drawLineValueArr[m] CGPointValue]];
                
            } else{
                [path addLineToPoint:[self.drawLineValueArr[m] CGPointValue]];
                [path moveToPoint:[self.drawLineValueArr[m] CGPointValue]];
            }
        }
        CAShapeLayer *shaper = [CAShapeLayer layer];
        shaper.path = path.CGPath;
        shaper.frame = self.bounds;
        shaper.lineWidth = 2.5;
        shaper.strokeColor = _lineChartPathColor.CGColor;
        
        [self.layerArr addObject:shaper];
        
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
        
        basic.fromValue = @0;
        basic.toValue = @1;
        basic.duration = 1;
        basic.delegate = self;
        [shaper addAnimation:basic forKey:@"stokentoend"];
        [self.bgScrollView.layer addSublayer:shaper];
    }
}

//移除所有的layer和柱状图
- (void)clearAllViewOrLayer {
    for (CALayer *layer in self.layerArr) {
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
    }
    
    for (UIView *subV in self.allBarShowViewArr) {
        [subV removeFromSuperview];
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        if (_isShowLineChart) {
            for (int32_t m = 0; m < _lineValueArray.count; m++) {
                NSLog(@"%@", self.drawLineValueArr[m]);
                CAShapeLayer *roundLayer = [CAShapeLayer layer];
                UIBezierPath *roundPath = [UIBezierPath bezierPathWithArcCenter:[self.drawLineValueArr[m] CGPointValue] radius:4.5 startAngle:M_PI_2 endAngle:M_PI_2 + M_PI * 2 clockwise:YES];
                roundLayer.path = roundPath.CGPath;
                roundLayer.fillColor = _lineChartValuePointColor.CGColor;
                [self.layerArr addObject:roundLayer];
                [self.bgScrollView.layer addSublayer:roundLayer];
            }
        }
    }
}


@end
