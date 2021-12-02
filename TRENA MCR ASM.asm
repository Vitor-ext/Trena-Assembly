; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * CONFIGURAÇÕES PARA GRAVAÇÃO *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
CONFIG OSC = HS, FCMEN = OFF, IESO = OFF, PWRT = ON, BOREN = OFF, BORV = 0
CONFIG WDT = OFF, WDTPS = 128, MCLRE = ON, LPT1OSC = OFF, PBADEN = OFF
CONFIG CCP2MX = PORTC, STVREN = ON, LVP = OFF, DEBUG = OFF, XINST = OFF


; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * DEFINIÇÃO DAS VARIÁVEIS *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
CBLOCK 0X00

 COUNTER1			;Definindo variavel
 TMR0				;Definindo variavel
				
 TEMPO1				;Definindo variavel
 TEMPO0				;Definindo variavel
 TESTE1				;Definindo variavel
 LCD1				;Definindo variavel			

UNID			;Definindo variavel
 DEZE				;Definindo variavel	
 CENT			;Definindo variavel		
 MIL				;Definindo variavel
 CONTAGEM 			;Definindo variavel

 MEMORIA_UNID1			;Definindo variavel
 MEMORIA_DEZ1			;Definindo variavel		
 MEMORIA_CENT1			;Definindo variavel		
 MEMORIA_MIL1			;Definindo variavel
 CONTAGEM1			;Definindo variavel

 MEMORIA_UNID2			;Definindo variavel
 MEMORIA_DEZ2			;Definindo variavel			
 MEMORIA_CENT2			;Definindo variavel		
 MEMORIA_MIL2			;Definindo variavel
 CONTAGEM2			;Definindo variavel


 A0				;Definindo variavel								
 B0				;Definindo variavel					
 C0				;Definindo variavel					
 C1				;Definindo variavel					

 REG_AUX			;Definindo variavel
 UNI				;Definindo variavel			
 DEZ				;Definindo variavel
 CEN				;Definindo variavel

 MODO				;Definindo variavel

ENDC				;Terminando vetor de Declaracao de variaveis
	
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * DEFINIÇÃO DAS VARIÁVEIS INTERNAS DO PIC *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#INCLUDE <P18F4520.INC>		;Incluindo biblioteca de intrucoes do pic

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * CONSTANTES INTERNAS *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MAX1 EQU .10		;Defininco constante
MAX2 EQU .6			;Definindo constante

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * ENTRADAS *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#DEFINE BOTAO_0 PORTB,7		;Definindo botao para o PortC
#DEFINE BOTAO_1 PORTB,2		;Definindo botao para o PortC
#DEFINE BOTAO_2 PORTB,3		;Definindo botao para o PortC
#DEFINE BOTAO_3 PORTB,4		;Definindo botao para o PortC
#DEFINE BOTAO_4 PORTC,5		;Definindo botao para o PortC
#DEFINE SENSOR1 PORTB,0		;Definindo botao para o PortC	
#DEFINE SENSOR2 PORTB,1		;Definindo botao para o PortC
#DEFINE BOTAO_7 PORTB,6		;Definindo botao para o PortC
#DEFINE BOTAO_5 PORTB,5		;Definindo botao para o PortC
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * SAÍDAS *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
#DEFINE DISPLAY LATD		;Definindo display para o LATD
#DEFINE RS LATC,2			;Definindo Pino RS para o LATC, 2
#DEFINE ENABLE LATC,3		;Definindo Pino RS para o LATC, 3

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * VETOR DE RESET DO MICROUNIDROLADOR *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
ORG 0X0000					;Vetor 0
GOTO CONFIGURACAO			;Vai para a configuracao da placa

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * ROTINA DE DELAY *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
DELAY_MS			 		;Rotina de delay
 MOVWF TEMPO1
 MOVLW .200
 MOVWF TEMPO0
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 DECFSZ TEMPO0,F
 BRA $-.14

 DECFSZ TEMPO1,F
 BRA $-.22
 RETURN

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * CONFIGURACOES INICIAIS DO DISPLAY *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
INICIALIZACAO_DISPLAY			;Rotina de configuracoes iniciais do LCD
 MOVLW .30
 RCALL DELAY_MS
 BCF RS
 MOVLW B'00111000'
 RCALL ESCREVE
 MOVLW B'00001100'
 RCALL ESCREVE

 MOVLW B'00000001'
 RCALL ESCREVE
 MOVLW .1
 RCALL DELAY_MS

 MOVLW B'00000110'
 RCALL ESCREVE

 BSF RS 
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * ROTINA DE ESCRITA DE UM CARACTER NO DISPLAY *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
ESCREVE	
 MOVWF DISPLAY
 NOP
 BSF ENABLE
 NOP
 NOP
 BCF ENABLE
 MOVLW .1
 RCALL DELAY_MS
 RETURN

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * TABELA PARA CONTAGEM *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
TABELA_7S					;Tabela com o digito base para devolver valor das variaveis
 ANDLW B'00001111'
 RLNCF WREG,W
 ADDWF PCL,F

 RETLW '0' ; 0h - 0			
 RETLW '1' ; 1h - 1
 RETLW '2' ; 2h - 2
 RETLW '3' ; 3h - 3
 RETLW '4' ; 4h - 4
 RETLW '5' ; 5h - 5
 RETLW '6' ; 6h - 6
 RETLW '7' ; 7h - 7
 RETLW '8' ; 8h - 8
 RETLW '9' ; 9h - 9
 RETURN


; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * ROTINA DE ESCRITA DA TELA PRINCIPAL *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
MOSTRA_TELA_PRINCIPAL
 CLRF MEMORIA_UNID1			;Zera variável
 CLRF MEMORIA_DEZ1				;Zera variável
 CLRF MEMORIA_CENT1			;Zera variável
 CLRF MEMORIA_MIL1				;Zera variável		
 CLRF CONTAGEM1				;Zera variável			
 CLRF MEMORIA_UNID2			;Zera variável
 CLRF MEMORIA_DEZ2				;Zera variável
 CLRF MEMORIA_CENT2			;Zera variável
 CLRF MEMORIA_MIL2				;Zera variável
 CLRF CONTAGEM2				;Zera variável
 CLRF MODO					;Zera variável
 
 BCF RS                         ;Altera bit para enviar comand
 MOVLW 0X01
 RCALL ESCREVE
 MOVLW .1
 RCALL DELAY_MS
 MOVLW 0X80
 RCALL ESCREVE
 RCALL ESCREVE_CRONOMETRO
 BRA ESCREVE_START 

ESCREVE_CRONOMETRO
 BSF RS
 MOVLW 'T'					;Escreve digito no display
 RCALL ESCREVE				;Escreve digito no display
 MOVLW 'R'					;Escreve digito no display
 RCALL ESCREVE				;Escreve digito no display
 MOVLW 'E'					;Escreve digito no display
 RCALL ESCREVE				;Escreve digito no display
 MOVLW 'N'					;Escreve digito no display	
 RCALL ESCREVE				;Escreve digito no display
 MOVLW 'A'					;Escreve digito no display
 RCALL ESCREVE				;Escreve digito no display
 MOVLW ' '					;Escreve digito no display
 RCALL ESCREVE				;Escreve digito no display
 MOVLW 'M'					;Escreve digito no display
 RCALL ESCREVE				;Escreve digito no display
 MOVLW 'C'					;Escreve digito no display
 RCALL ESCREVE				;Escreve digito no display
 MOVLW 'R'					;Escreve digito no display
 RCALL ESCREVE				;Escreve digito no display
 MOVLW '-'					;Escreve digito no display
 RCALL ESCREVE				;Escreve digito no display
 MOVLW 'A'					;Escreve digito no display
 CALL ESCREVE				;Escreve digito no display
 MOVLW 'S'					;Escreve digito no display
 CALL ESCREVE				;Escreve digito no display
 MOVLW 'M'					;Escreve digito no display
 CALL ESCREVE				;Escreve digito no display
 RETURN

