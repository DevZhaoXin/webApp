//
//  ViewController.m
//  stackOverflow
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Person+Category.h"
#import <objc/runtime.h>

@interface ViewController ()

@property (nonatomic, strong) UIButton *btn1;

@property (nonatomic, strong) UIButton *btn2;

@property (nonatomic, strong) UIButton *btn3;

@property (nonatomic, strong) UIButton *btn4;

@property (nonatomic, strong) UIButton *btn5;

@property (nonatomic, strong) UIButton *btn6;

@end

@implementation ViewController
{
    Person *person; // 创建一个person实例
}

- (UIButton *)btn1 {
    if (!_btn1) {
        _btn1 = [[UIButton alloc] init];
        [_btn1 setTitle:@"获取所有变量" forState:UIControlStateNormal];
        [self.view addSubview:_btn1];
        [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 20));
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(40);
        }];
    }
    return _btn1;
}

- (UIButton *)btn2 {
    if (!_btn2) {
        _btn2 = [[UIButton alloc] init];
        [_btn2 setTitle:@"获取所有方法" forState:UIControlStateNormal];
        [self.view addSubview:_btn2];
        [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 20));
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(70);
        }];
    }
    return _btn2;
}

- (UIButton *)btn3 {
    if (!_btn3) {
        _btn3 = [[UIButton alloc] init];
        [_btn3 setTitle:@"改变私有变量name的值" forState:UIControlStateNormal];
        [self.view addSubview:_btn3];
        [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 20));
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(100);
        }];
    }
    return _btn3;
}

- (UIButton *)btn4 {
    if (!_btn4) {
        _btn4 = [[UIButton alloc] init];
        [_btn4 setTitle:@"添加一个新的属性" forState:UIControlStateNormal];
        [self.view addSubview:_btn4];
        [_btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 20));
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(130);
        }];
    }
    return _btn4;
}

- (UIButton *)btn5 {
    if (!_btn5) {
        _btn5 = [[UIButton alloc] init];
        [_btn5 setTitle:@"添加一个新的方法" forState:UIControlStateNormal];
        [self.view addSubview:_btn5];
        [_btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 20));
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(160);
        }];
    }
    return _btn5;
}

- (UIButton *)btn6 {
    if (!_btn6) {
        _btn6 = [[UIButton alloc] init];
        [_btn6 setTitle:@"交换两个方法功能" forState:UIControlStateNormal];
        [self.view addSubview:_btn6];
        [_btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 20));
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(190);
        }];
    }
    return _btn6;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btn1 addTarget:self action:@selector(getAllVariable) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:@selector(getAllMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.btn3 addTarget:self action:@selector(changeVariable) forControlEvents:UIControlEventTouchUpInside];
    [self.btn4 addTarget:self action:@selector(addVariable) forControlEvents:UIControlEventTouchUpInside];
    [self.btn5 addTarget:self action:@selector(addMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.btn6 addTarget:self action:@selector(replacemethod) forControlEvents:UIControlEventTouchUpInside];
    
    person = [[Person alloc] init]; // 初始化person类
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

// 1.获取person所有成员变量
- (void)getAllVariable {
    unsigned int count = 0;
    // 获取类的一个包含所有属性变量的列表，IVar是runtime声明的一个宏，实例变量的意思
    Ivar *allVariable = class_copyIvarList([Person class], &count);
    
    for (int i = 0; i < count; i++) {
        // 便利每一个变量，包含名称和类型（此处没有“*”）
        Ivar ivar = allVariable[i];
        const char *variablename = ivar_getName(ivar); // 获取成员变量名称
        const char *variableType = ivar_getTypeEncoding(ivar); // 获取成员变量类型
        NSLog(@"成员变量名称：%s  ------- 成员变量类型: %s", variablename, variableType);
    }
}

// 2.获取person所有方法
- (void)getAllMethod {
    unsigned int count;
    // 获取方法列表，所有在.m文件显式实现的方法都会被找到，包括setter和getter方法;
    Method *allMethods = class_copyMethodList([Person class], &count);
    for (int i = 0; i < count; i++) {
        // Method: runtime声明的一个宏，表示一个方法
        Method md = allMethods[i];
        // 获取SEL: SEL类型，即获取方法选择器@selector()
        SEL sel = method_getName(md);
        // 得到sel的方法名：以字符串格式获取sel的name，也即@selector()中的方法名称
        const char *methodName = sel_getName(sel);
        NSLog(@"方法名称: %s", methodName);
    }
}

// 3.改变person的name 变量属性
- (void)changeVariable {
    NSLog(@"改变之前的person: %@", person);
    
    unsigned int count = 0;
    Ivar *allIvarList = class_copyIvarList([person class], &count);
    
    // 从第一个方法getAllVariable中输出的控制台信息，可以看到name是第一个实例属性；
    Ivar iva = allIvarList[0];
    // name属性呗runtime强制改变   由原来的yang改为zhao
    object_setIvar(person, iva, @"zhao");
    NSLog(@"改变之后的person： %@", person);
    
}

// 4.添加新的属性
- (void)addVariable {
    person.height = 12; // 给分类中添加的新的属性复制 setter
    NSLog(@"%f", [person height]); // 访问新属性的值  getter
}

// 5.添加新的方法试试（等同于对父类添加分类对方法进行拓展）
- (void)addMethod {
    /*
     第一个参数表示Class cls类；
     第二个参数表示待调用的方法名称；
     第三个参数（IMP）myAddingFunction,IMP一个函数指针，这里表示制定具体实现方法myAddingFunction；
     第四个参数表方法的参数，0代表没有参数；
     */
    class_addMethod([person class], @selector(NewMethod), (IMP)myAddingFunction, 0);
    // 调用  如果使用[person method]方法（在ARC下回报no visible @interface错误）
    [person performSelector:@selector(NewMethod)];
}

int myAddingFunction(id self,SEL _cmd) {
    NSLog(@"已新增方法：NewMethod");
    return 1;
}

// 6.交换两种方法 (平时开发中一般放在类中的load方法中，好看一些)
- (void)replacemethod {
    
    Method method1 = class_getInstanceMethod([person class], @selector(func1));
    Method method2 = class_getInstanceMethod([person class], @selector(func2));
    
    NSLog(@"---------------------------");
    NSLog(@"方法未交换以前调用func1");
    [person func1];
    NSLog(@"---------------------------");
    
    method_exchangeImplementations(method1, method2); // 交换两个方法
    
    NSLog(@"---------------------------");
    NSLog(@"已交换func1和func2，下方一条打印是调用func1后的结果");
    [person func1];
    NSLog(@"---------------------------");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
