//
//  NSObject+Swizzle.h
//  EchofonExtension
//
//  Created by Kazuya Takeshima on 11/01/20.
//  Copyright 2011 Kazuya Takeshima. All rights reserved.
//

@interface NSObject(Swizzle)

+ (void)swizzleMethod:(SEL)orig_sel withMethod:(SEL)alt_sel;

@end
