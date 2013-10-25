//
//  Deck.h
//  MyMatchismo
//
//  Created by Alexander Bykov on 10/15/13.
//  Copyright (c) 2013 Alexander Bykov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)initWithCardsCount:(NSUInteger)count;

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
