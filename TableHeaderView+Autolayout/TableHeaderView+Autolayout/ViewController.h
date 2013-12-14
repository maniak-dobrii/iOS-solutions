//
//  ViewController.h
//  TableHeaderView+Autolayout
//
//  Created by MD on 12/14/13.
//  Copyright (c) 2013 MDC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) IBOutlet UIView* tableHeaderViewWrapper;

@property (nonatomic, strong) IBOutlet UILabel* headerLabel;
@end
