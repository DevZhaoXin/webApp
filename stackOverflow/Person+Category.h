//
//  Person+Category.h
//  stackOverflow
//
//  Created by yangzhaoxin on 2018/2/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "Person.h"

@interface Person (Category)

// 利用分类添加属性，使用runtime实现其setter,getter方法
@property (nonatomic, assign) float height;

@end
