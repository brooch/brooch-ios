//
//  BRPostDetailTextView.m
//  brooch
//
//  Created by 栗林 健太郎 on 8/3/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRPostDetailTextView.h"

@interface UITextView ()

- (id)styleString;

@end

@implementation BRPostDetailTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)styleString {
    return [[super styleString] stringByAppendingString:@"; line-height: 2em"];
}

@end
