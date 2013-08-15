//
//  BRPostTableLoadMoreViewCell.h
//  brooch
//
//  Created by 栗林 健太郎 on 8/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRPostTableLoadMoreViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

- (void)startLoading;
- (void)endLoading;

@end
