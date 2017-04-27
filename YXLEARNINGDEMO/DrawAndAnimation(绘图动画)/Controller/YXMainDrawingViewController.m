//
//  YXMainDrawingViewController.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/2/27.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import "YXMainDrawingViewController.h"
#import "YXDrawingViewController.h" //绘图
#import "YXGesturePasswordViewController.h" //手势密码
#import "YXGeetureViewController.h"

@interface YXMainDrawingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *cellNameArr;
@end

@implementation YXMainDrawingViewController

- (NSArray *)cellNameArr {
    if (_cellNameArr == nil) {
        self.cellNameArr = [NSArray arrayWithObjects:@"绘图", @"手势密码", nil];
    }
    return _cellNameArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绘图";
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellNameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cell_ID = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cell_ID];
    }
    cell.textLabel.text = self.cellNameArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        YXDrawingViewController *drawingVC = [[YXDrawingViewController alloc] init];
        [self.navigationController pushViewController:drawingVC animated:YES];
    } else if (indexPath.row == 1) {
        YXGeetureViewController *gesturePasswordVC = [[YXGeetureViewController alloc] init];
        [self.navigationController pushViewController:gesturePasswordVC animated:YES];
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
