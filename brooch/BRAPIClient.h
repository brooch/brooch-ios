//
//  BRAPIClient.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/14/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessHandler)(NSHTTPURLResponse *response, NSDictionary *result);
typedef void (^FailureHandler)(NSHTTPURLResponse *response, NSDictionary *result);
typedef void (^ErrorHandler)(NSError *error);

@interface BRAPIClient : NSObject

- (void)request:(NSString *)method
           path:(NSString *)path
         params:(NSDictionary *)params
        success:(SuccessHandler)successHandler
        failure:(FailureHandler)faulureHandler
          error:(ErrorHandler)errorHandler;

- (void)signUp:(NSDictionary *)params
       success:(SuccessHandler)successHandler
       failure:(FailureHandler)faulureHandler
         error:(ErrorHandler)errorHandler;

- (void)signIn:(NSDictionary *)params
       success:(SuccessHandler)successHandler
       failure:(FailureHandler)faulureHandler
         error:(ErrorHandler)errorHandler;

@end