ESCREVE_START 
 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0XC0			;Define 5 Digito da Segunda Linha para começar a escrita
 RCALL ESCREVE		;Envia o comando para o Microcontrolador


 BSF RS
 MOVLW 'S'					;Escreve digito no display
 RCALL ESCREVE				;Escreve digito no display
 MOVLW 't'					;Escreve digito no display
 RCALL ESCREVE				;Escreve digito no display
 MOVLW 'a'					;Escreve digito no display
 RCALL ESCREVE				;Escreve digito no display
 MOVLW 'r'					;Escreve digito no display
 RCALL ESCREVE				;Escreve digito no display
 MOVLW 't'					;Escreve digito no display
 RCALL ESCREVE				;Escreve digito no display

 BCF RS				;Configura local de Escrita do LCD
 MOVLW 0XC8
 RCALL ESCREVE
 BSF RS  

 MOVLW 'M'
 CALL ESCREVE
 MOVLW 'o'
 CALL ESCREVE  
 MOVLW 'd'
 CALL ESCREVE
 MOVLW 'o'
 CALL ESCREVE
 MOVLW ':'
 CALL ESCREVE
 MOVLW 'c'
 CALL ESCREVE
 MOVLW 'm'
 CALL ESCREVE
 

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * ROTINA DE LEITURA DOS BOTOES*
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

INICIO_UNID
 BTFSS BOTAO_0
 BRA STATUS_TEMPO_CONTANDO
 BTFSS BOTAO_2
 GOTO TRATA_BOTAO_2
 BTFSS BOTAO_5
 BRA  ALTERA_MODO
 BRA INICIO_UNID

ALTERA_MODO
 BTFSS  BOTAO_5
 GOTO 	ALTERA_MODO
 BTG	MODO,0

 BTFSS	MODO,0
 GOTO   ESCREVE_CM
 GOTO   ESCREVE_MET

ESCREVE_CM
 BCF RS				;Configura local de Escrita do LCD
 MOVLW 0XCD
 RCALL ESCREVE

 BSF RS  
 MOVLW 'c'
 CALL ESCREVE
 MOVLW 'm'
 CALL ESCREVE 
 GOTO INICIO_UNID

ESCREVE_MET
 BCF RS				;Configura local de Escrita do LCD
 MOVLW 0XCD
 RCALL ESCREVE

 BSF RS  
 MOVLW ' '
 CALL ESCREVE  
 MOVLW 'm'
 CALL ESCREVE
 GOTO INICIO_UNID



; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * ROTINA INICIALIZANDO A MEDIÇÃO*
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *


STATUS_TEMPO_CONTANDO
 CLRF UNID
 CLRF DEZE
 CLRF CENT
 CLRF MIL
 CLRF CONTAGEM

 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0X80
 RCALL ESCREVE

 BSF RS
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'I'
 RCALL ESCREVE
 MOVLW 'n'
 RCALL ESCREVE
 MOVLW 'i'
 RCALL ESCREVE
 MOVLW 'c'
 RCALL ESCREVE
 MOVLW 'i'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'l'
 RCALL ESCREVE
 MOVLW 'i'
 RCALL ESCREVE
 MOVLW 'z'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'n'
 CALL ESCREVE
 MOVLW 'd'
 CALL ESCREVE
 MOVLW 'o'
 CALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE

 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0XC0			;Define 5 Digito da Segunda Linha para começar a escrita
 RCALL ESCREVE		;Envia o comando para o Microcontrolador
 
 BSF RS
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'M'
 RCALL ESCREVE
 MOVLW 'e'
 RCALL ESCREVE
 MOVLW 'd'
 RCALL ESCREVE
 MOVLW 'i'
 RCALL ESCREVE
 MOVLW 'd'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'e'
 RCALL ESCREVE
 MOVLW 'm'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE

 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0XCC			;Define 5 Digito da Segunda Linha para começar a escrita
 RCALL ESCREVE		;Envia o comando para o Microcontrolador

 CALL DEFINE_UNID

 MOVLW ' '
 RCALL ESCREVE

DELAYS
 MOVLW .3000
 RCALL DELAY_MS

 MOVLW .3000
 RCALL DELAY_MS

 MOVLW .3000
 RCALL DELAY_MS


