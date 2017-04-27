//
//  YXGeetureViewController.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/2/27.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import "YXGeetureViewController.h"
#import "YXGestureView.h"

@interface YXGeetureViewController ()
@property (nonatomic, strong) YXGestureView *gestureView;
@end

@implementation YXGeetureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YXGestureView *ds = [[YXGestureView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
    [self.view addSubview:ds];

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
