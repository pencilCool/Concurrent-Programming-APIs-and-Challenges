//
//  pthreadTest.h
//  并发编程：API及挑战
//
//  Created by tangyuhua on 2016/11/12.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

#ifndef pthreadTest_h
#define pthreadTest_h

#include <stdio.h>
#include <stdlib.h>
#import <pthread.h>

#define MIN(a,b) (a<b? a:b)

#define MAX(a,b) (a>b? a:b)




struct threadInfo {
    uint32_t * inputValues;
    size_t count;
};

struct threadResult {
    uint32_t min;
    uint32_t max;
};

void * findMinAndMax(void *arg);

#endif /* pthreadTest_h */
