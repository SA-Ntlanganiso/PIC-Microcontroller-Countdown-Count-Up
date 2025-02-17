#include p16f627a.inc
__config h'3d10'


start				bsf 			status,5
					clrf 			portb
					bcf 			status,5

initialize 			clrf 			portb
					bsf				porta,0
					bsf				porta,1
					clrf 			50h
					movlw			.10
					movwf 			25h
					call 			delay
					call 			bcd
					call 			delay


TEST				btfsc			porta,0
					goto			count_up
					btfsc			porta,1
					goto			count_down
					goto			initialize

count_down			decf 			25h,1
					movfw 			25h
					call 			bcd
					movwf 			portb
					call 			delay
					movlw 			.0
					subwf 			25h,0
					btfss 			status,z
					goto 			count_down
					goto 			initialize

count_up 			incf 			50h,1
					movfw 			50h
					call 			bcd
					movwf 			portb
					call 			delay
					movlw 			.10
					subwf 			50h,0
					btfss 			status,z
					goto 			count_up 
					goto 			initialize

bcd: 				movwf 			40h
					clrf 			30h
repeat2: 			movlw 			.10
					subwf 			40h,0
					btfss 			status,c
					goto 			finish2
					movwf 			40h
					incf 			30h,1
					goto 			repeat2
finish2: 			swapf 			30h,0
					addwf 			40h,0
					return
delay 				movlw 			.8
					movwf 			20h
loop3 				movlw 			.103
					movwf 			21h
loop2 				movlw 			.201
					movwf 			22h
loop1 				decfsz 			22h,1
					goto 			loop1
					decfsz 			21h,1
					goto 			loop2
					decfsz 			20h,1
					goto 			loop3
					return
					END