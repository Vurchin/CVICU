//
//  ViewController.h
//  newCVICU
//
//  Created by Yicheng Wang on 4/4/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customTextField.h"

@interface ViewController : UIViewController <NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIButton *loginbutton;
@property (weak, nonatomic) IBOutlet customTextField *userfield;
@property (weak, nonatomic) IBOutlet customTextField *passfield;
@property NSMutableData *dataChunk;

@end

