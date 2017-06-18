//
//  YXChartViewController.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/6/15.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import "YXChartViewController.h"
#import "YXChartShowViewController.h"

@interface YXChartViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *itemArr;//分区数组
@property (nonatomic, strong) UITableView *chartTableView;
@end

@implementation YXChartViewController

- (NSArray *)itemArr {
    if (!_itemArr) {
        _itemArr = @[@"折线图-第一象限",
                     @"折线图-第一二象限",
                     @"折线图第一四象限",
                     @"折线图-全象限",
                     @"饼图",
                     @"环状图",
                     @"柱状图",
                     @"表格",
                     @"雷达图",
                     @"散点图"];
    }
    return _itemArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"图表汇总";
    [self setUpTableView];
}

- (void)setUpTableView {
    self.chartTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStylePlain)];
    self.chartTableView.delegate = self;
    self.chartTableView.dataSource = self;
    [self.view addSubview:self.chartTableView];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cell_ID = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_ID];
    }
    cell.textLabel.text = self.itemArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YXChartShowViewController *showVC = [[YXChartShowViewController alloc] init];
    showVC.titleName = self.itemArr[indexPath.row];
    showVC.index = indexPath.row;
    [self.navigationController pushViewController:showVC animated:YES];
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
