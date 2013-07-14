//
//  BRUser.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRUser : NSObject

+ (BRUser *)sharedManager;
- (BOOL) isSignedIn;

@end
