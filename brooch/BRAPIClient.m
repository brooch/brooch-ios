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
static NSString *base_url = @"http://localhost:3000/v1";
#else
static NSString *base_url = @"https://brooch-kentaro.sqale.jp/v1";
#endif

- (void)signUp:(NSDictionary *)params
        success:(SuccessHandler)successHandler
        failure:(FailureHandler)failureHandler
          error:(ErrorHandler)errorHandler
{
    [self request:@"POST"
             path:@"/users"
           params:params
          success:successHandler
          failure:failureHandler
            error:errorHandler];
}

- (void)signIn:(NSDictionary *)params
       success:(SuccessHandler)successHandler
       failure:(FailureHandler)failureHandler
         error:(ErrorHandler)errorHandler
{
    [self request:@"POST"
             path:@"/signin"
           params:params
          success:successHandler
          failure:failureHandler
            error:errorHandler];
}

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
                [pairs addObject:[NSString stringWithFormat:@"%@=%@", [self encodeURLComponent:key], [self encodeURLComponent:[params valueForKey:key]]]];
            }
        }

        NSString *query   = [pairs componentsJoinedByString:@"&"];
        NSData *queryData = [query dataUsingEncoding:NSUTF8StringEncoding];
    
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setHTTPMethod:method];

        if ([method isEqualToString:@"POST"]) {
            [request setURL:[self buildURL:path query:nil]];
            [request setHTTPBody:queryData];
        }
        else {
            [request setURL:[self buildURL:path query:query]];
        }
    
        NSHTTPURLResponse *response;
        NSError *requestError;
    
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                               returningResponse:&response
                                                           error:&requestError];

        if (requestError) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (errorHandler) {
                    errorHandler(requestError);
                }
                else {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通信エラー"
                                                                        message:@"通信中にエラーが発生しました。"
                                                                       delegate:nil
                                                              cancelButtonTitle:nil
                                                              otherButtonTitles:@"OK", nil];
                    [alertView show];
                }
            });
        }
        else {
            NSError *jsonError = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];

            dispatch_async(dispatch_get_main_queue(), ^{
                if (jsonError) {
                    if (errorHandler) {
                        errorHandler(jsonError);
                    }
                    else {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"レスポンスエラー"
                                                                            message:@"サーバからのレスポンスが不正です。"
                                                                           delegate:nil
                                                                  cancelButtonTitle:nil
                                                                  otherButtonTitles:@"OK", nil];
                        [alertView show];
                    }
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
            query:(NSString *)query
{
    if (query) {
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@", base_url, path, query]];
    }
    else {
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", base_url, path]];
    }
}

- (NSString *)encodeURLComponent:(NSString *)str
{
    CFStringRef strRef = CFURLCreateStringByAddingPercentEscapes(
        NULL,
        (CFStringRef)str,
        NULL,
        (CFStringRef)@"!*'();:@&=+$,/?%#[]~",
        kCFStringEncodingUTF8
    );
    NSString *encodedStr = [NSString stringWithString:(__bridge NSString *)strRef];
    CFRelease(strRef);
    return encodedStr;
}

@end
