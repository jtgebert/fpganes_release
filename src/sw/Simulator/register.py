#!/usr/bin/env python

class RegisterFile:
	def __init__(self):
		self.A = 0
		self.X = 0
		self.Y = 0
		self.SP = 0
		self.PC = 0
		self.neg_flag = False
		self.overflow_flag = False
		self.zero_flag = False
		self.carry_flag = False

	def carry(self):
		if self.carry_flag:
			return 1
		else:
			return 0 

	def update_neg_flag(self, result):
		int8 = result & 0xff
		self.neg_flag = (int8 >> 7) > 0
		return	

	def update_overflow_flag(self, result, op1, op2):
		return

	def update_zero_flag(self, result):
		self.zero_flag = result == 0
		return

	def update_carry_flag(self, result, op1, op2):
		return
