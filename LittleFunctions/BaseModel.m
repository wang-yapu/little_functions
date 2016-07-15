//
//  BaseModel.m
//  imfine
//
//  Created by wangyapu on 16/7/15.
//  Copyright © 2016年 wangyapu. All rights reserved.
//

#import "BaseModel.h"

/**
 *  Model 的基类   
 *  只针对 NSString 和 NSNumber 类型进行优化,其余类型务必要在初始化方法里手写赋值!!!!
 *  只针对 NSString 和 NSNumber 类型进行优化,其余类型务必要在初始化方法里手写赋值!!!!
 *  只针对 NSString 和 NSNumber 类型进行优化,其余类型务必要在初始化方法里手写赋值!!!!
 *  提供一个 initWithDictionary: 初始化方法
 *  利用 runtime自动根据每个属性的类型给该属性赋值, 如果是字典的值非法, 字符串则赋值为@"", 数字则赋值为@0
 *  相当于实现了
 */
@implementation BaseModel

/**
 *  从 property_getAttributes 字符串获取里面的类型  例如 NSNumber NSString
 *
 *  @param attrutributeString property_getAttributes 字符串
 *
 *  @return 这个属性的类型
 */
- (NSString *)getClassStringFromAttrutributeString:(NSString *)attrutributeString{
    NSRange rangeBegin = [attrutributeString rangeOfString:@"T@\""];
    NSRange rangeEnd = [attrutributeString rangeOfString:@"\","];
    if (rangeBegin.length == 0 || rangeEnd.length == 0) {
        return @"";
    }
    NSInteger location = rangeBegin.location + rangeBegin.length;
    NSInteger length = rangeEnd.location - (rangeBegin.location + rangeBegin.length);
    NSString *class = [attrutributeString substringWithRange:NSMakeRange(location, length)];
    return class;
}
/**
 *  得到这个属性的 setter 方法
 *
 *  @param propertyName 属性的名字字符串
 *
 *  @return SEL 类型的方法名
 */
- (SEL)getSetterWithPropertyName: (NSString *) propertyName{
    //1.首字母大写
    NSString * firstLetter = [propertyName substringToIndex:1 ].uppercaseString;
    propertyName = [firstLetter stringByAppendingString:[propertyName substringFromIndex:1]];
    
    //2.拼接上set关键字
    propertyName = [NSString stringWithFormat:@"set%@:", propertyName];
    
    //3.返回set方法
    return NSSelectorFromString(propertyName);
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            const char *name = property_getName(property);
            const char *attrutribute = property_getAttributes(property);
            NSString *attrutributeString = [NSString stringWithCString:attrutribute encoding:NSUTF8StringEncoding];
            NSString *classString = [self getClassStringFromAttrutributeString:attrutributeString];
            // 这个属性名称的字符串
            NSString *propertyNameString = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            
            if ([classString isEqualToString:@"NSNumber"]) {
                SEL setSel = [self getSetterWithPropertyName:propertyNameString];
                id value = [NSNumber numberWithLongLong:[dictionary[propertyNameString] longLongValue]];
                if (dictionary[propertyNameString] != nil && ![dictionary[propertyNameString] isEqual:[NSNull null]]) {
                    [self performSelectorOnMainThread:setSel
                                           withObject:value
                                        waitUntilDone:[NSThread isMainThread]];
                }else{
                    [self performSelectorOnMainThread:setSel
                                           withObject:@0
                                        waitUntilDone:[NSThread isMainThread]];
                }
            }else if ([classString isEqualToString:@"NSString"]){
                SEL setSel = [self getSetterWithPropertyName:propertyNameString];
                id value = dictionary[propertyNameString];
                if (dictionary[propertyNameString] != nil && ![dictionary[propertyNameString] isEqual:[NSNull null]]) {
                    [self performSelectorOnMainThread:setSel
                                           withObject:value
                                        waitUntilDone:[NSThread isMainThread]];
                    
                }else{
                    [self performSelectorOnMainThread:setSel
                                           withObject:@""
                                        waitUntilDone:[NSThread isMainThread]];
                }
            }
        }
    }
    return self;
}
@end
