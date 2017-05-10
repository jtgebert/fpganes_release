import csv
indent='\t';
indent1='\t\t';
indent2='\t\t\t';
indent3='\t\t\t\t';
target = open('cpu_switchcase.sv', 'w')
target.write( 'case( { instruction_type, addressing_mode } )\n' );

with open('cpu_spec.csv', 'rb') as csvfile:
    cpu_spec = csv.reader(csvfile, delimiter=',',  dialect=csv.excel_tab)
    for row in cpu_spec:

        ii=0;
        
        for col in row:
            ii=ii+1;
            if(col==''):                
                continue;
            col = col.replace(';', ';\n'+indent3)
            if(ii==1):
                target.write( indent + '{'+col+','+row[1]+'}:  begin'+"\n");
            elif(ii==2):
                target.write( indent1+'case(state)'+"\n");
            else:
                target.write( indent2+str(ii-3)+':  begin'+"\n");
                target.write( indent3+col+';'+"\n");
                last_col=0;
                if(ii==len(row)):
                    last_col=1;
                elif(row[ii]==''):
                    last_col=1;
                else:
                    last_col=0;
                if(last_col):#last element
                    target.write( indent3+'next_state=1\'b1;'+"\n");
                    if 'AD_P' in col:
                        target.write( indent3+"ld_sel=LD_INSTR;"+"\n");
                    elif 'INTERRUPT' in row[ 0 ]:
                        target.write( indent3 + "ld_sel=LD_INSTR;\n" + indent3 + "pc_sel=INC_PC;\n" );
                    else:    
                        target.write( indent3+row[2].replace(';', ';\n'+indent3)+";"+"\n");
                    target.write( indent3+"end\n");
                    target.write( 'default : begin /* do nothing */ end\n' );
                    target.write( indent1+"endcase"+"\n"+indent+"end\n");
                else:
                    if 'skip_' in col:
                        target.write( indent3+'next_state=state+1\'b1+skip_cycle;'+"\n"+indent3+"end\n");
                    else:
                        target.write( indent3+'next_state=state+1\'b1;'+"\n"+indent3+"end\n");
                
target.write( 'default : begin /* do nothing */ end\n' );
target.write( 'endcase\n' );
target.close();     
        
        #check if row empty        
        #ele1:
        #tab case(ele2):
        #tab tab case(state)
        #tab tab tab
        #next_state=state+1'b1;
        #target.write( row
        #if last element in row, next_state=0, target.write( ele3
        