;****************************************************************************
 BSF	INTCON,T0IE
 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0X80
 RCALL ESCREVE

 BSF RS
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'I'
 RCALL ESCREVE
 MOVLW 'n'
 RCALL ESCREVE
 MOVLW 'i'
 RCALL ESCREVE
 MOVLW 'c'
 RCALL ESCREVE
 MOVLW 'i'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'r'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'M'
 RCALL ESCREVE
 MOVLW 'e'
 RCALL ESCREVE
 MOVLW 'd'
 RCALL ESCREVE
 MOVLW 'i'
 RCALL ESCREVE
 MOVLW 'd'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE



 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0XC0			;Define 5 Digito da Segunda Linha para começar a escrita
 RCALL ESCREVE		;Envia o comando para o Microcontrolador

 BSF RS
 MOVLW 'S'
 RCALL ESCREVE
 MOVLW 't'
 RCALL ESCREVE
 MOVLW 'o'
 RCALL ESCREVE
 MOVLW 'p'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 RCALL 	ATUALIZA

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * MONITORAMENTO DOS SENSORES DA TRENA*
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

LOP1
		BTFSS		BOTAO_1
		GOTO		TRATA_STOP
		BTFSC		SENSOR1
		GOTO		LOOP
		GOTO		LOP1
LOP2
		BTFSS		BOTAO_1
		GOTO		TRATA_STOP
		BTFSC		SENSOR2
		GOTO		LOOP
		GOTO		LOP2		
LOOP
		BTFSS		BOTAO_1
		GOTO		TRATA_STOP
		BTFSS		SENSOR1
		GOTO		LOOP1
		BTFSS		SENSOR2
		GOTO		LOOP3
		GOTO		LOOP
LOOP1
		BTFSS		BOTAO_1
		GOTO		TRATA_STOP
		BTFSC		SENSOR1
		GOTO		LOOP2
		GOTO		LOOP1
LOOP2
		BTFSS		BOTAO_1
		GOTO		TRATA_STOP
		BTFSS		SENSOR2
		GOTO		AUMENTA
		BTFSS		SENSOR1
		GOTO		LOP1
		GOTO		LOOP2
AUMENTA
		BTFSS		BOTAO_1
		GOTO		TRATA_STOP
		BTFSC		SENSOR2
		GOTO		INCREMENTANDO
		GOTO		AUMENTA
INCREMENTANDO
		INCF		CONTAGEM
 		RCALL 		INCREMENTA
		RCALL 		CORRIGE_VALOR
		BTFSS		BOTAO_1
		GOTO		TRATA_STOP
		GOTO		LOOP
LOOP3
		BTFSS		BOTAO_1
		GOTO		TRATA_STOP
		BTFSC		SENSOR2
		GOTO		LOOP4
		GOTO		LOOP3
LOOP4
		BTFSS		BOTAO_1
		GOTO		TRATA_STOP
		BTFSS		SENSOR1
		GOTO		DIMINUI
		BTFSS		SENSOR2
		GOTO		LOP2
		GOTO		LOOP4
DIMINUI
		BTFSS		BOTAO_1
		GOTO		TRATA_STOP
		BTFSC		SENSOR1
		GOTO		DECREMENTANDO
		GOTO		DIMINUI
DECREMENTANDO
		DECF		CONTAGEM
 		RCALL 		DECREMENTA
		RCALL 		CORRIGE_VALOR
		BTFSS		BOTAO_1
		GOTO		TRATA_STOP
		GOTO		LOOP

CORRIGE_VALOR
 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0XC8			;Define 5 Digito da Segunda Linha para começar a escrita
 RCALL ESCREVE		;Envia o comando para o Microcontrolador

ATUALIZA
 BTFSC	MODO,0
 BRA	ATUALIZA_METROS 

 BSF RS
 MOVF CENT,W		;Escreve numero Milhar no LCD
 RCALL TABELA_7S
 RCALL ESCREVE

 MOVF DEZE,W 	;Escreve numero Centena no LCD
 RCALL TABELA_7S
 RCALL ESCREVE

 MOVF UNID,W		;Escreve numero DEZE no LCD
 RCALL TABELA_7S
 RCALL ESCREVE 

 MOVLW ','			;Escreve ":" no LCD para dividir Minutos e Segundos
 RCALL ESCREVE 

 MOVLW '0'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'c'
 CALL ESCREVE
 MOVLW 'm'
 CALL ESCREVE
RETURN

