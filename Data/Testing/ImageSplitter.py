# Splits of into smaller size
import argparse
from PIL import Image
import os

# EXAMPLE
# python ImageSplitter.py --initSize 1024 --endSize 64 --baseLoc './Data/Testing/Movie 3' --baseName 'movie_3_' --highRange 268
parser = argparse.ArgumentParser()
parser.add_argument('--initSize', type=int, help="Initial image size")
parser.add_argument('--endSize', type=int, help="Ending image size")
parser.add_argument('--baseLoc', type=str, help="Location of base folder for images")
parser.add_argument('--baseName', type=str, help="Beginning Image File Names")
parser.add_argument('--ext', type = str, default='.png', help="File extension string")
parser.add_argument('--numChars', type=int, default=4, help="Number of chars to say number")
parser.add_argument('--lowRange', type=int, default=0, help="Lowest number for images")
parser.add_argument('--highRange', type=int, help="High number for images")

def splitSingleImage(args, num):
    #  Gen number string
    numString = str(num)
    if len(numString > args.numChars):
        print("Range is to high for numChars")
        exit()
    while len(numString) < args.numChars:
        numString = "0" + numString
    # Load image
    image_name = args.baseName + numString + args.ext
    if not os.path.exists(image_name):
        print("Image file does not exist:", image_name)
        exit()
    img = Image.open(args.baseName + numString + args.ext)
    if img.shape[0] != args.initSize:
        print("Input image is not correct length", img.shape[0], "!=", args.initSize)
        exit()
    # Check compatibility of sizes
    if args.startSize % args.endSize != 0:
        print("Start size must be a multiple of end size")
        exit()
    imagesPerLength = args.startSize // args.endSize
    images = []
    for i in range(imagesPerLength):
        for j in range(imagesPerLength):
            images.append(img[i*args.endSize:(i+1)*args.endSize], img[j*args.endSize:(j+1)*args.endSize])


if __name__ == "__main__":
    args = parser.parse_args()
    if args.initSize == 0:
        print("Initial size cannot be 0")
        exit()
    if args.endSize == 0:
        print("End size cannot be 0")
        exit()
    final_images = []
    for i in range(args.lowRange, args.highRange+1):
        final_images += splitSingleImage(args, i)
