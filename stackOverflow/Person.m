//
//  Person.m
//  stackOverflow
//
//  Created by yangzhaoxin on 2018/2/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "Person.h"

@implementation Person
{
    NSString *name;
}

//初始化person属性
- (instancetype)init {
    self = [super init];
    if (self) {
        name = @"yang";
        self.age = 27;
    }
    return self;
}

// person的两个方法
- (void)func1 {
    NSLog(@"执行func1方法。");
}

- (void)func2 {
    NSLog(@"执行func2方法。");
}

// 输出person对象时的方法
- (NSString *)description {
    return [NSString stringWithFormat:@"name:%@ age:%d",name,self.age];
}

@end
