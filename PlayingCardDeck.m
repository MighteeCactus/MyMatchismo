//
//  PlayingCardDeck.m
//  MyMatchismo
//
//  Created by Alexander Bykov on 10/16/13.
//  Copyright (c) 2013 Alexander Bykov. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (PlayingCardDeck *)init
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < [[PlayingCard validSuits] count]; i++) {
            for (int j = 0; j < [PlayingCard maxRank]; j++) {
                PlayingCard * card = [[PlayingCard alloc] init];
                card.suit = [PlayingCard validSuits][i];
                card.rank = j;
                NSLog(@"Added card: %@ to deck", card.contents);
                [self addCard:card atTop:NO];
            }
            
        }
    }
    
    return self;
}

@end
