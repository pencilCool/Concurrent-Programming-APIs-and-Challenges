//
//  MyOperation.m
//  并发编程：API及挑战
//
//  Created by tangyuhua on 2016/11/12.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

#import "MyOperation.h"

@implementation MyOperation

- (void)main
{
//    // 进行处理 ...
//
//    while ( !self.isCancelled) {
//        // 进行处理
//    }
//
    NSLog(@"MyOperation main");
}

- (void)start{
    
   NSLog(@"MyOperation start");
}

- (void)finished
{
   NSLog(@"MyOperation finised");
}

- (NSString *)description{
//    可以很容易的标示出在某个队列中当前被调度的所有操作
    return @"this is My operation";
}
@end
