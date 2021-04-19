LCD_DATA SET P1		; ustawienie portow
LCD_RS SET P3.5
LCD_E SET P3.4

LJMP INIT		; skok do etykiety INIT

ORG 050H		; miejsce zapisania programu w pamieci
INIT:			; etykieta INIT
CALL LCD_INIT		; wywolanie procedury LCD_INIT
LJMP START		; skok do etykiety START

ORG 100H
START:			; etykieta start
MOV A,#02H		; przesuniecie kursora do pozycji 3 w 1 linii
CALL CMD		; wywolanie procedury CMD 
MOV A,#'T'	
CALL DISP		; wywolanie procedury DISP
MOV A,#'M'
CALL DISP		
MOV A,#' '
CALL DISP
MOV A,#'2'
CALL DISP
MOV A,#'0'
CALL DISP
MOV A,#'2'
CALL DISP
MOV A,#'0'
CALL DISP 
MOV A,#'/'
CALL DISP 
MOV A,#'2'
CALL DISP
MOV A,#'0'
CALL DISP
MOV A,#'2'
CALL DISP
MOV A,#'1'
CALL DISP
MOV A, #040H		; przesuniecie kursora do pozycji 1 w 2 linii
CALL CMD 		; wywolanie procedury CMD
MOV A,#'L'
CALL DISP
MOV A,#'A'
CALL DISP
MOV A,#'B'
CALL DISP
MOV A,#'O'
CALL DISP
MOV A,#'R'
CALL DISP
MOV A,#'A'
CALL DISP
MOV A,#'T'
CALL DISP
MOV A,#'O'
CALL DISP
MOV A,#'R'
CALL DISP
MOV A,#'I'
CALL DISP
MOV A,#'U'
CALL DISP
MOV A,#'M'
CALL DISP
MOV A,#' '
CALL DISP
MOV A,#' '
CALL DISP
MOV A,#'1'
CALL DISP
MOV A,#'1'
CALL DISP
LJMP KONIEC			; skok do etykiety koniec

LCD_INIT:
				; function set
CLR LCD_RS
MOV LCD_DATA, #00111000B 	; wlaczenie wyswietlacza 2 wierszowego
CALL DELAY			; wylowanie procedury DELAY 
				; display off
CLR LCD_RS
MOV LCD_DATA, #00001000B 
CALL DELAY			; wylowanie procedury DELAY 
				; display clear
CLR LCD_RS
MOV LCD_DATA, #00000001B 
CALL DELAY2 			; wylowanie procedury DELAY2
				; entry mode set
CLR LCD_RS
MOV LCD_DATA, #00000110B 
CALL DELAY			; wylowanie procedury DELAY  
				; display on
CLR LCD_RS
MOV LCD_DATA, #00001111B 
CALL DELAY			; wylowanie procedury DELAY 
RET

DELAY:				; procedura opozniajaca
MOV DPTR, #25D			; wpisanie wartosci 25 do DPTR
DEL:				; etykieta
DJNZ DPL, DEL			; dekremetacja warunkowa
RET			

DELAY2:				; procedura opozniajaca
MOV DPTR, #1000D		; wpisanie wartosci do DPTR
DEL2:				; ETYKIETA
DJNZ DPL,DEL2			; dekremetacja warunkowa
DJNZ DPH,DPHDEL			; dekremetacja warunkowa
LJMP ENDDEL2			; skok do etykiety
DPHDEL:				; etykieta
MOV DPL, #0FFH			; wpisanie 
LJMP DEL2			; skok do etykiety
ENDDEL2:			; etykieta
DJNZ DPL, ENDDEL2		; dekremetacja warunkowa
RET

CMD:				; Procedura CMD
CLR LCD_RS			; wyzerowanie u Portu 1.7
MOV LCD_DATA, A			; przepisanie wartosci z A do LCD_DATA
SETB P1.7			; ustawienie bit
CLR LCD_E			; wyzerowanie 
SETB LCD_E			; ustawienie bitu LCD_E
CALL DELAY			; wywolanie procedury DELAY  
RET

DISP:				; procedura DISP	
SETB LCD_RS			; ustawienie LCD_RS	
MOV LCD_DATA, A			; przepisanie wartosci z A do LCD_DATA	
CLR LCD_E			; wyzerowanie
SETB LCD_E			; ustawienie bitu LCD_E
CALL DELAY			; wywolanie procedury DELAY 
RET

KONIEC:
END