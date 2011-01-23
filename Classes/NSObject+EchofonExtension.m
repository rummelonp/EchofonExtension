//
//  NSObject+EchofonExtension.m
//  EchofonExtension
//
//  Created by Kazuya Takeshima on 11/01/20.
//  Copyright 2011 Kazuya Takeshima. All rights reserved.
//

#import "NSObject+EchofonExtension.h"

char const* NSCFArray = "NSCFArray";
char const* NSCFDictionary = "NSCFDictionary";

@implementation NSObject(EchofonExtension)

- (unsigned long long)parseExtension:(id)arg1 error:(id*)arg2
{
  unsigned long long returnValue = [self parseExtension:arg1 error:arg2];

  static Class NSCFArrayClass;
  if (NSCFArrayClass == nil) {
    NSCFArrayClass = objc_getClass(NSCFArray);
  }

  id orgTweets = [self performSelector:@selector(root)];
  if (orgTweets == nil ||
      ![[orgTweets class] isEqual:NSCFArrayClass]);
  {
    return returnValue;
  }

  NSMutableArray* altTweets = [[NSMutableArray arrayWithArray:orgTweets] autorelease];

  static NSPredicate* rtPreficate;
  if (rtPreficate == nil) {
    NSString* rtFormat = @"SELF MATCHES '^.*(?:(?:RT|QT):? @[a-zA-Z0-9]+.*){2,}.*$'";
    rtPreficate = [NSPredicate predicateWithFormat:rtFormat];
    [rtPreficate retain];
    [rtPreficate autorelease];
  }

  static Class NSCFDictionaryClass;
  if (NSCFDictionaryClass == nil) {
    NSCFDictionaryClass = objc_getClass(NSCFDictionary);
  }

  for (id tweet in orgTweets) {
    if (tweet == nil ||
        ![[tweet class] isEqual:NSCFDictionaryClass])
    {
      continue;
    }

    NSString* text = [tweet objectForKey:@"text"];
    [text autorelease];
    if (text == nil) {
      continue;
    }

    if ([rtPreficate evaluateWithObject:text]) {
      NSLog(@"Deleted tweet: %@", text);
      [altTweets removeObject:tweet];
    }
  }

  object_setInstanceVariable(self, "root", altTweets);

  return returnValue;
}

@end
