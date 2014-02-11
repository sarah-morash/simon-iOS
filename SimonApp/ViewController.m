/**
 *  ViewController.m
 *  SimonApp
 *
 *  Created by Sarah Morash on 2013-09-27.
 *  Copyright (c) 2013 Sarah Morash. All rights reserved.
 */

#import "ViewController.h"



// Define some constants for code clarity
#define RED       ((int) 1)
#define GREEN     ((int) 2)
#define BLUE      ((int) 3)
#define YELLOW    ((int) 4)

#define FLASH_TIMER ((float) 1.00)
#define FLASH_COOLDOWN ((float) 0.50)

@interface ViewController ()
@end

@implementation ViewController

// Initializes variables
// Disables all buttons except for play button
- (void)viewDidLoad {
    [super viewDidLoad];
    _isPaused = false;
    _player = [[AVAudioPlayer alloc] init];
    //_player.delegate = self;
    
    // Set all buttons as disabled
    // Except for the play option
    [_redButton setEnabled:NO];
    [_blueButton setEnabled:NO];
    [_greenButton setEnabled:NO];
    [_yellowButton setEnabled:NO];
    [_stop setEnabled:NO];
    [_pause setEnabled:NO];
    [_play setEnabled:YES];
}

// Plays sound for red button
- (void)playRedSound {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"note4" ofType:@"wav"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    _player.volume = 0.5;

    [_player play];
}

// Plays sound for green button
- (void)playGreenSound {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"note3" ofType:@"wav"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    _player.volume = 0.5;

    [_player play];
}

// Plays sound for blue button
- (void)playBlueSound {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"note2" ofType:@"wav"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    _player.volume = 0.5;

    [_player play];
}

// Plays sound for yellow button
- (void)playYellowSound {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"note1" ofType:@"wav"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    player.volume = 0.5;

    [player play];
}

// Plays sound for play button
- (void)playStartSound {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"play" ofType:@"wav"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    //_player.volume = 0.5;
    
    [_player play];
}

// Plays sound for stop button
- (void)playStopSound {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"stop" ofType:@"wav"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    player.volume = 0.5;
    
    [player play];
}



- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    NSLog(@"AUDIO ERROR");
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"FINISHED PLAYING");    
}


// Start game
// Set turns, update scores
- (IBAction)playGame:(id)sender {
    
    // Initializes health, score, level, and arrays
    _gameController = [[SimonGameModel alloc] init];
    
    _index = 0;
    _simonIndex = 0;
    _turn = 0;

    [self playStartSound];
    
    // Set selected buttons as enabled
    [_stop setEnabled:YES];
    [_pause setEnabled:YES];
    [_play setEnabled:NO];
    
    // Add one item to Simon
    // Get Simon array from SimonGameController
    // Call on function to show highlighted moves
    [self updateLevel];
    [self updateScore];
    [self updateHealth];
    [NSTimer scheduledTimerWithTimeInterval:FLASH_TIMER target:self selector:@selector(simonIsCurrentPlayer) userInfo:nil repeats:NO];
}

/**
 *  Creates a timer and repeats every 0.5 seconds 
 *  calls on currentPatternStep to show next button highlighted 
 */
- (void)showSimonPattern {
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:(FLASH_TIMER*2) target:self selector:@selector(currentPatternStep:) userInfo:self repeats:YES];
}

/**
 *  Checks who's turn it is
 *  Plays current move in array by highlighting the button
 */
