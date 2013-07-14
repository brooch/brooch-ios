//
//  BRUser.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRUser : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *api_token;

+ (BRUser *)sharedManager;
- (BOOL) isSignedIn;
- (void) saveUserData:(NSDictionary *)params;

@end
