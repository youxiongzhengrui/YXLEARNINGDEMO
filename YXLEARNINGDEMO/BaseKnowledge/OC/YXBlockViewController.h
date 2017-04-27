//
//  YXBlockViewController.h
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/2/13.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import <UIKit/UIKit.h>
// block，循环引用问题
@interface YXBlockViewController : UIViewController

@end

// 引用类
@interface YXShop : NSObject
@property (nonatomic, strong) NSString *string;
@property (nonatomic, copy) void(^myBlock)();
@end
