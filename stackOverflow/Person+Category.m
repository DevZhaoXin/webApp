//
//  Person+Category.m
//  stackOverflow
//
//  Created by yangzhaoxin on 2018/2/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "Person+Category.h"
#import <objc/runtime.h>

// 用一个常量作为key，必须是C语言的字符串
const char *str = "myKey";

@implementation Person (Category)

- (void)setHeight:(float)height {
    NSNumber *num = [NSNumber numberWithFloat:height];
    /*
     第一个参数是需要添加属性的对象；
     第二个参数是关联属性需要的key；
     第三个属性是属性的值；
     第四个参数是使用策略，可根据开发需要选择不同的枚举。
     */
    // 属性和对象关联方法
    objc_setAssociatedObject(self, str, num, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (float)height {
    // 提取属性的值
    NSNumber *num = objc_getAssociatedObject(self, str);
    return [num floatValue];
}

@end
