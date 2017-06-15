//
//  NSObject+YXKeyValues.m
//  YXLEARNINGDEMO
//
//  Created by ~YXzr~ on 2017/6/14.
//  Copyright © 2017年 ~YXzr~. All rights reserved.
//

#import "NSObject+YXKeyValues.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (YXKeyValues)

+ (id)objectWithKeyValues:(NSDictionary *)dict {
    id objc = [[self alloc] init];
    for (NSString *key in dict.allKeys) {
        id value = dict[key];
        
        /*判断当前属性是不是Model*/
        objc_property_t property = class_getProperty(self, key.UTF8String);
        unsigned int outCount = 0;
        objc_property_attribute_t *attributeList = property_copyAttributeList(property, &outCount);
        objc_property_attribute_t attribute = attributeList[0];
        NSString *typeString = [NSString stringWithUTF8String:attribute.value];
        if ([typeString isEqualToString:@"@\"TestModel\""]) {
            value = [self objectWithKeyValues:value];
        }
        /**********************/
        
        //生成setter方法，并用objc_msgSend调用
        NSString *methodName = [NSString stringWithFormat:@"set%@%@:", [key substringToIndex:1].uppercaseString, [key substringFromIndex:1]];
//         NSString *methodName1 = [NSString stringWithFormat:@"set%@:", [key capitalizedString]];//capitalizedString返回每个单词首字母大写的字符串（每个单词的其余字母转换为小写）
        SEL setter = sel_registerName(methodName.UTF8String);
        if ([objc respondsToSelector:setter]) {
            ((void (*) (id, SEL, id)) objc_msgSend) (objc, setter, value);
        }
        free(attributeList);
    }
    return objc;
}

- (NSDictionary *)keyValuesWithObject {
    unsigned int outCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &outCount);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = propertyList[i];
        //生成getter方法，并用objc_msgSend调用
        const char *propertyName = property_getName(property);
        SEL getter = sel_registerName(propertyName);
        if ([self respondsToSelector:getter]) {
            id value = ((id (*) (id, SEL)) objc_msgSend)(self, getter);
            
            /*判断当前属性是不是Model*/
            if ([value isKindOfClass:[self class]] && value) {
                value = [value keyValuesWithObject];
            }
            /**********************/
            if (value) {
                NSString *key = [NSString stringWithUTF8String:propertyName];
                [dict setValue:value forKey:key];
            }
        }
    }
    free(propertyList);
    return dict;
}


@end
