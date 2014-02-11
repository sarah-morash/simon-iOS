/**
 *  SimonGameController.h
 *  SimonApp
 *
 *  Created by Sarah Morash on 2013-10-01.
 *  Copyright (c) 2013 Sarah Morash. All rights reserved.
 */

@interface SimonGameModel : NSObject
//_ (void)targetMethod:(NSTimer*)timer;

@property (nonatomic, assign) int health; // Highest health is 3, decrements by 1 every time a mistake is made
@property (nonatomic, assign) int score;  // Score starts at zero and increments every time a pattern is successfully repeated
@property (nonatomic, assign) int level;  // After every 5 levels played, increase the difficulty
@property (nonatomic, assign) int index;  // Index of the array
@property (nonatomic, assign) int simonIndex;  // Index of the array

@property (nonatomic, assign) int rand;   // Random number
@property (nonatomic, strong) NSMutableArray *highScores;     // an array of the top 10 highsc
@property (nonatomic, strong) NSMutableArray *simonPattern;   // Pattern of buttons pressed
@property (nonatomic, strong) NSMutableArray *simonCopy;      // Copy of simonPattern

// Set methods
- (void)decrementHealth;
- (void)incrementScore;
- (void)levelUp;
- (void)addToSimonArray;
- (void)removeFromSimonArray;

// Get Methods
- (int)getHealth;
- (int)getScore;
- (int)getLevel;
- (NSMutableArray *)returnSimonsMovesToVC;
//- (void)gameEnded;

@end
