//
//  YXChartView.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/6/15.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import "YXChartView.h"

@implementation YXChartView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _xDescTextFontSize = _yDescTextFontSize = 8.0;
        _xAndYLineColor = [UIColor darkGrayColor];
        _contentInsets = UIEdgeInsetsMake(10, 20, 10, 10);
        _chartOrigin = Point_M(self.contentInsets.left, CGRectGetHeight(self.frame) - self.contentInsets.bottom);
    }
    return self;
}

- (void)showViewWithAnimation {
    
}

- (void)clearAllViewOrLayer {
    
}


/**
 *  返回字符串的占用尺寸
 *
 *  @param maxSize   最大尺寸
 *  @param fontSize  字号大小
 *  @param aimString 目标字符串
 *
 *  @return 占用尺寸
 */
- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize textFont:(CGFloat)fontSize aimString:(NSString *)aimString{
    
    
    return [[NSString stringWithFormat:@"%@",aimString] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    
}

@end
