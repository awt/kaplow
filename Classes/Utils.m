#import "Utils.h"

@implementation NSString (Comics)

 + (NSString *) documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
 
  }

@end
