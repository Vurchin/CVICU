//
//  Hypothermia.m
//  newCVICU
//
//  Created by Yicheng Wang on 4/4/15.
//  Copyright (c) 2015 Yicheng Wang. All rights reserved.
//

#import "Hypothermia.h"

NSString *backMsg;

@implementation Hypothermia

- (void)viewDidLoad{
    self.options = @[@"YES",@"NO"];
    self.optionTable.delegate = self;
    self.optionTable.dataSource = self;
}

#pragma mark - Table config

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.options count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bool" forIndexPath:indexPath];
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
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Hypoth"
                                                       object:backMsg];
}

@end
