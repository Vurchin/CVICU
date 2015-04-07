//
//  CPR Options.m
//  newCVICU
//
//  Created by Yicheng Wang on 4/4/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import "CPR Options.h"

NSString *backMsg;

@implementation CPR_Options

- (void)viewDidLoad{
    self.options = @[@"ROSC",@"ECMO",@"DEATH"];
    self.optionTable.delegate = self;
    self.optionTable.dataSource = self;
}


#pragma mark - Table config

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.options count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CPRoption" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.options[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    backMsg = self.options[indexPath.row];
    [self sendBackMsg];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - notification

- (void)sendBackMsg{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CPRoptions"
                                                       object:backMsg];
}


@end
