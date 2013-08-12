//
//  BRUserModel.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRAPIClient.h"
#import "BRPostModel.h"

@interface BRUserModel : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *apiToken;

+ (BRUserModel *)sharedManager;

- (BOOL) isSignedIn;
- (void) saveUserData:(NSDictionary *)params;

- (void)signUp:(NSDictionary *)params
       success:(SuccessHandler)successHandler
       failure:(FailureHandler)faulureHandler
         error:(ErrorHandler)errorHandler;

- (void)signIn:(NSDictionary *)params
       success:(SuccessHandler)successHandler
       failure:(FailureHandler)faulureHandler
         error:(ErrorHandler)errorHandler;

- (void)createPost:(BRPostModel *)post
           success:(SuccessHandler)successHandler
           failure:(FailureHandler)failureHandler
             error:(ErrorHandler)errorHandler;

- (void)updatePost:(BRPostModel *)post
           success:(SuccessHandler)successHandler
           failure:(FailureHandler)failureHandler
             error:(ErrorHandler)errorHandler;

- (void)deletePost:(BRPostModel *)post
           success:(SuccessHandler)successHandler
           failure:(FailureHandler)failureHandler
             error:(ErrorHandler)errorHandler;

- (void)posts:(NSDictionary *)args
      success:(SuccessHandler)successHandler
      failure:(FailureHandler)failureHandler
        error:(ErrorHandler)errorHandler;

@end
