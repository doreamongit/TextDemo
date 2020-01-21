//
//  NSObject+HookAlloc.m
//  TestDemo
//
//  Created by 孟庆宇 on 2020/1/20.
//  Copyright © 2020 Damon. All rights reserved.
//

#import "NSObject+HookAlloc.h"
#import <objc/runtime.h>

//static CFArrayRef recordClassPrefixes = NULL;

@implementation NSObject(HookAlloc)

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

static inline void SwizzleClassMethod(Class c, SEL origSEL, SEL newSEL)
{
    Method origMethod = class_getClassMethod(c, origSEL);
    Method newMethod = class_getClassMethod(c, newSEL);
    
//    if (class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(origMethod))) {
//        class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(newMethod));
//    } else {
        method_exchangeImplementations(origMethod, newMethod);
//    }
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SwizzleClassMethod([self class], @selector(alloc), @selector(allocCustom));
        
//        Method original = class_getClassMethod(self, @selector(alloc));
//        Method swizzle  = class_getClassMethod(self, @selector(allocCustom));
//        method_exchangeImplementations(original, swizzle);
    });
}

+ (id)allocCustom
{
//    NSLog(@"%s", __FUNCTION__); // no way
//    return [self allocCustom];
    
    Class cls = object_getClass(self);
    CFStringRef className = createCFString(class_getName(cls));
    if (!className) {
        return [self allocCustom];
    }
    if (CFStringCompare(className, CFSTR("NSAutoreleasePool"), kCFCompareBackwards) == kCFCompareEqualTo) {
        return [self allocCustom];
    }
    if (CFStringCompare(className, CFSTR("NSThread"), kCFCompareBackwards) == kCFCompareEqualTo) {
        return [self allocCustom];
    }
    
    NSObject *obj = [self allocCustom];
    
    NSArray *subAry = [NSThread callStackSymbols];
//    if (subAry.count>1) {
//        NSString *str = subAry[1];
//        NSLog(@"---:%@",str);
//    }
    
    return obj;
}

+ (NSObject *)qy_alloc
{
    Class cls = object_getClass(self);
    CFStringRef className = createCFString(class_getName(cls));
    if (!className) {
        return [NSObject qy_alloc];
    }
    if (CFStringCompare(className, CFSTR("NSAutoreleasePool"), kCFCompareBackwards) == kCFCompareEqualTo) {
        return [NSObject qy_alloc];
    }
    
    NSObject *obj = [NSObject qy_alloc];
    
    NSArray *subAry = [NSThread callStackSymbols];
    if (subAry.count>1) {
        NSString *str = subAry[1];
        NSString *pattern = @"(\\[.*\\])|[a-zA-Z]+|(0x.*?\\s)";
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: pattern options: NSRegularExpressionAnchorsMatchLines error: &error];
        NSArray *match = [regex matchesInString:str options:NSMatchingReportCompletion range: NSMakeRange(0, [str length])];
        
        NSMutableString *infoStr = [NSMutableString string];
        for (NSTextCheckingResult *res in match) {
            NSString *subStr = [str substringWithRange:res.range];
            [infoStr appendFormat:@"%@\t",subStr];
        }
        
        NSLog(@"--23534---:%@",infoStr);
    }
    
    return obj;
}

-(NSString *)debugIdentifier
{
    return objc_getAssociatedObject(self, @selector(debugIdentifier));
}

-(void)setDebugIdentifier:(NSString *)debugIdentifier
{
    objc_setAssociatedObject(self, @selector(debugIdentifier), debugIdentifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@", self.debugIdentifier, [self description]];
}

static inline CFStringRef createCFString(const char *cStr)
{
    return CFStringCreateWithCString(NULL, cStr, kCFStringEncodingUTF8);
}
//
//bool canRecordObject(id obj)
//{
//    if ([obj isProxy]) {
//        // NSProxy sub classes will cause crash when calling class_getName on its class
//        return false;
//    }
//
//    Class cls = object_getClass(obj);
//
//    bool canRecord = true;
//    CFStringRef className = createCFString(class_getName(cls));
//    if (!className) {
//        return false;
//    }
//
//    if (CFStringCompare(className, CFSTR("NSAutoreleasePool"), kCFCompareBackwards) == kCFCompareEqualTo) {
//        return false;
//    }
//
//    if (recordClassPrefixes) {
//        for (int i = 0; i < CFArrayGetCount(recordClassPrefixes); i++) {
//            CFStringRef prefix = CFArrayGetValueAtIndex(recordClassPrefixes, i);
//            canRecord = CFStringHasPrefix(className, prefix);
//            if (canRecord) {
//                break;
//            }
//        }
//    }
//
//    return canRecord;
//}
//
//+ (void)addClassPrefixesToRecord:(NSArray *)prefixes
//{
//    @synchronized(self) {
//        if ([prefixes count] > 0) {
//            if (recordClassPrefixes) {
//                NSMutableSet *existing = [NSMutableSet setWithArray:(__bridge NSArray*)recordClassPrefixes];
//                [existing addObjectsFromArray:prefixes];
//                recordClassPrefixes = (__bridge CFArrayRef)[[existing allObjects] copy];
//            } else {
//                recordClassPrefixes = (__bridge CFArrayRef)[prefixes copy];
//            }
//        }
//    }
//}
//
//+ (void)removeAllClassPrefixesToRecord
//{
//    recordClassPrefixes = NULL;
//}

@end
