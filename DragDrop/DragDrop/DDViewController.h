//
//  DDViewController.h
//  DragDrop
//
//  Created by Haodan Huang on 8/25/13.
//  Copyright (c) 2013 Haodan Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>

@interface DDViewController : UIViewController < UITableViewDataSource, UITableViewDelegate>{
    
    NSMutableArray *module;
    NSMutableDictionary *subModule;

    UIView *draggedView;
    
}


@property (weak, nonatomic) IBOutlet UITableView *modelTable;

@end
