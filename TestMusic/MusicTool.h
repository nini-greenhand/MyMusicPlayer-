
//  Created by uplooking on 15/10/14.
//  Copyright (c) 2015年 uplooking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <AVFoundation/AVFoundation.h>

@class Music;
@interface MusicTool : NSObject
singleton_interface(MusicTool)
@property(nonatomic,strong) AVAudioPlayer *player;

-(void)prepareToPlayWithMusic:(Music *)music;

-(void)play;

-(void)pause;

@end
