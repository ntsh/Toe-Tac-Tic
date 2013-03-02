//
//  NGViewController.m
//  Toe Tac Tic
//
//  Created by Neetesh Gupta on 13/01/13.
//  Copyright (c) 2013 Neetesh Gupta. All rights reserved.
//

#import "NGViewController.h"
#import "NGGameView.h"
int gameMode = 1;
@interface NGViewController ()

@end

@implementation NGViewController

@synthesize grid_h,grid_w,grid_x,grid_y,turn;
@synthesize firstMove, cellWidth;
@synthesize gamestate,gameStatus,infoMenu,imgView;

- (void) viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[self drawInterface];
    //[self computerMove];
     //1 player OR 2 player mode
    firstMove = 'p'; // p = phone , h = human
    cellWidth = 100;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initVars
{
    grid_x = 10;
    grid_y = 150;
    grid_w = 300;
    grid_h = 300;
    turn = 1;
    

    for(int i = 0; i <3; i++)
        for( int j = 0; j<3; j++)
            matrix[i][j]='2';
    return;
}

- (void) loadView
{
    //Adding View Programmatically
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    UIView *contentView = [[UIView alloc] initWithFrame:applicationFrame];
    contentView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.0];
    self.view = contentView;

    [self initVars];
    CGFloat scrheight = [UIScreen mainScreen].bounds.size.height;
    CGFloat scrwidth = [UIScreen mainScreen].bounds.size.width;
    NSLog(@"width = %f, height = %f",scrwidth, scrheight);
    
    //*Adding tictactoe grid
    CGRect imageRect = CGRectMake(grid_x,grid_y,grid_w,grid_h);
    UIImage *grid_img = [UIImage imageNamed:@"grid"];
    imgView = [[UIImageView alloc] initWithFrame:imageRect];
    [imgView setImage:grid_img];
    [imgView setBounds:imageRect];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.backgroundColor = [UIColor whiteColor];
    /*imgView.layer.shadowColor = [UIColor grayColor].CGColor;
    imgView.layer.shadowOffset = CGSizeMake(-15, 20);
    imgView.layer.shadowRadius = 5;*/
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:imgView.bounds];
    imgView.layer.masksToBounds = NO;
    imgView.layer.shadowColor = [UIColor grayColor].CGColor;
    imgView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    imgView.layer.shadowOpacity = 0.5f;
    imgView.layer.shadowPath = shadowPath.CGPath;
    [self.view addSubview:imgView];
    
    //Adding Top Label and reload button
    CGRect  viewRect = CGRectMake(10, -100, scrwidth - 20, 60);
    infoMenu = [[UIView alloc] initWithFrame:viewRect];
    [infoMenu setBackgroundColor:[UIColor whiteColor]];
    shadowPath = [UIBezierPath bezierPathWithRect:infoMenu.bounds];
    infoMenu.layer.masksToBounds = NO;
    infoMenu.layer.shadowColor = [UIColor blackColor].CGColor;
    infoMenu.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    infoMenu.layer.shadowOpacity = 0.5f;
    infoMenu.layer.shadowPath = shadowPath.CGPath;
    //[infoMenu setAlpha:0.6];
    //[self.view addSubview:infoMenu];
    
    CGRect gameStatusLabelPosition = CGRectMake(10, 10, 200, 40);
    gameStatus = [[UILabel alloc] initWithFrame:gameStatusLabelPosition];
    [gameStatus setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:32]];
    gameStatus.text = @"New Game";
    [infoMenu addSubview:gameStatus];
    
    //Adding segments for selecting number of players
    NSArray *itemArray = [NSArray arrayWithObjects:
                                @"v/s Human", @"v/s Phone", nil];
    UISegmentedControl *numOfPlayersToggle = [[UISegmentedControl alloc]
                                                    initWithItems:itemArray];
    numOfPlayersToggle.frame =  CGRectMake(10,10,300,50);
    [numOfPlayersToggle setWidth:150 forSegmentAtIndex:1];
    [numOfPlayersToggle setWidth:150 forSegmentAtIndex:0];
    [numOfPlayersToggle setEnabled:true forSegmentAtIndex:0];
    numOfPlayersToggle.selectedSegmentIndex = gameMode;
    //numOfPlayersToggle.segmentedControlStyle = UISegmentedControlStyleBezeled;
    //[numOfPlayersToggle setTintColor:[UIColor blackColor]];
    [self.view addSubview:numOfPlayersToggle];
    [numOfPlayersToggle addTarget:self
                           action:@selector(changePlayMode:)
                 forControlEvents:UIControlEventValueChanged] ;
    
    //Adding game information on the extra space of iPhone 5
    CGRect  viewRect2 = CGRectMake(10, 480, scrwidth - 20, 60);
    if (scrheight < 568) viewRect2 = CGRectMake( 10, 75, 300, 60);
    UIView *gameinfoMenu = [[UIView alloc] initWithFrame:viewRect2];
    [gameinfoMenu setBackgroundColor:[UIColor whiteColor]];
    shadowPath = [UIBezierPath bezierPathWithRect:gameinfoMenu.bounds];
    gameinfoMenu.layer.masksToBounds = NO;
    gameinfoMenu.layer.shadowColor = [UIColor blackColor].CGColor;
    gameinfoMenu.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    gameinfoMenu.layer.shadowOpacity = 0.5f;
    gameinfoMenu.layer.shadowPath = shadowPath.CGPath;
    //[infoMenu setAlpha:0.6];
    [self.view addSubview:gameinfoMenu];
    
    CGRect gameinfoLabelPosition = CGRectMake(10, 10, 280, 40);
    UILabel *gameinfo = [[UILabel alloc] initWithFrame:gameinfoLabelPosition];
    [gameinfo setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight"size:24]];
    gameinfo.text = @"ToeTacTic - Play to Lose";
    [gameinfoMenu addSubview:gameinfo];
    
    if(gameMode == 1 && firstMove == 'p' && turn == 1)
    {
        [self computerMove];
        firstMove = 'h';
    }
    if(gameMode == 1 && firstMove == 'h' && turn == 1)
    {
        firstMove = 'p';
    }

}

