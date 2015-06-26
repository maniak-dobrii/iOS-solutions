IBInspectable+AccessibilityIdentifier
=============

Demonstrates ability to set UIView's accessibilityIdentifier from interface builder via IBInspectable.

This demo includes UIView category which allows to have currently unavailable in IB accessibilityIdentifier to be configured via Interface Builder. This allows setting accessibilityIdentifier for any UIView subclass via Interface Builder. Category does not introduce any additional properties or overrides, it just extends accessibilityIdentifier with IBInspectable attribute. This technique could be used for other properties or adding additional.
