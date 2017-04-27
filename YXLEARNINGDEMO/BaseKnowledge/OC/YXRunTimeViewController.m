//
//  YXRunTimeViewController.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/1/18.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import "YXRunTimeViewController.h"
#import <objc/runtime.h>

@interface YXRunTimeViewController ()

@end

@implementation YXRunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self getPropertyList];
}

- (void)getPropertyList {
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property-------%@", [NSString stringWithUTF8String:propertyName]);
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
