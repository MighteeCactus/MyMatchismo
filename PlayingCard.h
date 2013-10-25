//
//  PlayingCard.h
//  MyMatchismo
//
//  Created by Alexander Bykov on 10/15/13.
//  Copyright (c) 2013 Alexander Bykov. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (nonatomic, strong) NSString * suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
+ (NSUInteger)minRank;

@end
