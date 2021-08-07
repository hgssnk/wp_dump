import os
import sys

MAX_CNT=int(sys.argv[1])

from operator import itemgetter
filelists = []
for file in os.listdir():
    base, ext = os.path.splitext(file)
    if ext == '.zip':
        filelists.append([file, os.path.getctime(file)])
filelists.sort(key=itemgetter(1), reverse=True)
for i,file in enumerate(filelists):
    if i > MAX_CNT - 1:
        print('{}は削除します'.format(file[0]))
        os.remove(file[0])
