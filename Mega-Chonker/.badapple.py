import os
from time import sleep

dir = ".frames-ascii"

for filename in sorted(os.listdir(dir)):
    f = os.path.join(dir, filename)
    if os.path.isfile(f):
        with open(f, 'r') as file:
            os.system('clear')
            print(file.read())
    sleep(1/30)