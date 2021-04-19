TH2 SET 00CDH    		;zdefiniowanie symbolu TH2
TL2 SET 00CCH    		;zdefiniowanie symbolu TL2
RCAP2H SET 00CBH   		;zdefiniowanie symbolu RCAP2H
RCAP2L SET 00CAH   		;zdefiniowanie symbolu RCA2L
T2CON SET 00C8H 		;zdefiniowanie symbolu T2CON
LJMP INIT			;skok do etykiety INIT

ORG 0023H 			;miejsce pamieci gdzie program skacze po przerwaniu licznika T2
LJMP UART 			;skok do etykiety IRQT2
ORG 50H 			
INIT: 				;etykieta INIT 
	MOV R0,     #40H
	MOV R1,     #40H
	MOV SCON,   #01010000B 	;inicjacja slowa SCON
	MOV T2CON,  #00110100B 	;inicjacja slowa T2CON
	MOV TL2,    #0DCH 	;ustawienie slowa TL2
	MOV TH2,    #0FFH 	;ustawienie slowa TH2
	MOV RCAP2H, #0FFH 	;ustawienie slowa RCAP2H  
	MOV RCAP2L, #0DCH 	;ustawienie slowa RCAP2L
	MOV IE,     #10010000B	;ustawienie slowa IE
	
LJMP START

ORG 100H			
START: 				;etykieta START
	INC R7
	CJNE R0, #50H, END_START
	MOV R0, #40H
	CALL SEND
	END_START:	
LJMP START			

ORG 200H 			
UART:			;przerwanie			
	INC R6
	JNB TI,REC
CALL SEND
	LJMP END_IRQT2
	REC:
	JNB RI,END_IRQT2
CALL RECEIVE
	END_IRQT2:
	CLR RI
	CLR TI
RETI	

RECEIVE:
	MOV A, SBUF
	MOV @R0, A
	INC R0
	CJNE R0, #50H,END_RECEIVE
	MOV R0, #40H
END_RECEIVE:
RET

SEND:
	MOV A, @R1
	MOV SBUF, A
	INC R1
	CJNE R1,#50H,END_SEND
	MOV R1,#40H
END_SEND:
RET

END