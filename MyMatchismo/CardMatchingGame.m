//
//  CardMatchingGame.m
//  MyMatchismo
//
//  Created by Alexander Bykov on 10/16/13.
//  Copyright (c) 2013 Alexander Bykov. All rights reserved.
//

#import "CardMatchingGame.h"

#define CARD_GAME_MODE_TWO 2
#define CARD_GAME_MODE_THREE 3

@interface CardMatchingGame()
@property (nonatomic, readwrite) int score;
@property (nonatomic, getter=isGameStarted, readwrite) BOOL gameStarted;
@property (nonatomic, readonly) NSInteger cardsToMatch;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [NSMutableArray new];
    return _cards;
}

- (void)mode:(NSInteger)mode
{
    if (mode == CARD_GAME_MODE_TWO || mode == CARD_GAME_MODE_THREE) {
        _mode = mode;
    } else {
        _mode = CARD_GAME_MODE_TWO;
    }
}

- (NSInteger)cardsToMatch
{
    return self.mode - 1;
}

- (NSInteger)mode
{
    return _mode == 0 ? CARD_GAME_MODE_TWO : _mode;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [self init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card * card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card * card = [self cardAtIndex:index];
    int flipScore = 0;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            
            NSMutableArray * otherCards = [NSMutableArray new];
            for (Card * otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) { [otherCards addObject:otherCard]; }
            }
            
            if ([otherCards count] == self.cardsToMatch) {
                int matchScore = 0;
                matchScore = [card match:otherCards];
                if (matchScore) {
                    for (Card * otherCard in otherCards) {
                        otherCard.unplayable = YES;
                    }
                    
                    card.unplayable = YES;
                    flipScore += matchScore * MATCH_BONUS;
                } else {
                    for (Card * otherCard in otherCards) {
                        otherCard.faceUp = NO;
                    }

                    flipScore -= MISMATCH_PENALTY;
                }
                [otherCards addObject:card];
                [self setFlipDescriptionWithCards:otherCards score:flipScore];
            }

            flipScore -= FLIP_COST;
            if (abs(flipScore) == abs(FLIP_COST)) {
                [self setFlipDescriptionWithCards:@[card] score:flipScore];
            }
        }
        self.score += flipScore;
        card.faceUp = !card.isFaceUp;
    }

    self.gameStarted = YES;
}

- (void)setFlipDescriptionWithCards:(NSArray *)cards score:(NSInteger)score
{
    score = abs(score);
    if (score == abs(FLIP_COST) && [cards count] == 1) {
        self.flipDescription = [NSString stringWithFormat:@"Flipped up %@!", [(Card *)[cards lastObject] contents]];
    } else if (score == abs(MISMATCH_PENALTY) && [cards count] == 2) {
        Card * card = [cards firstObject];
        Card * otherCard = [cards lastObject];
        self.flipDescription = [NSString stringWithFormat:@"%@ & %@ don't match! %d point penalty!",  [card contents], [otherCard contents], abs(MISMATCH_PENALTY)];
    } else if (score == abs(MISMATCH_PENALTY) && [cards count] == 3) {
        Card * card = [cards objectAtIndex:0];
        Card * otherCard = [cards objectAtIndex:1];
        Card * lastOtherCard = [cards objectAtIndex:2];
        self.flipDescription = [NSString stringWithFormat:@"%@, %@ & %@ don't match! %d point penalty!",  [card contents], [otherCard contents], [lastOtherCard contents], abs(MISMATCH_PENALTY)];
    } else if ([cards count] == CARD_GAME_MODE_TWO) {
        Card * card = [cards firstObject];
        Card * otherCard = [cards lastObject];
        self.flipDescription = [NSString stringWithFormat:@"Matched %@ & %@ for %d points",  [card contents], [otherCard contents], score];
    } else if ([cards count] == CARD_GAME_MODE_THREE) {
        Card * card = [cards objectAtIndex:0];
        Card * otherCard = [cards objectAtIndex:1];
        Card * lastOtherCard = [cards objectAtIndex:2];
        self.flipDescription = [NSString stringWithFormat:@"Matched %@, %@ & %@ for %d points",  [card contents], [otherCard contents], [lastOtherCard contents], score];
    } else {
        self.flipDescription = [NSString stringWithFormat:@"You did something incredible!"];
    }
    
}

- (NSString *)flipDescription
{
    if (!_flipDescription) _flipDescription = [NSString stringWithFormat:FLIP_DESCRIPTION_NOTHING];
    return _flipDescription;
}

@end
