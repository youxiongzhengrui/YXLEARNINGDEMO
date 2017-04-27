//
//  YXBlockViewController.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/2/13.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import "YXBlockViewController.h"

@interface YXBlockViewController ()

@end

@implementation YXBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)testOne {
    YXShop *shop = [[YXShop alloc] init];
    shop.string = @"Happy new year";
    //如果block代码块的内部，使用了外面的强引用shop对象（也就是shop.myBlock代码块内部使用了NSLog(@"%@",shop.string);），block代码块的内部会自动产生一个强引用，引用着shop对象！所以上面的shop不会被销毁，造成循环引用！
    shop.myBlock = ^{
        NSLog(@"%@", shop.string); // 存在循环引用
    };
    shop.myBlock();
}

// 用__weak我这里声明了一个宏
//总结：Block内部使用外部的一个对象，如果外部对象是强引用那么内部会自动生成一个强引用，引用着外部对象。如果外部对象是弱引用那么内部会自动生成一个弱引用，引用着外部对象。
#define YXWeakSelf(type) __weak typeof(type) weak##type = type;
- (void)testTwo {
    YXShop *shop = [[YXShop alloc] init];
    shop.string = @"Happy new year";
    YXWeakSelf(shop);
    shop.myBlock = ^{
        NSLog(@"%@", weakshop.string);
    };
    shop.myBlock();
}

// __weak 与 __strong 一起使用
#define LRWeakSelf(type)  __weak typeof(type) weak##type = type;
#define LRStrongSelf(type)  __strong typeof(type) type = weak##type;
- (void)testThree {
    YXShop *shop = [[YXShop alloc]init];
    shop.string = @"welcome to our company";
    LRWeakSelf(shop);
    shop.myBlock = ^{
        LRStrongSelf(shop)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@",shop.string);
        });
    };
    shop.myBlock();
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


@implementation YXShop


@end



