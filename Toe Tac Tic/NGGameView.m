//
//  NGGameView.m
//  Toe Tac Tic
//
//  Created by Neetesh Gupta on 14/01/13.
//  Copyright (c) 2013 Neetesh Gupta. All rights reserved.
//

#import "NGGameView.h"

@implementation NGGameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGFloat red[4] = {1.0f, 0.0f, 0.0f, 1.0f};
    CGContextSetStrokeColor(c, red);
    CGContextSetLineWidth(c, 4.0);
    
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, 80.0f, 5.0f);
    CGContextAddLineToPoint(c, 80.0f, 240.0f);
    CGContextStrokePath(c);
    
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, 160.0f, 5.0f);
    CGContextAddLineToPoint(c, 160.0f, 240.0f);
    CGContextStrokePath(c);
    
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, 0.0f, 80.0f);
    CGContextAddLineToPoint(c, 240.0f, 80.0f);
    CGContextStrokePath(c);

    CGContextBeginPath(c);
    CGContextMoveToPoint(c, 0.0f, 160.0f);
    CGContextAddLineToPoint(c, 240.0f, 160.0f);
    CGContextStrokePath(c);

}



@end
