/* Branch (c) 2015 Makenzie Schwartz. */

#import "Obstacle.h"

@interface MainScene : CCNode {
    int branchState;
    int playerState;
    int timeToNextBranch;
    int speed;
    int dropFrequency;
    int dropProbability;
    int numObstaclesInUse;
    int obstacleHeight;
    int score;
    int obstacleDropWait;
    int bonusCounter;
    
    BOOL isPlaying;
    BOOL isPaused;
    BOOL showingTutorialFirst;
    BOOL isMuted;
    BOOL branching;
    BOOL branching1_3;
    BOOL branching3_1;
    BOOL branching3_7;
    BOOL branching7_3;
    BOOL forceBranch7;
}

- (void)switchPlayer;
- (void)changeBGColor;
- (void)increseDifficulty;
- (void)resetBranchingTimer;
- (int)nextDropLocation;
- (Obstacle *)getNextDrop;
- (void)playButtonPressed;
- (void)leaderboardButtonPressed;
- (void)replayButtonPressed;
- (void)menuButtonPressed;
- (void)pauseButtonPressed;
- (void)helpButtonPressed;
- (void)soundButtonPressed;
- (void)addBonusScore;
- (void)tutorialClosed;

@end