-(void)changePlayMode:(id)sender
{
    gameMode = [sender selectedSegmentIndex];
    NSLog(@"Mode changed to %d player",gameMode);
    [self.view setNeedsDisplay];
    [self loadView];
    return;
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    NSLog(@"touched at %f,%f",touchLocation.x,touchLocation.y);
    
    int touchx = touchLocation.x - grid_x;
    int touchy = touchLocation.y - grid_y;
    if((touchy > 0 && touchy < grid_h) && (touchx > 0 && touchx < grid_w))
    {
        int touch_column = (int) touchx * 3 / grid_w;
        int touch_row = (int) touchy * 3 / grid_h;
        [self move:touch_row :touch_column];
    }
}

-(void) move:(int)row :(int)column
{
    char player = [self currentPlayer];
    char grid_cell_status = matrix[row][column];
    if(turn > 9)
    {
        //NSLog(@" Turn = 10");
        [self.view setNeedsDisplay];
        [self loadView];
        return;
    }
    if(grid_cell_status != '2')
    {
        //NSLog(@"cheating");
        return;
    }
    
    [self processMove:player :row :column];
    if(gameMode == 1 && turn <= 9)
        [self computerMove];
    
    /*NSLog(@"---");
    NSLog(@"%s",matrix[0]);
    NSLog(@"%s",matrix[1]);
    NSLog(@"%s",matrix[2]);*/
}

-(void) computerMove
{
    char player = [self currentPlayer];
    char human = 'X';
    if (player == 'X') human = 'O';
    int xc,yc;
    int found = 0;
    int possibleMoves_x[9];
    int possibleMoves_y[9];
    int numberOfPossibleMoves = 0;
    int checkPosition_phone=0;
    int checkPosition_human=0;
    int safemove[2];
    int hasSafeMove = 0;
    char oldChar = '2';
    for(int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            if(matrix[i][j] == '2')
            {
                xc = i;
                yc = j;
                found = 1;
                oldChar = matrix[i][j];   //in next 6 lines we are checking
                matrix[i][j] = player;    //if a particular cell was  a possible
                checkPosition_phone = [self check_loss:player :i :j]; //
                matrix[i][j] = human;    //  lose situation for either X or O ,
                checkPosition_human = [self check_loss:human :i :j]; //  hence
                matrix[i][j] = oldChar;   // a possible move to avoid
                NSLog(@"checkPosition_player = %d, checkPosition_opponent = %d",checkPosition_phone,checkPosition_human);
                if(checkPosition_human == 0 && checkPosition_phone == 0)
                {
                    possibleMoves_x[numberOfPossibleMoves] = i;
                    possibleMoves_y[numberOfPossibleMoves] = j;
                    numberOfPossibleMoves++;
                    NSLog(@"(%d,%d) in next moves",i,j);
                }
                else
                {
                    if (checkPosition_phone == 0)
                    {
                        safemove[0] = i;
                        safemove[1] = j;
                        hasSafeMove = 1;
                    }
                    NSLog(@"(%d,%d) not in next moves",i,j);
                }
                //break;
            }
            else
            {
               //NSLog(@"NOPE, xc = %d, yc = %d",xc,yc);
            }
        }
        
        //if (found == 1) break;
        //found = 0;
    }
    NSLog(@"Number of possible moves = %d",numberOfPossibleMoves);
    //NSLog(@"hmm, xc = %d, yc = %d",xc,yc);
    if(numberOfPossibleMoves > 0)
    {
        int temp = arc4random() % (numberOfPossibleMoves);
        NSLog(@"temp = %d",temp);
        xc = possibleMoves_x[temp];
        yc = possibleMoves_y[temp];
    }
    else if(numberOfPossibleMoves == 0 && hasSafeMove == 1)
    {
        xc = safemove[0];
        yc = safemove[1];
    }
    NSLog(@"computer move : %d,%d",xc,yc);
    
    [self processMove:player :xc :yc];    
    return;
}