ATUALIZA_METROS
 BSF RS
 MOVF MIL,W		;Escreve numero Milhar no LCD
 RCALL TABELA_7S
 RCALL ESCREVE

 MOVF CENT,W		;Escreve numero Milhar no LCD
 RCALL TABELA_7S
 RCALL ESCREVE

 MOVLW ','			;Escreve ":" no LCD para dividir Minutos e Segundos
 RCALL ESCREVE 

 MOVF DEZE,W 	;Escreve numero Centena no LCD
 RCALL TABELA_7S
 RCALL ESCREVE

 MOVF UNID,W		;Escreve numero DEZE no LCD
 RCALL TABELA_7S
 RCALL ESCREVE 

 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'M'
 CALL ESCREVE
 MOVLW ' '
 CALL ESCREVE
RETURN





; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * TELA DE STOP *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

TELA_STOP
 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0X80
 RCALL ESCREVE

 BSF RS
 MOVLW 'V'
 RCALL ESCREVE
 MOVLW '.'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'M'
 RCALL ESCREVE
 MOVLW 'e'
 RCALL ESCREVE
 MOVLW 'd'
 RCALL ESCREVE
 MOVLW '.'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE

 CALL ATUALIZA



 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0XC0			;Define 5 Digito da Segunda Linha para começar a escrita
 RCALL ESCREVE		;Envia o comando para o Microcontrolador

 BSF RS
 MOVLW 'Z'
 RCALL ESCREVE
 MOVLW 'e'
 RCALL ESCREVE
 MOVLW 'r'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'r'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'M'
 RCALL ESCREVE
 MOVLW '1'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'M'
 RCALL ESCREVE
 MOVLW '2'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE

RETURN


; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * CONFIGURA??ES INICIAIS DE HARDWARE E SOFTWARE *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
CONFIGURACAO
 MOVLW B'11111111'
 MOVWF TRISB
 MOVLW B'00000000'
 MOVWF TRISD
 MOVLW B'00000100'
 MOVWF TRISE
 MOVLW B'11000001'
 MOVWF TRISA
 MOVLW B'00100000'
 MOVWF TRISC

 CLRF LATB
 CLRF LATD
 CLRF LATA
 CLRF LATE
 RCALL INICIALIZACAO_DISPLAY
 MOVLW		H'80'						;w = 80h
 MOVWF		INTCON						;CONFIGURA INTCON...

	MOVLW		D'0'						;move a literal 0d para work
	MOVWF		TMR0						;inicializa TMR0 em 10d. Timer0 = 256 - 10 = 246
	
	MOVLW		D'128'						;move a literal 128d para work
	MOVWF		COUNTER1					;inicializa counter1 em 18d
 GOTO MOSTRA_TELA_PRINCIPAL 

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * ROTINA INCREMENTA CONTADOR *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
INCREMENTA
 INCF UNID,F
 MOVLW MAX1
 XORWF UNID,W
 BTFSS STATUS,Z
 RETURN
 CLRF UNID
 
 INCF DEZE,F
 MOVLW MAX2
 XORWF DEZE,W
 BTFSS STATUS,Z
 RETURN
 CLRF UNID
 CLRF DEZE
 
 INCF CENT,F
 MOVLW MAX1
 XORWF CENT,W
 BTFSS STATUS,Z
 RETURN
 CLRF UNID
 CLRF DEZE
 CLRF CENT 

 INCF MIL,F
 MOVLW MAX2
 XORWF MIL,W
 BTFSS STATUS,Z
 RETURN
 CLRF UNID
 CLRF DEZE
 CLRF CENT
 CLRF MIL 

 RETURN

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * ROTINA DECREMENTA CONTADOR *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
DECREMENTA
 TSTFSZ  UNID;
 BRA $+.8
 MOVLW 	.9
 MOVWF	UNID
 BRA $+.6
 DECF UNID,F 
 RETURN

 TSTFSZ  DEZE;
 BRA $+.8
 MOVLW 	.9
 MOVWF	DEZE
 BRA $+.6
 DECF DEZE,F 
 RETURN
 
 
 TSTFSZ  CENT;
 BRA $+.8
 MOVLW 	.9
 MOVWF	CENT
 BRA $+.6
 DECF CENT,F 
 RETURN

 TSTFSZ  MIL;
 BRA $+.14
 CLRF UNID
 CLRF DEZE
 CLRF CENT
 CLRF MIL
 CLRF CONTAGEM
 RETURN
 DECF MIL,F 
 RETURN

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * ROTINA SALVAR MEMORIA 1 *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

