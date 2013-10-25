//
//  Card.m
//  MyMatchismo
//
//  Created by Alexander Bykov on 10/15/13.
//  Copyright (c) 2013 Alexander Bykov. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card * card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
