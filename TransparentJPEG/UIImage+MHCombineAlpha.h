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
 * Category on the UIImage class that allows you to have transparent JPEGs.
 */
@interface UIImage (MHCombineAlpha)

/*!
 * Combines a source image, which is assumed not to have any alpha information,
 * with a second image that serves as its alpha channel.
 *
 * You can use this method to add alpha information to an image loaded from a
 * JPEG file, in order to give it transparency.
 *
 * @param alphaImage This must be a grayscale image of the same dimensions as
 *        the source image. Black represents full transparency, white is full
 *        opacity.
 *
 * @param backgroundColor Because the source image does not have transparency,
 *        it is rendered on top of a solid color, usually pure white or black.
 *        You must specify this background color, so that the original colors
 *        can be restored.
 *
 * @return a new UIImage object
 */
- (UIImage *)mh_combineWithAlphaImage:(UIImage *)alphaImage backgroundColor:(UIColor *)backgroundColor;

@end