SALVAR_M1
 MOVFF UNID, MEMORIA_UNID1
 MOVFF DEZE, MEMORIA_DEZ1
 MOVFF CENT, MEMORIA_CENT1
 MOVFF MIL, MEMORIA_MIL1
 MOVFF CONTAGEM, CONTAGEM1

 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0X80
 RCALL ESCREVE

 BSF RS
 MOVLW 'M'
 RCALL ESCREVE
 MOVLW '1'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'A'
 RCALL ESCREVE
 MOVLW 'r'
 RCALL ESCREVE
 MOVLW 'm'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'z'
 RCALL ESCREVE
 MOVLW 'e'
 RCALL ESCREVE
 MOVLW 'n'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'd'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE

 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0XC0			;Define 5 Digito da Segunda Linha para começar a escrita
 RCALL ESCREVE		;Envia o comando para o Microcontrolador

 BSF RS
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'V'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'l'
 RCALL ESCREVE
 MOVLW 'o'
 RCALL ESCREVE
 MOVLW 'r'
 RCALL ESCREVE
 MOVLW ':'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE

CALL ATUALIZA

 MOVLW .3000
 RCALL DELAY_MS

 MOVLW .3000
 RCALL DELAY_MS

 MOVLW .3000
 RCALL DELAY_MS

RCALL TELA_STOP
RETURN

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * ROTINA SALVAR MEMORIA 1 *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

SALVAR_M2

BTFSS MODO,0
GOTO ERRO_MEMORIA2

 MOVFF UNID, MEMORIA_UNID2
 MOVFF DEZE, MEMORIA_DEZ2
 MOVFF CENT, MEMORIA_CENT2
 MOVFF MIL, MEMORIA_MIL2
 MOVFF CONTAGEM, CONTAGEM2

 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0X80
 RCALL ESCREVE

 BSF RS
 MOVLW 'M'
 RCALL ESCREVE
 MOVLW '2'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'A'
 RCALL ESCREVE
 MOVLW 'r'
 RCALL ESCREVE
 MOVLW 'm'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'z'
 RCALL ESCREVE
 MOVLW 'e'
 RCALL ESCREVE
 MOVLW 'n'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'd'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE

 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0XC0			;Define 5 Digito da Segunda Linha para começar a escrita
 RCALL ESCREVE		;Envia o comando para o Microcontrolador

 BSF RS
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'V'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'l'
 RCALL ESCREVE
 MOVLW 'o'
 RCALL ESCREVE
 MOVLW 'r'
 RCALL ESCREVE
 MOVLW ':'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE

CALL ATUALIZA

 MOVLW .3000
 RCALL DELAY_MS

 MOVLW .3000
 RCALL DELAY_MS

 MOVLW .3000
 RCALL DELAY_MS

RCALL TELA_STOP
RETURN

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * CALCULO DA AREA *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *


CALC_AREA

BTFSS MODO,0
GOTO ERRO_MODO

 	MOVFF		CONTAGEM1, A0							;A0 = número
 	MOVFF		CONTAGEM2, B0							;A0 = número
 	CALL		mult						;chama sub-rotina de multiplicação
 	MOVF		C0,W									
	CALL		conv_binToDec

 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0X80
 RCALL ESCREVE

 BSF RS
 MOVLW 'A'
 RCALL ESCREVE
 MOVLW 'r'
 RCALL ESCREVE
 MOVLW 'e'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'C'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'l'
 RCALL ESCREVE
 MOVLW 'c'
 RCALL ESCREVE
 MOVLW 'u'
 RCALL ESCREVE
 MOVLW 'l'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'd'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW ':'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE

 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0XC0			;Define 5 Digito da Segunda Linha para começar a escrita
 RCALL ESCREVE		;Envia o comando para o Microcontrolador

 BSF RS
 MOVLW 'V'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'l'
 RCALL ESCREVE
 MOVLW 'o'
 RCALL ESCREVE
 MOVLW 'r'
 RCALL ESCREVE
 MOVLW ':'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE


 MOVF MIL,W		;Escreve numero Milhar no LCD
 RCALL TABELA_7S
 RCALL ESCREVE

 MOVF CEN,W 	;Escreve numero Centena no LCD
 RCALL TABELA_7S
 RCALL ESCREVE

 MOVF DEZ,W		;Escreve numero DEZE no LCD
 RCALL TABELA_7S
 RCALL ESCREVE 

 MOVLW ','			;Escreve "," no LCD
 RCALL ESCREVE 

 MOVF UNI,W  	;Escreve numero UNID no LCD
 RCALL TABELA_7S
 RCALL ESCREVE

 MOVLW ' '
 RCALL ESCREVE

 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'M'
 RCALL ESCREVE


 MOVLW .3000
 RCALL DELAY_MS

 MOVLW .3000
 RCALL DELAY_MS

 MOVLW .3000
 RCALL DELAY_MS

 GOTO STOP_BOTOES

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * TELA ERRO NO MODO ESCOLHIDO *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

