//
//  MusicCell.m
//  TestMusic
//
//  Created by uplooking on 15/10/14.
//  Copyright (c) 2015年 uplooking. All rights reserved.
//

#import "MusicCell.h"
#import "Music.h"


@implementation MusicCell

+(instancetype)musicCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"MusicCell";
    return [tableView dequeueReusableCellWithIdentifier:ID];
    
}
-(void)setMusic:(Music *)music{

    _music = music;
   self.textLabel.text = music.name;
    
   self.detailTextLabel.text = music.singer;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
