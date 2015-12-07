//
//  MusicCell.h
//  TestMusic
//
//  Created by uplooking on 15/10/14.
//  Copyright (c) 2015年 uplooking. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Music;
@interface MusicCell : UITableViewCell
+(instancetype)musicCellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) Music *music;
@end
