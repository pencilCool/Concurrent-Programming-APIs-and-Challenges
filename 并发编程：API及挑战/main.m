//
//  main.m
//  并发编程：API及挑战
//
//  Created by tangyuhua on 2016/11/12.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "pthreadTest.h"
#import "FindMinMaxThread.h"
#import "MyOperation.h"

int main(int argc, const char * argv[]) {
    
#pragma mark - pthread
    
    NSLog(@"pthread: \n");
     size_t const count = 1000000;
    
    {
    
   
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
 
#pragma mark - NSThread
     NSLog(@"NSThread: \n");
    NSMutableArray *numbers = [NSMutableArray new];
    
    
    for (size_t i = 0; i < count; ++i) {
        int a = arc4random();
        NSNumber *numb = @(a);
        [numbers addObject:numb];
    }
    NSMutableSet *threads = [NSMutableSet set];
    NSUInteger numberCount = numbers.count;
    NSUInteger threadCount = 4;
    for (NSUInteger i = 0; i < threadCount; i++) {
        NSUInteger offset = (count / threadCount) * i;
        NSUInteger count = MIN(numberCount - offset, numberCount / threadCount);
        NSRange range = NSMakeRange(offset, count);
        NSArray *subset = [numbers subarrayWithRange:range];
        FindMinMaxThread *thread = [[FindMinMaxThread alloc] initWithNumbers:subset];
        [threads addObject:thread];
        [thread start];
    }
    
    //判断全部完成
    while (1) {
        BOOL finished = YES;
        for (FindMinMaxThread *thread in threads) {
            if (finished == NO) {
                break;
            }
            if (!thread.isFinished) {
                finished = NO;
            }
        }
        if (finished == YES) {
            break;
        };
    }
    //判断最大最小值
    NSUInteger nmin = UINT32_MAX;
    NSUInteger nmax = 0;
    for (FindMinMaxThread *thread in threads) {
        nmin = MIN(nmin, thread.min);
        nmax = MAX(nmax, thread.max);
    }
    NSLog(@"min : %ld",nmin);
    NSLog(@"max : %ld",nmax);
    
    
#pragma mark - NSOperation
    
    NSLog(@"NSOperation");
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    MyOperation *operation1 = [[MyOperation alloc] init];
    MyOperation *operation2 = [[MyOperation alloc] init];
    
    MyOperation *intermediateOperation = [[MyOperation alloc] init];
    
    MyOperation *finishedOperation = [[MyOperation alloc] init];
    
    [intermediateOperation addDependency:operation1];
    [intermediateOperation addDependency:operation2];
    [finishedOperation addDependency:intermediateOperation];
    
    [queue  addOperation:operation1];
    [queue  addOperation:operation2];
    [queue  addOperation:intermediateOperation];
    [queue  addOperation:finishedOperation];
    
    

    
    
    
    
    
    return NSApplicationMain(argc, argv);;
    

}
