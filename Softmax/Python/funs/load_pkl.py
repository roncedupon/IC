#保存变量
import pickle
import torch
def save_pkl(v,filename):
  f=open(filename,'wb')          #打开或创建名叫filename的文档。
  pickle.dump(v,f)               #在文件filename中写入v
  f.close()                      #关闭文件，释放内存。
  return filename

def load_pkl(filename):
  try:
    f=open(filename,'rb+')
    r=pickle.load(f)
    f.close()
    return r
  except EOFError:
    return ""
