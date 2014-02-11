/**
 *  SimonGameController.m
 *  SimonApp
 *
 *  The main logic of the game (the view doesn't talk to it directly, must go through the view controller first)
 *
 *  Created by Sarah Morash on 2013-10-01.
 *  Copyright (c) 2013 Sarah Morash. All rights reserved.
 */

#import "SimonGameModel.h"
#import "ViewController.h"
#include <stdlib.h>

@interface SimonGameModel ()

@end

@implementation SimonGameModel

// Initialize arrays 
- (id)init {
    self = [super init];
    if (self) {
        _simonPattern = [[NSMutableArray alloc] init];
        _simonCopy = [[NSMutableArray alloc] init];
        _health = 3;
        _score = 0;
        _level = 0;
        _index = 0;
        _simonIndex = 0;
    }
    return self;
}

// Decrement players health by 1
- (void)decrementHealth {
    _health--;
}

// Get player's health
- (int)getHealth {
    return _health;
}

// Score increments by 1
- (void)incrementScore {
    _score++;
}

// Get player's score
- (int)getScore {
    return _score;
}

// Level increments by 1
- (void)levelUp {
    _level++;
}

// Get player's level
- (int)getLevel {
    return _level;
}

// Add the next random number between 1 and 4 to Simons array
- (void)addToSimonArray {
    NSInteger rand = arc4random_uniform(4) + 1;
    [_simonPattern insertObject:[NSNumber numberWithInteger:rand] atIndex:_index];
    [_simonCopy insertObject:[NSNumber numberWithInteger:rand] atIndex:_index];
}

// Return array to view controller
- (NSMutableArray *)returnSimonsMovesToVC {
    return _simonPattern;
}

// Remove item from Simon array
- (void)removeFromSimonArray {
    [_simonPattern removeObjectAtIndex:0];
}

@end
