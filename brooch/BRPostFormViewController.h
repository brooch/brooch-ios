//
//  BRPostViewController.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/22/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRPostModel.h"
#import "BRTopViewController.h";

@interface BRPostFormViewController : UIViewController

@property (strong, nonatomic) BRTopViewController *topVC;
@property (strong, nonatomic) BRPostModel *post;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextView *textField;
@property (strong, nonatomic) IBOutlet UITextField *authorField;
@property (strong, nonatomic) NSNumber *imageId;

@end
