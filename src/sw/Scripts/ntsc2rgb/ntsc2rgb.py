#!/usr/bin/env python

import sys

table = [
	'24\'h7C7C7C',
	'24\'h0000FC',
	'24\'h0000BC',
	'24\'h4428BC',
	'24\'h940084',
	'24\'hA80020',
	'24\'hA81000',
	'24\'h881400',
	'24\'h503000',
	'24\'h007800',
	'24\'h006800',
	'24\'h005800',
	'24\'h004058',
	'24\'h000000',
	'24\'h000000',
	'24\'h000000',
	'24\'hBCBCBC',
	'24\'h0078F8',
	'24\'h0058F8',
	'24\'h6844FC',
	'24\'hD800CC',
	'24\'hE40058',
	'24\'hF83800',
	'24\'hE45C10',
	'24\'hAC7C00',
	'24\'h00B800',
	'24\'h00A800',
	'24\'h00A844',
	'24\'h008888',
	'24\'h000000',
	'24\'h000000',
	'24\'h000000',
	'24\'hF8F8F8',
	'24\'h3CBCFC',
	'24\'h6888FC',
	'24\'h9878F8',
	'24\'hF878F8',
	'24\'hF85898',
	'24\'hF87858',
	'24\'hFCA044',
	'24\'hF8B800',
	'24\'hB8F818',
	'24\'h58D854',
	'24\'h58F898',
	'24\'h00E8D8',
	'24\'h787878',
	'24\'h000000',
	'24\'h000000',
	'24\'hFCFCFC',
	'24\'hA4E4FC',
	'24\'hB8B8F8',
	'24\'hD8B8F8',
	'24\'hF8B8F8',
	'24\'hF8A4C0',
	'24\'hF0D0B0',
	'24\'hFCE0A8',
	'24\'hF8D878',
	'24\'hD8F878',
	'24\'hB8F8B8',
	'24\'hB8F8D8',
	'24\'h00FCFC',
	'24\'hF8D8F8',
	'24\'h000000',
	'24\'h000000',
]

def show_usage():
	print "./ntsc2rgb.py <single hex value>"
	exit(0)

def ntsc2rgb(ntscColor):
	return table[ntscColor]
	
def main():
	if len(sys.argv) != 2:
		show_usage()
	if int('0x' + sys.argv[1], 16) > 63:
		show_usage()
	print "rgb color: " + ntsc2rgb(int('0x' + sys.argv[1], 16))
	return

def make_table():
	for i in range(64):
		print str(i) + ": {red, green, blue} = " + ntsc2rgb(i)

if __name__ == "__main__":
	main()
	
