//
//  MMViewController.m
//  MyMatchismo
//
//  Created by Alexander Bykov on 10/11/13.
//  Copyright (c) 2013 Alexander Bykov. All rights reserved.
//

#import "MMViewController.h"
#import "Deck.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

#define TWO_CARDS 2
#define THREE_CARDS 3

@interface MMViewController()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) CardMatchingGame * game;
@property (weak, nonatomic) IBOutlet UILabel *logLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSwitcher;
@end

@implementation MMViewController

- (IBAction)switchMode:(UISegmentedControl *)sender {
    NSInteger mode = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] integerValue];
    self.game = [self makeGameWithMode:mode];
}

- (CardMatchingGame *)makeGameWithMode:(NSInteger)mode
{
    CardMatchingGame * game;
    game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
    game.mode = mode;
    
    return game;
}

- (IBAction)deal:(id)sender {
    NSInteger mode = [[self.modeSwitcher titleForSegmentAtIndex:self.modeSwitcher.selectedSegmentIndex] integerValue];
    self.game = [self makeGameWithMode:mode];;
    self.flipCount = 0;
    [self updateUI];
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [self makeGameWithMode:TWO_CARDS];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    
    UIImage * transparentImage = [UIImage imageNamed:@"transparent.png"];
    UIImage * coverImage = [UIImage imageNamed:@"card_back.jpg"];
    
    [cardButtons enumerateObjectsUsingBlock:^(UIButton * cardButton, NSUInteger idx, BOOL *stop) {
        [cardButton setBackgroundImage:coverImage forState:UIControlStateNormal];
        [cardButton setBackgroundImage:transparentImage forState:UIControlStateSelected];
        [cardButton setBackgroundImage:transparentImage forState:UIControlStateSelected|UIControlStateDisabled];
    }];
    
    [self updateUI];
}

- (void)setLogLabel:(UILabel *)logLabel
{
    if (!_logLabel) {
        _logLabel = logLabel;
        logLabel.text = self.game.flipDescription;
    } else {
        _logLabel = logLabel;
    }
}

- (void)updateUI
{
    for (UIButton * cardButton in self.cardButtons) {
        Card * card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    self.logLabel.text = [self.game flipDescription];
    
    [self setModeSwitcherEnabled:!self.game.isGameStarted];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", _flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (void)setModeSwitcherEnabled:(BOOL)isEnabled
{
    if (isEnabled) {
        self.modeSwitcher.enabled = YES;
        self.modeSwitcher.alpha = 1.0;
    } else {
        self.modeSwitcher.enabled = NO;
        self.modeSwitcher.alpha = .3;
    }
}

@end
