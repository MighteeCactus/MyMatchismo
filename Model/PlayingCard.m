//
//  PlayingCard.m
//  MyMatchismo
//
//  Created by Alexander Bykov on 10/15/13.
//  Copyright (c) 2013 Alexander Bykov. All rights reserved.
//

#import "PlayingCard.h"

#define MAX_CARD_RANK 13;
#define MIN_CARD_RANK 0;

#define MATCH_SUIT_SCORE 1
#define MATCH_RANK_SCORE 4

@implementation PlayingCard

@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard * otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = MATCH_SUIT_SCORE;
        } else if (otherCard.rank == self.rank) {
            score = MATCH_RANK_SCORE;
        }
    } else {

        int maxSuitMatch = 0;
        for (NSString * suit in [PlayingCard validSuits]) {
            NSPredicate * suitsMatch = [NSPredicate predicateWithFormat:@"suit contains %@", suit];
            NSArray * sameSuits = [otherCards filteredArrayUsingPredicate:suitsMatch];
            maxSuitMatch = MAX(maxSuitMatch, [sameSuits count]);
        }
        
        int maxRankMatch = 0;
        for (int rank = [PlayingCard minRank]; rank < [PlayingCard maxRank]; rank++) {
            NSPredicate * ranksMatch = [NSPredicate predicateWithFormat:@"rank == %d", rank];
            NSArray * sameRanks = [otherCards filteredArrayUsingPredicate:ranksMatch];
            maxRankMatch = MAX(maxRankMatch, [sameRanks count]);
        }
        
        if (maxSuitMatch > 1) {
            score += maxSuitMatch * MATCH_SUIT_SCORE;
        }
        
        if (maxRankMatch > 1) {
            score += maxRankMatch * MATCH_RANK_SCORE;
        }
    }
    
    return score;
}

- (NSString *)contents
{
    return [[self rankAsString] stringByAppendingString:self.suit];
}

+ (NSUInteger)maxRank
{
    return MAX_CARD_RANK;
}

+ (NSUInteger)minRank
{
    return MIN_CARD_RANK;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank < [PlayingCard minRank]) {
        _rank = [PlayingCard minRank];
    } else if  (rank < [PlayingCard maxRank]) {
        _rank = rank;
    } else {
        _rank = [PlayingCard maxRank];
    }
}

+ (NSArray *)validSuits
{
    return @[@"♠", @"♣", @"♥", @"♦"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    static NSArray * rankStrings;
    rankStrings = @[@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    return rankStrings;
}

- (NSString *)rankAsString
{
    NSArray * ranks = [PlayingCard rankStrings];
    return ranks[self.rank];
}

@end
