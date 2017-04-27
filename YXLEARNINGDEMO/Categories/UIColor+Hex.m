//
//  UIColor+Hex.m
//  imoffice
//
//  Created by zhanghao on 14-9-11.
//  Copyright (c) 2014年 IMO. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)hexStringToColor:(NSString *)stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    if ([cString length] < 6)
        return [UIColor blackColor];
    
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6)
        return [UIColor blackColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    
    NSString *bString = [cString substringWithRange:range];

    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((CGFloat) r / 255.0f)
                           green:((CGFloat) g / 255.0f)
                            blue:((CGFloat) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *)colorWithHexNumber:(NSUInteger)hexColor {
    CGFloat r = ((hexColor >> 16) & 0xFF) / 255.0f;
    CGFloat g = ((hexColor >> 8) & 0xFF) / 255.0f;
    CGFloat b = (hexColor & 0xFF) / 255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}

@end
