
import os, glob
from PIL import Image

files = glob.glob("/site/site/_assets/img/pexels-orig/*.jpeg")
for file in files:
    basename = os.path.basename(file)
    print(basename)

    img = Image.open(file)

    ratio = 0.25
    size = img.size
    w, h = int(size[0] * ratio), int(size[1] * ratio)

    newimg = img.resize((w, h), Image.ANTIALIAS)
    newimg.save("/site/site/assets/img/pexels-opt/{}".format(basename), quality=35, optimize=True)
