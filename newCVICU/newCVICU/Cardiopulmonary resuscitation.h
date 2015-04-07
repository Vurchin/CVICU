//
//  Cardiopulmonary resuscitation.h
//  newCVICU
//
//  Created by Yicheng Wang on 4/4/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cardiopulmonary_resuscitation : UIViewController

@property NSMutableDictionary *report;
@property (weak, nonatomic) IBOutlet UITextField *startdate;
@property (weak, nonatomic) IBOutlet UITextField *enddate;
@property (weak, nonatomic) IBOutlet UITextField *startfield;
@property (weak, nonatomic) IBOutlet UITextField *endField;
@property NSMutableData *dataChunk;

@end
