//
//  BRPostTableLoadMoreViewCell.m
//  brooch
//
//  Created by 栗林 健太郎 on 8/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRPostTableLoadMoreViewCell.h"

@implementation BRPostTableLoadMoreViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)startLoading
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

    // ここハードコーディングしたくないんだけどどうしたらいいの
    indicator.frame = CGRectMake(95, 13, 30, 30);

    [self.view addSubview:indicator];
    [self.view bringSubviewToFront:indicator];
    [indicator startAnimating];

    self.indicator = indicator;
}

- (void)endLoading
{
    if (self.indicator) {
        [self.indicator stopAnimating];
        [self.view sendSubviewToBack:self.indicator];
        self.indicator = nil;
    }
}

@end
