//
//  CPR Options.h
//  newCVICU
//
//  Created by Yicheng Wang on 4/4/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPR_Options : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSArray *options;
@property (weak, nonatomic) IBOutlet UITableView *optionTable;

@end