- (void)currentPatternStep:(id)timer {

    // Simon's turn
    if (_turn == 0) {

        [_pause setEnabled:NO];
        [_stop setEnabled:NO];
       
        id red = [NSNumber numberWithInteger: RED];
        id blue = [NSNumber numberWithInteger: BLUE];
        id green = [NSNumber numberWithInteger: GREEN];
        id yellow = [NSNumber numberWithInteger: YELLOW];

        // If there are more moves in the array to show to user
        if (_simonIndex < [_gameController.simonPattern count]) {
            
            if([_gameController.simonPattern objectAtIndex:_simonIndex] == red) {             // red
                _simonIndex++;
                
                [_redButton setImage:[UIImage imageNamed:@"redPressed.png"] forState:UIControlStateNormal];
                [self playRedSound];
                
                [NSTimer scheduledTimerWithTimeInterval:FLASH_COOLDOWN target:self selector:@selector(redDonePress) userInfo:nil repeats:NO];
                
            }   else if([_gameController.simonPattern objectAtIndex:_simonIndex] == green) {  // green
                _simonIndex++;
                
                [_greenButton setImage:[UIImage imageNamed:@"greenPressed.png"] forState:UIControlStateNormal];
                [self playGreenSound];
                
                [NSTimer scheduledTimerWithTimeInterval:FLASH_COOLDOWN target:self selector:@selector(greenDonePress) userInfo:nil repeats:NO];
                
            }   else if([_gameController.simonPattern objectAtIndex:_simonIndex] == blue) {   // blue
                _simonIndex++;
                
                [_blueButton setImage:[UIImage imageNamed:@"bluePressed.png"] forState:UIControlStateNormal];
                [self playBlueSound];

                [NSTimer scheduledTimerWithTimeInterval:FLASH_COOLDOWN target:self selector:@selector(blueDonePress) userInfo:nil repeats:NO];
                
            }   else if([_gameController.simonPattern objectAtIndex:_simonIndex] == yellow) { // yellow
                _simonIndex++;
                
                [_yellowButton setImage:[UIImage imageNamed:@"yellowPressed.png"] forState:UIControlStateNormal];
                [self playYellowSound];
    
                [NSTimer scheduledTimerWithTimeInterval:FLASH_COOLDOWN target:self selector:@selector(yellowDonePress) userInfo:nil repeats:NO];
            }
            
        }   else {
            _turn = 1;
        }
    }

    // User's turn
    if (_turn == 1) {
        
        // Turn off timer
        [_myTimer invalidate];
        _myTimer = nil;
        
        [_redButton setEnabled:YES];
        [_blueButton setEnabled:YES];
        [_greenButton setEnabled:YES];
        [_yellowButton setEnabled:YES];
        _simonIndex = 0;
        
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(userIsCurrentPlayer) userInfo:nil repeats:NO];
    }
}

// Compares the user button pressed with the current value in the Simon Pattern array
// And updates score accordingly
- (void)compareMoves:(int)buttonPressed :(NSMutableArray *)simonsMoves {
    id idOfButton = [NSNumber numberWithInteger: buttonPressed];

    if (idOfButton == [simonsMoves objectAtIndex:_index]) {
        _index++;
        
        // If all values in the array have been played,
        // Give control back to Simon
        if(_index == simonsMoves.count) {
            
            [_gameController incrementScore];
            [self updateScore];
            [self updateLevel];
            
            CGFloat rand = arc4random_uniform(2.0) + 1.00;
            [NSTimer scheduledTimerWithTimeInterval:rand target:self selector:@selector(simonsTurnTimer) userInfo:nil repeats:NO];
            [self simonIsCurrentPlayer];
        }
        
        
    }   else {
        [_gameController decrementHealth];
        
        [self updateHealth];

        if ([_gameController getHealth] == 0) {
            [self stopGame:self.stop];
        }
    }
}

- (void)simonsTurnTimer {
    _turn = 0;
}

- (IBAction)redPressed:(id)sender {
    [self compareMoves:RED :[_gameController returnSimonsMovesToVC]];
    
    [_redButton setImage:[UIImage imageNamed:@"redPressed.png"] forState:UIControlStateNormal];
    [self playRedSound];

    [NSTimer scheduledTimerWithTimeInterval:FLASH_TIMER target:self selector:@selector(redDonePress) userInfo:nil repeats:NO];
}

- (void)redDonePress {
    [_redButton setImage:[UIImage imageNamed:@"red.png"] forState:UIControlStateNormal];
    //[NSTimer scheduledTimerWithTimeInterval:FLASH_TIMER target:self selector:@selector(showSimonPattern) userInfo:nil repeats:NO];
}

- (IBAction)greenPressed:(id)sender {
    [self compareMoves:GREEN :[_gameController returnSimonsMovesToVC]];
    
    [_greenButton setImage:[UIImage imageNamed:@"greenPressed.png"] forState:UIControlStateNormal];
    [self playGreenSound];

    [NSTimer scheduledTimerWithTimeInterval:FLASH_TIMER target:self selector:@selector(greenDonePress) userInfo:nil repeats:NO];
}

