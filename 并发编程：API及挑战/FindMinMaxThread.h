//
//  FindMinMaxThread.h
//  并发编程：API及挑战
//
//  Created by tangyuhua on 2016/11/12.
//  Copyright © 2016年 tangyuhua. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FindMinMaxThread : NSThread
@property (nonatomic) NSUInteger min;
@property (nonatomic) NSUInteger max;
- (instancetype)initWithNumbers:(NSArray *)numbers;
@end

