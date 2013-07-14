//
//  BRAPIClient.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/14/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRAPIClient.h"

@implementation BRAPIClient

#ifdef DEBUG
static NSString *base_url = @"http://localhost:3000";
#else
static NSString *base_url = @"https://api.brooch.mobi";
#endif

- (void)request:(NSString *)method
           path:(NSString *)path
         params:(NSDictionary *)params
        success:(SuccessHandler)successHandler
        failure:(FailureHandler)failureHandler
        error:(ErrorHandler)errorHandler
{
    dispatch_queue_t queue = dispatch_queue_create("mobi.brooch.BRAPIClient", NULL);
    dispatch_async(queue, ^{
        NSMutableArray *pairs = [NSMutableArray array];
        if (params) {
            for (NSString *key in [params keyEnumerator]) {
                [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, [params valueForKey:key]]];
            }
        }
    
        NSString *query   = [pairs componentsJoinedByString:@"&"];
        NSData *queryData = [query dataUsingEncoding:NSUTF8StringEncoding];
    
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[self buildURL:path]];
        [request setHTTPMethod:method];
        [request setHTTPBody:queryData];
    
        NSHTTPURLResponse *response;
        NSError *requestError;
    
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:&response
                                                           error:&requestError];

        if (requestError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                errorHandler(requestError);
            });
        }
        else {
            NSError *jsonError   = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];

            dispatch_async(dispatch_get_main_queue(), ^{
                if (jsonError) {
                    errorHandler(jsonError);
                }
                else if ([response statusCode] < 300) {
                    successHandler(response, result);
                }
                else {
                    failureHandler(response, result);
                }
            });
        }
    });
}

- (NSURL *)buildURL:(NSString *)path
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", base_url, path]];
}

@end
