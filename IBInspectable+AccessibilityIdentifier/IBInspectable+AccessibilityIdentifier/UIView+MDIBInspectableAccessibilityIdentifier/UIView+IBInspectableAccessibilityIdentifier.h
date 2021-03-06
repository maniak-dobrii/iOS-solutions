//
//  UIView+IBInspectableAccessibilityIdentifier.h
//  IBInspectable+AccessibilityIdentifier
//
//  Created by Mikhail Solodovnichenko on 26/06/15.
//  Copyright (c) 2015 MDC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IBInspectableAccessibilityIdentifier)
@property(nonatomic, copy) IBInspectable NSString *accessibilityIdentifier;
@end
