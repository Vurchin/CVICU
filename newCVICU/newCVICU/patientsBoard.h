//
//  patientsBoard.h
//  newCVICU
//
//  Created by Yicheng Wang on 4/4/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComplicationTable.h"

@interface patientsBoard : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *patientTable;
@property NSMutableArray *patientList;
@property NSMutableDictionary *report;

@end
