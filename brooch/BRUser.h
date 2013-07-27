//
//  BRUser.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRAPIClient.h"

@interface BRUser : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *apiToken;

+ (BRUser *)sharedManager;
- (BOOL) isSignedIn;
- (void) saveUserData:(NSDictionary *)params;

- (void)createPost:(NSString *)text
            author:(NSString *)author
              tags:(NSArray *)tags
           success:(SuccessHandler)successHandler
           failure:(FailureHandler)failureHandler
             error:(ErrorHandler)errorHandler;

- (void)posts:(NSDictionary *)args
      success:(SuccessHandler)successHandler
      failure:(FailureHandler)failureHandler
        error:(ErrorHandler)errorHandler;

@end
