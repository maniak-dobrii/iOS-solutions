//
//  ViewController.m
//  TableHeaderView+Autolayout
//
//  Created by MD on 12/14/13.
//  Copyright (c) 2013 MDC. All rights reserved.
//



/*
    1) Add a headerView to a UITableView.
    2) Add a subview to headerView, let's call it wrapper.
    3) Make wrapper's height be adjusted with it's subviews (via Auto Layout).
    4) When autolayout had finished layout, set headerView's height to wrapper's height. (see -updateTableViewHeaderViewHeight)
    5) Reset headerView. (see -resetTableViewHeaderView)
 
 
    All this works seamlessly after the initial autolayout pass. Later, if you change wrapper's contents so that it gains different
    height, it wont work for some reason (guess laying out UILabel requires several autolayout passes or something). I solved this
    with scheduling setNeedsLayout for the ViewController's view in the next run loop iteration.
 */



#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark Important stuff

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self updateTableViewHeaderViewHeight];
}

/**
 tableView's tableViewHeaderView contains wrapper view, which height is evaluated
 with Auto Layout. Here I use evaluated height and update tableView's tableViewHeaderView's frame.
 
 New height for tableViewHeaderView doesn't applies without magic, that's why I call -resetTableViewHeaderView.
 And again, this doesn't work due to some internals of UITableView, so -resetTableViewHeaderView call is scheduled
 in the main run loop just after it's the last iteration finishes.
 */
- (void)updateTableViewHeaderViewHeight
{
    // get height of the wrapper and apply it to a header
    CGRect Frame = self.tableView.tableHeaderView.frame;
    Frame.size.height = self.tableHeaderViewWrapper.frame.size.height;
    self.tableView.tableHeaderView.frame = Frame;
    
    // this magic applies the above changes
    // note, that if you won't schedule this call to the next run loop iteration
    // you'll get and error
    [self performSelector:@selector(resetTableViewHeaderView) withObject:self afterDelay:0];
}

// yeah, gues there's something special in the setter
- (void)resetTableViewHeaderView
{
    // whew, this could be animated!
    [UIView beginAnimations:@"tableHeaderView" context:nil];
    
        self.tableView.tableHeaderView = self.tableView.tableHeaderView;
    
    [UIView commitAnimations];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        self.headerLabel.text = @"waka!";
    }
    else
    {
        self.headerLabel.text = @"Dynamic text label, sooo long, that it wraps to the next line, just to show that it could have different height.";
    }
    
    // We need this to update the height, still not fully sure why do we need to
    // schedule this call for the next Run Loop iteration, will appreciate comments.
    [self.view performSelector:@selector(setNeedsLayout) withObject:nil afterDelay:0];
}









#pragma mark -
// some not interesting UITableView stuff
#pragma mark UITableView stuff
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    if(indexPath.row == 0)
    {
        cell.textLabel.text = @"Make text Short";
    }
    else
    {
        cell.textLabel.text = @"Make text Long";
    }
    
    
    return cell;
}



// some init stuff, which is just a boilerplate
#pragma mark Common init stuff
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
