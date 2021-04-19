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
MOV A,#03H		; przesuniecie kursora do pozycji 3 w 1 linii
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
MOV A,#'1'
CALL DISP
MOV A, #040H	   ; przesuniecie kursora do pozycji 0 w 2 linii	
CALL CMD 	   ; wywolanie procedury CMD 	
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
LJMP KONIEC			

LCD_INIT:
				
CLR LCD_RS
MOV LCD_DATA, #00111000B 	
CALL DELAY			
				
CLR LCD_RS
MOV LCD_DATA, #00001000B 
CALL DELAY			
				
CLR LCD_RS
MOV LCD_DATA, #00000001B 
CALL DELAY2 			
				
CLR LCD_RS
MOV LCD_DATA, #00000110B 
CALL DELAY			
				
CLR LCD_RS
MOV LCD_DATA, #00001111B 
CALL DELAY			
RET

DELAY:				
MOV DPTR, #25D			
DEL:				
DJNZ DPL, DEL			
RET			

DELAY2:				
MOV DPTR, #1000D		
DEL2:				
DJNZ DPL,DEL2			
DJNZ DPH,DPHDEL			
LJMP ENDDEL2			
DPHDEL:				
MOV DPL, #0FFH			
LJMP DEL2			
ENDDEL2:			
DJNZ DPL, ENDDEL2		
RET

CMD:				
CLR LCD_RS			
MOV LCD_DATA, A			
SETB P1.7			
CLR LCD_E			
SETB LCD_E			
CALL DELAY			
RET

DISP:					
SETB LCD_RS			
MOV LCD_DATA, A			
CLR LCD_E			
SETB LCD_E			
CALL DELAY			
RET

KONIEC:
END