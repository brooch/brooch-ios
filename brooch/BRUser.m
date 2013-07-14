//
//  BRUser.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRUser.h"

@implementation BRUser

static NSString *userDefaultsKey = @"mobi.brooch.BRUser";
static BRUser *_sharedInstance = nil;

+ (BRUser *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[BRUser alloc] init];
        [_sharedInstance loadUserData];
    });

    return _sharedInstance;
}

- (void)loadUserData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userData = [defaults dictionaryForKey:userDefaultsKey];
    NSLog(@"%@", userData);
    [self updateUserData:userData];
}

- (void)updateUserData:(NSDictionary *)userData
{
    self.userId    = [userData objectForKey:@"id"];
    self.name      = [userData objectForKey:@"name"];
    self.email     = [userData objectForKey:@"email"];
    self.api_token = [userData objectForKey:@"api_token"];
}

- (void)saveUserData:(NSDictionary *)userData
{
    [self updateUserData:userData];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userData forKey:userDefaultsKey];
    [defaults synchronize];
}

- (void)discardUserData
{
    NSDictionary *userData = @{};
    [self updateUserData:userData];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userData forKey:userDefaultsKey];
    [defaults synchronize];
}

- (BOOL) isSignedIn
{
    return !!self.api_token;
}

@end