ERRO_MODO
 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0X80
 RCALL ESCREVE

 BSF RS
 MOVLW 'A'
 RCALL ESCREVE
 MOVLW 'r'
 RCALL ESCREVE
 MOVLW 'e'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'C'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'l'
 RCALL ESCREVE
 MOVLW 'c'
 RCALL ESCREVE
 MOVLW 'u'
 RCALL ESCREVE
 MOVLW 'l'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'd'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW ':'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE

 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0XC0			;Define 5 Digito da Segunda Linha para começar a escrita
 RCALL ESCREVE		;Envia o comando para o Microcontrolador

 BSF RS
 MOVLW 'S'
 RCALL ESCREVE
 MOVLW 't'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'r'
 RCALL ESCREVE
 MOVLW 't'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'E'
 RCALL ESCREVE
 MOVLW 'r'
 RCALL ESCREVE
 MOVLW 'r'
 RCALL ESCREVE
 MOVLW 'o'
 RCALL ESCREVE
 MOVLW '-'
 RCALL ESCREVE
 MOVLW 'M'
 RCALL ESCREVE
 MOVLW 'o'
 RCALL ESCREVE
 MOVLW 'd'
 RCALL ESCREVE
 MOVLW 'o'
 RCALL ESCREVE
 MOVLW '!'
 RCALL ESCREVE


 MOVLW .3000
 RCALL DELAY_MS

 MOVLW .3000
 RCALL DELAY_MS

 MOVLW .3000
 RCALL DELAY_MS
GOTO TELA_STOP



; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * TELA ERRO MEMORIA 2 EM CENTIMETROS *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

ERRO_MEMORIA2
 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0X80
 RCALL ESCREVE

 BSF RS
 MOVLW 'M'
 RCALL ESCREVE
 MOVLW 'e'
 RCALL ESCREVE
 MOVLW 'm'
 RCALL ESCREVE
 MOVLW 'o'
 RCALL ESCREVE
 MOVLW 'r'
 RCALL ESCREVE
 MOVLW 'i'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW '2'
 RCALL ESCREVE
 MOVLW ' '
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 'P'
 RCALL ESCREVE
 MOVLW 'e'
 RCALL ESCREVE
 MOVLW 'n'
 RCALL ESCREVE
 MOVLW 'a'
 RCALL ESCREVE
 MOVLW 's'
 RCALL ESCREVE

 BCF RS 			;Muda modo de funcionamento para Enviar Comandos
 MOVLW 0XC0			;Define 5 Digito da Segunda Linha para começar a escrita
 RCALL ESCREVE		;Envia o comando para o Microcontrolador

 BSF RS
 MOVLW 'p'
 CALL ESCREVE
 MOVLW 'a'
 CALL ESCREVE
 MOVLW 'r'
 CALL ESCREVE
 MOVLW 'a'
 CALL ESCREVE
 MOVLW ' '
 CALL ESCREVE
 MOVLW 'm'
 CALL ESCREVE
 MOVLW 'e'
 CALL ESCREVE
 MOVLW 't'
 CALL ESCREVE
 MOVLW 'r'
 CALL ESCREVE
 MOVLW 'o'
 CALL ESCREVE
 MOVLW 's'
 CALL ESCREVE
 MOVLW ' '
 CALL ESCREVE
 MOVLW ' '
 CALL ESCREVE
 MOVLW ' '
 CALL ESCREVE
 MOVLW ' '
 CALL ESCREVE
 MOVLW ' '
 CALL ESCREVE


 MOVLW .3000
 CALL DELAY_MS

 MOVLW .3000
 CALL DELAY_MS

 MOVLW .3000
 CALL DELAY_MS
