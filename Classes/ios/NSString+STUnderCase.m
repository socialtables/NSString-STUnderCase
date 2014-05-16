// The MIT License
//
// Copyright (c) 2014 Social Tables
//
// Based on http://walkingsmarts.com/camelcasing-and-underscoring-strings-in-objectivec/
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

#import "NSString+STUnderCase.h"

@implementation NSString (STUnderCase)

- (NSString *)camelCaseStringWithOptions:(STUnderCaseOption)option {
    // First get a copy of the string, encoded as UTF-8 bytes (we're
    // really expecting ASCII here)
    char *orig = (char *)[self UTF8String];

    size_t len = strlen(orig);
    size_t maxlen = ((sizeof(*orig) * len) + 1);

    // We need to work off a copy that uses memory *we* own, so we have to
    // allocate it ourselves
    char *src = malloc(maxlen);
    bzero(src, maxlen);
    strncpy(src, orig, len);

    char *dst = malloc(maxlen);
    bzero(dst, maxlen);
    char *dstp = dst;

    char *word = NULL;
    int firstword = 1;
    size_t wordlen = 0;
    size_t newlen = 0;

    for (word = strsep(&src, "_"); word != NULL; word = strsep(&src, "_")) {
        if ((option == STUnderCaseOptionClass) || (!firstword)) {
            if (word[0] > 96 && word[0] < 123) {  // Is it lowercase ASCII?
                word[0] -= 32;
            }
        }
        wordlen = strlen(word);
        strncpy(dstp, word, wordlen);
        dstp += wordlen;
        newlen += wordlen;
        firstword = 0;
    }

    // Now create the result NSString -- note this is owned by ARC
    NSString *result = [[NSString alloc] initWithBytes:dst length:newlen encoding:NSUTF8StringEncoding];
    // Don't forget to free allocated memory!
    free(dst); free(src);
    return result;
}


- (NSString *)camelCaseString {
    return [self camelCaseStringWithOptions:STUnderCaseOptionAttribute];
}


- (NSString *)underscoreString {
    char *orig = (char *)[self UTF8String];
    size_t len = strlen(orig);

    // We need the copy to make sure we're working on memory _we_ own, and as
    // we don't know how many underscores we'll have to be insert we stay on
    // the safe side with the maximum length
    char *src = malloc(len * 2);
    bzero(src, len * 2);

    strncpy(src, orig, len);

    char *dst = malloc(len * 2);
    bzero(dst, len * 2);

    char *srcp;
    char *dstp;

    for (srcp = src, dstp = dst; (srcp - src) < len; srcp++, dstp++) {
        if ((*srcp > 64) && (*srcp < 91)) { // Is it uppercase ASCII?
            (*srcp) += 32;
            if ((srcp != src) && (*(srcp - 1) != '_')) {
                (*dstp) = '_';
                dstp++;
            }
          }
        (*dstp) = (*srcp);
    }

    NSString *result = [NSString stringWithUTF8String:dst];
    // Don't forget to free allocated memory!
    free(dst); free(src);
    return result;
}

@end
