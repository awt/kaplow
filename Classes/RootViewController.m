//
//  RootViewController.m
//  Comic Reader
//
//  Created by Adam Thorsen on 11/8/08.
//  Copyright Owyhee Software, LLC 2008. All rights reserved.
//

#import "RootViewController.h"
#import "Comic_ReaderAppDelegate.h"
#import "ComicViewController.h"
#include <libtar.h>
#include <zlib.h>
int gzopen_frontend(char *pathname, int oflags, int mode)
{
	char *gzoflags;
	gzFile gzf;
	int fd;

	switch (oflags & O_ACCMODE)
	{
	case O_WRONLY:
		gzoflags = "wb";
		break;
	case O_RDONLY:
		gzoflags = "rb";
		break;
	default:
	case O_RDWR:
		errno = EINVAL;
		return -1;
	}

	fd = open(pathname, oflags, mode);
	if (fd == -1)
		return -1;

	if ((oflags & O_CREAT) && fchmod(fd, mode))
		return -1;

	gzf = gzdopen(fd, gzoflags);
	if (!gzf)
	{
		errno = ENOMEM;
		return -1;
	}

	return (int)gzf;
}

tartype_t gztype = { (openfunc_t) gzopen_frontend, (closefunc_t) gzclose,
	(readfunc_t) gzread, (writefunc_t) gzwrite
};

@implementation RootViewController

- (void)awakeFromNib {
  
  self.title = NSLocalizedString(@"Kaplow!", @"Master view navigation title");
  options = [[NSArray arrayWithObjects:@"My Library", @"Online Catalog", nil] retain];
  NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"file:///Users/awt/shade.tar.gz"]
                                         cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:60.0];
  
  NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
  if (theConnection) {
      receivedData=[[NSMutableData data] retain];
  } 
  else {

  }

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
    [receivedData release];
 
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    NSString *documentsDirectory = [NSString documentsDirectory];
    if (!documentsDirectory) {
        NSLog(@"Documents directory not found!");
        return NO;
    }

    NSString *tarball = [documentsDirectory stringByAppendingPathComponent:@"shade.tar.gz"];
    [receivedData writeToFile:tarball atomically:YES];
    
    TAR *t = NULL; 
    int tar_open_result = tar_open(&t, [tarball UTF8String], &gztype, O_RDONLY, 0644, 0);

    int tar_extract_result = tar_extract_all(t, [documentsDirectory UTF8String]);
    tar_close(t);

    [connection release];
    [receivedData release];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [options count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell
    cell.text = [options objectAtIndex:[indexPath indexAtPosition:0]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch([indexPath indexAtPosition:0]) {
      case 0:
       [[self navigationController] pushViewController:librarySearchViewController animated:YES];
        break;
      case 1:
       [[self navigationController] pushViewController:catalogSearchViewController animated:YES];
        break;
      default:
        break;
    }
}


/*
- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to add the Edit button to the navigation bar.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/


/*
// Override to support editing the list
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support conditional editing of the list
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support rearranging the list
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the list
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [options release];
    [super dealloc];
}


@end

