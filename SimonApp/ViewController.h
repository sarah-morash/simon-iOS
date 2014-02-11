/**
 *  ViewController.h
 *  SimonApp
 *
 *  Created by Sarah Morash on 2013-09-27.
 *  Copyright (c) 2013 Sarah Morash. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "SimonGameModel.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@class SimonGameModel;

@interface ViewController : UIViewController <AVAudioPlayerDelegate> 
@property (nonatomic, strong) AVAudioPlayer *player;

// Used to access SimonGameController
@property (strong, nonatomic) SimonGameModel* gameController;

// Buttons in the view
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *yellowButton;
@property (weak, nonatomic) IBOutlet UIButton *play;
@property (weak, nonatomic) IBOutlet UIButton *pause;
@property (weak, nonatomic) IBOutlet UIButton *stop;

// Labels in the view
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *healthLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *pauseLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnLabel;

// Dynamic labels (their value will be changed throughout the game)
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *health;
@property (weak, nonatomic) IBOutlet UILabel *level;

// Extra properties 
@property (nonatomic, assign) BOOL isPaused;   // 0 -> game is paused, 1 -> game is unpaused
@property (nonatomic, assign) int index;       // To determine which move the user is currently trying to repeat from Simon's Array
@property (nonatomic, assign) int simonIndex;  // To determine which move the user is currently trying to repeat from Simon's Array
@property (nonatomic, assign) int userHealth;
@property (nonatomic, assign) int userLevel;
@property (nonatomic, assign) int userScore;
@property (nonatomic, assign) int turn;        // 0 -> show Simon sequence, 1 -> wait x amount of seconds for user to play pattern
@property (nonatomic, weak) NSTimer *myTimer;

// Actions caused by user - pressing a button
- (IBAction)redPressed:(id)sender;
- (IBAction)greenPressed:(id)sender;
- (IBAction)bluePressed:(id)sender;
- (IBAction)yellowPressed:(id)sender;
- (IBAction)playGame:(id)sender;
- (IBAction)pauseGame:(id)sender;
- (IBAction)stopGame:(id)sender;

// Other functions called in View Controller
- (void)showSimonPattern;
- (void)redDonePress;
- (void)blueDonePress;
- (void)greenDonePress;
- (void)yellowDonePress;
- (void)compareMoves:(int)buttonPressed :(NSMutableArray *)simonsMoves;
- (void)currentPatternStep:(id)timer;
- (void)simonsTurnTimer;
- (void)updateScore;
- (void)updateHealth;
- (void)updateLevel;
- (void)simonIsCurrentPlayer;
- (void)userIsCurrentPlayer;
- (void)gameOver;

// To play sounds
- (void)playRedSound;
- (void)playBlueSound;
- (void)playGreenSound;
- (void)playYellowSound;
- (void)playStartSound;
- (void)playStopSound;

@end
