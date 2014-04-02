# Transparent JPEG Images

The advantage of JPEG is that it compresses much better than PNG, especially for photos. The downside is that JPEG images cannot have transparency. But with a little trick we can create a transparent image from a JPEG anyway.

Using the `mh_combineWithAlphaImage:backgroundColor:` method from the UIImage category in this project, you can combine the JPEG source image with a second image that contains only an alpha channel, to create an image that does have transparency.

Your workflow should be as follows:

1. Export your image from Photoshop as a PNG with transparency.

2. Export the image again as a JPEG, using suitable compression settings. The background should have a solid color, typically white or black but any color will do.

3. Save the alpha channel to a separate JPEG or PNG image. I couldn't find an easy way to do this from Photoshop, but the ImageMagick tool can do it without problems (see below).

4. Add the two JPEG images (or JPEG + PNG) to the app and call the method to combine them into a new, transparent, image.

5. Your app probably should save the combined image to the Caches folder so you don't have to do this again.

Extracting the alpha channel is very easy using the ImageMagick command line tool. If you have ImageMagick installed, open a Terminal and go to the folder that contains the exported PNG image. Then type:

`convert -alpha Extract -type optimize -strip -quality 60 +dither Source.png Alpha.jpg`

This extracts the alpha channel from the PNG image and saves it as a JPEG file. You can tweak the level of compression with the -quality parameter. If you specify "Alpha.png" instead of "Alpha.jpg", ImageMagick saves the alpha channel as a grayscale PNG-8 file. You should use whichever one makes the smallest file size.

Note: The source and alpha images can be different file formats, but must always have the same dimensions. If they are both JPEG then they may use different quality/compression settings.

This project includes a simple app with some sample images to demonstrate how this works.

The current implementation is naive and not very fast. It also uses more memory than is strictly necessary. I might rewrite this at some point to use the Accelerate framework or Core Image.

The source code is copyright 2011-2014 Matthijs Hollemans and is licensed under the terms of the MIT license.

Bird image by Sias van Schalkwyk (http://www.sxc.hu/photo/1362219)
