MOV R1,#0		;petla do while
START:			;etykieta start
INC R1			;zawartosc petli
CJNE R1,#3,START	;warunek - skok na poczatek jesli spelniony


MOV R1,#0		;petla while
LJMP COND 		;skok do warunku (etykieta COND)
CONT: INC R1		;wykonanie zawartosci zawartosc petli
COND: CJNE R1,#3,CONT	;sprawdzenie warunku, jesli spelniony to wykonuje skok do zawartosci(etykieta CONT)

MOV R1,#0		;wyzerowanie R1
MOV R2,#20D		;ustawienie liczby cykli petli
CJNE R2,#0, START2	;jesli n != 0 to skocz do startu
LJMP SKIP		;pominiecie petli jesli n = 0
START2:			;etykieta startu petli
	MOV A,#50H 	;zawartosc petli
	ADD A,R2
	MOV R1,A
	MOV A,R2
	MOV @R1,A
	DJNZ R2, START2	;warunek, jesli r2 > 0 to wraca na poczatek petli
SKIP:



KONIEC: LJMP KONIEC
END