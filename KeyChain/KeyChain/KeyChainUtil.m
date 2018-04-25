//
//  KeyChainUtil.m
//  KeyChain
//
//  Created by peace on 2018/4/25.
//  Copyright © 2018 peace. All rights reserved.
//

#import "KeyChainUtil.h"

@implementation KeyChainUtil

+ (BOOL)saveData:(id)data key:(NSString *)key {
    if ([self dataWithKey:key]) {
        return [self updateData:data key:key];
    }
    else {
        return [self addData:data key:key];
    }
}

+ (BOOL)addData:(id)data key:(NSString *)key {
    if (!key || ![key isKindOfClass:[NSString class]] || key.length == 0) {
        return NO;
    }
    
    if (!data) {
        return NO;
    }
    
    NSMutableDictionary *queryDictionary = [self queryWithKey:key];
    [queryDictionary setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    
    return SecItemAdd((CFDictionaryRef)queryDictionary, NULL) == noErr;
}

+ (BOOL)deleteDataWithKey:(NSString *)key {
    if (!key || ![key isKindOfClass:[NSString class]] || key.length == 0) {
        return NO;
    }

    return SecItemDelete((CFDictionaryRef)[self queryWithKey:key]) == noErr;
}

+ (BOOL)updateData:(id)data key:(NSString *)key {
    if (!key || ![key isKindOfClass:[NSString class]] || key.length == 0) {
        return NO;
    }
    
    if (!data) {
        return NO;
    }
    
    NSMutableDictionary *queryDictionary = [self queryWithKey:key];
    NSMutableDictionary *updateDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSKeyedArchiver archivedDataWithRootObject:data],(id)kSecValueData, nil];
    return SecItemUpdate((CFDictionaryRef)queryDictionary,(CFDictionaryRef)updateDictionary) == errSecSuccess;
}

+ (id)dataWithKey:(NSString *)key {
    if (!key || ![key isKindOfClass:[NSString class]] || key.length == 0) {
        return nil;
    }
    
    NSMutableDictionary *queryDictionary = [self queryWithKey:key];
    [queryDictionary setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [queryDictionary setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)queryDictionary, (CFTypeRef *)&keyData) == noErr) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
    }
    if (keyData) {
        CFRelease(keyData);
    }
    
    return nil;
}

+ (NSMutableDictionary *)queryWithKey:(NSString *)key {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,kSecClass,
            key,kSecAttrService,
            key,kSecAttrAccount,
            kSecAttrAccessibleAfterFirstUnlock,kSecAttrAccessible,
            nil];
}

@end
