//
//  BRUser.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRUser.h"

@implementation BRUser

static BRUser *_sharedInstance = nil;

+ (BRUser *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[BRUser alloc] init];
    });

    return _sharedInstance;
}

- (BOOL) isSignedIn
{
    return NO;
}

@end
