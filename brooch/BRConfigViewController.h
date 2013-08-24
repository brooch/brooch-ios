//
//  BRConfigViewController.h
//  brooch
//
//  Created by 栗林 健太郎 on 8/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRConfigViewController : UITableViewController <UIAlertViewDelegate>

{
    UIButton *signoutbutton;
}


//buttonプロパティの宣言
@property(nonatomic, weak) IBOutlet UIButton *signOutButton;
//signoutbuttonがクリックされた時に呼ばれるメソッドの宣言
-(IBAction)respondToButtonClick:(id)sender;
//アラートがクリックされた時に呼ばれるメソッドの宣言
-(void)alertView;


@end
