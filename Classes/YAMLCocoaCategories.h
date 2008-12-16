//
//  YAMLCocoaCategories.h
//  YAML
//
//  Created by Will on 29/09/2004.
//  Copyright 2004 __MyCompanyName__. All rights reserved.
//

@interface NSAffineTransform (YAMLCocoaAdditions)
+(id) objectWithYAML:(id)data;
-(id) toYAML;
@end

@interface NSValue (YAMLCocoaAdditions)
+(id) objectWithYAML:(id)data;
-(id) toYAML;
@end

@interface NSNumber (YAMLCocoaAdditions)
+(id) objectWithYAML:(id)data;
-(id) toYAML;
@end

@interface NSData (YAMLCocoaAdditions)
+(id) objectWithYAML:(id)data;
-(id) toYAML;
@end
