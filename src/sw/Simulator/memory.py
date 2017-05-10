#!/usr/bin/env python

class Memory:

	program_start = 0x2000

	def __init__(self):
		self.mem = [0 for x in range(2**16)]

	def write(self, address, data):
		self.mem[address] = data

	def read(self, address):
		return self.mem[address]
