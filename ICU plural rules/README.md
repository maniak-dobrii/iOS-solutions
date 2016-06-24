ICU plural rules
=============

Demonstrates number plural form determination via [ICU](http://site.icu-project.org/). Apple uses something like that to select correct string from `.stringsdict`.

Apple uses ICU's `uplrules_select` and friends for plural form selection, so I desided to try to access that features. 
Apple supplies required object code with `CoreFoundation` in `libicucore.A.dylib`. 
Unfortunately Apple does not provide **upluralrules.h** with required functions, so I had to add them by myself.

For more details see [Understanding iOS internationalization](http://maniak-dobrii.com/understanding-ios-internationalization/).
