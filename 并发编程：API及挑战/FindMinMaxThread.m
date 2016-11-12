//
//  FindMinMaxThread.m
//  并发编程：API及挑战
//
//  Created by tangyuhua on 2016/11/12.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

#import "FindMinMaxThread.h"

@implementation FindMinMaxThread {
    NSArray *_numbers;
}

- (instancetype)initWithNumbers:(NSArray *)numbers
{
    self = [super init];
    if (self) {
        _numbers = numbers;
    }
    return self;
}

- (void)main
{
    NSUInteger min = UINT32_MAX;
    NSUInteger max = 0;
    // 进行相关数据的处理
    
    
    for (int i=0; i<_numbers.count; ++i) {
        min = MIN(min, [_numbers[i] integerValue]);
        max = MAX(max, [_numbers[i] integerValue]);
    }

    self.min = min;
    self.max = max;
}


@end
