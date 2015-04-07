//
//  customTextField.h
//  CoppeWeb
//
//  Created by Xinyue Deng on 12/22/14.
//  Copyright (c) 2014 Yicheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customTextField : UITextField
- (CGRect)textRectForBounds:(CGRect)bounds;
- (CGRect)editingRectForBounds:(CGRect)bounds;
@end
