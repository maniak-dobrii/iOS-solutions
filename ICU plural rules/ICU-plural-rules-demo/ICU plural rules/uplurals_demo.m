//
//  uplurals_demo.m
//  ICU-plural-rules-demo
//
//  Created by Mikhail Solodovnichenko on 9/21/15.
//
//

#import "uplurals_demo.h"
#import "upluralrules.h"

NSString *getPluralForm(double value, NSLocale *locale)
{
    NSString *localeIdentifier = locale.localeIdentifier;

    // fallback to the language app is probably running in
    if(localeIdentifier == nil)
    {
        localeIdentifier = [[[NSBundle mainBundle] preferredLocalizations] firstObject];
    }

    // fallback to english if something is really weird
    if(localeIdentifier == nil)
    {
        localeIdentifier = @"en";
    }

    NSString *form = nil;

    UErrorCode status = U_ZERO_ERROR;
    // get plural rules for locale, guess this could be cached and could be expensive
    UPluralRules *pluralRules = uplrules_open([localeIdentifier cStringUsingEncoding:NSASCIIStringEncoding], &status);

    if(U_SUCCESS(status) && pluralRules != NULL)
    {
        status = U_ZERO_ERROR;
        int32_t capacity = 16; // fancy random capacity so that the biggest keyword could fit
        UChar keyword[capacity];

        // use plural rules to obtain plural form for value
        int32_t length = uplrules_select(pluralRules, value, keyword, capacity, &status);
        if(length > 0)
        {
            form = [[NSString alloc] initWithCharacters:keyword length:length];
        }

        uplrules_close(pluralRules);
    }

    // fallback to form "other" if something went wrong
    return form ?: @"other";
}