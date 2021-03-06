//
//  BRPostModel.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/30/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRPostModel : NSObject

@property (nonatomic, strong) NSString            *postId;
@property (nonatomic, strong) NSString            *text;
@property (nonatomic, strong) NSMutableDictionary *author;
@property (nonatomic, strong) NSArray             *tags;
@property (nonatomic, strong) NSNumber            *imageId;

- (BRPostModel *)initWithDictionary:(NSDictionary *)dict;
- (NSString *)imageFileName;
- (UIImage *)imageAsUIImage;

@end
