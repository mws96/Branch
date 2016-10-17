/* Branch (c) 2015 Makenzie Schwartz. */

#import "MainScene.h"
#import "Player1.h"
#import "Player3.h"
#import "Player7.h"
#import "RandomColorGenerator.h"
#import "CCNodeGradient+colorbreakdown.h"
#import "Obstacle.h"
#import "StartBackground.h"
#import "Tutorial.h"
#import "ABGameKitHelper.h"

#define BRANCH_WARNING_TIME 100
#define PLAYER_HEIGHT 57
#define OBSTACLE_HEIGHT_1 37
#define OBSTACLE_HEIGHT_3 27
#define OBSTACLE_HEIGHT_7 14
#define SPEED_INCREMENT 20
#define FREQUENCY_INCREMENT -5
#define PROBABILITY_INCREMENT 5
#define MAX_SPEED 500
#define MAX_FREQUENCY 0
#define MAX_PROBABILITY 85
#define SWITCH_SPEED 0.1f
#define SCREEN_HEIGHT 568
#define HIGHSCORE_KEY @"highscore"
#define SHOW_TUT_KEY @"firstTime"
#define SOUND_KEY @"muted"

@implementation MainScene {
    Player1 *_player1;
    Player3 *_player3_1;
    Player3 *_player3_2;
    Player7 *_player7_1;
    Player7 *_player7_2;
    Player7 *_player7_3;
    Player7 *_player7_4;
    
    Obstacle *_obstacle1;
    Obstacle *_obstacle2;
    Obstacle *_obstacle3;
    Obstacle *_obstacle4;
    Obstacle *_obstacle5;
    Obstacle *_obstacle6;
    NSArray *_obstacles;
    Obstacle *_mostRecentDrop;
    
    CCSprite *_board_d1;
    CCSprite *_board_d3;
    CCSprite *_board_d7;
    CCSprite *_branch1_3;
    CCSprite *_branch3_1;
    CCSprite *_branch3_7;
    CCSprite *_branch7_3;
    CCSprite *_branch1_3l_mask;
    CCSprite *_branch1_3r_mask;
    CCSprite *_branch3_1l_mask;
    CCSprite *_branch3_1r_mask;
    CCSprite *_branch3_7l_mask;
    CCSprite *_branch3_7r_mask;
    CCSprite *_branch7_3l_mask;
    CCSprite *_branch7_3r_mask;
    
    CCClippingNode *_clippingNode;
    
    CCNodeGradient *_bgGradient;
    
    CCActionMoveTo *move1;
    CCActionMoveTo *move31;
    CCActionMoveTo *move32;
    CCActionMoveTo *move71;
    CCActionMoveTo *move72;
    CCActionMoveTo *move73;
    CCActionMoveTo *move74;
    CCActionMoveTo *move1b;
    CCActionMoveTo *move31b;
    CCActionMoveTo *move32b;
    CCActionMoveTo *move71b;
    CCActionMoveTo *move72b;
    CCActionMoveTo *move73b;
    CCActionMoveTo *move74b;
    
    RandomColorGenerator *colorGen;
    
    CCLabelTTF *_scoreLabel;
    CCLabelTTF *_highscoreLabel;
    CCLabelTTF *_scoreInfoLabel;
    CCLabelTTF *_highscoreInfoLabel;
    CCLabelTTF *_infoLabel;
    
    CCSprite *_titleLogo;
    CCButton *_playButton;
    CCButton *_leaderboardButton;
    CCButton *_replayButton;
    CCButton *_menuButton;
    CCButton *_pauseButton;
    CCButton *_helpButton;
    CCButton *_soundButton;
    CCSprite *_playButtonFrame;
    CCSprite *_leaderboardButtonFrame;
    CCSprite *_scoreBorder;
    
    StartBackground *_startBackground;
    CCNodeColor *_screenShader;
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
    isPlaying = FALSE;
    
    //[[CCDirector sharedDirector] setAnimationInterval:1.0/10.0];
    
    //_obstacle1 = (Obstacle *)[CCBReader load:@"Obstacle"];
    //_obstacle2 = (Obstacle *)[CCBReader load:@"Obstacle"];
    _obstacles = [NSArray arrayWithObjects:_obstacle1, _obstacle2, _obstacle3, _obstacle4, _obstacle5, _obstacle6, nil];
    
    colorGen = [[RandomColorGenerator alloc] init];
    
    NSArray *startColor = [colorGen startColor];
    
    _bgGradient.startColor = [startColor objectAtIndex:0]; // Teal
    _bgGradient.endColor = [startColor objectAtIndex:1];
    
    for (Obstacle *ob in _obstacles) {
        [ob runAction:[CCActionTintTo actionWithDuration:2.0 color:[startColor objectAtIndex:2]]];
    }
    
    /* CCAnimationManager *animationManager = _playButtonFrame.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Default Timeline"];
    animationManager = _leaderboardButtonFrame.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Default Timeline"]; */
    
    [_playButtonFrame runAction:[CCActionFadeIn actionWithDuration:1.0]];
    [_leaderboardButtonFrame runAction:[CCActionFadeIn actionWithDuration:1.0]];
    
    CCAnimationManager *animationManager = _obstacle1.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Obstacle1_1"];
    animationManager = _obstacle2.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Obstacle1_3"];
    animationManager = _obstacle3.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Obstacle1_7"];
    animationManager = _obstacle4.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Obstacle2_1"];
    animationManager = _obstacle5.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Obstacle2_3"];
    animationManager = _obstacle6.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Obstacle2_7"];
    
    //_bgGradient.startColor = [CCColor colorWithRed:0.20 green:0.21 blue:0.26]; // Gray
    //_bgGradient.endColor = [CCColor colorWithRed:0.29 green:0.30 blue:0.37];
    //_bgGradient.startColor = [CCColor colorWithRed:0.20 green:0.53 blue:0.60]; // Teal
    //_bgGradient.endColor = [CCColor colorWithRed:0.22 green:0.58 blue:0.66];
    //_bgGradient.startColor = [CCColor colorWithRed:0.37 green:0 blue:0.27]; // Purple
    //_bgGradient.endColor = [CCColor colorWithRed:0.45 green:0 blue:0.31];
    //_bgGradient.startColor = [CCColor colorWithRed:0 green:0.52 blue:0.42]; // Light Green
    //_bgGradient.endColor = [CCColor colorWithRed:0 green:0.63 blue:0.50];
    //_bgGradient.startColor = [CCColor colorWithRed:0.55 green:0.71 blue:0]; // Lime Green
    //_bgGradient.endColor = [CCColor colorWithRed:0.65 green:0.83 blue:0];
    //_bgGradient.startColor = [CCColor colorWithRed:0.94 green:0.49 blue:0.42]; // Salmon
    //_bgGradient.endColor = [CCColor colorWithRed:0.97 green:0.50 blue:0.44];
    //_bgGradient.startColor = [CCColor colorWithRed:0.68 green:0.33 blue:0.45]; // Pink
    //_bgGradient.endColor = [CCColor colorWithRed:0.79 green:0.38 blue:0.52];
    //_bgGradient.startColor = [CCColor colorWithRed:0.89 green:0.48 blue:0.25]; // Orange
    //_bgGradient.endColor = [CCColor colorWithRed:0.95 green:0.51 blue:0.27];
    //_bgGradient.startColor = [CCColor colorWithRed:0.02 green:0.30 blue:0.16]; // Green
    //_bgGradient.endColor = [CCColor colorWithRed:0.02 green:0.37 blue:0.20];
    
    branchState = 1;
    playerState = 0;
    timeToNextBranch = 600;
    speed = 320;
    dropFrequency = 60;
    dropProbability = 30;
    numObstaclesInUse = 0;
    obstacleHeight = OBSTACLE_HEIGHT_1;
    score = 0;
    obstacleDropWait = 50;
    bonusCounter = 0;
    
    branching = FALSE;
    branching1_3 = FALSE;
    branching3_1 = FALSE;
    branching3_7 = FALSE;
    branching7_3 = FALSE;
    forceBranch7 = FALSE;
    
    showingTutorialFirst = [[NSUserDefaults standardUserDefaults] boolForKey:SHOW_TUT_KEY];
    
    _clippingNode.alphaThreshold = 0.0;
    _clippingNode.inverted = TRUE;
    
    _scoreLabel.color = [CCColor blackColor];
    _scoreLabel.shadowColor = [CCColor whiteColor];
    _scoreLabel.shadowBlurRadius = 2.0;
    [_scoreLabel setZOrder:1];
    [_scoreLabel setString:[@(score) stringValue]];
    
    _highscoreLabel.color = [CCColor blackColor];
    _highscoreLabel.shadowColor = [CCColor whiteColor];
    _highscoreLabel.shadowBlurRadius = 2.0;
    
    _infoLabel.opacity = 0;
    
    [_screenShader setZOrder:1];
    [_infoLabel setZOrder:1];
    [_pauseButton setZOrder:1];
    [_helpButton setZOrder:1];
    [_soundButton setZOrder:1];
    
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio preloadEffect:@"Sounds/branch.caf"];
    [audio preloadEffect:@"Sounds/button.caf"];
    [audio preloadEffect:@"Sounds/gameover.caf"];
    [audio preloadEffect:@"Sounds/highscore.caf"];
    [audio preloadEffect:@"Sounds/point.caf"];
    [audio preloadEffect:@"Sounds/slide.caf"];
    
    isMuted = [[NSUserDefaults standardUserDefaults] boolForKey:SOUND_KEY];
    [audio setEffectsMuted:isMuted];
    if (isMuted)
        [_soundButton setBackgroundSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Sprites/soundoff.png"] forState:CCControlStateNormal];
    else
        [_soundButton setBackgroundSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Sprites/soundon.png"] forState:CCControlStateNormal];
    
    [ABGameKitHelper sharedHelper];
    
    move1 = [CCActionMoveTo actionWithDuration:SWITCH_SPEED position:ccp(160.0, 0)];
    move31 = [CCActionMoveTo actionWithDuration:SWITCH_SPEED position:ccp(80.0, 0)];
    move32 = [CCActionMoveTo actionWithDuration:SWITCH_SPEED position:ccp(240.0, 0)];
    move71 = [CCActionMoveTo actionWithDuration:SWITCH_SPEED position:ccp(40.0, 0)];
    move72 = [CCActionMoveTo actionWithDuration:SWITCH_SPEED position:ccp(120.0, 0)];
    move73 = [CCActionMoveTo actionWithDuration:SWITCH_SPEED position:ccp(200.0, 0)];
    move74 = [CCActionMoveTo actionWithDuration:SWITCH_SPEED position:ccp(280.0, 0)];
    move1b = [CCActionMoveTo actionWithDuration:SWITCH_SPEED position:ccp(0.0, 0)];
    move31b = [CCActionMoveTo actionWithDuration:SWITCH_SPEED position:ccp(0.0, 0)];
    move32b = [CCActionMoveTo actionWithDuration:SWITCH_SPEED position:ccp(160.0, 0)];
    move71b = [CCActionMoveTo actionWithDuration:SWITCH_SPEED position:ccp(0.0, 0)];
    move72b = [CCActionMoveTo actionWithDuration:SWITCH_SPEED position:ccp(80.0, 0)];
    move73b = [CCActionMoveTo actionWithDuration:SWITCH_SPEED position:ccp(160.0, 0)];
    move74b = [CCActionMoveTo actionWithDuration:SWITCH_SPEED position:ccp(240.0, 0)];
}

- (void)playButtonPressed {
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/button.caf"];
    if (!showingTutorialFirst) {
        [self helpButtonPressed];
    } else {
        [_titleLogo stopAllActions];
        [_titleLogo runAction:[CCActionFadeOut actionWithDuration:0.5]];
        [_startBackground stopAllObstacleActions];
        [_startBackground fadeOut];
        [_startBackground stopAllActions];
        [_startBackground runAction:[CCActionFadeOut actionWithDuration:0.5]];
        [_playButtonFrame stopAllActions];
        [_playButtonFrame runAction:[CCActionFadeOut actionWithDuration:0.3]];
        [_leaderboardButtonFrame stopAllActions];
        [_leaderboardButtonFrame runAction:[CCActionFadeOut actionWithDuration:0.3]];
        _playButton.visible = FALSE;
        _leaderboardButton.visible = FALSE;
        _helpButton.visible = FALSE;
        _soundButton.visible = FALSE;
        _pauseButton.visible = TRUE;
        [_board_d1 runAction:[CCActionMoveTo actionWithDuration:0.5 position:ccp(160, 0)]];
        [_player1 runAction:[CCActionMoveTo actionWithDuration:0.5 position:ccp(0, 0)]];
        [_scoreLabel runAction:[CCActionFadeIn actionWithDuration:0.6]];
        isPlaying = TRUE;
    }
}

- (void)leaderboardButtonPressed {
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/button.caf"];
    [[ABGameKitHelper sharedHelper] showLeaderboard:@"branch_highscore"];
}

- (void)pauseButtonPressed {
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/button.caf"];
    if (isPaused == FALSE) {
        isPlaying = FALSE;
        isPaused = TRUE;
        _helpButton.visible = TRUE;
        _soundButton.visible = TRUE;
        [_infoLabel setString:@"TAP TO RESUME"];
        [_infoLabel stopAllActions];
        _infoLabel.opacity = 1.0;
        _infoLabel.visible = TRUE;
        [_pauseButton setBackgroundSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Sprites/playbutton.png"] forState:CCControlStateNormal];
        [_screenShader setOpacity:0.85];
    } else {
        isPlaying = TRUE;
        isPaused = FALSE;
        _helpButton.visible = FALSE;
        _soundButton.visible = FALSE;
        _infoLabel.visible = FALSE;
        _infoLabel.opacity = 0;
        [_pauseButton setBackgroundSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Sprites/pausebutton.png"] forState:CCControlStateNormal];
        [_screenShader setOpacity:0];
    }
}

- (void)replayButtonPressed {
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/button.caf"];
    [_branch1_3 setPosition:ccp(160.0, 570.0)];
    [_branch1_3l_mask setPosition:ccp(160.0, 490.0)];
    [_branch1_3r_mask setPosition:ccp(160.0, 490.0)];
    [_branch3_1 setPosition:ccp(160.0, 568.0)];
    [_branch3_1l_mask setPosition:ccp(160.0, 488.0)];
    [_branch3_1r_mask setPosition:ccp(160.0, 488.0)];
    [_board_d3 setPosition:ccp(160.0, 568.0)];
    [_branch3_7 setPosition:ccp(160.0, 568.0)];
    [_branch3_7l_mask setPosition:ccp(160.0, 468.0)];
    [_branch3_7r_mask setPosition:ccp(160.0, 468.0)];
    [_board_d7 setPosition:ccp(160.0, 568.0)];
    [_branch7_3 setPosition:ccp(160.0, 568.0)];
    [_branch7_3l_mask setPosition:ccp(160.0, 468.0)];
    [_branch7_3r_mask setPosition:ccp(160.0, 468.0)];
    
    [_player1 setPosition:ccp(0, -PLAYER_HEIGHT)];
    
    playerState = 0;
    branchState = 1;
    timeToNextBranch = 600;
    speed = 320;
    dropFrequency = 60;
    dropProbability = 30;
    numObstaclesInUse = 0;
    obstacleHeight = OBSTACLE_HEIGHT_1;
    score = 0;
    obstacleDropWait = 50;
    bonusCounter = 0;
    
    branching = FALSE;
    branching1_3 = FALSE;
    branching3_1 = FALSE;
    branching3_7 = FALSE;
    branching7_3 = FALSE;
    forceBranch7 = FALSE;
    
    _player1.visible = TRUE;
    _player3_1.visible = FALSE;
    _player3_2.visible = FALSE;
    _player7_1.visible = FALSE;
    _player7_2.visible = FALSE;
    _player7_3.visible = FALSE;
    _player7_4.visible = FALSE;
    
    [_player1 runAction:[CCActionMoveBy actionWithDuration:0.5 position:ccp(0, PLAYER_HEIGHT)]];
    [_player3_1 runAction:[CCActionMoveBy actionWithDuration:0.5 position:ccp(0, PLAYER_HEIGHT)]];
    [_player3_2 runAction:[CCActionMoveBy actionWithDuration:0.5 position:ccp(0, PLAYER_HEIGHT)]];
    [_player7_1 runAction:[CCActionMoveBy actionWithDuration:0.5 position:ccp(0, PLAYER_HEIGHT)]];
    [_player7_2 runAction:[CCActionMoveBy actionWithDuration:0.5 position:ccp(0, PLAYER_HEIGHT)]];
    [_player7_3 runAction:[CCActionMoveBy actionWithDuration:0.5 position:ccp(0, PLAYER_HEIGHT)]];
    [_player7_4 runAction:[CCActionMoveBy actionWithDuration:0.5 position:ccp(0, PLAYER_HEIGHT)]];
    
    for (Obstacle *ob in _obstacles) {
        [ob setPosition:ccp(-100, 0)];
    }
    
    [_board_d1 stopAllActions];
    [_board_d3 stopAllActions];
    [_board_d7 stopAllActions];
    _board_d1.opacity = 1.0;
    _board_d3.opacity = 1.0;
    _board_d7.opacity = 1.0;
    
    [_branch1_3 stopAllActions];
    [_branch3_1 stopAllActions];
    [_branch3_7 stopAllActions];
    [_branch7_3 stopAllActions];
    _branch1_3.opacity = 1.0;
    _branch3_1.opacity = 1.0;
    _branch3_7.opacity = 1.0;
    _branch7_3.opacity = 1.0;
    
    [_startBackground stopAllActions];
    [_startBackground stopAllObstacleActions];
    [_startBackground fadeOut];
    [_startBackground runAction:[CCActionFadeOut actionWithDuration:0.5]];
    
    [_board_d1 runAction:[CCActionMoveTo actionWithDuration:0.5 position:ccp(160, 0)]];
    
    score = 0;
    [_scoreLabel setString:[@(score) stringValue]];
    [_scoreLabel stopAllActions];
    [_scoreLabel runAction:[CCActionMoveTo actionWithDuration:0.5 position:ccp(160, 530)]];
    
    [_highscoreLabel stopAllActions];
    [_highscoreLabel runAction:[CCActionFadeOut actionWithDuration:0.5]];
    
    _pauseButton.visible = TRUE;
    
    _helpButton.visible = FALSE;
    _soundButton.visible = FALSE;
    
    [_playButtonFrame runAction:[CCActionFadeOut actionWithDuration:0.3]];
    [_leaderboardButtonFrame runAction:[CCActionFadeOut actionWithDuration:0.3]];
    [_scoreBorder runAction:[CCActionFadeOut actionWithDuration:0.3]];
    
    _replayButton.visible = FALSE;
    _menuButton.visible = FALSE;
    
    [_scoreInfoLabel stopAllActions];
    _scoreInfoLabel.visible = FALSE;
    [_highscoreInfoLabel stopAllActions];
    _highscoreInfoLabel.visible = FALSE;
    
    [_bgGradient stopAllActions];
    [self changeBGColor];
    
    isPlaying = TRUE;
}

- (void)menuButtonPressed {
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/button.caf"];
    [_board_d1 setPosition:ccp(160.0, 568.0)];
    [_branch1_3 setPosition:ccp(160.0, 570.0)];
    [_branch1_3l_mask setPosition:ccp(160.0, 490.0)];
    [_branch1_3r_mask setPosition:ccp(160.0, 490.0)];
    [_branch3_1 setPosition:ccp(160.0, 568.0)];
    [_branch3_1l_mask setPosition:ccp(160.0, 488.0)];
    [_branch3_1r_mask setPosition:ccp(160.0, 488.0)];
    [_board_d3 setPosition:ccp(160.0, 568.0)];
    [_branch3_7 setPosition:ccp(160.0, 568.0)];
    [_branch3_7l_mask setPosition:ccp(160.0, 468.0)];
    [_branch3_7r_mask setPosition:ccp(160.0, 468.0)];
    [_board_d7 setPosition:ccp(160.0, 568.0)];
    [_branch7_3 setPosition:ccp(160.0, 568.0)];
    [_branch7_3l_mask setPosition:ccp(160.0, 468.0)];
    [_branch7_3r_mask setPosition:ccp(160.0, 468.0)];
    
    [_player1 setPosition:ccp(0, -PLAYER_HEIGHT)];
    
    playerState = 0;
    branchState = 1;
    timeToNextBranch = 600;
    speed = 320;
    dropFrequency = 60;
    dropProbability = 30;
    numObstaclesInUse = 0;
    obstacleHeight = OBSTACLE_HEIGHT_1;
    score = 0;
    obstacleDropWait = 50;
    bonusCounter = 0;
    
    branching = FALSE;
    branching1_3 = FALSE;
    branching3_1 = FALSE;
    branching3_7 = FALSE;
    branching7_3 = FALSE;
    forceBranch7 = FALSE;
    
    _player1.visible = TRUE;
    _player3_1.visible = FALSE;
    _player3_2.visible = FALSE;
    _player7_1.visible = FALSE;
    _player7_2.visible = FALSE;
    _player7_3.visible = FALSE;
    _player7_4.visible = FALSE;
    
    for (Obstacle *ob in _obstacles) {
        [ob setPosition:ccp(-100, 0)];
    }
    
    [_board_d1 stopAllActions];
    [_board_d3 stopAllActions];
    [_board_d7 stopAllActions];
    _board_d1.opacity = 1.0;
    _board_d3.opacity = 1.0;
    _board_d7.opacity = 1.0;
    
    [_branch1_3 stopAllActions];
    [_branch3_1 stopAllActions];
    [_branch3_7 stopAllActions];
    [_branch7_3 stopAllActions];
    _branch1_3.opacity = 1.0;
    _branch3_1.opacity = 1.0;
    _branch3_7.opacity = 1.0;
    _branch7_3.opacity = 1.0;
    
    [_scoreBorder stopAllActions];
    [_scoreBorder runAction:[CCActionFadeOut actionWithDuration:0.2]];
    [_startBackground menuScreen];
    
    [_scoreLabel stopAllActions];
    [_scoreLabel runAction:[CCActionSequence actions:[CCActionFadeOut actionWithDuration:0.2], [CCActionMoveTo actionWithDuration:0.5 position:ccp(160, 530)], nil]];
    [_scoreLabel setString:[@(score) stringValue]];
    
    [_highscoreLabel stopAllActions];
    [_highscoreLabel runAction:[CCActionFadeOut actionWithDuration:0.2]];
    
    [_titleLogo runAction:[CCActionFadeIn actionWithDuration:0.5]];
    
    [_playButtonFrame runAction:[CCActionSequence actions:[CCActionFadeOut actionWithDuration:0.3], [CCActionFadeIn actionWithDuration:0.3], nil]];
    [_leaderboardButtonFrame runAction:[CCActionSequence actions:[CCActionFadeOut actionWithDuration:0.3], [CCActionFadeIn actionWithDuration:0.3], nil]];
    
    _replayButton.visible = FALSE;
    _menuButton.visible = FALSE;
    _playButton.visible = TRUE;
    _leaderboardButton.visible = TRUE;
    
    [_scoreInfoLabel stopAllActions];
    _scoreInfoLabel.visible = FALSE;
    [_highscoreInfoLabel stopAllActions];
    _highscoreInfoLabel.visible = FALSE;
    
    [_bgGradient stopAllActions];
    [self changeBGColor];
}

- (void)helpButtonPressed {
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/button.caf"];
    [_screenShader setOpacity:0.85];
    Tutorial *tut = (Tutorial *)[CCBReader load:@"Tutorial"];
    [tut setMainScene:self];
    [tut setPosition:ccp(160, 284)];
    [tut setZOrder:2];
    _playButton.enabled = FALSE;
    _leaderboardButton.enabled = FALSE;
    _replayButton.enabled = FALSE;
    _menuButton.enabled = FALSE;
    _pauseButton.enabled = FALSE;
    [self addChild:tut];
}

- (void)soundButtonPressed {
    isMuted = !isMuted;
    [[OALSimpleAudio sharedInstance] setEffectsMuted:isMuted];
    [[NSUserDefaults standardUserDefaults] setBool:isMuted forKey:SOUND_KEY];
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/button.caf"];
    if (isMuted)
        [_soundButton setBackgroundSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Sprites/soundoff.png"] forState:CCControlStateNormal];
    else
        [_soundButton setBackgroundSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Sprites/soundon.png"] forState:CCControlStateNormal];
}

- (void)update:(CCTime)delta {
    if (isPlaying) {
        if (!branching && timeToNextBranch <= 0) {
            if (branchState == 1) {
                branching1_3 = TRUE;
                branchState = 3;
                obstacleHeight = OBSTACLE_HEIGHT_3;
                _board_d3.visible = TRUE;
                _branch1_3.visible = TRUE;
                _branch1_3l_mask.visible = TRUE;
                _branch1_3r_mask.visible = TRUE;
                if (playerState == 0)
                    _clippingNode.stencil = _branch1_3l_mask;
                else
                    _clippingNode.stencil = _branch1_3r_mask;
            } else if (branchState == 3) {
                if (!forceBranch7 && arc4random_uniform(400) < 100) {
                    branching3_1 = TRUE;
                    branchState = 1;
                    obstacleHeight = OBSTACLE_HEIGHT_1;
                    forceBranch7 = TRUE;
                    _branch3_1.visible = TRUE;
                    _branch3_1l_mask.visible = TRUE;
                    _branch3_1r_mask.visible = TRUE;
                    if (playerState == 0)
                        _clippingNode.stencil = _branch3_1l_mask;
                    else
                        _clippingNode.stencil = _branch3_1r_mask;
                } else {
                    branching3_7 = TRUE;
                    branchState = 7;
                    obstacleHeight = OBSTACLE_HEIGHT_7;
                    _board_d7.visible = TRUE;
                    _branch3_7.visible = TRUE;
                    _branch3_7l_mask.visible = TRUE;
                    _branch3_7r_mask.visible = TRUE;
                    if (playerState == 0)
                        _clippingNode.stencil = _branch3_7l_mask;
                    else
                        _clippingNode.stencil = _branch3_7r_mask;
                }
            } else if (branchState == 7) {
                if (!branching7_3) {
                    [_board_d3 setPosition:ccp(160.0, 528.0)];
                }
                branching7_3 = TRUE;
                branchState = 3;
                obstacleHeight = OBSTACLE_HEIGHT_3;
                forceBranch7 = FALSE;
                _board_d3.visible = TRUE;
                _branch7_3.visible = TRUE;
                _branch7_3l_mask.visible = TRUE;
                _branch7_3r_mask.visible = TRUE;
                if (playerState == 0)
                    _clippingNode.stencil = _branch7_3l_mask;
                else
                    _clippingNode.stencil = _branch7_3r_mask;
            }
            branching = TRUE;
        }
        
        if (branching) {
            if (branching1_3) {
                [_board_d3 setPosition:ccp(_board_d3.position.x, _board_d3.position.y - speed * delta)];
                [_branch1_3 setPosition:ccp(_branch1_3.position.x, _branch1_3.position.y - speed * delta)];
                [_branch1_3l_mask setPosition:ccp(_branch1_3l_mask.position.x, _branch1_3l_mask.position.y - speed * delta)];
                [_branch1_3r_mask setPosition:ccp(_branch1_3r_mask.position.x, _branch1_3r_mask.position.y - speed * delta)];
                if (self.userInteractionEnabled == TRUE && _branch1_3l_mask.position.y <= BRANCH_WARNING_TIME) {
                    self.userInteractionEnabled = FALSE;
                    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/branch.caf"];
                }
                if (_branch1_3l_mask.position.y <= 0) {
                    _player3_1.visible = TRUE;
                    _player3_2.visible = TRUE;
                }
                if (_branch1_3.position.y <= -80) {
                    _player1.visible = FALSE;
                    _branch1_3.visible = FALSE;
                    _clippingNode.stencil = nil;
                    _branch1_3l_mask.visible = FALSE;
                    _branch1_3r_mask.visible = FALSE;
                    
                    [_branch1_3 setPosition:ccp(160.0, 570.0)];
                    [_branch1_3l_mask setPosition:ccp(160.0, 490.0)];
                    [_branch1_3r_mask setPosition:ccp(160.0, 490.0)];
                    [_board_d3 setPosition:ccp(160.0, -80.0)];
                    
                    [self changeBGColor];
                    [self increseDifficulty];
                    
                    branching = FALSE;
                    branching1_3 = FALSE;
                    [self resetBranchingTimer];
                    self.userInteractionEnabled = TRUE;
                }
            } else if (branching3_1) {
                [_board_d3 setPosition:ccp(_board_d3.position.x, _board_d3.position.y - speed * delta)];
                [_branch3_1 setPosition:ccp(_branch3_1.position.x, _branch3_1.position.y - speed * delta)];
                [_branch3_1l_mask setPosition:ccp(_branch3_1l_mask.position.x, _branch3_1l_mask.position.y - speed * delta)];
                [_branch3_1r_mask setPosition:ccp(_branch3_1r_mask.position.x, _branch3_1r_mask.position.y - speed * delta)];
                if (self.userInteractionEnabled == TRUE && _branch3_1l_mask.position.y <= BRANCH_WARNING_TIME) {
                    self.userInteractionEnabled = FALSE;
                    [self addBonusScore];
                    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/branch.caf"];
                }
                if (_branch3_1l_mask.position.y <= 0) {
                    _player1.visible = TRUE;
                }
                if (_branch3_1.position.y <= -80) {
                    _player3_1.visible = FALSE;
                    _player3_2.visible = FALSE;
                    _branch3_1.visible = FALSE;
                    _clippingNode.stencil = nil;
                    _branch3_1l_mask.visible = FALSE;
                    _branch3_1r_mask.visible = FALSE;
                    
                    [_board_d3 setPosition:ccp(160.0, 568.0)];
                    [_branch3_1 setPosition:ccp(160.0, 568.0)];
                    [_branch3_1l_mask setPosition:ccp(160.0, 488.0)];
                    [_branch3_1r_mask setPosition:ccp(160.0, 488.0)];
                    
                    [self changeBGColor];
                    [self increseDifficulty];
                    
                    branching = FALSE;
                    branching3_1 = FALSE;
                    [self resetBranchingTimer];
                    self.userInteractionEnabled = TRUE;
                }
            } else if (branching3_7) {
                [_board_d7 setPosition:ccp(_board_d7.position.x, _board_d7.position.y - speed * delta)];
                [_branch3_7 setPosition:ccp(_branch3_7.position.x, _branch3_7.position.y - speed * delta)];
                [_branch3_7l_mask setPosition:ccp(_branch3_7l_mask.position.x, _branch3_7l_mask.position.y - speed * delta)];
                [_branch3_7r_mask setPosition:ccp(_branch3_7r_mask.position.x, _branch3_7r_mask.position.y - speed * delta)];
                if (self.userInteractionEnabled == TRUE && _branch3_7l_mask.position.y <= BRANCH_WARNING_TIME) {
                    self.userInteractionEnabled = FALSE;
                    [self addBonusScore];
                    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/branch.caf"];
                }
                if (_branch3_7l_mask.position.y <= 0) {
                    _player7_1.visible = TRUE;
                    _player7_2.visible = TRUE;
                    _player7_3.visible = TRUE;
                    _player7_4.visible = TRUE;
                }
                if (_branch3_7.position.y <= -40) {
                    _player3_1.visible = FALSE;
                    _player3_2.visible = FALSE;
                    _branch3_7.visible = FALSE;
                    _clippingNode.stencil = nil;
                    _branch3_7l_mask.visible = FALSE;
                    _branch3_7r_mask.visible = FALSE;
                    
                    [_board_d3 setPosition:ccp(160.0, 568.0)];
                    [_branch3_7 setPosition:ccp(160.0, 568.0)];
                    [_branch3_7l_mask setPosition:ccp(160.0, 468.0)];
                    [_branch3_7r_mask setPosition:ccp(160.0, 468.0)];
                    [_board_d7 setPosition:ccp(160.0, -40.0)];
                    
                    [self changeBGColor];
                    [self increseDifficulty];
                    
                    branching = FALSE;
                    branching3_7 = FALSE;
                    [self resetBranchingTimer];
                    self.userInteractionEnabled = TRUE;
                }
            } else if (branching7_3) {
                [_board_d3 setPosition:ccp(_board_d3.position.x, _board_d3.position.y - speed * delta)];
                [_board_d7 setPosition:ccp(_board_d7.position.x, _board_d7.position.y - speed * delta)];
                [_branch7_3 setPosition:ccp(_branch7_3.position.x, _branch7_3.position.y - speed * delta)];
                [_branch7_3l_mask setPosition:ccp(_branch7_3l_mask.position.x, _branch7_3l_mask.position.y - speed * delta)];
                [_branch7_3r_mask setPosition:ccp(_branch7_3r_mask.position.x, _branch7_3r_mask.position.y - speed * delta)];
                if (self.userInteractionEnabled == TRUE && _branch7_3l_mask.position.y <= BRANCH_WARNING_TIME) {
                    self.userInteractionEnabled = FALSE;
                    [self addBonusScore];
                    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/branch.caf"];
                }
                if (_branch7_3l_mask.position.y <= 0) {
                    _player3_1.visible = TRUE;
                    _player3_2.visible = TRUE;
                }
                if (_branch7_3.position.y <= -40) {
                    _player7_1.visible = FALSE;
                    _player7_2.visible = FALSE;
                    _player7_3.visible = FALSE;
                    _player7_4.visible = FALSE;
                    _branch7_3.visible = FALSE;
                    _branch7_3l_mask.visible = FALSE;
                    _branch7_3r_mask.visible = FALSE;
                    
                    [_board_d7 setPosition:ccp(160.0, 568.0)];
                    [_branch7_3 setPosition:ccp(160.0, 568.0)];
                    [_branch7_3l_mask setPosition:ccp(160.0, 468.0)];
                    [_branch7_3r_mask setPosition:ccp(160.0, 468.0)];
                    [_board_d3 setPosition:ccp(160.0, -80.0)];
                    
                    [self changeBGColor];
                    [self increseDifficulty];
                    
                    branching = FALSE;
                    branching7_3 = FALSE;
                    [self resetBranchingTimer];
                    self.userInteractionEnabled = TRUE;
                }
            }
        } else
            timeToNextBranch--;
        
        if (timeToNextBranch == 50) {
            obstacleDropWait = 100;
        }
        
        // OBSTACLES
        if (obstacleDropWait <= 0 && _mostRecentDrop.position.y <= SCREEN_HEIGHT - (PLAYER_HEIGHT + obstacleHeight + dropFrequency)) {
            if (arc4random_uniform(100) < dropProbability ) {
                Obstacle *nextDrop = [self getNextDrop];
                if (nextDrop != nil) {
                    [nextDrop setBranchState:branchState];
                    [nextDrop enteringBoard];
                    numObstaclesInUse++;
                    [nextDrop setPosition:ccp([self nextDropLocation], 608.0)];
                    _mostRecentDrop = nextDrop;
                }
            }
        } else
            obstacleDropWait--;
        
        for (Obstacle *ob in _obstacles) {
            if (ob.isBeingUsed) {
                [ob setPosition:ccp(ob.position.x, ob.position.y - speed * delta)];
                
                if (ob.position.y <= PLAYER_HEIGHT + obstacleHeight && ob.position.y >= PLAYER_HEIGHT / 3) {
                    if ([ob getBranchState] == 1) {
                        if (ob.position.x - ob.boundingBox.size.width / 2 >= _player1.position.x && ob.position.x + ob.boundingBox.size.width / 2 <= _player1.position.x + 160) {
                            isPlaying = FALSE;
                            [self gameOver];
                        }
                    }
                    if ([ob getBranchState] == 3) {
                        if (ob.position.x - ob.boundingBox.size.width / 2 >= _player3_1.position.x && ob.position.x + ob.boundingBox.size.width / 2 <= _player3_1.position.x + 80) {
                            isPlaying = FALSE;
                            [self gameOver];
                        } else if (ob.position.x - ob.boundingBox.size.width / 2 >= _player3_2.position.x && ob.position.x + ob.boundingBox.size.width / 2 <= _player3_2.position.x + 80) {
                            isPlaying = FALSE;
                            [self gameOver];
                        }
                    }
                    if ([ob getBranchState] == 7) {
                        if (ob.position.x - ob.boundingBox.size.width / 2 >= _player7_1.position.x && ob.position.x + ob.boundingBox.size.width / 2 <= _player7_1.position.x + 40) {
                            isPlaying = FALSE;
                            [self gameOver];
                        } else if (ob.position.x - ob.boundingBox.size.width / 2 >= _player7_2.position.x && ob.position.x + ob.boundingBox.size.width / 2 <= _player7_2.position.x + 40) {
                            isPlaying = FALSE;
                            [self gameOver];
                        } else if (ob.position.x - ob.boundingBox.size.width / 2 >= _player7_3.position.x && ob.position.x + ob.boundingBox.size.width / 2 <= _player7_3.position.x + 40) {
                            isPlaying = FALSE;
                            [self gameOver];
                        } else if (ob.position.x - ob.boundingBox.size.width / 2 >= _player7_4.position.x && ob.position.x + ob.boundingBox.size.width / 2 <= _player7_4.position.x + 40) {
                            isPlaying = FALSE;
                            [self gameOver];
                        }
                    }
                }
                
                if (ob.position.y <= -50) {
                    [ob leavingBoard];
                    [ob setPosition:ccp(-100.0, 0)];
                    numObstaclesInUse--;
                    score += 1;
                    if (branchState == 3)
                        bonusCounter += 1;
                    else if (branchState == 7)
                        bonusCounter += 3;
                    [_scoreLabel setString:[@(score) stringValue]];
                    [_scoreLabel runAction:[CCActionSequence actions:[CCActionScaleTo actionWithDuration:0.1 scale:1.5],[CCActionScaleTo actionWithDuration:0.5 scale:1], nil]];
                    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/point.caf"];
                }
            }
        }
    }
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    if (isPlaying) {
        [self switchPlayer];
    } else if (isPaused) {
        [self pauseButtonPressed];
    }
}

- (void)switchPlayer {
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/slide.caf"];
    switch (playerState) {
        case 0:
            //if (_player1.position.x > 5) {
            //    return;
            //}
            [_player1 stopAllActions];
            [_player3_1 stopAllActions];
            [_player3_2 stopAllActions];
            [_player7_1 stopAllActions];
            [_player7_2 stopAllActions];
            [_player7_3 stopAllActions];
            [_player7_4 stopAllActions];
            [_player1 runAction:move1];
            [_player3_1 runAction:move31];
            [_player3_2 runAction:move32];
            [_player7_1 runAction:move71];
            [_player7_2 runAction:move72];
            [_player7_3 runAction:move73];
            [_player7_4 runAction:move74];
            playerState = 1;
            if (branching1_3)
                _clippingNode.stencil = _branch1_3r_mask;
            else if (branching3_1)
                _clippingNode.stencil = _branch3_1r_mask;
            else if (branching3_7)
                _clippingNode.stencil = _branch3_7r_mask;
            else if (branching7_3)
                _clippingNode.stencil = _branch7_3r_mask;
            break;
        case 1:
            //if (_player1.position.x < 155.0) {
            //    return;
            //}
            [_player1 stopAllActions];
            [_player3_1 stopAllActions];
            [_player3_2 stopAllActions];
            [_player7_1 stopAllActions];
            [_player7_2 stopAllActions];
            [_player7_3 stopAllActions];
            [_player7_4 stopAllActions];
            [_player1 runAction:move1b];
            [_player3_1 runAction:move31b];
            [_player3_2 runAction:move32b];
            [_player7_1 runAction:move71b];
            [_player7_2 runAction:move72b];
            [_player7_3 runAction:move73b];
            [_player7_4 runAction:move74b];
            playerState = 0;
            if (branching1_3)
                _clippingNode.stencil = _branch1_3l_mask;
            else if (branching3_1)
                _clippingNode.stencil = _branch3_1l_mask;
            else if (branching3_7)
                _clippingNode.stencil = _branch3_7l_mask;
            else if (branching7_3)
                _clippingNode.stencil = _branch7_3l_mask;
            break;
        default:
            break;
    }
}

- (void)addBonusScore {
    [_infoLabel setString:[NSString stringWithFormat:@"BONUS +%d", bonusCounter]];
    _infoLabel.visible = TRUE;
    [_infoLabel runAction:[CCActionSequence actions:[CCActionFadeIn actionWithDuration:0.2], [CCActionDelay actionWithDuration:0.7], [CCActionFadeOut actionWithDuration:0.3], [CCActionHide action], nil]];
    score += bonusCounter;
    bonusCounter = 0;
    [_scoreLabel setString:[@(score) stringValue]];
    [_scoreLabel runAction:[CCActionSequence actions:[CCActionScaleTo actionWithDuration:0.1 scale:1.5],[CCActionScaleTo actionWithDuration:0.5 scale:1], nil]];
    [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/point.caf"];
}

- (Obstacle *)getNextDrop {
    Obstacle *drop = nil;
    for (Obstacle *ob in _obstacles) {
        if (!ob.isBeingUsed) {
            drop = ob;
            return drop;
        }
    }
    return drop;
}

- (int)nextDropLocation {
    return (160 / (branchState + 1)) * (2 * (arc4random_uniform(branchState + 1) + 1) - 1);
}

- (void)resetBranchingTimer {
    timeToNextBranch = 600 + arc4random_uniform(600);
}

- (void)increseDifficulty {
    if (speed < MAX_SPEED)
        speed += SPEED_INCREMENT;
    if (dropFrequency > MAX_FREQUENCY)
        dropFrequency += FREQUENCY_INCREMENT;
    if (dropProbability < MAX_PROBABILITY) {
        dropProbability += PROBABILITY_INCREMENT;
    }
}

- (void)changeBGColor {
    NSArray *colors = [colorGen nextColor];
    CCColor *nsc = [colors objectAtIndex:0];
    CCColor *nec = [colors objectAtIndex:1];
    CCColor *noc = [colors objectAtIndex:2];
    
    CCActionTween *sRed = [CCActionTween actionWithDuration:2.0 key:@"startcolorR" from:_bgGradient.startcolorR to:nsc.red];
    CCActionTween *sGreen = [CCActionTween actionWithDuration:2.0 key:@"startcolorG" from:_bgGradient.startcolorG to:nsc.green];
    CCActionTween *sBlue = [CCActionTween actionWithDuration:2.0 key:@"startcolorB" from:_bgGradient.startcolorB to:nsc.blue];
    CCActionTween *eRed = [CCActionTween actionWithDuration:2.0 key:@"endcolorR" from:_bgGradient.endcolorR to:nec.red];
    CCActionTween *eGreen = [CCActionTween actionWithDuration:2.0 key:@"endcolorG" from:_bgGradient.endcolorG to:nec.green];
    CCActionTween *eBlue = [CCActionTween actionWithDuration:2.0 key:@"endcolorB" from:_bgGradient.endcolorB to:nec.blue];
    [_bgGradient runAction:[CCActionSequence actions:[CCActionSpawn actions:eRed, eGreen, eBlue, nil], [CCActionSpawn actions:sRed, sGreen, sBlue, nil], nil]];

    for (Obstacle *ob in _obstacles) {
        [ob runAction:[CCActionTintTo actionWithDuration:2.0 color:noc]];
    }
    
    [_startBackground colorize:noc];
}

- (void)gameOver {
    [_player1 runAction:[CCActionMoveTo actionWithDuration:0.5 position:ccp(_player1.position.x, -PLAYER_HEIGHT)]];
    [_player3_1 runAction:[CCActionMoveTo actionWithDuration:0.5 position:ccp(_player3_1.position.x, -PLAYER_HEIGHT)]];
    [_player3_2 runAction:[CCActionMoveTo actionWithDuration:0.5 position:ccp(_player3_2.position.x, -PLAYER_HEIGHT)]];
    [_player7_1 runAction:[CCActionMoveTo actionWithDuration:0.5 position:ccp(_player7_1.position.x, -PLAYER_HEIGHT)]];
    [_player7_2 runAction:[CCActionMoveTo actionWithDuration:0.5 position:ccp(_player7_2.position.x, -PLAYER_HEIGHT)]];
    [_player7_3 runAction:[CCActionMoveTo actionWithDuration:0.5 position:ccp(_player7_3.position.x, -PLAYER_HEIGHT)]];
    [_player7_4 runAction:[CCActionMoveTo actionWithDuration:0.5 position:ccp(_player7_4.position.x, -PLAYER_HEIGHT)]];
    
    [_board_d1 runAction:[CCActionFadeOut actionWithDuration:1.0]];
    [_board_d3 runAction:[CCActionFadeOut actionWithDuration:1.0]];
    [_board_d7 runAction:[CCActionFadeOut actionWithDuration:1.0]];
    
    if (branching1_3) {
        [_branch1_3 runAction:[CCActionFadeOut actionWithDuration:0.9]];
    } else if (branching3_1) {
        [_branch3_1 runAction:[CCActionFadeOut actionWithDuration:0.9]];
    } else if (branching3_7) {
        [_branch3_7 runAction:[CCActionFadeOut actionWithDuration:0.9]];
    } else if (branching7_3) {
        [_branch7_3 runAction:[CCActionFadeOut actionWithDuration:0.9]];
    }
    
    for (Obstacle *ob in _obstacles) {
        [ob leavingBoard];
        [ob runAction:[CCActionMoveTo actionWithDuration:0.5 position:ccp(ob.position.x, -50)]];
    }
    
    [_bgGradient stopAllActions];
    [self changeBGColor];
    
    [_startBackground replayScreen];
    CCAnimationManager *animationManager = _startBackground.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Default Timeline"];
    [_startBackground runAction:[CCActionFadeIn actionWithDuration:1.0]];
    [_startBackground fadeIn];
    
    [_scoreLabel runAction:[CCActionMoveTo actionWithDuration:0.5 position:ccp(160, 430)]];
    
    int highscore = 0;
    NSNumber *highscore_num = [[NSUserDefaults standardUserDefaults] objectForKey:HIGHSCORE_KEY];
    if (highscore_num != nil) {
        highscore = [highscore_num intValue];
    }
    
    if (score > highscore) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:score] forKey:HIGHSCORE_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        highscore = score;
        [[ABGameKitHelper sharedHelper] reportScore:score forLeaderboard:@"branch_highscore"];
        _highscoreLabel.color = [CCColor whiteColor];
        [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/highscore.caf"];
    } else {
        _highscoreLabel.color = [CCColor blackColor];
        [[OALSimpleAudio sharedInstance] playEffect:@"Sounds/gameover.caf"];
    }
    
    [_highscoreLabel setString:[@(highscore) stringValue]];
    [_highscoreLabel runAction:[CCActionFadeIn actionWithDuration:1.5]];
    
    [_scoreInfoLabel runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.5], [CCActionToggleVisibility action], nil]];
    [_highscoreInfoLabel runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.5], [CCActionToggleVisibility action], nil]];
    
    _pauseButton.visible = FALSE;
    
    [_helpButton runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.5], [CCActionToggleVisibility action], nil]];
    [_soundButton runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.5], [CCActionToggleVisibility action], nil]];
    
    
    [_playButtonFrame runAction:[CCActionFadeIn actionWithDuration:0.5]];
    [_leaderboardButtonFrame runAction:[CCActionFadeIn actionWithDuration:0.5]];
    [_scoreBorder runAction:[CCActionFadeIn actionWithDuration:0.5]];
    [_replayButton runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.5], [CCActionToggleVisibility action], nil]];
    [_menuButton runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:0.5], [CCActionToggleVisibility action], nil]];
}

- (void)tutorialClosed {
    _playButton.enabled = TRUE;
    _leaderboardButton.enabled = TRUE;
    _replayButton.enabled = TRUE;
    _menuButton.enabled = TRUE;
    _pauseButton.enabled = TRUE;
    if (!isPaused)
        [_screenShader setOpacity:0];
    if (!showingTutorialFirst) {
        showingTutorialFirst = TRUE;
        [[NSUserDefaults standardUserDefaults] setBool:showingTutorialFirst forKey:SHOW_TUT_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self playButtonPressed];
    }
}

@end
