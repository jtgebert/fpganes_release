#!/usr/bin/env python
import sys
import os

def show_usage():
    print "USAGE: ./bin2mif <bin_file_input> <mif_file_output>"
    exit(-1)

def write_header(file, depth, width, addrRadix, dataRadix):
    try:
        file.write("DEPTH = " + str(depth) + ";\n")
        file.write("WIDTH = " + str(width) + ";\n")
        file.write("ADDRESS_RADIX = " + addrRadix + ";\n")
        file.write("DATA_RADIX = " + dataRadix + ";\n")
        file.write("CONTENT\n")
        file.write("BEGIN\n")
    except IOError:
        print "ERROR: write_header can not write to the given file"
        exit(-1)

def main():
    if len(sys.argv) != 3:
        show_usage()
    
    inFile = sys.argv[1]
    outFile = sys.argv[2]

    try:
        readFile = open(inFile, 'rb')
    except IOError:
        print "ERROR: could not open file " + inFile
        exit()

    try:
        writeFile = open(outFile, 'w')
    except IOError:
        print "ERROR: could not create file " + outFile

    size = os.path.getsize(inFile)
    write_header(writeFile, size, 8, "HEX", "HEX")
    for i in range(size):
        byte = readFile.read(1)
        writeFile.write(format(i, '04X') + ": " + format(ord(byte), '02X') + ";\n")

    writeFile.write("END;\n")
    

if __name__ == "__main__":
    main()