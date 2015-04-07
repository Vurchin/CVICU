//
//  MainBoard.h
//  newCVICU
//
//  Created by Yicheng Wang on 4/4/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "patientsBoard.h"

@interface MainBoard : UIViewController <NSURLConnectionDataDelegate>

@property NSMutableData *dataChunk;
@property NSMutableArray *sendinglist;

@end
