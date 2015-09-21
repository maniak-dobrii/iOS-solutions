//
//  uplurals_demo.h
//  ICU-plural-rules-demo
//
//  Created by Mikhail Solodovnichenko on 9/21/15.
//
//

#import <Foundation/Foundation.h>

/**
 *  Returns plural form for given value according to plural
 *  rules for given locale. Rules are described here: http://cldr.unicode.org/index/cldr-spec/plural-rules
 *
 *  @param value  Number for which the rule has to be determined.
 *  @param locale Locale for which plural rules are desired.
 *
 *  @return ICU plural form.
 */
NSString *getPluralForm(double value, NSLocale *locale);
