//
//  NGViewController.h
//  Toe Tac Tic
//
//  Created by Neetesh Gupta on 13/01/13.
//  Copyright (c) 2013 Neetesh Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "math.h"
#import <QuartzCore/QuartzCore.h>
#import <stdlib.h>

char matrix[3][3];

@interface NGViewController : UIViewController
@property int grid_x;
@property int grid_y;
@property int grid_w;
@property int grid_h;
@property int turn;
@property char firstMove;
@property int cellWidth;

@property NSMutableArray *gamestate ;
@property UILabel *gameStatus ;
@property UIView* infoMenu;
@property UIImageView *imgView;
@end