- (void) processMove:(char)player :(int)row :(int)column
{
    NSLog(@"Processing %c move : %d,%d",player,row,column);
    NSString* msg;
    [self addMoveImage :row :column];
    matrix[row][column]=player;
    turn++;
    int hasLost = 0;
    if(turn > 4) hasLost = [self check_loss:player:row:column];
    //if(hasLost==0) return;
    if(hasLost >= 1)
    {
        turn = 10;
        //NSLog(@"--- %c has lost ",player);
        //[self drawGameOverLine];
        int startx,starty,endx,endy;
        if(hasLost == 1)
        {
            startx = 0;
            endx = 3 * cellWidth;
            starty = endy =  row * cellWidth + cellWidth / 2;
            //NSLog(@"row line");
        }
        if(hasLost == 2)
        {
            starty = 0;
            endy = 3 * cellWidth;
            endx = startx = column * cellWidth + cellWidth / 2;
            //NSLog(@"Column line");
        }
        if(hasLost == 3)
        {
            startx = starty = 0;
            endx = endy = grid_w;
        }
        if(hasLost == 4)
        {
            startx = endy = grid_w;
            starty = endx = 0;
        }
        [self drawGameOverLine:startx:starty:endx:endy];
        msg = [NSString stringWithFormat:@"Player %c Lost",player];
        [self showGameOverMsg:msg];
        return ;
    }
    if(turn > 9) //draw
    {
        msg = [NSString stringWithFormat:@"Game Drawn"];
        [self showGameOverMsg:msg];
    }
}

-(char) currentPlayer
{
    if(turn%2 == 0) return 'O';
    else return 'X';
}

- (int) check_loss:(char)player :(int)row :(int)column
{
    int hor = 0;
    int ver = 0;
    int diag = 0;
    int rdiag = 0;
    for (int i = 0; i < 3; i++)
    {
        if(matrix[i][column] == player) ver++;
        if(matrix[row][i] == player) hor++;
        if(matrix[i][i] == player) diag++;
        if(matrix[i][2-i] == player) rdiag++;
    }
    if(hor == 3) return 1;
    if(ver == 3) return 2;
    if(diag == 3) return 3;
    if(rdiag == 3) return 4;

    return 0;
}

-(void) addMoveImage :(int)row :(int)column
{
    NSString *imgName;
    if([self currentPlayer] == 'O') imgName = @"o";
    else imgName = @"x";
    CGRect imageRect = CGRectMake(grid_x + column*100 +10,
                                  grid_y + row*100 +10,
                                  grid_w/3 -25,
                                  grid_h/3 -25);
    
    UIImage *grid_img = [UIImage imageNamed:imgName];
    //UIImageView *imgView = [[UIImageView alloc] initWithFrame:imageRect];
    imgView = [[UIImageView alloc] initWithFrame:imageRect];
    [imgView setImage:grid_img];
    [imgView setBounds:imageRect];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.alpha = 0;
    [self.view addSubview:imgView];
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         imgView.alpha = 1.0;
                     }
                     completion:^(BOOL finished){}];

}

-(void) drawGameOverLine: (int)startx : (int)starty : (int)endx : (int)endy
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(grid_x+startx,grid_y+starty)];
    [path addLineToPoint:CGPointMake(grid_x+endx,grid_y+endy)];
   
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.view.bounds;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [[UIColor blackColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 2.0f;
    pathLayer.lineJoin = kCALineCapRound;
    
    [self.view.layer addSublayer:pathLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation
                                       animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

-(void) showGameOverMsg: (NSString *)msg
{
    gameStatus.text = [NSString stringWithFormat:@"%@",msg];
    [self.view addSubview:infoMenu];
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         infoMenu.frame = CGRectMake( 10, 75, 300, 60);
                     }
                     completion:^(BOOL finished){}];
}

@end
