//
//  BRPostDetailViewController.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/27/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRPostModel.h"

@interface BRPostDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *backgroundView;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *authorView;
@property (nonatomic, strong) BRPostModel *currentPost;

- (void)updateViewWith:(BRPostModel *)post;

@end
