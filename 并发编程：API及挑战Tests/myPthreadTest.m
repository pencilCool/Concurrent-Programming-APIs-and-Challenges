//
//  myPthreadTest.m
//  并发编程：API及挑战
//
//  Created by tangyuhua on 2016/11/12.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "pthreadTest.h"
@interface myPthreadTest : XCTestCase

@end

@implementation myPthreadTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {

    
    // 在这里测试是没有结果的，设计到runloop 和测试的一些关系：
    
    size_t const count = 1000000;
    uint32_t inputValues[count];
    
    // 使用随机数字填充 inputValues
    for (size_t i = 0; i < count; ++i) {
        inputValues[i] = arc4random();
    }
    
    // 开始4个寻找最小值和最大值的线程
    size_t const threadCount = 4;
    pthread_t tid[threadCount];
    for (size_t i = 0; i < threadCount; ++i) {
        struct threadInfo * const info = (struct threadInfo *) malloc(sizeof(*info));
        size_t offset = (count / threadCount) * i;
        info->inputValues = inputValues + offset;
        info->count = MIN(count - offset, count / threadCount);
        int err = pthread_create(tid + i, NULL, &findMinAndMax, info);
        NSCAssert(err == 0, @"pthread_create() failed: %d", err);
    }
    // 等待线程退出
    struct threadResult * results[threadCount];
    for (size_t i = 0; i < threadCount; ++i) {
        int err = pthread_join(tid[i], (void **) &(results[i]));
        NSCAssert(err == 0, @"pthread_join() failed: %d", err);
    }
    // 寻找 min 和 max
    uint32_t min = UINT32_MAX;
    uint32_t max = 0;
    for (size_t i = 0; i < threadCount; ++i) {
        min = MIN(min, results[i]->min);
        max = MAX(max, results[i]->max);
        free(results[i]);
        results[i] = NULL;
    }
    
    NSLog(@"min = %u", min);
    NSLog(@"max = %u", max);

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
