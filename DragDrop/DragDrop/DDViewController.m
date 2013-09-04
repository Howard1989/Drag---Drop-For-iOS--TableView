//
//  DDViewController.m
//  DragDrop
//
//  Created by Haodan Huang on 8/25/13.
//  Copyright (c) 2013 Haodan Huang. All rights reserved.
//

#import "DDViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DDViewController ()

@end

@implementation DDViewController

@synthesize modelTable;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //init
    module = [[NSMutableArray alloc] initWithObjects:@"fruit",@"animal", @"human", nil];
    NSMutableArray *animal = [[NSMutableArray alloc] initWithObjects:@"tiger",@"monkey", @"lion",@"pig",@"rabbit" ,nil];
    NSMutableArray *fruit = [[NSMutableArray alloc] initWithObjects:@"apple",@"pear", @"peach",@"keyvee",@"banana",@"coconut",nil];
    NSMutableArray *human = [[NSMutableArray alloc] initWithObjects:@"yellow",@"white",@"black",nil];
    subModule = [[NSMutableDictionary alloc] initWithObjectsAndKeys:animal,@"animal",fruit,@"fruit",human,@"human", nil];
    
    
    [self.storyboard instantiateViewControllerWithIdentifier:@"DDViewController"];
    modelTable.delegate = self;
    modelTable.dataSource = self;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [module count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[subModule objectForKey:[module objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.textLabel.text = [[subModule objectForKey:[module objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [cell addGestureRecognizer:longPress];
    
    
    return cell;
}

- (IBAction)longPress:(UIGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        // figure out which item in the table was selected
        
       
        NSLog(@"start!\n");
        NSIndexPath *indexPath = [self.modelTable indexPathForRowAtPoint:[sender locationInView:self.modelTable]];
        
        UITableViewCell *cell = [modelTable cellForRowAtIndexPath:indexPath];
        NSLog(@"%@",cell.textLabel.text);
        
        UIGraphicsBeginImageContextWithOptions(cell.bounds.size, cell.opaque, 0.0);
        [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        
        UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
        draggedView = [[UIView alloc] init];
        draggedView.frame = cell.frame;
        UIImageView *iv = [[UIImageView alloc] initWithImage:img];
        [draggedView addSubview:iv];
     //   draggedView = cell;
        
        [self.view addSubview: draggedView];
        
        CGPoint point = [sender locationInView:self.view];
        draggedView.center = point;
        
        [[subModule objectForKey:[module objectAtIndex:indexPath.section]] removeObjectAtIndex:indexPath.row];
        [modelTable deleteRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        // we dragged it, so let's update the coordinates of the dragged view
        NSLog(@"change!\n");
        
        
        UIView *splitView = self.view;
        CGPoint point = [sender locationInView:splitView];
        draggedView.center = point;
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        // we dropped, so remove it from the view
        NSLog(@"finish!\n");
        [draggedView removeFromSuperview];
        
        NSIndexPath *indexPath = [self.modelTable indexPathForRowAtPoint:[sender locationInView:self.modelTable]];
        
        UITableViewCell *cell = [modelTable cellForRowAtIndexPath:indexPath];
        NSLog(@"%@",cell.textLabel.text);
        
        
        [[subModule objectForKey:[module objectAtIndex:indexPath.section]] insertObject:@"new" atIndex:indexPath.row];
        [modelTable insertRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
        
        
        // and let's figure out where we dropped it
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}



@end
