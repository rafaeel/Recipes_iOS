//
//  ShowRecipesViewController.m
//  Recipe_iOS
//
//  Created by Rafael on 4/19/13.
//  Copyright (c) 2013 Rafael. All rights reserved.
//

#import "ShowRecipesViewController.h"
#import "ShowRecipeDetailViewController.h"

@interface ShowRecipesViewController ()<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>
{
    NSMutableData *webData;
    NSURLConnection *con;
    NSMutableArray *array;
}

@end

@implementation ShowRecipesViewController

@synthesize TableView;
@synthesize nameOfArray;
@synthesize Transf;
@synthesize recipes;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.title = @"Show Recipes";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[self TableView]setDelegate:self];
    [[self TableView]setDataSource:self];
    array = [[NSMutableArray alloc] init];
    
    //NSURL * url =[[NSURL alloc] initWithString: @"http://192.168.1.101:3000/prescriptions.json"]; //casa
    NSURL * url =[[NSURL alloc] initWithString: @"http://192.168.0.25:3000/prescriptions.json"]; //RubyThree
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    con = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (con) {
        webData = [[NSMutableData alloc]init];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"FAILED");
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *allDataDictioray = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    
    for (NSDictionary *diction in allDataDictioray) {
        nameOfArray = [diction objectForKey:@"prescription"];
        NSLog(@"%@", allDataDictioray);
        NSString *label = [nameOfArray valueForKey:@"name"];
        
        [array addObject:label];
    }
    [[self TableView]reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    ShowRecipeDetailViewController *recipeDetailViewController = [[ShowRecipeDetailViewController alloc]init];
    recipeDetailViewController.recipeDetails = self.nameOfArray[indexPath.row];
    Transf = nameOfArray[indexPath.row];
    
    NSLog(@"Erro: %@", Transf);
    [self.navigationController pushViewController:recipeDetailViewController animated:YES];
    
}

@end
