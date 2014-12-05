//
//  GameSceneViewController.m
//  MemoryGame
//
//  Created by Jeon BooSang on 2014. 12. 4..
//  Copyright (c) 2014년 Jeon BooSang. All rights reserved.
//

#import "GameSceneViewController.h"

@interface GameSceneViewController ()

@property UIImage *blankTileImage;
@property UIImage *backTileImage;
@property NSMutableArray *tiles;
@property NSMutableArray *shuffledTiles;
@property NSInteger matchCounter;
@property NSInteger guessCounter;
@property NSInteger tileFlipped;
@property UIButton *tile1;
@property UIButton *tile2;

- (void) shuffleTiles;
- (void) resetTiles;
- (void) gameWon;

@end

@implementation GameSceneViewController
static bool isDiabled = false;
static bool isMatch = false;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.backTileImage = [UIImage imageNamed:@"back.png"];
    self.blankTileImage = [UIImage imageNamed:@"blank.png"];
    
    self.tileFlipped = -1;
    self.matchCounter = 0;
    self.guessCounter = 0;
    
    self.gameScoreLabel.text = [NSString stringWithFormat:@"Match %ld Guesses: %ld", self.matchCounter, self.guessCounter];
    
    self.tiles = [[NSMutableArray alloc]initWithObjects:
                  [UIImage imageNamed:@"icons01.png"],
                  [UIImage imageNamed:@"icons01.png"],
                  [UIImage imageNamed:@"icons02.png"],
                  [UIImage imageNamed:@"icons02.png"],
                  [UIImage imageNamed:@"icons03.png"],
                  [UIImage imageNamed:@"icons03.png"],
                  [UIImage imageNamed:@"icons04.png"],
                  [UIImage imageNamed:@"icons04.png"],
                  [UIImage imageNamed:@"icons05.png"],
                  [UIImage imageNamed:@"icons05.png"],
                  [UIImage imageNamed:@"icons06.png"],
                  [UIImage imageNamed:@"icons06.png"],
                  [UIImage imageNamed:@"icons07.png"],
                  [UIImage imageNamed:@"icons07.png"],
                  [UIImage imageNamed:@"icons08.png"],
                  [UIImage imageNamed:@"icons08.png"],
                  [UIImage imageNamed:@"icons09.png"],
                  [UIImage imageNamed:@"icons09.png"],
                  [UIImage imageNamed:@"icons10.png"],
                  [UIImage imageNamed:@"icons10.png"],
                  [UIImage imageNamed:@"icons11.png"],
                  [UIImage imageNamed:@"icons11.png"],
                  [UIImage imageNamed:@"icons12.png"],
                  [UIImage imageNamed:@"icons12.png"],
                  [UIImage imageNamed:@"icons13.png"],
                  [UIImage imageNamed:@"icons13.png"],
                  [UIImage imageNamed:@"icons14.png"],
                  [UIImage imageNamed:@"icons14.png"],
                  [UIImage imageNamed:@"icons15.png"],
                  [UIImage imageNamed:@"icons15.png"],
                  nil];
    
    [self shuffleTiles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)tileClicked:(id)sender
{
    if (isDiabled == true)
        return;

    int senderId = (int)[sender tag];
    NSLog(@"Our ID is : %d\n", senderId);
    
    if (self.tileFlipped >= 0 && senderId != self.tileFlipped)
    {
        self.tile2 = sender;
       
        UIImage *lastImage = [self.tiles objectAtIndex:self.tileFlipped];
        UIImage *tileImage = [self.tiles objectAtIndex:senderId];
    
        [sender setImage: tileImage forState:UIControlStateNormal];
        self.guessCounter++;

        CGImageRef tile1Ref = tileImage.CGImage;
        CGImageRef tile2Ref = lastImage.CGImage;
        if (tile1Ref == tile2Ref)
        {
            NSLog(@"MATCHING TILES");
            [self.tile1 setEnabled:false];
            [self.tile2 setEnabled:false];
            self.matchCounter++;
            isMatch = true;
        }
        isDiabled = true;
        
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(resetTiles) userInfo:nil repeats:NO];
        self.tileFlipped = -1;
    } else {
        self.tileFlipped = senderId;
        self.tile1 = sender;
        UIImage *tileImage = [self.tiles objectAtIndex:senderId];
        [sender setImage: tileImage forState:UIControlStateNormal];
    }
    
    self.gameScoreLabel.text = [NSString stringWithFormat:@"Matches: %ld Guesses: %ld", self.matchCounter, self.guessCounter];
};

- (void)shuffleTiles
{
    int tileCount = (int)[self.tiles count];
    for (int tileId = 0; tileId < (tileCount/2); tileId++)
    {
        [self.shuffledTiles addObject:[NSNumber numberWithInt:tileId]];
        [self.shuffledTiles addObject:[NSNumber numberWithInt:tileId]];
    }
    
    for (NSUInteger i = 0; i < tileCount; ++i) {
        NSInteger nElements = tileCount - i;
        NSInteger n = (arc4random() % nElements) + i;
        [self.shuffledTiles exchangeObjectAtIndex:i withObjectAtIndex:n];
        [self.tiles exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

- (void)resetTiles
{
    if (isMatch)
    {
        [self.tile1 setImage: self.blankTileImage forState:UIControlStateNormal];
        [self.tile2 setImage: self.blankTileImage forState:UIControlStateNormal];
    } else {
        [self.tile1 setImage: self.backTileImage forState:UIControlStateNormal];
        [self.tile2 setImage: self.backTileImage forState:UIControlStateNormal];
    }
    isDiabled = false;
    isMatch = false;

    if (self.matchCounter == (self.tiles.count/2))
        [self gameWon];
}

- (void)gameWon
{
    self.gameScoreLabel.text = [NSString stringWithFormat:@"You won with %ld Guesses", self.guessCounter];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

@end
