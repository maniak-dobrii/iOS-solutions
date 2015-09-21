//
//  AppDelegate.m
//  ICU-plural-rules-demo
//
//  Created by Mikhail Solodovnichenko on 9/21/15.
//
//

#import "AppDelegate.h"
#import "uplurals_demo.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self demonstrate];

    return YES;
}

- (void)demonstrate
{
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"ru"];
    NSArray *values = @[@0, @1, @2, @5, @1.1];

    [values enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        double value = [obj doubleValue];
        NSString *form = getPluralForm(value, locale);

        NSLog(@"ICU plural form using '%@' locale for %g is '%@'", locale.localeIdentifier, value, form);
    }];
}

@end
