//
//  BRPostTableViewCell.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/31/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRPostModel.h"

@protocol BRPostTableViewCellDelegate <NSObject>

- (void)didPushDeletePostButton:(id)sender post:(BRPostModel *)post;

@end

@interface BRPostTableViewCell : UITableViewCell

@property (weak, nonatomic) id <BRPostTableViewCellDelegate> delegate;
@property (strong, nonatomic) BRPostModel *post;
@property (strong, nonatomic) IBOutlet UIView *slideView;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

- (void)showBackgroundView;
- (void)hideBackgroundView;

@end
