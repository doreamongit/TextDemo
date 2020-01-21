//
//  NSObject+HookAlloc.h
//  TestDemo
//
//  Created by 孟庆宇 on 2020/1/20.
//  Copyright © 2020 Damon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(HookAlloc)

@property (strong, nonatomic) NSString *debugIdentifier;

- (NSString *)description;

@end

NS_ASSUME_NONNULL_END
