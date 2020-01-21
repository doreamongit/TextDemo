//
//  UIView+HookInit.m
//  TestDemo
//
//  Created by 孟庆宇 on 2020/1/20.
//  Copyright © 2020 Damon. All rights reserved.
//

#import "UIView+HookInit.h"
#import <objc/runtime.h>

@implementation UIView(HookInit)

static inline void SwizzleInstanceMethod(Class c, SEL origSEL, SEL newSEL)
{
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method newMethod = class_getInstanceMethod(c, newSEL);
    
    if (class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(origMethod))) {
        class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(newMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SwizzleInstanceMethod([self class], @selector(init), @selector(qy_init));
        SwizzleInstanceMethod([self class], @selector(initWithFrame:), @selector(qy_initWithFrame:));
        SwizzleInstanceMethod([self class], @selector(description), @selector(qy_description));
    });
}

-(UIView *)qy_init
{
    UIView *hookView = [self qy_init];
    [self setUpDebugIdentifier];
    
    return hookView;
}

-(UIView *)qy_initWithFrame:(CGRect)frame
{
    UIView *hookView = [self qy_initWithFrame:frame];
    [self setUpDebugIdentifier];
    
    return hookView;
}

- (void)setUpDebugIdentifier
{
    NSArray *subAry = [NSThread callStackSymbols];
    for (int index=2;index<subAry.count;index++) {
        
        NSString *str = subAry[index];
        
        NSString *pattern = @"(\\[.*\\])|[a-zA-Z]+|(0x.*?\\s)";
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: pattern options: NSRegularExpressionAnchorsMatchLines error: &error];
        NSArray *match = [regex matchesInString:str options:NSMatchingReportCompletion range: NSMakeRange(0, [str length])];
        
        if (match.count>0) {
            NSTextCheckingResult *res = match[0];
            NSString *subStr = [str substringWithRange:res.range];
            if ([subStr isEqualToString:@"UIKit"]) {
                continue ;
            }
        }
        
        NSMutableString *infoStr = [NSMutableString string];
        for (int index=0;index<match.count;index++) {
            if (index == 1) {
                continue ;
            }
            NSTextCheckingResult *res = match[index];
            NSString *subStr = [str substringWithRange:res.range];
            [infoStr appendFormat:@"%@\t",subStr];
        }
        self.debugIdentifier = infoStr;
        
        break ;
    }
}

-(NSString *)debugIdentifier
{
    return objc_getAssociatedObject(self, @selector(debugIdentifier));
}

-(void)setDebugIdentifier:(NSString *)debugIdentifier
{
    objc_setAssociatedObject(self, @selector(debugIdentifier), debugIdentifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)qy_description {
    return [NSString stringWithFormat:@"%@ %@", self.debugIdentifier, [self qy_description]];
}


@end
