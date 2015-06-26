//
//  ViewController.m
//  IBInspectable+AccessibilityIdentifier
//
//  Created by Mikhail Solodovnichenko on 26/06/15.
//  Copyright (c) 2015 MDC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
// greenWrapper's accessibilityIdentifier was set by IB
@property (nonatomic, weak) IBOutlet UIView *greenWrapper;
@property (nonatomic, weak) IBOutlet UILabel *identifierTitle;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // it was set from IB!
    self.identifierTitle.text = self.greenWrapper.accessibilityIdentifier;
}
@end