- (void)greenDonePress {
    [_greenButton setImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
    //[NSTimer scheduledTimerWithTimeInterval:FLASH_TIMER target:self selector:@selector(showSimonPattern) userInfo:nil repeats:NO];
}

- (IBAction)bluePressed:(id)sender {
    [self compareMoves:BLUE :[_gameController returnSimonsMovesToVC]];
    
    [_blueButton setImage:[UIImage imageNamed:@"bluePressed.png"] forState:UIControlStateNormal];
    [self playBlueSound];

    [NSTimer scheduledTimerWithTimeInterval:FLASH_TIMER target:self selector:@selector(blueDonePress) userInfo:nil repeats:NO];
}

- (void)blueDonePress {
    [_blueButton setImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
    //[NSTimer scheduledTimerWithTimeInterval:FLASH_TIMER target:self selector:@selector(showSimonPattern) userInfo:nil repeats:NO];
}

- (IBAction)yellowPressed:(id)sender {
    [self compareMoves:YELLOW :[_gameController returnSimonsMovesToVC]];
    
    [_yellowButton setImage:[UIImage imageNamed:@"yellowPressed.png"] forState:UIControlStateNormal];
    [self playYellowSound];

    [NSTimer scheduledTimerWithTimeInterval:FLASH_TIMER target:self selector:@selector(yellowDonePress) userInfo:nil repeats:NO];
}

- (void)yellowDonePress {
    [_yellowButton setImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
    //[NSTimer scheduledTimerWithTimeInterval:FLASH_TIMER target:self selector:@selector(showSimonPattern) userInfo:nil repeats:NO];
}

// Disable all componenets
- (IBAction)pauseGame:(id)sender {
    
    // Unpause the game
    if(_isPaused){
        [_play setEnabled:YES];
        [_stop setEnabled:YES];
        [_redButton setEnabled:YES];
        [_blueButton setEnabled:YES];
        [_greenButton setEnabled:YES];
        [_yellowButton setEnabled:YES];
        [_pauseLabel setHidden:TRUE];
        _isPaused = false;
    
    // Pause the game
    }   else {
        [_myTimer invalidate];
        _myTimer = nil;
        [_play setEnabled:NO];
        [_stop setEnabled:NO];
        [_redButton setEnabled:NO];
        [_blueButton setEnabled:NO];
        [_greenButton setEnabled:NO];
        [_yellowButton setEnabled:NO];
        [_pauseLabel setHidden:FALSE];
        _isPaused = true;
    }
}

// Disable all elements except for play
- (IBAction)stopGame:(id)sender {
    [self gameOver];
    
    [_redButton setEnabled:NO];
    [_blueButton setEnabled:NO];
    [_greenButton setEnabled:NO];
    [_yellowButton setEnabled:NO];
    [_stop setEnabled:NO];
    [_pause setEnabled:NO];
    [_play setEnabled:YES];

    //check for highscore
    //set everything to initial values
}

// Update score on view
- (void)updateScore {
    self.score.text = [NSString stringWithFormat: @"%d", [_gameController getScore]];
}

// Update health on view
- (void)updateHealth {
    int i;
    self.health.text = @"";
    
    // Change health label so user can see
    for (i = 0; i < [_gameController getHealth]; i++){
        self.health.text = [self.health.text stringByAppendingString:@"♥"];
    }
}

// Update level on view
- (void)updateLevel {
 
    // Level up!
    if ([_gameController getScore] % 5 == 0 && [_gameController getScore] != 0) {
        [_gameController levelUp];
    }
    self.level.text = [NSString stringWithFormat: @"%d", [_gameController getLevel]];

}

// When updateTurn is called, the function will call on the function that represents which whose turn is next
- (void)simonIsCurrentPlayer {
    _index = 0;
    int i;
    
    // Simon's turn
    // Call on Simon's moves to display pattern
    _gameController.simonPattern = [[NSMutableArray alloc] init];

    // If score is less than 5, only add one value to array
    if ([_gameController getScore] < 5) {
        [_gameController addToSimonArray];
    
    // Add as many items into the array as there are levels
    }   else {
        for (i = 0; i < [_gameController getLevel]; i++) {            
            [_gameController addToSimonArray];
        }
    }
    
    self.turnLabel.text = [NSString stringWithFormat: @"Simon's turn"];

    [NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(showSimonPattern) userInfo:nil repeats:NO];
}

// Player's turn
- (void)userIsCurrentPlayer {
    [_pause setEnabled:YES];
    self.turnLabel.text = [NSString stringWithFormat: @"Your turn"]; 
}

// Game over
- (void)gameOver {
    
    [_myTimer invalidate];
    _myTimer = nil;
    [self playStopSound];

    self.turnLabel.text = [NSString stringWithFormat: @"Game Over"];
    [_pause setEnabled:NO];
    [_play setEnabled:YES];
    [_redButton setEnabled:NO];
    [_blueButton setEnabled:NO];
    [_greenButton setEnabled:NO];
    [_yellowButton setEnabled:NO];
}

@end
