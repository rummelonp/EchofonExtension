//
//  NSObject+EchofonExtension.m
//  EchofonExtension
//
//  Created by Kazuya Takeshima on 11/01/20.
//  Copyright 2011 Kazuya Takeshima. All rights reserved.
//

#import "NSObject+EchofonExtension.h"

@implementation NSObject(EchofonExtension)

- (unsigned long long)parseExtension:(id)arg1 error:(id*)arg2
{
  unsigned long long returnValue = [self parseExtension:arg1 error:arg2];

  id orgTweets = [self performSelector:@selector(root)];
  if (orgTweets == nil ||
      ![[orgTweets class] isEqual:objc_getClass("NSCFArray")])
  {
    return returnValue;
  }

  NSMutableArray* altTweets = [[NSMutableArray arrayWithArray:orgTweets] autorelease];

  static NSPredicate* rtPreficate;
  if (rtPreficate == nil) {
    NSString* rtFormat = @"SELF MATCHES '^.*(?:(?:RT|QT):? @[a-zA-Z0-9]+.*){2,}.*$'";
    rtPreficate = [[NSPredicate predicateWithFormat:rtFormat] retain];
  }

  for (id tweet in orgTweets) {
    if (tweet == nil ||
        ![[tweet class] isEqual:objc_getClass("NSCFDictionary")])
    {
      continue;
    }

    NSString* text = [tweet objectForKey:@"text"];
    if (text == nil) {
      continue;
    }

    if ([rtPreficate evaluateWithObject:text]) {
      NSLog(@"Deleted tweet: %@", text);
      [altTweets removeObject:tweet];
      [tweet release];
    }
  }

  object_setInstanceVariable(self, "root", altTweets);

  return returnValue;
}

@end
