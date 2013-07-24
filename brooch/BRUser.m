//
//  BRUser.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRUser.h"

@interface BRUser ()

@property (nonatomic, strong) BRAPIClient *apiClient;

@end

@implementation BRUser

static NSString *userDefaultsKey = @"mobi.brooch.BRUser";
static BRUser *_sharedInstance = nil;

+ (BRUser *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[BRUser alloc] init];
        _sharedInstance.apiClient = [[BRAPIClient alloc] init];
        [_sharedInstance loadUserData];
    });

    return _sharedInstance;
}

- (void)loadUserData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userData = [defaults dictionaryForKey:userDefaultsKey];
    [self updateUserData:userData];
}

- (void)updateUserData:(NSDictionary *)userData
{
    self.userId    = [userData objectForKey:@"id"];
    self.name      = [userData objectForKey:@"name"];
    self.email     = [userData objectForKey:@"email"];
    self.apiToken  = [userData objectForKey:@"api_token"];
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

- (BOOL)isSignedIn
{
    return !!self.apiToken;
}

- (void)requestWithApiToken:(NSString *)method
                       path:(NSString *)path
                     params:(NSMutableDictionary *)params
                    success:(SuccessHandler)successHandler
                    failure:(FailureHandler)faulureHandler
                      error:(ErrorHandler)errorHandler
{
    [params setObject:self.apiToken forKey:@"api_token"];
    
}

- (void)createPost:(NSString *)text
            author:(NSString *)author
              tags:(NSArray *)tags
           success:(SuccessHandler)successHandler
           failure:(FailureHandler)failureHandler
             error:(ErrorHandler)errorHandler
{
    NSMutableDictionary *params = (NSMutableDictionary *)@{
        @"text":   text,
        @"author": author
    };

    [self.apiClient request:@"POST"
                       path:[NSString stringWithFormat:@"/users/%@/posts", self.userId]
                     params:params
                    success:successHandler
                    failure:failureHandler
                      error:errorHandler];
}

@end
