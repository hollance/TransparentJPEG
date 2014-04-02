/*
 * Copyright (c) 2011-2014 Matthijs Hollemans
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

/*!
 * Allows raw byte access to UIImage data.
 */
@interface UIImage (MHRawBytes)

/*!
 * Creates a new image from a byte array.
 *
 * @param data The byte array. This must contain width*height*4 bytes in ARGB
 *        order. You still need to free() the data afterwards yourself.
 * @param size The dimensions of the image in pixels.
 * @param scale Set this to 2.0 for a Retina image.
 * @return The new UIImage or nil if creating the image failed.
 */
+ (UIImage *)mh_imageWithBytes:(unsigned char *)data size:(CGSize)size scale:(CGFloat)scale;

/*!
 * Returns the raw bytes that make up the image.
 *
 * Offset for the pixel at (x,y) in the byte array is: y*width*4 + x*4.
 * Alpha = offset[0], red = offset[1], green = offset[2], blue = offset[3].
 *
 * @return A byte array or NULL if the operation failed. The array contains
 *         width*height*4 bytes in ARGB order. You are responsible for freeing
 *         this memory with free() when you are done with it.
 */
- (unsigned char *)mh_createBytesFromImage;

@end
