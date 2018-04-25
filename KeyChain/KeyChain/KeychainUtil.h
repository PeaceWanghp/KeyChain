//
//  KeyChainUtil.h
//  KeyChain
//
//  Created by peace on 2018/4/25.
//  Copyright © 2018 peace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeychainUtil : NSObject

+ (BOOL)saveData:(id)data key:(NSString *)key;

+ (BOOL)deleteDataWithKey:(NSString *)key;

+ (id)dataWithKey:(NSString *)key;

@end
