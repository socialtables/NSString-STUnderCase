// The MIT License
//
// Copyright (c) 2014 Social Tables
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

/**
  Defines the two styles in which a string can be camelCased: attribute style,
  i.e. "camelCase", or class style, i.e. "CamelCase"
  */
enum {
    STUnderCaseOptionAttribute,
    STUnderCaseOptionClass
};

typedef NSInteger STUnderCaseOption;

@interface NSString (STUnderCase)

/**
  Return the string camel-cased according to the passed style

  @param STUnderCaseOption Either `STUnderCaseOptionAttribute` or
    `STUnderCaseOptionClass`, to define the style in which camel-casing should
    be done

  @return NSString The string camel-cased appropriately
  @see `STUnderCaseOption`
  */
- (NSString *)camelCaseStringWithOptions:(STUnderCaseOption)option;

/**
  Return the string camel-cased using the default (attribute) style

  @return NSString The camel-cased string
  @see `camelCaseStringWithOptions`
  */
- (NSString *)camelCaseString;

/**
  Return the string transformed to underscores_separating_words style.

  @return The transformed string.
  */
- (NSString *)underscoreString;

@end
