//
//  BRConfigViewController.h
//  brooch
//
//  Created by 栗林 健太郎 on 8/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@interface BRConfigViewController : UITableViewController  <UIAlertViewDelegate>

-(void)alertSignOut;

@property (strong, nonatomic) IBOutlet UITableViewCell *signOut;

@end