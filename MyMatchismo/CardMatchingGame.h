//
//  CardMatchingGame.h
//  MyMatchismo
//
//  Created by Alexander Bykov on 10/16/13.
//  Copyright (c) 2013 Alexander Bykov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

#define FLIP_DESCRIPTION_NOTHING @"You did nothing"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

- (Card *)cardAtIndex:(NSUInteger)index;

- (void)flipCardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (nonatomic, getter=isGameStarted, readonly) BOOL gameStarted;
@property (nonatomic, strong) NSMutableArray * cards;
@property (nonatomic, strong) NSString * flipDescription;
@property (nonatomic) NSInteger mode;

@end
