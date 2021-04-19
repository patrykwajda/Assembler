MOV A,#22H	;zapisanie liczby 22H do akumulatora
MOV R1,#25D	;zapisanie liczby 25D do rejestru R1
MOV 50H,#15H	;zapisanie liczby 15H do komorki w pamieci RAM 50H
MOV A,#27H	;zapisanie wartosci do akumulatora - rozpoczecie adresowania posredniego do komorki 50H w XRAM
MOV DPTR,#50H	;zapisanie adresu 50H jako wartosc do DPTR
MOVX @DPTR,A	;przepisanie wartosci z akumulatora do adresu zczytanego z DPTR do pamieci XRAM - zakonczenie zapisywania liczby do XRAM
MOV P1,#44D 	;zapisanie liczby do portu P1

		;--- czesc 2, program sumujacy ---
MOV P2,#16H	;zapisanie liczby do portu P2, do P1 wczesniej zapisano
MOV A,P1	;przeniesienie wartosci portu P1 do akumulatora
MOV R1,P2	;przeniesienie wartosci portu P2 do rejestru R1
ADD A,R1	;sumowanie akumulatora(P1) i rejestru R1(P2)
MOV 45H,A	;zapisanie wartosci dodawania z akumulatora do komorki 45H RAM
		;rozpoczecie adresowania posredniego do komorki 45H w XRAM
MOV DPTR,#45H	;zapisanie adresu 45H jako wartosc do DPTR
MOVX @DPTR,A	;przepisanie wartosci z akumulatora do adresu zczytanego z DPTR do pamieci XRAM - zakonczenie zapisywania liczby do XRAM
		; ---> wynik dodawania P1 + P2 w komorce 45H RAM i XRAM <---

KONIEC:LJMP KONIEC
END