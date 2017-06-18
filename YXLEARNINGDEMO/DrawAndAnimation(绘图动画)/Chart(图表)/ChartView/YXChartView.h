//
//  YXChartView.h
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/6/15.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXChartView : UIView

/**
 *  The margin value of the content view chart view
 *  图表的边界值
 */
@property (nonatomic, assign) UIEdgeInsets contentInsets;


/**
 *  The origin of the chart is different from the meaning of the origin of the chart.
 As a pie chart and graph center ring. The line graph represents the origin.
 *  图表的原点值（如果需要）
 */
@property (assign, nonatomic)  CGPoint chartOrigin;


/**
 *  Name of chart. The name is generally not displayed, just reserved fields
 *  图表名称
 */
@property (copy, nonatomic) NSString * chartTitle;


/**
 *  The fontsize of Y line text.Default id 8;
 */
@property (nonatomic,assign) CGFloat yDescTextFontSize;



/**
 *  The fontsize of X line text.Default id 8;
 */
@property (nonatomic,assign) CGFloat xDescTextFontSize;


/**
 *  X, Y axis line color
 */
@property (nonatomic, strong) UIColor * xAndYLineColor;


/**
 *  Start drawing chart.
 */
- (void)showViewWithAnimation;

/**
 *  Clear current chart when refresh
 */
- (void)clearAllViewOrLayer;


/**
 *  According to the relevant conditions to determine the width of the text
 *  @param maxSize：Maximum range of text
 *  @param textFont：Text font
 *  @param aimString:Text that needs to be measured
 */
- (CGSize)sizeOfStringWithMaxSize:(CGSize)maxSize
                         textFont:(CGFloat)fontSize
                        aimString:(NSString *)aimString;

@end
