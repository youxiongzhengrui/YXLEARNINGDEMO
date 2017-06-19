//
//  YXChartShowViewController.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/6/15.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import "YXChartShowViewController.h"
#import "YXBarChartView.h"//柱状图

@interface YXChartShowViewController ()

@end

@implementation YXChartShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = self.titleName;
    switch (self.index) {
        case 0:
        {
            [self showFirstQuardrant];
        } break;
        case 6:
        {
            [self showColumnView];
        } break;
        default:
            break;
    }
}

- (void)showFirstQuardrant {
    
}

//柱状图
- (void)showColumnView {
    YXBarChartView *barChartView = [[YXBarChartView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 320)];
    barChartView.bgVewBackgoundColor = [UIColor whiteColor];
     barChartView.originSize = Point_M(30, 20);
    barChartView.valueArr = @[
                        @[@12],
                        @[@22],
                        @[@15],
                        @[@21],
                        @[@19],
                        @[@12],
                        @[@15],
                        @[@9],
                        @[@8],
                        @[@6],
                        @[@9],
                        @[@18],
                        @[@23],
                        ];
    barChartView.typeSpace = 10;
    barChartView.columnWidth = 30;
    barChartView.isShowYLine = YES;
    barChartView.drawTextColorForX_Y = [UIColor blackColor];
    barChartView.colorForXYLine = [UIColor darkGrayColor];
    barChartView.columnBGcolorsArr = @[[UIColor colorWithRed:72/256.0 green:200.0/256 blue:255.0/256 alpha:1],[UIColor greenColor],[UIColor orangeColor]];
    barChartView.xShowInfoText = @[@"A班级",@"B班级",@"C班级",@"D班级",@"E班级",@"F班级",@"G班级",@"H班级",@"I班级",@"J班级",@"L班级",@"M班级",@"N班级"];
    barChartView.isShowLineChart = YES;
    barChartView.lineValueArray =  @[@6,
                                   @12,
                                   @10,
                                   @1,
                                   @9,
                                   @5,
                                   @9,
                                   @9,
                                   @5,
                                   @6,
                                   @4,
                                   @8,
                                   @11];

    [barChartView showViewWithAnimation];
    [self.view addSubview:barChartView];
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