GOTO TELA_STOP




mult:
	clrf		C0							;limpa conteúdo do registrador C0
	clrf		C1							;limpa conteúdo do registrador C1
	movf		A0,W						;envia o conteúdo de A0 para W
	movwf		C0							;envia o conteúdo de W para C0
	
loop_mult:
	decf		B0,F						;decrementa B0
	btfsc		STATUS,Z					;B0 igual a zero?
	return									;Sim, retorna
	movf		A0,W						;copia A0 para W
	addwf		C0,F						;Soma A0 com C0 e armazena resultado em C0
	btfsc		STATUS,C					;Houve transbordo em C0?
	incf		C1,F						;Sim, incrementa C1
	goto		loop_mult					;Vai para label loop_mult




conv_binToDec:

	movwf		REG_AUX						;salva valor a converter em REG_AUX
	clrf		UNI							;limpa unidade
	clrf		DEZ							;limpa dezena
	clrf		CEN							;limpa centena

	movf		REG_AUX,F					;REG_AUX = REG_AUX
	btfsc		STATUS,Z					;valor a converter resultou em zero?
	return									;Sim. Retorna

start_adj:
						
	incf		UNI,F						;Não. Incrementa UNI
	movf		UNI,W						;move o conteúdo de UNI para Work
	xorlw		H'0A'						;W = UNI XOR 10d
	btfss		STATUS,Z					;Resultou em 10d?
	goto		end_adj						;Não. Desvia para end_adj
						 
	clrf		UNI							;Sim. Limpa registrador UNI
	movf		DEZ,W						;Move o conteúdo de DEZ para Work
	xorlw		H'09'						;W = DEZ_A XOR 9d
	btfss		STATUS,Z					;Resultou em 9d?
	goto		incDezA						;Não, valor menor que 9. Incrementa DEZ_A
	clrf		DEZ							;Sim. Limpa registrador DEZ
	incf		CEN,F						;Incrementa registrador CEN
	goto		end_adj						;Desvia para end_adj
	
incDezA:
	incf		DEZ,F						;Incrementa DEZ
	
end_adj:
	decfsz		REG_AUX,F					;Decrementa REG_AUX. Fim da conversão ?
	goto		start_adj					;Não. Continua
	return	

DEFINE_UNID
 BTFSC	MODO,0
 BRA	METROS 

 BSF RS
 MOVLW 'c'
 CALL ESCREVE
 MOVLW 'm'
 CALL ESCREVE
 MOVLW ' '
 CALL ESCREVE
 MOVLW ' '
 CALL ESCREVE
 GOTO DELAYS

METROS 
 BSF RS
 MOVLW ' '
 CALL ESCREVE
 MOVLW 'M'
 CALL ESCREVE
RETURN

; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
; * TRATAMENTO DOS BOTÕES *
; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

TRATA_STOP
 BTFSS BOTAO_1
 GOTO  TRATA_STOP
 RCALL TELA_STOP

STOP_BOTOES
 BTFSS BOTAO_2
 GOTO MOSTRA_TELA_PRINCIPAL

 BTFSS BOTAO_0
 GOTO STATUS_TEMPO_CONTANDO

 BTFSS BOTAO_3
 RCALL SALVAR_M1

 BTFSS BOTAO_4
 RCALL SALVAR_M2

 BTFSS BOTAO_7
 GOTO CALC_AREA

 GOTO STOP_BOTOES

TRATA_BOTAO_7
 BTFSS BOTAO_7
 GOTO TRATA_BOTAO_7
 GOTO TELA_STOP



TRATA_BOTAO_2
 BTFSS BOTAO_2
 GOTO TRATA_BOTAO_2
 GOTO MOSTRA_TELA_PRINCIPAL

END 