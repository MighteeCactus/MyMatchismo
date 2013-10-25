//
//  Card.h
//  MyMatchismo
//
//  Created by Alexander Bykov on 10/15/13.
//  Copyright (c) 2013 Alexander Bykov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, strong) NSString * contents;

@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;

@end
