/*
 * Copyright (c) 2011-2012 Matthijs Hollemans
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "UIImage+MHRawBytes.h"

@implementation UIImage (MHRawBytes)

+ (UIImage *)mh_imageWithBytes:(unsigned char *)data size:(CGSize)size
{
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	if (colorSpace == NULL)
	{
		NSLog(@"Could not create color space");
		return nil;
	}

	CGContextRef context = CGBitmapContextCreate(
		data, size.width, size.height, 8, size.width * 4, colorSpace,
		kCGImageAlphaPremultipliedFirst);

	CGColorSpaceRelease(colorSpace);

	if (context == NULL)
	{
		NSLog(@"Could not create context");
		return nil;
	}

	CGImageRef ref = CGBitmapContextCreateImage(context);

	if (ref == NULL)
	{
		NSLog(@"Could not create image");
		CGContextRelease(context);
		return nil;
	}

	CGContextRelease(context);

	UIImage *image = [UIImage imageWithCGImage:ref];
	CFRelease(ref);

	return image;	
}

- (unsigned char *)mh_createBytesFromImage
{
	size_t width = self.size.width;
	size_t height = self.size.height;

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	if (colorSpace == NULL)
	{
		NSLog(@"Could not create color space");
		return NULL;
	}

	void *contextData = calloc(width * height, 4);
	if (contextData == NULL)
	{
		NSLog(@"Could not allocate memory");
		CGColorSpaceRelease(colorSpace);
		return NULL;
	}

	CGContextRef context = CGBitmapContextCreate(
		contextData, width, height, 8, width * 4, colorSpace,
		kCGImageAlphaPremultipliedFirst);

	CGColorSpaceRelease(colorSpace);

	if (context == NULL)
	{
		NSLog(@"Could not create context");
		free(contextData);
		return NULL;
	}

	CGRect rect = CGRectMake(0.0f, 0.0f, width, height);
	CGContextDrawImage(context, rect, self.CGImage);
	CGContextRelease(context);

	return contextData;
}

@end
