//
//  YXRootViewController.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 16/9/7.
//  Copyright © 2016年 ~YXzr~. All rights reserved.
//

#import "YXRootViewController.h"
#import "YXMainDrawingViewController.h"
#import "YXRunTimeViewController.h"
#import "YXGCDViewController.h"

@interface YXRootViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *rootTableView;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation YXRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"~YXzr~";
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.titleArray = @[@"绘图动画", @"RunTime", @"GCD"];
}

#pragma mark - UITableViewDelegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        YXMainDrawingViewController *mainDrawingVC = [[YXMainDrawingViewController alloc] init];
        [self.navigationController pushViewController:mainDrawingVC animated:YES];
    } else if (indexPath.row == 2) {
        YXGCDViewController *gcdVC = [[YXGCDViewController alloc] init];
        [self.navigationController pushViewController:gcdVC animated:YES];
    }
    // else if (indexPath.row == 1) {
//        YXRunTimeViewController *runTimeVC = [[YXRunTimeViewController alloc] init];
//        [self.navigationController pushViewController:runTimeVC animated:YES];
//    }
    
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
