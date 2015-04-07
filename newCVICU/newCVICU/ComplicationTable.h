//
//  ComplicationTable.h
//  newCVICU
//
//  Created by Yicheng Wang on 4/4/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cardiopulmonary resuscitation.h"

@interface ComplicationTable : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *ComplicationTable;
@property NSMutableArray *ComplicationList;
@property NSMutableDictionary *report;

@end
