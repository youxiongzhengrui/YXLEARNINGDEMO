//
//  YXSixTypeDrawingView.h
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 16/10/10.
//  Copyright © 2016年 ~YXzr~. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXSixTypeDrawingView : UIView

@end
/*
 *  第一种UIKit框架drawRect:
 *  第二种Core Graphics框架inContext:
 *  第三种UIKit框架inContext:
 *  第四种Core Graphics框架inContext:
 *  第五种UIKit框架UIGraphicsBeginImageContextWithOptions
 *  第六种Core Graphics框架UIGraphicsBeginImageContextWithOptions
 *
 *
 */

// 第三种UIKit框架inContext:
// 1、直接声明一个Layer类, 然后视图的Layer直接添加子layer
@interface TestLayer : CALayer

@end

// 2、声明layer代理
@interface DrawLayerDelegate : NSObject

@end






