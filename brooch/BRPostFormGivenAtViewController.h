//
//  BRPostFormGivenAtViewController.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/31/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRPostFormGivenAtViewController : UIViewController

@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, strong) UILabel *parentGivenAtField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
