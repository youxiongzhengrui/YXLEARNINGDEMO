//
//  NSObject+YXKeyValues.h
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/6/14.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YXKeyValues)

+ (id)objectWithKeyValues:(NSDictionary *)dict;

- (NSDictionary *)keyValuesWithObject;

@end
