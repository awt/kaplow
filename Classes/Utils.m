#import "Utils.h"

@implementation NSString (Comics)

 + (NSString *) booksDirectory {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *booksDirectory = [[NSString documentsDirectory] stringByAppendingPathComponent:@"books"];

    if (![fm fileExistsAtPath:booksDirectory])
    {
      [fm createDirectoryAtPath:booksDirectory attributes:nil]; 
    }
    return booksDirectory;
  }

 + (NSString *) documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
 
    if (!documentsDirectory) {
        NSLog(@"Documents directory not found!");
        return nil;
    }
    else {
      return documentsDirectory; 
    }
  }

@end
