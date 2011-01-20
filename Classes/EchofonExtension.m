//
//  EchofonExtension.m
//  EchofonExtension
//
//  Created by Kazuya Takeshima on 11/01/20.
//  Copyright 2011 Kazuya Takeshima. All rights reserved.
//

#import "EchofonExtension.h"
#import "NSObject+Swizzle.h"

@implementation EchofonExtension

+ (void)load
{
  NSLog(@"EchofonExtension loaded.");
}

@end
