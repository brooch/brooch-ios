//
//  BRPostModel.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/30/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRPostModel.h"

@implementation BRPostModel

- (BRPostModel *)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.text   = dict[@"text"];
        self.author = dict[@"author"];
        self.tags   = dict[@"tags"];
    }
    
    return self;
}

@end
