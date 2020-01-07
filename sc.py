import os
from collections import deque
import threading
import sys

LOTUS = "lotus"
lotus_list = None

list_miners = ["t01004"]

tick_list = []

def exec_cmd(cmd):
	return os.popen(cmd).read()

def process_list():
	global lotus_list
	l = []
	for x in lotus_list:
		if x != "":
			l.append(x.split(" ")[0])
	lotus_list = l

def import_file(filename):
	global tick_list
	cmd_str = "lotus client import {}".format(filename) 
	li = exec_cmd(cmd_str)
	li = li.replace("\n","")
	print(li)
	return li

def process_tick(index):
	global tick_list

	for li in range((index+1)*1000,100000):
		print(li)
		filename = "test_{}.txt".format(li)
		print(filename)
		cmd_str = "bash -c \"./mkfile.sh {} 30000 M\"".format(filename)
		print(cmd_str)
		os.system(cmd_str)

		code = import_file(filename)
		print(code)
		cmd_str = "{} client deal {} {} 0.0000000005 10".format(LOTUS,code,list_miners[index])
		print(cmd_str)
		res = exec_cmd(cmd_str)


		print(res)
		if res.find("WARN")>=1:
			return
		import time
		time.sleep(10)

def init_pool():
	for x in range(0,len(list_miners)):
		print(x)
		t = threading.Thread(target=process_tick, args=(x,))
		t.setDaemon(True)
		t.start()


def main():
	init_pool()
	while True:
		import time
		time.sleep(1)



if __name__ == '__main__':
	main()
