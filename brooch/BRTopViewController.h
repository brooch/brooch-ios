//
//  BRViewController.h
//  brooch
//
//  Created by 栗林 健太郎 on 7/10/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRTopViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *listView;
@property (strong, nonatomic) NSMutableArray *posts;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *navBarRightButton;

@end
