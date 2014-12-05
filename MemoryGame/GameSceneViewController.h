//
//  GameSceneViewController.h
//  MemoryGame
//
//  Created by Jeon BooSang on 2014. 12. 4..
//  Copyright (c) 2014년 Jeon BooSang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameSceneViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonViews;
@property (weak, nonatomic) IBOutlet UILabel *gameScoreLabel;

- (IBAction)tileClicked:(id)sender;
@end
