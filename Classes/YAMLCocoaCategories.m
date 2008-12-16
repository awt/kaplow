//
//  YAMLCocoaCategories.m
//  YAML
//
//  Created by Will on 29/09/2004.
//  Copyright 2004 __MyCompanyName__. All rights reserved.
//

#import "YAMLCocoaCategories.h"

@implementation NSAffineTransform (YAMLCocoaAdditions)

+(id) objectWithYAML:(id)data
{
	if([data isKindOfClass:[NSArray class]])
	{
		NSAffineTransform			*transform = [NSAffineTransform transform];
		NSAffineTransformStruct		aStruct;
		
		aStruct.m11 = [[data objectAtIndex:0] floatValue];
		aStruct.m12 = [[data objectAtIndex:1] floatValue];
		aStruct.tX = [[data objectAtIndex:2] floatValue];
		aStruct.m21 = [[data objectAtIndex:3] floatValue];
		aStruct.m22 = [[data objectAtIndex:4] floatValue];
		aStruct.tY = [[data objectAtIndex:5] floatValue];
		
		[transform setTransformStruct:aStruct];
		
		return  transform;
	}
		
	return nil;
}

-(id) toYAML
{
	NSAffineTransformStruct		aStruct;
		
	aStruct = [self transformStruct];
		
	return [NSArray arrayWithObjects:
				[NSNumber numberWithFloat:aStruct.m11],
				[NSNumber numberWithFloat:aStruct.m12],
				[NSNumber numberWithFloat:aStruct.tX],
				[NSNumber numberWithFloat:aStruct.m21],
				[NSNumber numberWithFloat:aStruct.m22],
				[NSNumber numberWithFloat:aStruct.tY], NULL];
}


@end

@implementation NSValue (YAMLCocoaAdditions)

+(id) objectWithYAML:(id)data
{
	if([data objectForKey:@"x"] && [data objectForKey:@"w"])
	{
		return  [NSValue valueWithRect:NSMakeRect([[data objectForKey:@"x"] floatValue], [[data objectForKey:@"y"] floatValue],
												  [[data objectForKey:@"w"] floatValue], [[data objectForKey:@"h"] floatValue])];
	}
	else if([data objectForKey:@"x"])
	{
		return  [NSValue valueWithPoint:NSMakePoint([[data objectForKey:@"x"] floatValue], [[data objectForKey:@"y"] floatValue])];
	}
	else if([data objectForKey:@"w"])
	{
		return  [NSValue valueWithSize:NSMakeSize([[data objectForKey:@"w"] floatValue], [[data objectForKey:@"h"] floatValue])];
	}
	else if([data objectForKey:@"p"])
	{
		return  [NSValue valueWithRange:NSMakeRange([[data objectForKey:@"p"] floatValue], [[data objectForKey:@"l"] floatValue])];
	}
		
	return nil;
}

-(id) toYAML
{
	if(strcmp([self objCType], "{_NSPoint=ff}") == 0)
	{
		NSPoint		p = [self pointValue];
		
		return [NSDictionary dictionaryWithObjectsAndKeys:
				[NSNumber numberWithFloat:p.x],	@"x",
				[NSNumber numberWithFloat:p.y],	@"y", NULL];
	}
	else if(strcmp([self objCType], "{_NSSize=ff}") == 0)
	{
		NSSize		p = [self sizeValue];
		
		return [NSDictionary dictionaryWithObjectsAndKeys:
				[NSNumber numberWithFloat:p.width],		@"w",
				[NSNumber numberWithFloat:p.height],	@"h", NULL];
	}
	return NULL;
}

@end

@implementation NSNumber (YAMLCocoaAdditions)

+(id) objectWithYAML:(id)data
{
	return [NSNumber numberWithFloat:[data floatValue]];
}

-(id) toYAML
{
	return [self description];
}

@end

@implementation NSData (YAMLCocoaAdditions)

+(id) objectWithYAML:(id)data
{
	char		*buffer;
	int			ptr = 0, index = 1, length;
	char		*dataString;
	
	dataString = [data cString];
	length = [data length];
	buffer = malloc(length);

	while(index < length-1)
	{
		int hex, n;
		sscanf(&dataString[index], "%02x %n", &hex,&n);
		buffer[ptr] = hex;
		index += n;
		ptr++;
	}
	
	free(buffer);
	return [NSData dataWithBytes:buffer length:ptr];
}

-(id) toYAML
{
	return [self description];
}

@end

@implementation NSDate (YAMLCocoaAdditions)

+(id) objectWithYAML:(id)data
{
	return [NSDate dateWithNaturalLanguageString:data];
}

-(id) toYAML
{
	return [self description];
}

@end
