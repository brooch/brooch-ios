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
        self.text    = dict[@"text"];
        self.author  = dict[@"author"];
        self.tags    = dict[@"tags"];
        self.imageId = [NSNumber numberWithInt:[dict[@"image_id"] intValue]];
    }
    
    return self;
}

- (NSString *)imageFileName
{
    return [NSString stringWithFormat:@"image_bg_%@@2x.jpg", self.imageId];
}

- (UIImage *)imageAsUIImage
{
    NSString *fileName = self.imageFileName;
    return [UIImage imageNamed:fileName];
}

@end
