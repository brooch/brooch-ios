//
//  BRUserModel.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRUserModel.h"

@interface BRUserModel ()

@property (nonatomic, strong) BRAPIClient *apiClient;

@end

@implementation BRUserModel

static NSString *userDefaultsKey = @"mobi.brooch.BRUserModel";
static BRUserModel *_sharedInstance = nil;

+ (BRUserModel *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[BRUserModel alloc] init];
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
                     params:(NSDictionary *)params
                    success:(SuccessHandler)successHandler
                    failure:(FailureHandler)failureHandler
                      error:(ErrorHandler)errorHandler
{
    NSMutableDictionary *paramsWithApiToken = [params mutableCopy];
    [paramsWithApiToken setObject:self.apiToken forKey:@"api_token"];

    [self.apiClient request:method
                       path:path
                     params:(NSDictionary *)paramsWithApiToken
                    success:successHandler
                    failure:failureHandler
                      error:errorHandler];
}

- (void)createPost:(BRPostModel *)post
           success:(SuccessHandler)successHandler
           failure:(FailureHandler)failureHandler
             error:(ErrorHandler)errorHandler
{
    NSDictionary *params = @{
        @"text":     post.text,
        @"author":   post.author[@"name"],
        @"image_id": [NSString stringWithFormat:@"%@", post.imageId]
    };

    [self requestWithApiToken:@"POST"
                         path:[NSString stringWithFormat:@"/users/%@/posts", self.userId]
                       params:params
                      success:successHandler
                      failure:failureHandler
                        error:errorHandler];
}

- (void)updatePost:(BRPostModel *)post
           success:(SuccessHandler)successHandler
           failure:(FailureHandler)failureHandler
             error:(ErrorHandler)errorHandler
{
    NSDictionary *params = @{
        @"text":     post.text,
        @"author":   post.author[@"name"],
        @"image_id": [NSString stringWithFormat:@"%@", post.imageId]
    };
    
    [self requestWithApiToken:@"POST"
                         path:[NSString stringWithFormat:@"/users/%@/posts/%@", self.userId, post.postId]
                       params:params
                      success:successHandler
                      failure:failureHandler
                        error:errorHandler];
}

- (void)posts:(NSDictionary *)args
      success:(SuccessHandler)successHandler
      failure:(FailureHandler)failureHandler
        error:(ErrorHandler)errorHandler
{
    NSDictionary *params = @{
        @"offset": [NSString stringWithFormat:@"%@", [args objectForKey:@"offset"]],
        @"limit":  [NSString stringWithFormat:@"%@", [args objectForKey:@"limit"]]
    };
    
    [self requestWithApiToken:@"GET"
                         path:[NSString stringWithFormat:@"/users/%@/posts", self.userId]
                       params:params
                      success:successHandler
                      failure:failureHandler
                        error:errorHandler];
}

@end
