//
//  pthreadTest.c
//  并发编程：API及挑战
//
//  Created by tangyuhua on 2016/11/12.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

#include "pthreadTest.h"



void * findMinAndMax(void *arg)
{
    struct threadInfo const * const info = (struct threadInfo *) arg;
    uint32_t min = UINT32_MAX;
    uint32_t max = 0;
    for (size_t i = 0; i < info->count; ++i) {
        uint32_t v = info->inputValues[i];
        min = MIN(min, v);
        max = MAX(max, v);
        
 
    }
    free(arg);
    struct threadResult * const result = (struct threadResult *) malloc(sizeof(*result));
    result->min = min;
    result->max = max;
    return result;
    
    
    
    
}

