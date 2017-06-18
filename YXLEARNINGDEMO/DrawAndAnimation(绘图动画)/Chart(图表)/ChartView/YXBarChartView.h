//
//  YXBarChartView.h
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/6/15.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import "YXChartView.h"

/**
    柱状图
 */
@interface YXBarChartView : YXChartView

/**
 Each histogram of the background color, if you do not set the default value for green. Setup must ensure that the number and type of the data source array are the same, otherwise the default is not set.
    每个直方图的背景颜色,如果你没有设置默认值为绿色。设置必须保证数据源的数量和类型数组是相同的(多个柱状图一组),否则默认没有设置。
 */
@property (nonatomic, strong) NSArray<NSArray *> * columnBGcolorsArr;

/**
    柱状图最大值上限数组，valueArr内部装的是数组
    Create an array of data sources, each array is a module data. For example, 
    the first array can represent the average score of a class of different 
    subjects, the next array represents the average score of different subjects
    in another class
 */
@property (nonatomic, strong) NSArray<NSArray *> * valueArr;

/**
 *  X axis classification of each icon (X轴每个图标分类名称)
 */
@property (nonatomic, strong) NSArray * xShowInfoText;


/**
 *  The background color of the content view （背景颜色）
 */
@property (nonatomic, strong) UIColor  * bgVewBackgoundColor;


/**
 *  Column spacing, non continuous, default is 5 (每个分类柱状图间的间距)
 */
@property (nonatomic, assign) CGFloat typeSpace;

/**
 *  The width of the column, the default is 40
 */
@property (nonatomic, assign) CGFloat columnWidth;

/**
 *  Whether the need for Y, X axis, the default YES
 */
@property (nonatomic, assign) BOOL needXandYLine;//是否需要XY轴线

/**
 *  Y, X axis line color
 */
@property (nonatomic, strong) UIColor * colorForXYLine;

/**
 *  X, Y axis text description color
 */
@property (nonatomic, strong) UIColor * drawTextColorForX_Y;

/**
 *  Dotted line guide color
 */
@property (nonatomic, strong) UIColor * dashColor;

/**
 *  The starting point, can be understood as the origin of the left and bottom margins
 */
@property (nonatomic, assign) CGPoint originSize;

/**
 *  Starting from the origin of the horizontal distance histogram
 */
@property (nonatomic, assign) CGFloat drawFromOriginX;

/**
 *  Whether this chart show Y line or not .Default is Yes
 */
@property (nonatomic,assign) BOOL isShowYLine;

/**
 *  Whether this chart show line or not.Default is NO;
 */
@property (nonatomic,assign) BOOL isShowLineChart;


/**
 *  If isShowLineChart proprety is YES,we need this value array to draw chart
 */
@property (nonatomic,strong)NSArray * lineValueArray;


/**
 *  If isShowLineChart proprety is Yes,we will draw path of this linechart with this color
 *  Default is blue
 */
@property (nonatomic,strong)UIColor * lineChartPathColor;

/**
 *  if isShowLineChart proprety is Yes,we will draw this linechart valuepoint with this color
 *  Default is yellow
 */
@property (nonatomic,strong)UIColor * lineChartValuePointColor;


@end
