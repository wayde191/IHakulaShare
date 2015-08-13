//
//  XibView.h
//  IHakulaShare
//
//  Created by Wayde Sun on 1/31/15.
//  Copyright (c) 2015 IHakula. All rights reserved.

#import "XibViewUtils.h"

@implementation XibViewUtils

+ (id)loadViewFromXibNamed:(NSString*)xibName withFileOwner:(id)fileOwner {
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:xibName owner:fileOwner options:nil];
    if (array && [array count]) {
        return array[0];
    }else {
        return nil;
    }
}

+ (id)loadViewFromXibNamed:(NSString*)xibName {
    return [XibViewUtils loadViewFromXibNamed:xibName withFileOwner:nil];
}

@end
