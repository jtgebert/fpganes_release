if [ $# -ne 1 ]
then
    echo "Please provide the name of the game as an arguement."
    echo "eg. if the ROM is named SuperMario.nes, provide 'SuperMario' as an arguement"
else
    mkdir ../../mem_init/$1
    rm *.class
    javac *.java
    java NEStoMIF ../../ROMs/$1.nes ../../mem_init/$1/prog_rom.mif ../../mem_init/$1/char_rom.mif
fi
