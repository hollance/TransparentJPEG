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

#import "UIImage+MHCombineAlpha.h"
#import "UIImage+MHRawBytes.h"

@implementation UIImage (MHCombineAlpha)

- (UIImage *)mh_combineWithAlphaImage:(UIImage *)alphaImage backgroundColor:(UIColor *)backgroundColor
{
	NSParameterAssert(alphaImage != nil);
	NSParameterAssert(backgroundColor != nil);
	NSAssert(CGSizeEqualToSize(self.size, alphaImage.size), @"Source and alpha images must have equal dimensions");

	// Get the RGB components for the background color.
	int backR, backG, backB;
	const float *components = CGColorGetComponents(backgroundColor.CGColor);
	if (CGColorGetNumberOfComponents(backgroundColor.CGColor) == 4)
	{
		backR = components[0] * 255.0f;
		backG = components[1] * 255.0f;
		backB = components[2] * 255.0f;
	}
	else  // this is for [UIColor whiteColor] etc
	{
		backR = backG = backB = components[0] * 255.0f;
	}

	uint8_t *data = [self mh_createBytesFromImage];
	if (data == NULL) return nil;

	uint8_t *alphaData = [alphaImage mh_createBytesFromImage];
	if (alphaData == NULL) return nil;

	enum { A, R, G, B };
	int pixelCount = self.size.width * self.size.height;
	int offset = 0;
	int a, r, g, b;

	for (int i = 0; i < pixelCount; ++i)
	{
		// Get the alpha data from the mask image. This is a grayscale image
		// so it doesn't matter whether we pick R, G or B.
		a = alphaData[offset + R];

		// Get the color from the source image. The source image has no alpha,
		// so we don't need to "un-premultiply" anything here.
		r = data[offset + R];
		g = data[offset + G];
		b = data[offset + B];

		// The RGB values from the source image combine the original color with
		// the background color, so to find out what the original color was, we
		// have to filter out the background color.
		//
		// The colors were mixed like this:
		// RGB_image = alpha * RGB_original + (1 - alpha) * RGB_background
		//
		// Therefore, to get the original color we need to do:
		// RGB_original = (RGB_image - RGB_background) / alpha + RGB_background
		//
		if (a > 0)
		{
			r = (r - backR) * 255 / a + backR;
			g = (g - backG) * 255 / a + backG;
			b = (b - backB) * 255 / a + backB;

			// Because of rounding errors, colors with low values (near 0)
			// can end up less than 0, so we need to clamp them.
			if (r < 0) r = 0;
			if (g < 0) g = 0;
			if (b < 0) b = 0;
		}

		// Put the alpha and the original colors into the destination image.
		// Note: we have to premultiply the RGB values with alpha here.
		data[offset + A] = a;
		data[offset + R] = (uint8_t) (r * a / 255);
		data[offset + G] = (uint8_t) (g * a / 255);
		data[offset + B] = (uint8_t) (b * a / 255);

		offset += 4;
	}

	UIImage *combinedImage = [UIImage mh_imageWithBytes:data size:self.size];
	free(data);
	free(alphaData);
	return combinedImage;
}

@end
