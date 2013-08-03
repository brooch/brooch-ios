//
//  BRPostFormImageViewController.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/31/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRPostFormViewController.h"

@interface BRPostFormImageViewController : UIViewController

@property (strong, nonatomic) BRPostModel *post;
@property (strong, nonatomic) IBOutlet UICollectionView *imagePicker;
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSArray *thumbs;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
