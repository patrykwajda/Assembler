	LJMP INIT 		
ORG 0023H 			;adres pamieci obslugi przerwania portu szeregowego
	LJMP RS			;skok do etykiety RS
ORG 50H
   INIT: 			
	MOV SCON, #01010000B 	;ustawienie portu szeregowego SCON
	MOV TMOD, #00100000B 	;ustawienie TMOD T1 
	MOV TCON, #01000000B 	;ustawienie TCON
	MOV IE,   #10010000B 	;ustawienie IE obsluga przerwan
	MOV TL1,  #00FDH 	;ustawienie TL1
	MOV TH1,  #00FDH 	;ustawienie TH1
	MOV R3, #20H		;R3 - duza i mala litera roznia sie o 20H w ASCII
	LJMP START

ORG 100H			
  START:			;etykieta start
	INC R7			;inc r7
	LJMP START		;skok do start
				
ORG 200H	
RS:				;procedura przerwania od portu szeregowego
	MOV A, SBUF		;przepisanie wartosci z bufora do akumulatora
	MOV 50H, A 		;pod adresem 50H w internal RAM znajdzie sie kod nacisnietego znaku
	CJNE A, #40H, CZYZNAK	;jezeli nie sa takie same wartosci, skok do czyznak
CZYZNAK:
	JC KONIEC		;jezeli C ma stan wysoki - skok do koniec
	JNC ZAMIANA		;jezeli C ma stan niski - skok do zamiana
ZAMIANA:
	CJNE A,#5BH, ROZMIAR	;jezeli wartosci sa rozne, skok do rozmiar
ROZMIAR:
	JNC KONIEC		;jezeli C ma stan niski - skok do koniec
	ADD A, R3		;suma akumulatora z R3 - zmiana rozmiaru
	LJMP KONIEC		;skok do koniec
SPRAWDZ:
	JC KONIEC		;jezeli C ma stan wysoki - skok do koniec
	LJMP CZYZNAK		;skok do czyznak
KONIEC:				
	MOV SBUF,A		;przepisanie zmodyikowanego znaku do bufora portu
	CLR TI			;zerowanie ti
	CLR RI			;zeroawnie ri
	CLR C			;zeroawnie c
	RETI
	

END