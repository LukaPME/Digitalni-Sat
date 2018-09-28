
_my_strstr:

;SE9M.c,314 :: 		int my_strstr(int index, char *s1)
;SE9M.c,317 :: 		int flag = 0;
	CLRF        my_strstr_flag_L0+0 
	CLRF        my_strstr_flag_L0+1 
;SE9M.c,321 :: 		for( i = index; login_code[i] != '\0'; i++)
	MOVF        FARG_my_strstr_index+0, 0 
	MOVWF       R3 
	MOVF        FARG_my_strstr_index+1, 0 
	MOVWF       R4 
L_my_strstr0:
	MOVLW       _login_code+0
	ADDWF       R3, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_login_code+0)
	ADDWFC      R4, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_login_code+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_my_strstr1
;SE9M.c,323 :: 		if (login_code[i] == s1[0])
	MOVLW       _login_code+0
	ADDWF       R3, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_login_code+0)
	ADDWFC      R4, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_login_code+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVFF       FARG_my_strstr_s1+0, FSR2
	MOVFF       FARG_my_strstr_s1+1, FSR2H
	MOVF        R1, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_my_strstr3
;SE9M.c,325 :: 		for (j = i; ; j++)
	MOVF        R3, 0 
	MOVWF       R5 
	MOVF        R4, 0 
	MOVWF       R6 
L_my_strstr4:
;SE9M.c,327 :: 		if (s1[j-i] == '\0'){ flag = 1;
	MOVF        R3, 0 
	SUBWF       R5, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	SUBWFB      R6, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_my_strstr_s1+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_my_strstr_s1+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_my_strstr7
	MOVLW       1
	MOVWF       my_strstr_flag_L0+0 
	MOVLW       0
	MOVWF       my_strstr_flag_L0+1 
;SE9M.c,328 :: 		break;}
	GOTO        L_my_strstr5
L_my_strstr7:
;SE9M.c,329 :: 		if (login_code[j] == s1[j-i])
	MOVLW       _login_code+0
	ADDWF       R5, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_login_code+0)
	ADDWFC      R6, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_login_code+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	BTFSC       R6, 7 
	MOVLW       255
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R2
	MOVF        R3, 0 
	SUBWF       R5, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	SUBWFB      R6, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_my_strstr_s1+0, 0 
	MOVWF       FSR2 
	MOVF        R1, 0 
	ADDWFC      FARG_my_strstr_s1+1, 0 
	MOVWF       FSR2H 
	MOVF        R2, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_my_strstr8
;SE9M.c,330 :: 		continue;
	GOTO        L_my_strstr6
L_my_strstr8:
;SE9M.c,332 :: 		break;
	GOTO        L_my_strstr5
;SE9M.c,333 :: 		}
L_my_strstr6:
;SE9M.c,325 :: 		for (j = i; ; j++)
	INFSNZ      R5, 1 
	INCF        R6, 1 
;SE9M.c,333 :: 		}
	GOTO        L_my_strstr4
L_my_strstr5:
;SE9M.c,334 :: 		}
L_my_strstr3:
;SE9M.c,335 :: 		if (flag == 1)
	MOVLW       0
	XORWF       my_strstr_flag_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__my_strstr365
	MOVLW       1
	XORWF       my_strstr_flag_L0+0, 0 
L__my_strstr365:
	BTFSS       STATUS+0, 2 
	GOTO        L_my_strstr10
;SE9M.c,336 :: 		break;
	GOTO        L_my_strstr1
L_my_strstr10:
;SE9M.c,321 :: 		for( i = index; login_code[i] != '\0'; i++)
	INFSNZ      R3, 1 
	INCF        R4, 1 
;SE9M.c,337 :: 		}
	GOTO        L_my_strstr0
L_my_strstr1:
;SE9M.c,344 :: 		return j;
	MOVF        R5, 0 
	MOVWF       R0 
	MOVF        R6, 0 
	MOVWF       R1 
;SE9M.c,345 :: 		}
L_end_my_strstr:
	RETURN      0
; end of _my_strstr

_strstr1:

;SE9M.c,346 :: 		int strstr1(int index,char *s2, char *s1)
;SE9M.c,349 :: 		int flag = 0;
	CLRF        strstr1_flag_L0+0 
	CLRF        strstr1_flag_L0+1 
;SE9M.c,353 :: 		for( i = index; s2[i] != '\0'; i++)
	MOVF        FARG_strstr1_index+0, 0 
	MOVWF       R2 
	MOVF        FARG_strstr1_index+1, 0 
	MOVWF       R3 
L_strstr111:
	MOVF        R2, 0 
	ADDWF       FARG_strstr1_s2+0, 0 
	MOVWF       FSR0 
	MOVF        R3, 0 
	ADDWFC      FARG_strstr1_s2+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_strstr112
;SE9M.c,355 :: 		if (s2[i] == s1[0])
	MOVF        R2, 0 
	ADDWF       FARG_strstr1_s2+0, 0 
	MOVWF       FSR0 
	MOVF        R3, 0 
	ADDWFC      FARG_strstr1_s2+1, 0 
	MOVWF       FSR0H 
	MOVFF       FARG_strstr1_s1+0, FSR2
	MOVFF       FARG_strstr1_s1+1, FSR2H
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_strstr114
;SE9M.c,357 :: 		for (j = i; ; j++)
	MOVF        R2, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R5 
L_strstr115:
;SE9M.c,359 :: 		if (s1[j-i] == '\0'){ flag = 1;
	MOVF        R2, 0 
	SUBWF       R4, 0 
	MOVWF       R0 
	MOVF        R3, 0 
	SUBWFB      R5, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_strstr1_s1+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_strstr1_s1+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_strstr118
	MOVLW       1
	MOVWF       strstr1_flag_L0+0 
	MOVLW       0
	MOVWF       strstr1_flag_L0+1 
;SE9M.c,360 :: 		break;}
	GOTO        L_strstr116
L_strstr118:
;SE9M.c,361 :: 		if (s2[j] == s1[j-i])
	MOVF        R4, 0 
	ADDWF       FARG_strstr1_s2+0, 0 
	MOVWF       FSR0 
	MOVF        R5, 0 
	ADDWFC      FARG_strstr1_s2+1, 0 
	MOVWF       FSR0H 
	MOVF        R2, 0 
	SUBWF       R4, 0 
	MOVWF       R0 
	MOVF        R3, 0 
	SUBWFB      R5, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_strstr1_s1+0, 0 
	MOVWF       FSR2 
	MOVF        R1, 0 
	ADDWFC      FARG_strstr1_s1+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_strstr119
;SE9M.c,362 :: 		continue;
	GOTO        L_strstr117
L_strstr119:
;SE9M.c,364 :: 		break;
	GOTO        L_strstr116
;SE9M.c,365 :: 		}
L_strstr117:
;SE9M.c,357 :: 		for (j = i; ; j++)
	INFSNZ      R4, 1 
	INCF        R5, 1 
;SE9M.c,365 :: 		}
	GOTO        L_strstr115
L_strstr116:
;SE9M.c,366 :: 		}
L_strstr114:
;SE9M.c,367 :: 		if (flag == 1)
	MOVLW       0
	XORWF       strstr1_flag_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__strstr1367
	MOVLW       1
	XORWF       strstr1_flag_L0+0, 0 
L__strstr1367:
	BTFSS       STATUS+0, 2 
	GOTO        L_strstr121
;SE9M.c,368 :: 		break;
	GOTO        L_strstr112
L_strstr121:
;SE9M.c,353 :: 		for( i = index; s2[i] != '\0'; i++)
	INFSNZ      R2, 1 
	INCF        R3, 1 
;SE9M.c,369 :: 		}
	GOTO        L_strstr111
L_strstr112:
;SE9M.c,376 :: 		return j;
	MOVF        R4, 0 
	MOVWF       R0 
	MOVF        R5, 0 
	MOVWF       R1 
;SE9M.c,377 :: 		}
L_end_strstr1:
	RETURN      0
; end of _strstr1

_int2str:

;SE9M.c,379 :: 		void    int2str(long l, unsigned char *s)
;SE9M.c,383 :: 		if(l == 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       FARG_int2str_l+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str369
	MOVF        R0, 0 
	XORWF       FARG_int2str_l+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str369
	MOVF        R0, 0 
	XORWF       FARG_int2str_l+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str369
	MOVF        FARG_int2str_l+0, 0 
	XORLW       0
L__int2str369:
	BTFSS       STATUS+0, 2 
	GOTO        L_int2str22
;SE9M.c,385 :: 		s[0] = '0' ;
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVLW       48
	MOVWF       POSTINC1+0 
;SE9M.c,386 :: 		s[1] = 0 ;
	MOVLW       1
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SE9M.c,387 :: 		}
	GOTO        L_int2str23
L_int2str22:
;SE9M.c,390 :: 		if(l < 0)
	MOVLW       128
	XORWF       FARG_int2str_l+3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str370
	MOVLW       0
	SUBWF       FARG_int2str_l+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str370
	MOVLW       0
	SUBWF       FARG_int2str_l+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str370
	MOVLW       0
	SUBWF       FARG_int2str_l+0, 0 
L__int2str370:
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str24
;SE9M.c,392 :: 		l *= -1 ;
	MOVF        FARG_int2str_l+0, 0 
	MOVWF       R0 
	MOVF        FARG_int2str_l+1, 0 
	MOVWF       R1 
	MOVF        FARG_int2str_l+2, 0 
	MOVWF       R2 
	MOVF        FARG_int2str_l+3, 0 
	MOVWF       R3 
	MOVLW       255
	MOVWF       R4 
	MOVLW       255
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVF        R1, 0 
	MOVWF       FARG_int2str_l+1 
	MOVF        R2, 0 
	MOVWF       FARG_int2str_l+2 
	MOVF        R3, 0 
	MOVWF       FARG_int2str_l+3 
;SE9M.c,393 :: 		n = 1 ;
	MOVLW       1
	MOVWF       int2str_n_L0+0 
;SE9M.c,394 :: 		}
	GOTO        L_int2str25
L_int2str24:
;SE9M.c,397 :: 		n = 0 ;
	CLRF        int2str_n_L0+0 
;SE9M.c,398 :: 		}
L_int2str25:
;SE9M.c,399 :: 		s[0] = 0 ;
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	CLRF        POSTINC1+0 
;SE9M.c,400 :: 		i = 0 ;
	CLRF        int2str_i_L0+0 
;SE9M.c,401 :: 		while(l > 0)
L_int2str26:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_int2str_l+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str371
	MOVF        FARG_int2str_l+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str371
	MOVF        FARG_int2str_l+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str371
	MOVF        FARG_int2str_l+0, 0 
	SUBLW       0
L__int2str371:
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str27
;SE9M.c,403 :: 		for(j = i + 1 ; j > 0 ; j--)
	MOVF        int2str_i_L0+0, 0 
	ADDLW       1
	MOVWF       int2str_j_L0+0 
L_int2str28:
	MOVF        int2str_j_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str29
;SE9M.c,405 :: 		s[j] = s[j - 1] ;
	MOVF        int2str_j_L0+0, 0 
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR1H 
	DECF        int2str_j_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,403 :: 		for(j = i + 1 ; j > 0 ; j--)
	DECF        int2str_j_L0+0, 1 
;SE9M.c,406 :: 		}
	GOTO        L_int2str28
L_int2str29:
;SE9M.c,407 :: 		s[0] = l % 10 ;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_int2str_l+0, 0 
	MOVWF       R0 
	MOVF        FARG_int2str_l+1, 0 
	MOVWF       R1 
	MOVF        FARG_int2str_l+2, 0 
	MOVWF       R2 
	MOVF        FARG_int2str_l+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,408 :: 		s[0] += '0' ;
	MOVFF       FARG_int2str_s+0, FSR0
	MOVFF       FARG_int2str_s+1, FSR0H
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVLW       48
	ADDWF       POSTINC0+0, 1 
;SE9M.c,409 :: 		i++ ;
	INCF        int2str_i_L0+0, 1 
;SE9M.c,410 :: 		l /= 10 ;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_int2str_l+0, 0 
	MOVWF       R0 
	MOVF        FARG_int2str_l+1, 0 
	MOVWF       R1 
	MOVF        FARG_int2str_l+2, 0 
	MOVWF       R2 
	MOVF        FARG_int2str_l+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVF        R1, 0 
	MOVWF       FARG_int2str_l+1 
	MOVF        R2, 0 
	MOVWF       FARG_int2str_l+2 
	MOVF        R3, 0 
	MOVWF       FARG_int2str_l+3 
;SE9M.c,411 :: 		}
	GOTO        L_int2str26
L_int2str27:
;SE9M.c,412 :: 		if(n)
	MOVF        int2str_n_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_int2str31
;SE9M.c,414 :: 		for(j = i + 1 ; j > 0 ; j--)
	MOVF        int2str_i_L0+0, 0 
	ADDLW       1
	MOVWF       int2str_j_L0+0 
L_int2str32:
	MOVF        int2str_j_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str33
;SE9M.c,416 :: 		s[j] = s[j - 1] ;
	MOVF        int2str_j_L0+0, 0 
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR1H 
	DECF        int2str_j_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,414 :: 		for(j = i + 1 ; j > 0 ; j--)
	DECF        int2str_j_L0+0, 1 
;SE9M.c,417 :: 		}
	GOTO        L_int2str32
L_int2str33:
;SE9M.c,418 :: 		s[0] = '-' ;
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVLW       45
	MOVWF       POSTINC1+0 
;SE9M.c,419 :: 		}
L_int2str31:
;SE9M.c,420 :: 		}
L_int2str23:
;SE9M.c,421 :: 		}
L_end_int2str:
	RETURN      0
; end of _int2str

_ts2str:

;SE9M.c,422 :: 		void    ts2str (unsigned char *s, TimeStruct *t, unsigned char m){
;SE9M.c,428 :: 		if(m & TS2STR_DATE){
	BTFSS       FARG_ts2str_m+0, 0 
	GOTO        L_ts2str35
;SE9M.c,429 :: 		strcpy(s, wday[t->wd]) ;        // week day
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcpy_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcpy_to+1 
	MOVLW       4
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _wday+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_wday+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcpy_from+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,430 :: 		danuned = t->wd;
	MOVLW       4
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _danuned+0 
;SE9M.c,431 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr31_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr31_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,432 :: 		ByteToStr(t->md, tmp) ;         // day num
	MOVLW       3
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,433 :: 		dan = t->md;
	MOVLW       3
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _dan+0 
;SE9M.c,434 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,435 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr32_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr32_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,436 :: 		strcat(s, mon[t->mo]) ;        // month
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       5
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _mon+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_mon+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcat_from+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,437 :: 		mesec = t->mo;
	MOVLW       5
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _mesec+0 
;SE9M.c,438 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr33_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr33_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,439 :: 		WordToStr(t->yy, tmp) ;         // year
	MOVLW       6
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;SE9M.c,440 :: 		godina = t->yy;
	MOVLW       6
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__ts2str+4 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__ts2str+5 
	MOVF        FLOC__ts2str+4, 0 
	MOVWF       _godina+0 
	MOVF        FLOC__ts2str+5, 0 
	MOVWF       _godina+1 
;SE9M.c,441 :: 		godyear1 = godina / 1000;
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVF        FLOC__ts2str+4, 0 
	MOVWF       R0 
	MOVF        FLOC__ts2str+5, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _godyear1+0 
;SE9M.c,442 :: 		godyear2 = (godina - godyear1 * 1000) / 100;
	MOVLW       0
	MOVWF       R1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__ts2str+2 
	MOVF        R1, 0 
	MOVWF       FLOC__ts2str+3 
	MOVF        FLOC__ts2str+2, 0 
	SUBWF       FLOC__ts2str+4, 0 
	MOVWF       R0 
	MOVF        FLOC__ts2str+3, 0 
	SUBWFB      FLOC__ts2str+5, 0 
	MOVWF       R1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _godyear2+0 
;SE9M.c,443 :: 		godyear3 = (godina - godyear1 * 1000 - godyear2 * 100) / 10;
	MOVF        FLOC__ts2str+2, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R2, 0 
	SUBWF       FLOC__ts2str+4, 0 
	MOVWF       R2 
	MOVF        R3, 0 
	SUBWFB      FLOC__ts2str+5, 0 
	MOVWF       R3 
	MOVLW       100
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       FLOC__ts2str+0 
	MOVF        PRODH+0, 0 
	MOVWF       FLOC__ts2str+1 
	MOVF        FLOC__ts2str+0, 0 
	SUBWF       R2, 0 
	MOVWF       R0 
	MOVF        FLOC__ts2str+1, 0 
	SUBWFB      R3, 0 
	MOVWF       R1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _godyear3+0 
;SE9M.c,444 :: 		godyear4 = godina - godyear1 * 1000 - godyear2 * 100 - godyear3 * 10;
	MOVF        FLOC__ts2str+2, 0 
	SUBWF       FLOC__ts2str+4, 0 
	MOVWF       R2 
	MOVF        FLOC__ts2str+0, 0 
	SUBWF       R2, 1 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	SUBWF       R2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _godyear4+0 
;SE9M.c,445 :: 		fingodina = godyear3 * 10 + godyear4;
	MOVF        R1, 0 
	MOVWF       _fingodina+0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       _fingodina+0 
;SE9M.c,446 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,447 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr34_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr34_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,448 :: 		}
	GOTO        L_ts2str36
L_ts2str35:
;SE9M.c,450 :: 		*s = 0 ;
	MOVFF       FARG_ts2str_s+0, FSR1
	MOVFF       FARG_ts2str_s+1, FSR1H
	CLRF        POSTINC1+0 
;SE9M.c,451 :: 		}
L_ts2str36:
;SE9M.c,456 :: 		if(m & TS2STR_TIME){
	BTFSS       FARG_ts2str_m+0, 1 
	GOTO        L_ts2str37
;SE9M.c,457 :: 		ByteToStr(t->hh, tmp) ;         // hour
	MOVLW       2
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,458 :: 		sati = t->hh;
	MOVLW       2
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _sati+0 
;SE9M.c,459 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,460 :: 		strcat(s, ":") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr35_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr35_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,461 :: 		ByteToStr(t->mn, tmp) ;         // minute
	MOVLW       1
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,462 :: 		minuti = (t->mn);
	MOVLW       1
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _minuti+0 
;SE9M.c,463 :: 		if(*(tmp + 1) == ' ')
	MOVF        ts2str_tmp_L0+1, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_ts2str38
;SE9M.c,465 :: 		*(tmp + 1) = '0' ;
	MOVLW       48
	MOVWF       ts2str_tmp_L0+1 
;SE9M.c,466 :: 		}
L_ts2str38:
;SE9M.c,467 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,468 :: 		strcat(s, ":") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr36_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr36_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,469 :: 		ByteToStr(t->ss, tmp) ;         // second
	MOVFF       FARG_ts2str_t+0, FSR0
	MOVFF       FARG_ts2str_t+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,470 :: 		sekundi = t->ss;
	MOVFF       FARG_ts2str_t+0, FSR0
	MOVFF       FARG_ts2str_t+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       _sekundi+0 
;SE9M.c,471 :: 		if(*(tmp + 1) == ' ')
	MOVF        ts2str_tmp_L0+1, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_ts2str39
;SE9M.c,473 :: 		*(tmp + 1) = '0' ;
	MOVLW       48
	MOVWF       ts2str_tmp_L0+1 
;SE9M.c,474 :: 		}
L_ts2str39:
;SE9M.c,475 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,476 :: 		}
L_ts2str37:
;SE9M.c,481 :: 		if(m & TS2STR_TZ){
	BTFSS       FARG_ts2str_m+0, 2 
	GOTO        L_ts2str40
;SE9M.c,482 :: 		strcat(s, " GMT") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr37_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr37_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,483 :: 		if(conf.tz > 0)
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _conf+2, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ts2str41
;SE9M.c,485 :: 		strcat(s, "+") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr38_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr38_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,486 :: 		}
L_ts2str41:
;SE9M.c,487 :: 		int2str(conf.tz, s + strlen(s)) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_ts2str_s+0, 0 
	MOVWF       FARG_int2str_s+0 
	MOVF        R1, 0 
	ADDWFC      FARG_ts2str_s+1, 0 
	MOVWF       FARG_int2str_s+1 
	MOVF        _conf+2, 0 
	MOVWF       FARG_int2str_l+0 
	MOVLW       0
	BTFSC       _conf+2, 7 
	MOVLW       255
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	CALL        _int2str+0, 0
;SE9M.c,488 :: 		}
L_ts2str40:
;SE9M.c,489 :: 		}
L_end_ts2str:
	RETURN      0
; end of _ts2str

_mkSNTPrequest:

;SE9M.c,493 :: 		void    mkSNTPrequest(){
;SE9M.c,497 :: 		epoch_fract = presTmr * 274877.906944 ;// zbog tajmera i 2^32
	MOVF        _presTmr+0, 0 
	MOVWF       R0 
	MOVF        _presTmr+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       189
	MOVWF       R4 
	MOVLW       55
	MOVWF       R5 
	MOVLW       6
	MOVWF       R6 
	MOVLW       145
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2longint+0, 0
	MOVF        R0, 0 
	MOVWF       _epoch_fract+0 
	MOVF        R1, 0 
	MOVWF       _epoch_fract+1 
	MOVF        R2, 0 
	MOVWF       _epoch_fract+2 
	MOVF        R3, 0 
	MOVWF       _epoch_fract+3 
;SE9M.c,498 :: 		if (sntpSync)
	MOVF        _sntpSync+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest42
;SE9M.c,499 :: 		if (Net_Ethernet_28j60_UserTimerSec >= sntpTimer)
	MOVF        _sntpTimer+3, 0 
	SUBWF       _Net_Ethernet_28j60_UserTimerSec+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkSNTPrequest374
	MOVF        _sntpTimer+2, 0 
	SUBWF       _Net_Ethernet_28j60_UserTimerSec+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkSNTPrequest374
	MOVF        _sntpTimer+1, 0 
	SUBWF       _Net_Ethernet_28j60_UserTimerSec+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkSNTPrequest374
	MOVF        _sntpTimer+0, 0 
	SUBWF       _Net_Ethernet_28j60_UserTimerSec+0, 0 
L__mkSNTPrequest374:
	BTFSS       STATUS+0, 0 
	GOTO        L_mkSNTPrequest43
;SE9M.c,500 :: 		if (!sync_flag) {
	MOVF        _sync_flag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_mkSNTPrequest44
;SE9M.c,501 :: 		sntpSync = 0;
	CLRF        _sntpSync+0 
;SE9M.c,502 :: 		if (!memcmp(conf.sntpIP, "\0\0\0\0", 4))
	MOVLW       _conf+3
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr39_SE9M+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr39_SE9M+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       4
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_mkSNTPrequest45
;SE9M.c,503 :: 		reloadDNS = 1 ; // force to solve DNS
	MOVLW       1
	MOVWF       _reloadDNS+0 
L_mkSNTPrequest45:
;SE9M.c,504 :: 		}
L_mkSNTPrequest44:
L_mkSNTPrequest43:
L_mkSNTPrequest42:
;SE9M.c,506 :: 		if(reloadDNS)   // is SNTP ip address to be reloaded from DNS ?
	MOVF        _reloadDNS+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest46
;SE9M.c,509 :: 		if(isalpha(*conf.sntpServer))   // doest host name start with an alphabetic character ?
	MOVF        _conf+7, 0 
	MOVWF       FARG_isalpha_character+0 
	CALL        _isalpha+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest47
;SE9M.c,512 :: 		memset(conf.sntpIP, 0, 4);
	MOVLW       _conf+3
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       4
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;SE9M.c,513 :: 		if(remoteIpAddr = Net_Ethernet_28j60_dnsResolve(conf.sntpServer, 5))
	MOVLW       _conf+7
	MOVWF       FARG_Net_Ethernet_28j60_dnsResolve_host+0 
	MOVLW       hi_addr(_conf+7)
	MOVWF       FARG_Net_Ethernet_28j60_dnsResolve_host+1 
	MOVLW       5
	MOVWF       FARG_Net_Ethernet_28j60_dnsResolve_tmax+0 
	CALL        _Net_Ethernet_28j60_dnsResolve+0, 0
	MOVF        R0, 0 
	MOVWF       mkSNTPrequest_remoteIpAddr_L0+0 
	MOVF        R1, 0 
	MOVWF       mkSNTPrequest_remoteIpAddr_L0+1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest48
;SE9M.c,516 :: 		memcpy(conf.sntpIP, remoteIpAddr, 4) ;
	MOVLW       _conf+3
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_memcpy_d1+1 
	MOVF        mkSNTPrequest_remoteIpAddr_L0+0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        mkSNTPrequest_remoteIpAddr_L0+1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,517 :: 		}
L_mkSNTPrequest48:
;SE9M.c,518 :: 		}
	GOTO        L_mkSNTPrequest49
L_mkSNTPrequest47:
;SE9M.c,522 :: 		unsigned char *ptr = conf.sntpServer ;
	MOVLW       _conf+7
	MOVWF       mkSNTPrequest_ptr_L2+0 
	MOVLW       hi_addr(_conf+7)
	MOVWF       mkSNTPrequest_ptr_L2+1 
;SE9M.c,524 :: 		conf.sntpIP[0] = atoi(ptr) ;
	MOVF        mkSNTPrequest_ptr_L2+0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        mkSNTPrequest_ptr_L2+1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+3 
;SE9M.c,525 :: 		ptr = strchr(ptr, '.') + 1 ;
	MOVF        mkSNTPrequest_ptr_L2+0, 0 
	MOVWF       FARG_strchr_ptr+0 
	MOVF        mkSNTPrequest_ptr_L2+1, 0 
	MOVWF       FARG_strchr_ptr+1 
	MOVLW       46
	MOVWF       FARG_strchr_chr+0 
	CALL        _strchr+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       mkSNTPrequest_ptr_L2+0 
	MOVF        R1, 0 
	MOVWF       mkSNTPrequest_ptr_L2+1 
;SE9M.c,526 :: 		conf.sntpIP[1] = atoi(ptr) ;
	MOVF        R0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+4 
;SE9M.c,527 :: 		ptr = strchr(ptr, '.') + 1 ;
	MOVF        mkSNTPrequest_ptr_L2+0, 0 
	MOVWF       FARG_strchr_ptr+0 
	MOVF        mkSNTPrequest_ptr_L2+1, 0 
	MOVWF       FARG_strchr_ptr+1 
	MOVLW       46
	MOVWF       FARG_strchr_chr+0 
	CALL        _strchr+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       mkSNTPrequest_ptr_L2+0 
	MOVF        R1, 0 
	MOVWF       mkSNTPrequest_ptr_L2+1 
;SE9M.c,528 :: 		conf.sntpIP[2] = atoi(ptr) ;
	MOVF        R0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+5 
;SE9M.c,529 :: 		ptr = strchr(ptr, '.') + 1 ;
	MOVF        mkSNTPrequest_ptr_L2+0, 0 
	MOVWF       FARG_strchr_ptr+0 
	MOVF        mkSNTPrequest_ptr_L2+1, 0 
	MOVWF       FARG_strchr_ptr+1 
	MOVLW       46
	MOVWF       FARG_strchr_chr+0 
	CALL        _strchr+0, 0
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       mkSNTPrequest_ptr_L2+0 
	MOVF        R1, 0 
	MOVWF       mkSNTPrequest_ptr_L2+1 
;SE9M.c,530 :: 		conf.sntpIP[3] = atoi(ptr) ;
	MOVF        R0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+6 
;SE9M.c,531 :: 		}
L_mkSNTPrequest49:
;SE9M.c,535 :: 		reloadDNS = 0 ;         // no further call to DNS
	CLRF        _reloadDNS+0 
;SE9M.c,537 :: 		sntpSync = 0 ;          // clock is not sync for now
	CLRF        _sntpSync+0 
;SE9M.c,538 :: 		}
L_mkSNTPrequest46:
;SE9M.c,540 :: 		if(sntpSync)                    // is clock already synchronized from sntp ?
	MOVF        _sntpSync+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest50
;SE9M.c,542 :: 		return ;                // yes, no need to request time
	GOTO        L_end_mkSNTPrequest
;SE9M.c,543 :: 		}
L_mkSNTPrequest50:
;SE9M.c,548 :: 		memset(sntpPkt, 0, 48) ;        // clear sntp packet
	MOVLW       mkSNTPrequest_sntpPkt_L0+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(mkSNTPrequest_sntpPkt_L0+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       48
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;SE9M.c,551 :: 		sntpPkt[0] = 0b00011001 ;       // LI = 0 ; VN = 3 ; MODE = 1
	MOVLW       25
	MOVWF       mkSNTPrequest_sntpPkt_L0+0 
;SE9M.c,556 :: 		sntpPkt[2] = 0x0a ;             // 1024 sec (arbitrary value)
	MOVLW       10
	MOVWF       mkSNTPrequest_sntpPkt_L0+2 
;SE9M.c,559 :: 		sntpPkt[3] = 0xfa ;             // 0.015625 sec (arbitrary value)
	MOVLW       250
	MOVWF       mkSNTPrequest_sntpPkt_L0+3 
;SE9M.c,562 :: 		sntpPkt[6] = 0x44 ;
	MOVLW       68
	MOVWF       mkSNTPrequest_sntpPkt_L0+6 
;SE9M.c,565 :: 		sntpPkt[9] = 0x10 ;
	MOVLW       16
	MOVWF       mkSNTPrequest_sntpPkt_L0+9 
;SE9M.c,570 :: 		sntpPkt[16] = Highest(lastSync);
	MOVF        _lastSync+3, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+16 
;SE9M.c,571 :: 		sntpPkt[17] = Higher(lastSync);
	MOVF        _lastSync+2, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+17 
;SE9M.c,572 :: 		sntpPkt[18] = Hi(lastSync);
	MOVF        _lastSync+1, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+18 
;SE9M.c,573 :: 		sntpPkt[19] = Lo(lastSync);
	MOVF        _lastSync+0, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+19 
;SE9M.c,580 :: 		sntpPkt[40] = Highest(epoch);
	MOVF        _epoch+3, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+40 
;SE9M.c,581 :: 		sntpPkt[41] = Higher(epoch);
	MOVF        _epoch+2, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+41 
;SE9M.c,582 :: 		sntpPkt[42] = Hi(epoch);
	MOVF        _epoch+1, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+42 
;SE9M.c,583 :: 		sntpPkt[43] = Lo(epoch);
	MOVF        _epoch+0, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+43 
;SE9M.c,584 :: 		sntpPkt[44] = Highest(epoch_fract);
	MOVF        _epoch_fract+3, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+44 
;SE9M.c,585 :: 		sntpPkt[45] = Higher(epoch_fract);
	MOVF        _epoch_fract+2, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+45 
;SE9M.c,586 :: 		sntpPkt[46] = Hi(epoch_fract);
	MOVF        _epoch_fract+1, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+46 
;SE9M.c,587 :: 		sntpPkt[47] = Lo(epoch_fract);
	MOVF        _epoch_fract+0, 0 
	MOVWF       mkSNTPrequest_sntpPkt_L0+47 
;SE9M.c,607 :: 		Net_Ethernet_28j60_sendUDP(conf.sntpIP, 123, 123, sntpPkt, 48) ; // transmit UDP packet
	MOVLW       _conf+3
	MOVWF       FARG_Net_Ethernet_28j60_sendUDP_destIP+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_Net_Ethernet_28j60_sendUDP_destIP+1 
	MOVLW       123
	MOVWF       FARG_Net_Ethernet_28j60_sendUDP_sourcePort+0 
	MOVLW       0
	MOVWF       FARG_Net_Ethernet_28j60_sendUDP_sourcePort+1 
	MOVLW       123
	MOVWF       FARG_Net_Ethernet_28j60_sendUDP_destPort+0 
	MOVLW       0
	MOVWF       FARG_Net_Ethernet_28j60_sendUDP_destPort+1 
	MOVLW       mkSNTPrequest_sntpPkt_L0+0
	MOVWF       FARG_Net_Ethernet_28j60_sendUDP_pkt+0 
	MOVLW       hi_addr(mkSNTPrequest_sntpPkt_L0+0)
	MOVWF       FARG_Net_Ethernet_28j60_sendUDP_pkt+1 
	MOVLW       48
	MOVWF       FARG_Net_Ethernet_28j60_sendUDP_pktLen+0 
	MOVLW       0
	MOVWF       FARG_Net_Ethernet_28j60_sendUDP_pktLen+1 
	CALL        _Net_Ethernet_28j60_sendUDP+0, 0
;SE9M.c,609 :: 		sntpSync = 1 ;  // done
	MOVLW       1
	MOVWF       _sntpSync+0 
;SE9M.c,610 :: 		sync_flag = 0 ;
	CLRF        _sync_flag+0 
;SE9M.c,611 :: 		sntpTimer = Net_Ethernet_28j60_UserTimerSec + 2;
	MOVLW       2
	ADDWF       _Net_Ethernet_28j60_UserTimerSec+0, 0 
	MOVWF       _sntpTimer+0 
	MOVLW       0
	ADDWFC      _Net_Ethernet_28j60_UserTimerSec+1, 0 
	MOVWF       _sntpTimer+1 
	MOVLW       0
	ADDWFC      _Net_Ethernet_28j60_UserTimerSec+2, 0 
	MOVWF       _sntpTimer+2 
	MOVLW       0
	ADDWFC      _Net_Ethernet_28j60_UserTimerSec+3, 0 
	MOVWF       _sntpTimer+3 
;SE9M.c,612 :: 		}
L_end_mkSNTPrequest:
	RETURN      0
; end of _mkSNTPrequest

_Eth_Obrada:

;SE9M.c,622 :: 		void Eth_Obrada() {
;SE9M.c,624 :: 		if (conf.dhcpen == 0) {
	MOVF        _conf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada51
;SE9M.c,626 :: 		if (lease_time >= 60) {
	MOVLW       60
	SUBWF       _lease_time+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Eth_Obrada52
;SE9M.c,627 :: 		lease_time = 0;
	CLRF        _lease_time+0 
;SE9M.c,628 :: 		while (!Net_Ethernet_28j60_renewDHCP(5));  // try to renew until it works
L_Eth_Obrada53:
	MOVLW       5
	MOVWF       FARG_Net_Ethernet_28j60_renewDHCP_tmax+0 
	CALL        _Net_Ethernet_28j60_renewDHCP+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada54
	GOTO        L_Eth_Obrada53
L_Eth_Obrada54:
;SE9M.c,629 :: 		}
L_Eth_Obrada52:
;SE9M.c,630 :: 		}
L_Eth_Obrada51:
;SE9M.c,631 :: 		if (link == 1) {
	MOVF        _link+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada55
;SE9M.c,632 :: 		if (sync_flag == 1) {
	MOVF        _sync_flag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada56
;SE9M.c,633 :: 		sync_flag = 0;
	CLRF        _sync_flag+0 
;SE9M.c,634 :: 		mkSNTPrequest();
	CALL        _mkSNTPrequest+0, 0
;SE9M.c,635 :: 		}
L_Eth_Obrada56:
;SE9M.c,636 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;SE9M.c,637 :: 		Net_Ethernet_28j60_doPacket() ;
	CALL        _Net_Ethernet_28j60_doPacket+0, 0
;SE9M.c,638 :: 		for(i = 0; i < NUM_OF_SOCKET_28j60; i++) {
	CLRF        _i+0 
L_Eth_Obrada57:
	MOVLW       _NUM_OF_SOCKET_28j60
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Eth_Obrada58
;SE9M.c,639 :: 		if(socket_28j60[i].open == 0)
	MOVLW       51
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        _i+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _socket_28j60+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_socket_28j60+0)
	ADDWFC      R1, 1 
	MOVLW       34
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada60
;SE9M.c,640 :: 		pos[i] = 0;
	MOVF        _i+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
L_Eth_Obrada60:
;SE9M.c,638 :: 		for(i = 0; i < NUM_OF_SOCKET_28j60; i++) {
	INCF        _i+0, 1 
;SE9M.c,641 :: 		}
	GOTO        L_Eth_Obrada57
L_Eth_Obrada58:
;SE9M.c,642 :: 		}
L_Eth_Obrada55:
;SE9M.c,643 :: 		}
L_end_Eth_Obrada:
	RETURN      0
; end of _Eth_Obrada

_mkMarquee:

;SE9M.c,649 :: 		void    mkMarquee(unsigned char l)
;SE9M.c,654 :: 		if((*marquee == 0) || (marquee == 0))
	MOVFF       _marquee+0, FSR0
	MOVFF       _marquee+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__mkMarquee336
	MOVLW       0
	XORWF       _marquee+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkMarquee377
	MOVLW       0
	XORWF       _marquee+0, 0 
L__mkMarquee377:
	BTFSC       STATUS+0, 2 
	GOTO        L__mkMarquee336
	GOTO        L_mkMarquee63
L__mkMarquee336:
;SE9M.c,656 :: 		marquee = bufInfo ;
	MOVLW       _bufInfo+0
	MOVWF       _marquee+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       _marquee+1 
;SE9M.c,657 :: 		}
L_mkMarquee63:
;SE9M.c,658 :: 		if((len=strlen(marquee)) < 16) {
	MOVF        _marquee+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        _marquee+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       mkMarquee_len_L0+0 
	MOVLW       16
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_mkMarquee64
;SE9M.c,659 :: 		memcpy(marqeeBuff, marquee, len) ;
	MOVLW       mkMarquee_marqeeBuff_L0+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(mkMarquee_marqeeBuff_L0+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVF        _marquee+0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        _marquee+1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVF        mkMarquee_len_L0+0, 0 
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,660 :: 		memcpy(marqeeBuff+len, bufInfo, 16-len) ;
	MOVLW       mkMarquee_marqeeBuff_L0+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(mkMarquee_marqeeBuff_L0+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVF        mkMarquee_len_L0+0, 0 
	ADDWF       FARG_memcpy_d1+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FARG_memcpy_d1+1, 1 
	MOVLW       _bufInfo+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVF        mkMarquee_len_L0+0, 0 
	SUBLW       16
	MOVWF       FARG_memcpy_n+0 
	CLRF        FARG_memcpy_n+1 
	MOVLW       0
	SUBWFB      FARG_memcpy_n+1, 1 
	CALL        _memcpy+0, 0
;SE9M.c,661 :: 		}
	GOTO        L_mkMarquee65
L_mkMarquee64:
;SE9M.c,663 :: 		memcpy(marqeeBuff, marquee, 16) ;
	MOVLW       mkMarquee_marqeeBuff_L0+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(mkMarquee_marqeeBuff_L0+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVF        _marquee+0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        _marquee+1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_mkMarquee65:
;SE9M.c,664 :: 		marqeeBuff[16] = 0 ;
	CLRF        mkMarquee_marqeeBuff_L0+16 
;SE9M.c,667 :: 		}
L_end_mkMarquee:
	RETURN      0
; end of _mkMarquee

_DNSavings:

;SE9M.c,672 :: 		void DNSavings() {
;SE9M.c,673 :: 		tmzn = 0;
	CLRF        _tmzn+0 
;SE9M.c,675 :: 		}
L_end_DNSavings:
	RETURN      0
; end of _DNSavings

_ip2str:

;SE9M.c,677 :: 		void    ip2str(unsigned char *s, unsigned char *ip)
;SE9M.c,682 :: 		*s = 0 ;
	MOVFF       FARG_ip2str_s+0, FSR1
	MOVFF       FARG_ip2str_s+1, FSR1H
	CLRF        POSTINC1+0 
;SE9M.c,683 :: 		for(i = 0 ; i < 4 ; i++)
	CLRF        ip2str_i_L0+0 
L_ip2str66:
	MOVLW       4
	SUBWF       ip2str_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ip2str67
;SE9M.c,685 :: 		int2str(ip[i], buf) ;
	MOVF        ip2str_i_L0+0, 0 
	ADDWF       FARG_ip2str_ip+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ip2str_ip+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVLW       0
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       0
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       ip2str_buf_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(ip2str_buf_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,686 :: 		strcat(s, buf) ;
	MOVF        FARG_ip2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ip2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ip2str_buf_L0+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ip2str_buf_L0+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,687 :: 		if(i != 3)
	MOVF        ip2str_i_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_ip2str69
;SE9M.c,688 :: 		strcat(s, ".") ;
	MOVF        FARG_ip2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ip2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr40_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr40_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
L_ip2str69:
;SE9M.c,683 :: 		for(i = 0 ; i < 4 ; i++)
	INCF        ip2str_i_L0+0, 1 
;SE9M.c,689 :: 		}
	GOTO        L_ip2str66
L_ip2str67:
;SE9M.c,690 :: 		}
L_end_ip2str:
	RETURN      0
; end of _ip2str

_nibble2hex:

;SE9M.c,701 :: 		unsigned char nibble2hex(unsigned char n)
;SE9M.c,703 :: 		n &= 0x0f ;
	MOVLW       15
	ANDWF       FARG_nibble2hex_n+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_nibble2hex_n+0 
;SE9M.c,704 :: 		if(n >= 0x0a)
	MOVLW       10
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_nibble2hex70
;SE9M.c,706 :: 		return(n + '7') ;
	MOVLW       55
	ADDWF       FARG_nibble2hex_n+0, 0 
	MOVWF       R0 
	GOTO        L_end_nibble2hex
;SE9M.c,707 :: 		}
L_nibble2hex70:
;SE9M.c,708 :: 		return(n + '0') ;
	MOVLW       48
	ADDWF       FARG_nibble2hex_n+0, 0 
	MOVWF       R0 
;SE9M.c,709 :: 		}
L_end_nibble2hex:
	RETURN      0
; end of _nibble2hex

_byte2hex:

;SE9M.c,714 :: 		void    byte2hex(unsigned char *s, unsigned char v)
;SE9M.c,716 :: 		*s++ = nibble2hex(v >> 4) ;
	MOVF        FARG_byte2hex_v+0, 0 
	MOVWF       FARG_nibble2hex_n+0 
	RRCF        FARG_nibble2hex_n+0, 1 
	BCF         FARG_nibble2hex_n+0, 7 
	RRCF        FARG_nibble2hex_n+0, 1 
	BCF         FARG_nibble2hex_n+0, 7 
	RRCF        FARG_nibble2hex_n+0, 1 
	BCF         FARG_nibble2hex_n+0, 7 
	RRCF        FARG_nibble2hex_n+0, 1 
	BCF         FARG_nibble2hex_n+0, 7 
	CALL        _nibble2hex+0, 0
	MOVFF       FARG_byte2hex_s+0, FSR1
	MOVFF       FARG_byte2hex_s+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_byte2hex_s+0, 1 
	INCF        FARG_byte2hex_s+1, 1 
;SE9M.c,717 :: 		*s++ = nibble2hex(v) ;
	MOVF        FARG_byte2hex_v+0, 0 
	MOVWF       FARG_nibble2hex_n+0 
	CALL        _nibble2hex+0, 0
	MOVFF       FARG_byte2hex_s+0, FSR1
	MOVFF       FARG_byte2hex_s+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_byte2hex_s+0, 1 
	INCF        FARG_byte2hex_s+1, 1 
;SE9M.c,718 :: 		*s = '.' ;
	MOVFF       FARG_byte2hex_s+0, FSR1
	MOVFF       FARG_byte2hex_s+1, FSR1H
	MOVLW       46
	MOVWF       POSTINC1+0 
;SE9M.c,719 :: 		}
L_end_byte2hex:
	RETURN      0
; end of _byte2hex

_mkLCDselect:

;SE9M.c,724 :: 		unsigned int    mkLCDselect(unsigned char l, unsigned char m)
;SE9M.c,729 :: 		len = Net_Ethernet_28j60_putConstString("<select onChange=\\\"document.location.href = '/admin/") ;
	MOVLW       ?lstr_41_SE9M+0
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_41_SE9M+0)
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_41_SE9M+0)
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+2 
	CALL        _Net_Ethernet_28j60_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       mkLCDselect_len_L0+0 
	MOVF        R1, 0 
	MOVWF       mkLCDselect_len_L0+1 
;SE9M.c,730 :: 		Net_Ethernet_28j60_putByte('0' + l) ;
	MOVF        FARG_mkLCDselect_l+0, 0 
	ADDLW       48
	MOVWF       FARG_Net_Ethernet_28j60_putByte_v+0 
	CALL        _Net_Ethernet_28j60_putByte+0, 0
;SE9M.c,731 :: 		len++ ;
	INFSNZ      mkLCDselect_len_L0+0, 1 
	INCF        mkLCDselect_len_L0+1, 1 
;SE9M.c,732 :: 		len += Net_Ethernet_28j60_putConstString("/' + this.selectedIndex\\\">") ;
	MOVLW       ?lstr_42_SE9M+0
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_42_SE9M+0)
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_42_SE9M+0)
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+2 
	CALL        _Net_Ethernet_28j60_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,733 :: 		for(i = 0 ; i < 2 ; i++)
	CLRF        mkLCDselect_i_L0+0 
L_mkLCDselect71:
	MOVLW       2
	SUBWF       mkLCDselect_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_mkLCDselect72
;SE9M.c,735 :: 		len += Net_Ethernet_28j60_putConstString("<option ") ;
	MOVLW       ?lstr_43_SE9M+0
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_43_SE9M+0)
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_43_SE9M+0)
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+2 
	CALL        _Net_Ethernet_28j60_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,736 :: 		if(i == m)
	MOVF        mkLCDselect_i_L0+0, 0 
	XORWF       FARG_mkLCDselect_m+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_mkLCDselect74
;SE9M.c,738 :: 		len += Net_Ethernet_28j60_putConstString(" selected") ;
	MOVLW       ?lstr_44_SE9M+0
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_44_SE9M+0)
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_44_SE9M+0)
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+2 
	CALL        _Net_Ethernet_28j60_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,739 :: 		}
L_mkLCDselect74:
;SE9M.c,740 :: 		len += Net_Ethernet_28j60_putConstString(">") ;
	MOVLW       ?lstr_45_SE9M+0
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_45_SE9M+0)
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_45_SE9M+0)
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+2 
	CALL        _Net_Ethernet_28j60_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,741 :: 		len += Net_Ethernet_28j60_putConstString(LCDoption[i]) ;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        mkLCDselect_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _LCDoption+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_LCDoption+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+2 
	CALL        _Net_Ethernet_28j60_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,733 :: 		for(i = 0 ; i < 2 ; i++)
	INCF        mkLCDselect_i_L0+0, 1 
;SE9M.c,742 :: 		}
	GOTO        L_mkLCDselect71
L_mkLCDselect72:
;SE9M.c,743 :: 		len += Net_Ethernet_28j60_putConstString("</select>\";") ;
	MOVLW       ?lstr_46_SE9M+0
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_46_SE9M+0)
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_46_SE9M+0)
	MOVWF       FARG_Net_Ethernet_28j60_putConstString_ptr+2 
	CALL        _Net_Ethernet_28j60_putConstString+0, 0
	MOVF        mkLCDselect_len_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        mkLCDselect_len_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       mkLCDselect_len_L0+0 
	MOVF        R1, 0 
	MOVWF       mkLCDselect_len_L0+1 
;SE9M.c,744 :: 		return(len) ;
;SE9M.c,745 :: 		}
L_end_mkLCDselect:
	RETURN      0
; end of _mkLCDselect

_mkLCDLine:

;SE9M.c,750 :: 		void mkLCDLine(unsigned char l, unsigned char m){
;SE9M.c,751 :: 		switch(m)
	GOTO        L_mkLCDLine75
;SE9M.c,753 :: 		case 0:
L_mkLCDLine77:
;SE9M.c,755 :: 		memset(bufInfo, 0, sizeof(bufInfo)) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       200
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;SE9M.c,756 :: 		if(sync_flag)
	MOVF        _sync_flag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine78
;SE9M.c,759 :: 		strcpy(bufInfo, "Today is ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr47_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr47_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,760 :: 		ts2str(bufInfo + strlen(bufInfo), &ts, TS2STR_DATE) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       _bufInfo+0
	ADDWF       R0, 0 
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _ts+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       1
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,761 :: 		strcat(bufInfo, ". Please visit www.micro-examples.com for more details about the Ethernal Clock. You can browse ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr48_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr48_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,762 :: 		ip2str(bufInfo + strlen(bufInfo), ipAddr) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       _bufInfo+0
	ADDWF       R0, 0 
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,763 :: 		strcat(bufInfo, " to set the clock preferences.    ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr49_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr49_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,764 :: 		}
	GOTO        L_mkLCDLine79
L_mkLCDLine78:
;SE9M.c,768 :: 		strcpy(bufInfo, "The SNTP server did not respond, please browse ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr50_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr50_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,769 :: 		ip2str(bufInfo + strlen(bufInfo), ipAddr) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       _bufInfo+0
	ADDWF       R0, 0 
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,770 :: 		strcat(bufInfo, " to check clock settings.    ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr51_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr51_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,771 :: 		}
L_mkLCDLine79:
;SE9M.c,772 :: 		mkMarquee(l) ;           // display marquee
	MOVF        FARG_mkLCDLine_l+0, 0 
	MOVWF       FARG_mkMarquee_l+0 
	CALL        _mkMarquee+0, 0
;SE9M.c,773 :: 		break ;
	GOTO        L_mkLCDLine76
;SE9M.c,774 :: 		case 1:
L_mkLCDLine80:
;SE9M.c,778 :: 		ts2str(bufInfo, &ts, TS2STR_DATE) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _ts+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       1
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,784 :: 		break ;
	GOTO        L_mkLCDLine76
;SE9M.c,785 :: 		case 2:
L_mkLCDLine81:
;SE9M.c,789 :: 		ts2str(bufInfo, &ts, TS2STR_TIME) ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _ts+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       2
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,795 :: 		break ;
	GOTO        L_mkLCDLine76
;SE9M.c,796 :: 		}
L_mkLCDLine75:
	MOVF        FARG_mkLCDLine_m+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine77
	MOVF        FARG_mkLCDLine_m+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine80
	MOVF        FARG_mkLCDLine_m+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine81
L_mkLCDLine76:
;SE9M.c,797 :: 		}
L_end_mkLCDLine:
	RETURN      0
; end of _mkLCDLine

_Rst_Eth:

;SE9M.c,799 :: 		void Rst_Eth() {
;SE9M.c,800 :: 		Net_Ethernet_28j60_Rst = 0;
	BCF         LATA5_bit+0, BitPos(LATA5_bit+0) 
;SE9M.c,801 :: 		reset_eth = 1;
	MOVLW       1
	MOVWF       _reset_eth+0 
;SE9M.c,803 :: 		}
L_end_Rst_Eth:
	RETURN      0
; end of _Rst_Eth

_Net_Ethernet_28j60_UserTCP:

;SE9M.c,809 :: 		void Net_Ethernet_28j60_UserTCP(SOCKET_28j60_Dsc *socket)
;SE9M.c,812 :: 		unsigned int    len = 0 ;
	CLRF        Net_Ethernet_28j60_UserTCP_len_L0+0 
	CLRF        Net_Ethernet_28j60_UserTCP_len_L0+1 
	CLRF        Net_Ethernet_28j60_UserTCP_res_L0+0 
	CLRF        Net_Ethernet_28j60_UserTCP_res_L0+1 
;SE9M.c,823 :: 		if (socket->destPort != 80)                    // I listen only to web request on port 80
	MOVLW       12
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP386
	MOVLW       80
	XORWF       R1, 0 
L__Net_Ethernet_28j60_UserTCP386:
	BTFSC       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP82
;SE9M.c,825 :: 		return ;                     // return without reply
	GOTO        L_end_Net_Ethernet_28j60_UserTCP
;SE9M.c,826 :: 		}
L_Net_Ethernet_28j60_UserTCP82:
;SE9M.c,831 :: 		for (i = 0; i < 10 ; i++) {
	CLRF        Net_Ethernet_28j60_UserTCP_i_L0+0 
	CLRF        Net_Ethernet_28j60_UserTCP_i_L0+1 
L_Net_Ethernet_28j60_UserTCP83:
	MOVLW       128
	XORWF       Net_Ethernet_28j60_UserTCP_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP387
	MOVLW       10
	SUBWF       Net_Ethernet_28j60_UserTCP_i_L0+0, 0 
L__Net_Ethernet_28j60_UserTCP387:
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP84
;SE9M.c,832 :: 		htmlRequest[i] = Net_Ethernet_28j60_getByte();
	MOVLW       _htmlRequest+0
	ADDWF       Net_Ethernet_28j60_UserTCP_i_L0+0, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserTCP+0 
	MOVLW       hi_addr(_htmlRequest+0)
	ADDWFC      Net_Ethernet_28j60_UserTCP_i_L0+1, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserTCP+1 
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVFF       FLOC__Net_Ethernet_28j60_UserTCP+0, FSR1
	MOVFF       FLOC__Net_Ethernet_28j60_UserTCP+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,831 :: 		for (i = 0; i < 10 ; i++) {
	INFSNZ      Net_Ethernet_28j60_UserTCP_i_L0+0, 1 
	INCF        Net_Ethernet_28j60_UserTCP_i_L0+1, 1 
;SE9M.c,833 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserTCP83
L_Net_Ethernet_28j60_UserTCP84:
;SE9M.c,837 :: 		if(memcmp(htmlRequest, httpGetImage, 6) == 0){
	MOVLW       _htmlRequest+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_htmlRequest+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _httpGetImage+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_httpGetImage+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       6
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP388
	MOVLW       0
	XORWF       R0, 0 
L__Net_Ethernet_28j60_UserTCP388:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP86
;SE9M.c,838 :: 		sendIMG_mark = 1;
	MOVLW       1
	MOVWF       _sendIMG_mark+0 
;SE9M.c,839 :: 		post_prolaz = 2;
	MOVLW       2
	MOVWF       _post_prolaz+0 
;SE9M.c,841 :: 		} else
	GOTO        L_Net_Ethernet_28j60_UserTCP87
L_Net_Ethernet_28j60_UserTCP86:
;SE9M.c,843 :: 		if(memcmp(htmlRequest, httpGetMethod, 5) == 0){
	MOVLW       _htmlRequest+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_htmlRequest+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _httpGetMethod+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_httpGetMethod+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       5
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP389
	MOVLW       0
	XORWF       R0, 0 
L__Net_Ethernet_28j60_UserTCP389:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP88
;SE9M.c,844 :: 		if (admin == 0) {
	MOVF        _admin+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP89
;SE9M.c,845 :: 		sendHTML_mark = 1;
	MOVLW       1
	MOVWF       _sendHTML_mark+0 
;SE9M.c,846 :: 		post_prolaz = 2;
	MOVLW       2
	MOVWF       _post_prolaz+0 
;SE9M.c,848 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserTCP90
L_Net_Ethernet_28j60_UserTCP89:
;SE9M.c,849 :: 		else  if ( (htmlRequest[5] == 't') && (admin == 1) ){
	MOVF        _htmlRequest+5, 0 
	XORLW       116
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP93
	MOVF        _admin+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP93
L__Net_Ethernet_28j60_UserTCP348:
;SE9M.c,850 :: 		sendNTPMark = 0;
	CLRF        _sendNTPMark+0 
;SE9M.c,851 :: 		sendTimeMark = 1;
	MOVLW       1
	MOVWF       _sendTimeMark+0 
;SE9M.c,852 :: 		post_prolaz = 2;
	MOVLW       2
	MOVWF       _post_prolaz+0 
;SE9M.c,854 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserTCP94
L_Net_Ethernet_28j60_UserTCP93:
;SE9M.c,855 :: 		else  if ( (htmlRequest[5] == 'n') && (admin == 1) ){
	MOVF        _htmlRequest+5, 0 
	XORLW       110
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP97
	MOVF        _admin+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP97
L__Net_Ethernet_28j60_UserTCP347:
;SE9M.c,856 :: 		sendTimeMark = 0;
	CLRF        _sendTimeMark+0 
;SE9M.c,857 :: 		sendNTPMark = 1;
	MOVLW       1
	MOVWF       _sendNTPMark+0 
;SE9M.c,858 :: 		post_prolaz = 2;
	MOVLW       2
	MOVWF       _post_prolaz+0 
;SE9M.c,860 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserTCP98
L_Net_Ethernet_28j60_UserTCP97:
;SE9M.c,861 :: 		else  if ( (htmlRequest[5] == 'l') && (admin == 1) ){
	MOVF        _htmlRequest+5, 0 
	XORLW       108
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP101
	MOVF        _admin+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP101
L__Net_Ethernet_28j60_UserTCP346:
;SE9M.c,862 :: 		sendHTML_mark = 1;
	MOVLW       1
	MOVWF       _sendHTML_mark+0 
;SE9M.c,863 :: 		session = 0;
	CLRF        _session+0 
	CLRF        _session+1 
;SE9M.c,864 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,865 :: 		post_prolaz = 2;
	MOVLW       2
	MOVWF       _post_prolaz+0 
;SE9M.c,867 :: 		}
L_Net_Ethernet_28j60_UserTCP101:
L_Net_Ethernet_28j60_UserTCP98:
L_Net_Ethernet_28j60_UserTCP94:
L_Net_Ethernet_28j60_UserTCP90:
;SE9M.c,868 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserTCP102
L_Net_Ethernet_28j60_UserTCP88:
;SE9M.c,869 :: 		else if(memcmp(htmlRequest, httpPostMethod, 6) == 0) {
	MOVLW       _htmlRequest+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_htmlRequest+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _httpPostMethod+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_httpPostMethod+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       6
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP390
	MOVLW       0
	XORWF       R0, 0 
L__Net_Ethernet_28j60_UserTCP390:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP103
;SE9M.c,871 :: 		post_prolaz = 0;
	CLRF        _post_prolaz+0 
;SE9M.c,872 :: 		sendLoginMark = 1;
	MOVLW       1
	MOVWF       _sendLoginMark+0 
;SE9M.c,880 :: 		}
L_Net_Ethernet_28j60_UserTCP103:
L_Net_Ethernet_28j60_UserTCP102:
L_Net_Ethernet_28j60_UserTCP87:
;SE9M.c,883 :: 		if( ((memcmp(htmlRequest, httpGetMethod, 5) && (socket->state != 3))) || ( memcmp(htmlRequest, httpPostMethod, 6) &&( socket->state != 3) )){
	MOVLW       _htmlRequest+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_htmlRequest+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _httpGetMethod+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_httpGetMethod+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       5
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP345
	MOVLW       37
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP345
	GOTO        L__Net_Ethernet_28j60_UserTCP343
L__Net_Ethernet_28j60_UserTCP345:
	MOVLW       _htmlRequest+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_htmlRequest+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _httpPostMethod+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_httpPostMethod+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       6
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP344
	MOVLW       37
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP344
	GOTO        L__Net_Ethernet_28j60_UserTCP343
L__Net_Ethernet_28j60_UserTCP344:
	GOTO        L_Net_Ethernet_28j60_UserTCP110
L__Net_Ethernet_28j60_UserTCP343:
;SE9M.c,884 :: 		return;
	GOTO        L_end_Net_Ethernet_28j60_UserTCP
;SE9M.c,885 :: 		}
L_Net_Ethernet_28j60_UserTCP110:
;SE9M.c,886 :: 		while( post_prolaz < 2 ){
	MOVLW       2
	SUBWF       _post_prolaz+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP112
;SE9M.c,887 :: 		for (len = (MY_MSS_28j60 * post_prolaz); len < (MY_MSS_28j60 * (post_prolaz + 1)); len++){
	MOVLW       _MY_MSS_28j60
	MOVWF       R0 
	MOVLW       _MY_MSS_28j60+1
	MOVWF       R1 
	MOVF        _post_prolaz+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       Net_Ethernet_28j60_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       Net_Ethernet_28j60_UserTCP_len_L0+1 
L_Net_Ethernet_28j60_UserTCP113:
	MOVF        _post_prolaz+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _MY_MSS_28j60
	MOVWF       R4 
	MOVLW       _MY_MSS_28j60+1
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R1, 0 
	SUBWF       Net_Ethernet_28j60_UserTCP_len_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP391
	MOVF        R0, 0 
	SUBWF       Net_Ethernet_28j60_UserTCP_len_L0+0, 0 
L__Net_Ethernet_28j60_UserTCP391:
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP114
;SE9M.c,888 :: 		htmlRequest[len] = Net_Ethernet_28j60_getByte();
	MOVLW       _htmlRequest+0
	ADDWF       Net_Ethernet_28j60_UserTCP_len_L0+0, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserTCP+0 
	MOVLW       hi_addr(_htmlRequest+0)
	ADDWFC      Net_Ethernet_28j60_UserTCP_len_L0+1, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserTCP+1 
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVFF       FLOC__Net_Ethernet_28j60_UserTCP+0, FSR1
	MOVFF       FLOC__Net_Ethernet_28j60_UserTCP+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,887 :: 		for (len = (MY_MSS_28j60 * post_prolaz); len < (MY_MSS_28j60 * (post_prolaz + 1)); len++){
	INFSNZ      Net_Ethernet_28j60_UserTCP_len_L0+0, 1 
	INCF        Net_Ethernet_28j60_UserTCP_len_L0+1, 1 
;SE9M.c,889 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserTCP113
L_Net_Ethernet_28j60_UserTCP114:
;SE9M.c,890 :: 		post_prolaz++;
	INCF        _post_prolaz+0, 1 
;SE9M.c,892 :: 		}
L_Net_Ethernet_28j60_UserTCP112:
;SE9M.c,894 :: 		if (post_prolaz == 2) {
	MOVF        _post_prolaz+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP116
;SE9M.c,896 :: 		if (sendLoginMark == 1) {
	MOVF        _sendLoginMark+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP117
;SE9M.c,898 :: 		res = 0;
	CLRF        Net_Ethernet_28j60_UserTCP_res_L0+0 
	CLRF        Net_Ethernet_28j60_UserTCP_res_L0+1 
;SE9M.c,899 :: 		res = strstr1(res, htmlRequest,"usr");
	CLRF        FARG_strstr1_index+0 
	CLRF        FARG_strstr1_index+1 
	MOVLW       _htmlRequest+0
	MOVWF       FARG_strstr1_s2+0 
	MOVLW       hi_addr(_htmlRequest+0)
	MOVWF       FARG_strstr1_s2+1 
	MOVLW       ?lstr52_SE9M+0
	MOVWF       FARG_strstr1_s1+0 
	MOVLW       hi_addr(?lstr52_SE9M+0)
	MOVWF       FARG_strstr1_s1+1 
	CALL        _strstr1+0, 0
	MOVF        R0, 0 
	MOVWF       Net_Ethernet_28j60_UserTCP_res_L0+0 
	MOVF        R1, 0 
	MOVWF       Net_Ethernet_28j60_UserTCP_res_L0+1 
;SE9M.c,901 :: 		for ( i = 0 ; i < 15 ; i++){
	CLRF        Net_Ethernet_28j60_UserTCP_i_L0+0 
	CLRF        Net_Ethernet_28j60_UserTCP_i_L0+1 
L_Net_Ethernet_28j60_UserTCP118:
	MOVLW       128
	XORWF       Net_Ethernet_28j60_UserTCP_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP392
	MOVLW       15
	SUBWF       Net_Ethernet_28j60_UserTCP_i_L0+0, 0 
L__Net_Ethernet_28j60_UserTCP392:
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP119
;SE9M.c,902 :: 		if (htmlRequest[(res + 1) + i] == '&')
	MOVLW       1
	ADDWF       Net_Ethernet_28j60_UserTCP_res_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      Net_Ethernet_28j60_UserTCP_res_L0+1, 0 
	MOVWF       R1 
	MOVF        Net_Ethernet_28j60_UserTCP_i_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        Net_Ethernet_28j60_UserTCP_i_L0+1, 0 
	ADDWFC      R1, 1 
	MOVLW       _htmlRequest+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_htmlRequest+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       38
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP121
;SE9M.c,903 :: 		break;
	GOTO        L_Net_Ethernet_28j60_UserTCP119
L_Net_Ethernet_28j60_UserTCP121:
;SE9M.c,905 :: 		usercheck[i] = htmlRequest[i+(res + 1)];
	MOVLW       _usercheck+0
	ADDWF       Net_Ethernet_28j60_UserTCP_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_usercheck+0)
	ADDWFC      Net_Ethernet_28j60_UserTCP_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       Net_Ethernet_28j60_UserTCP_res_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      Net_Ethernet_28j60_UserTCP_res_L0+1, 0 
	MOVWF       R1 
	MOVF        Net_Ethernet_28j60_UserTCP_i_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        Net_Ethernet_28j60_UserTCP_i_L0+1, 0 
	ADDWFC      R1, 1 
	MOVLW       _htmlRequest+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_htmlRequest+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,901 :: 		for ( i = 0 ; i < 15 ; i++){
	INFSNZ      Net_Ethernet_28j60_UserTCP_i_L0+0, 1 
	INCF        Net_Ethernet_28j60_UserTCP_i_L0+1, 1 
;SE9M.c,907 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserTCP118
L_Net_Ethernet_28j60_UserTCP119:
;SE9M.c,908 :: 		res = strstr1(res, htmlRequest,"psw");
	MOVF        Net_Ethernet_28j60_UserTCP_res_L0+0, 0 
	MOVWF       FARG_strstr1_index+0 
	MOVF        Net_Ethernet_28j60_UserTCP_res_L0+1, 0 
	MOVWF       FARG_strstr1_index+1 
	MOVLW       _htmlRequest+0
	MOVWF       FARG_strstr1_s2+0 
	MOVLW       hi_addr(_htmlRequest+0)
	MOVWF       FARG_strstr1_s2+1 
	MOVLW       ?lstr53_SE9M+0
	MOVWF       FARG_strstr1_s1+0 
	MOVLW       hi_addr(?lstr53_SE9M+0)
	MOVWF       FARG_strstr1_s1+1 
	CALL        _strstr1+0, 0
	MOVF        R0, 0 
	MOVWF       Net_Ethernet_28j60_UserTCP_res_L0+0 
	MOVF        R1, 0 
	MOVWF       Net_Ethernet_28j60_UserTCP_res_L0+1 
;SE9M.c,910 :: 		for ( i = 0 ; i < 8 ; i++){
	CLRF        Net_Ethernet_28j60_UserTCP_i_L0+0 
	CLRF        Net_Ethernet_28j60_UserTCP_i_L0+1 
L_Net_Ethernet_28j60_UserTCP123:
	MOVLW       128
	XORWF       Net_Ethernet_28j60_UserTCP_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP393
	MOVLW       8
	SUBWF       Net_Ethernet_28j60_UserTCP_i_L0+0, 0 
L__Net_Ethernet_28j60_UserTCP393:
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP124
;SE9M.c,911 :: 		passcheck[i] =  htmlRequest[i+(res + 1)];
	MOVLW       _passcheck+0
	ADDWF       Net_Ethernet_28j60_UserTCP_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_passcheck+0)
	ADDWFC      Net_Ethernet_28j60_UserTCP_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       Net_Ethernet_28j60_UserTCP_res_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      Net_Ethernet_28j60_UserTCP_res_L0+1, 0 
	MOVWF       R1 
	MOVF        Net_Ethernet_28j60_UserTCP_i_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        Net_Ethernet_28j60_UserTCP_i_L0+1, 0 
	ADDWFC      R1, 1 
	MOVLW       _htmlRequest+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_htmlRequest+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,910 :: 		for ( i = 0 ; i < 8 ; i++){
	INFSNZ      Net_Ethernet_28j60_UserTCP_i_L0+0, 1 
	INCF        Net_Ethernet_28j60_UserTCP_i_L0+1, 1 
;SE9M.c,912 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserTCP123
L_Net_Ethernet_28j60_UserTCP124:
;SE9M.c,913 :: 		sendLoginMark = 0;
	CLRF        _sendLoginMark+0 
;SE9M.c,914 :: 		if ( ((strcmp(usercheck,username) == 0) && (strcmp(passcheck,password) == 0))||(admin == 1) ) {
	MOVLW       _usercheck+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_usercheck+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       _username+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(_username+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP394
	MOVLW       0
	XORWF       R0, 0 
L__Net_Ethernet_28j60_UserTCP394:
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP342
	MOVLW       _passcheck+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_passcheck+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       _password+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(_password+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP395
	MOVLW       0
	XORWF       R0, 0 
L__Net_Ethernet_28j60_UserTCP395:
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP342
	GOTO        L__Net_Ethernet_28j60_UserTCP341
L__Net_Ethernet_28j60_UserTCP342:
	MOVF        _admin+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP341
	GOTO        L_Net_Ethernet_28j60_UserTCP130
L__Net_Ethernet_28j60_UserTCP341:
;SE9M.c,915 :: 		admin = 1;
	MOVLW       1
	MOVWF       _admin+0 
;SE9M.c,916 :: 		sendTimeMark = 1;
	MOVLW       1
	MOVWF       _sendTimeMark+0 
;SE9M.c,918 :: 		} else {
	GOTO        L_Net_Ethernet_28j60_UserTCP131
L_Net_Ethernet_28j60_UserTCP130:
;SE9M.c,919 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,920 :: 		sendHTML_mark = 1;
	MOVLW       1
	MOVWF       _sendHTML_mark+0 
;SE9M.c,921 :: 		for (i = 0; i < 15 ; i++)
	CLRF        Net_Ethernet_28j60_UserTCP_i_L0+0 
	CLRF        Net_Ethernet_28j60_UserTCP_i_L0+1 
L_Net_Ethernet_28j60_UserTCP132:
	MOVLW       128
	XORWF       Net_Ethernet_28j60_UserTCP_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP396
	MOVLW       15
	SUBWF       Net_Ethernet_28j60_UserTCP_i_L0+0, 0 
L__Net_Ethernet_28j60_UserTCP396:
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP133
;SE9M.c,922 :: 		usercheck[i] = 0;
	MOVLW       _usercheck+0
	ADDWF       Net_Ethernet_28j60_UserTCP_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_usercheck+0)
	ADDWFC      Net_Ethernet_28j60_UserTCP_i_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SE9M.c,921 :: 		for (i = 0; i < 15 ; i++)
	INFSNZ      Net_Ethernet_28j60_UserTCP_i_L0+0, 1 
	INCF        Net_Ethernet_28j60_UserTCP_i_L0+1, 1 
;SE9M.c,922 :: 		usercheck[i] = 0;
	GOTO        L_Net_Ethernet_28j60_UserTCP132
L_Net_Ethernet_28j60_UserTCP133:
;SE9M.c,923 :: 		for (i = 0; i < 8; i++)
	CLRF        Net_Ethernet_28j60_UserTCP_i_L0+0 
	CLRF        Net_Ethernet_28j60_UserTCP_i_L0+1 
L_Net_Ethernet_28j60_UserTCP135:
	MOVLW       128
	XORWF       Net_Ethernet_28j60_UserTCP_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP397
	MOVLW       8
	SUBWF       Net_Ethernet_28j60_UserTCP_i_L0+0, 0 
L__Net_Ethernet_28j60_UserTCP397:
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP136
;SE9M.c,924 :: 		passcheck[i] = 0;
	MOVLW       _passcheck+0
	ADDWF       Net_Ethernet_28j60_UserTCP_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_passcheck+0)
	ADDWFC      Net_Ethernet_28j60_UserTCP_i_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SE9M.c,923 :: 		for (i = 0; i < 8; i++)
	INFSNZ      Net_Ethernet_28j60_UserTCP_i_L0+0, 1 
	INCF        Net_Ethernet_28j60_UserTCP_i_L0+1, 1 
;SE9M.c,924 :: 		passcheck[i] = 0;
	GOTO        L_Net_Ethernet_28j60_UserTCP135
L_Net_Ethernet_28j60_UserTCP136:
;SE9M.c,926 :: 		}
L_Net_Ethernet_28j60_UserTCP131:
;SE9M.c,928 :: 		}
L_Net_Ethernet_28j60_UserTCP117:
;SE9M.c,930 :: 		if (sendTimeMark == 1){
	MOVF        _sendTimeMark+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP138
;SE9M.c,931 :: 		while(pos[socket->ID] < timePage_size) {
L_Net_Ethernet_28j60_UserTCP139:
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        _timePage_size+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP398
	MOVF        _timePage_size+0, 0 
	SUBWF       R1, 0 
L__Net_Ethernet_28j60_UserTCP398:
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP140
;SE9M.c,932 :: 		if(Net_Ethernet_28j60_putByteTCP(time_code[pos[socket->ID]++], socket) == 0) {
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVFF       R4, FSR0
	MOVFF       R5, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       1
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVFF       R4, FSR1
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVLW       _time_code+0
	ADDWF       R2, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_time_code+0)
	ADDWFC      R3, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_time_code+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Net_Ethernet_28j60_putByteTCP_ch+0
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putByteTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putByteTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_putByteTCP+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP141
;SE9M.c,933 :: 		pos[socket->ID]--;
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVLW       1
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,934 :: 		break;
	GOTO        L_Net_Ethernet_28j60_UserTCP140
;SE9M.c,935 :: 		}
L_Net_Ethernet_28j60_UserTCP141:
;SE9M.c,936 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserTCP139
L_Net_Ethernet_28j60_UserTCP140:
;SE9M.c,937 :: 		if( Net_Ethernet_28j60_bufferEmptyTCP(socket) && (pos[socket->ID] >= timePage_size) ) {
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_bufferEmptyTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_bufferEmptyTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_bufferEmptyTCP+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP144
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        _timePage_size+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP399
	MOVF        _timePage_size+0, 0 
	SUBWF       R1, 0 
L__Net_Ethernet_28j60_UserTCP399:
	BTFSS       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP144
L__Net_Ethernet_28j60_UserTCP340:
;SE9M.c,938 :: 		Net_Ethernet_28j60_disconnectTCP(socket);
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_disconnectTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_disconnectTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_disconnectTCP+0, 0
;SE9M.c,939 :: 		socket_28j60[socket->ID].state = 0;
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       51
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _socket_28j60+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_socket_28j60+0)
	ADDWFC      R1, 1 
	MOVLW       37
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SE9M.c,940 :: 		pos[socket->ID] = 0;
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;SE9M.c,941 :: 		sendTimeMark = 0;
	CLRF        _sendTimeMark+0 
;SE9M.c,942 :: 		post_prolaz = 0;
	CLRF        _post_prolaz+0 
;SE9M.c,943 :: 		}
L_Net_Ethernet_28j60_UserTCP144:
;SE9M.c,945 :: 		}
L_Net_Ethernet_28j60_UserTCP138:
;SE9M.c,946 :: 		if (sendNTPMark == 1){
	MOVF        _sendNTPMark+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP145
;SE9M.c,947 :: 		while(pos[socket->ID] < ntpPage_size) {
L_Net_Ethernet_28j60_UserTCP146:
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        _ntpPage_size+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP400
	MOVF        _ntpPage_size+0, 0 
	SUBWF       R1, 0 
L__Net_Ethernet_28j60_UserTCP400:
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP147
;SE9M.c,948 :: 		if(Net_Ethernet_28j60_putByteTCP(ntp_code[pos[socket->ID]++], socket) == 0) {
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVFF       R4, FSR0
	MOVFF       R5, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       1
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVFF       R4, FSR1
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVLW       _ntp_code+0
	ADDWF       R2, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_ntp_code+0)
	ADDWFC      R3, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_ntp_code+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Net_Ethernet_28j60_putByteTCP_ch+0
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putByteTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putByteTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_putByteTCP+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP148
;SE9M.c,949 :: 		pos[socket->ID]--;
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVLW       1
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,950 :: 		break;
	GOTO        L_Net_Ethernet_28j60_UserTCP147
;SE9M.c,951 :: 		}
L_Net_Ethernet_28j60_UserTCP148:
;SE9M.c,952 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserTCP146
L_Net_Ethernet_28j60_UserTCP147:
;SE9M.c,953 :: 		if( Net_Ethernet_28j60_bufferEmptyTCP(socket) && (pos[socket->ID] >= ntpPage_size) ) {
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_bufferEmptyTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_bufferEmptyTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_bufferEmptyTCP+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP151
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        _ntpPage_size+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP401
	MOVF        _ntpPage_size+0, 0 
	SUBWF       R1, 0 
L__Net_Ethernet_28j60_UserTCP401:
	BTFSS       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP151
L__Net_Ethernet_28j60_UserTCP339:
;SE9M.c,954 :: 		Net_Ethernet_28j60_disconnectTCP(socket);
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_disconnectTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_disconnectTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_disconnectTCP+0, 0
;SE9M.c,955 :: 		socket_28j60[socket->ID].state = 0;
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       51
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _socket_28j60+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_socket_28j60+0)
	ADDWFC      R1, 1 
	MOVLW       37
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SE9M.c,956 :: 		pos[socket->ID] = 0;
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;SE9M.c,957 :: 		sendNTPMark = 0;
	CLRF        _sendNTPMark+0 
;SE9M.c,958 :: 		post_prolaz = 0;
	CLRF        _post_prolaz+0 
;SE9M.c,959 :: 		}
L_Net_Ethernet_28j60_UserTCP151:
;SE9M.c,961 :: 		}
L_Net_Ethernet_28j60_UserTCP145:
;SE9M.c,963 :: 		if (sendHTML_mark == 1)  {
	MOVF        _sendHTML_mark+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP152
;SE9M.c,981 :: 		while(pos[socket->ID] < login_size) {
L_Net_Ethernet_28j60_UserTCP153:
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        _login_size+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP402
	MOVF        _login_size+0, 0 
	SUBWF       R1, 0 
L__Net_Ethernet_28j60_UserTCP402:
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP154
;SE9M.c,982 :: 		if(Net_Ethernet_28j60_putByteTCP(login_code[pos[socket->ID]++], socket) == 0) {
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVFF       R4, FSR0
	MOVFF       R5, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       1
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVFF       R4, FSR1
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVLW       _login_code+0
	ADDWF       R2, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_login_code+0)
	ADDWFC      R3, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_login_code+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Net_Ethernet_28j60_putByteTCP_ch+0
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putByteTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putByteTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_putByteTCP+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP155
;SE9M.c,983 :: 		pos[socket->ID]--;
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVLW       1
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,984 :: 		break;
	GOTO        L_Net_Ethernet_28j60_UserTCP154
;SE9M.c,985 :: 		}
L_Net_Ethernet_28j60_UserTCP155:
;SE9M.c,986 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserTCP153
L_Net_Ethernet_28j60_UserTCP154:
;SE9M.c,987 :: 		if( Net_Ethernet_28j60_bufferEmptyTCP(socket) && (pos[socket->ID] >= login_size) ) {
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_bufferEmptyTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_bufferEmptyTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_bufferEmptyTCP+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP158
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        _login_size+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP403
	MOVF        _login_size+0, 0 
	SUBWF       R1, 0 
L__Net_Ethernet_28j60_UserTCP403:
	BTFSS       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP158
L__Net_Ethernet_28j60_UserTCP338:
;SE9M.c,988 :: 		Net_Ethernet_28j60_disconnectTCP(socket);
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_disconnectTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_disconnectTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_disconnectTCP+0, 0
;SE9M.c,989 :: 		socket_28j60[socket->ID].state = 0;
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       51
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _socket_28j60+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_socket_28j60+0)
	ADDWFC      R1, 1 
	MOVLW       37
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SE9M.c,990 :: 		pos[socket->ID] = 0;
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;SE9M.c,991 :: 		sendHTML_mark = 0;
	CLRF        _sendHTML_mark+0 
;SE9M.c,992 :: 		post_prolaz = 0;
	CLRF        _post_prolaz+0 
;SE9M.c,993 :: 		}
L_Net_Ethernet_28j60_UserTCP158:
;SE9M.c,995 :: 		}
L_Net_Ethernet_28j60_UserTCP152:
;SE9M.c,997 :: 		if (sendIMG_mark == 1) {
	MOVF        _sendIMG_mark+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP159
;SE9M.c,999 :: 		if (pos[socket->ID] == 0) {
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP404
	MOVLW       0
	XORWF       R1, 0 
L__Net_Ethernet_28j60_UserTCP404:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP160
;SE9M.c,1000 :: 		Net_Ethernet_28j60_putConstStringTCP(httpImage, socket);
	MOVLW       _httpImage+0
	MOVWF       FARG_Net_Ethernet_28j60_putConstStringTCP_ptr+0 
	MOVLW       hi_addr(_httpImage+0)
	MOVWF       FARG_Net_Ethernet_28j60_putConstStringTCP_ptr+1 
	MOVLW       higher_addr(_httpImage+0)
	MOVWF       FARG_Net_Ethernet_28j60_putConstStringTCP_ptr+2 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putConstStringTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putConstStringTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_putConstStringTCP+0, 0
;SE9M.c,1001 :: 		}
L_Net_Ethernet_28j60_UserTCP160:
;SE9M.c,1002 :: 		while(pos[socket->ID] < p1_size){
L_Net_Ethernet_28j60_UserTCP161:
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        _p1_size+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP405
	MOVF        _p1_size+0, 0 
	SUBWF       R1, 0 
L__Net_Ethernet_28j60_UserTCP405:
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP162
;SE9M.c,1003 :: 		if(Net_Ethernet_28j60_putByteTCP(p1[pos[socket->ID]++], socket) == 0) {
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVFF       R4, FSR0
	MOVFF       R5, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVLW       1
	ADDWF       R2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R1 
	MOVFF       R4, FSR1
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVLW       _p1+0
	ADDWF       R2, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_p1+0)
	ADDWFC      R3, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_p1+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_Net_Ethernet_28j60_putByteTCP_ch+0
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putByteTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putByteTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_putByteTCP+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP163
;SE9M.c,1004 :: 		pos[socket->ID]--;
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0
	MOVFF       R3, FSR0H
	MOVLW       1
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       R2, FSR1
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,1005 :: 		break;
	GOTO        L_Net_Ethernet_28j60_UserTCP162
;SE9M.c,1006 :: 		}
L_Net_Ethernet_28j60_UserTCP163:
;SE9M.c,1007 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserTCP161
L_Net_Ethernet_28j60_UserTCP162:
;SE9M.c,1008 :: 		if( Net_Ethernet_28j60_bufferEmptyTCP(socket) && (pos[socket->ID] >= p1_size) ) {
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_bufferEmptyTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_bufferEmptyTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_bufferEmptyTCP+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP166
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        _p1_size+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP406
	MOVF        _p1_size+0, 0 
	SUBWF       R1, 0 
L__Net_Ethernet_28j60_UserTCP406:
	BTFSS       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP166
L__Net_Ethernet_28j60_UserTCP337:
;SE9M.c,1009 :: 		Net_Ethernet_28j60_disconnectTCP(socket);
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_disconnectTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_disconnectTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_disconnectTCP+0, 0
;SE9M.c,1010 :: 		socket_28j60[socket->ID].state = 0;
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       51
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _socket_28j60+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_socket_28j60+0)
	ADDWFC      R1, 1 
	MOVLW       37
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SE9M.c,1011 :: 		pos[socket->ID] = 0;
	MOVLW       35
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _pos+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_pos+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;SE9M.c,1012 :: 		sendIMG_mark = 0;
	CLRF        _sendIMG_mark+0 
;SE9M.c,1013 :: 		post_prolaz = 0;
	CLRF        _post_prolaz+0 
;SE9M.c,1014 :: 		}
L_Net_Ethernet_28j60_UserTCP166:
;SE9M.c,1016 :: 		}
L_Net_Ethernet_28j60_UserTCP159:
;SE9M.c,1019 :: 		}
L_Net_Ethernet_28j60_UserTCP116:
;SE9M.c,1054 :: 		}
L_end_Net_Ethernet_28j60_UserTCP:
	RETURN      0
; end of _Net_Ethernet_28j60_UserTCP

_Print_Seg:

;SE9M.c,1058 :: 		char Print_Seg(char segm, char tacka) {
;SE9M.c,1060 :: 		if (segm == 0) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg167
;SE9M.c,1061 :: 		napolje = 0b01111110 | tacka;
	MOVLW       126
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1062 :: 		}
L_Print_Seg167:
;SE9M.c,1063 :: 		if (segm == 1) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg168
;SE9M.c,1064 :: 		napolje = 0b00011000 | tacka;
	MOVLW       24
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1065 :: 		}
L_Print_Seg168:
;SE9M.c,1066 :: 		if (segm == 2) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg169
;SE9M.c,1067 :: 		napolje = 0b10110110 | tacka;
	MOVLW       182
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1068 :: 		}
L_Print_Seg169:
;SE9M.c,1069 :: 		if (segm == 3) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg170
;SE9M.c,1070 :: 		napolje = 0b10111100 | tacka;
	MOVLW       188
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1071 :: 		}
L_Print_Seg170:
;SE9M.c,1072 :: 		if (segm == 4) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg171
;SE9M.c,1073 :: 		napolje = 0b11011000 | tacka;
	MOVLW       216
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1074 :: 		}
L_Print_Seg171:
;SE9M.c,1075 :: 		if (segm == 5) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg172
;SE9M.c,1076 :: 		napolje = 0b11101100 | tacka;
	MOVLW       236
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1077 :: 		}
L_Print_Seg172:
;SE9M.c,1078 :: 		if (segm == 6) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg173
;SE9M.c,1079 :: 		napolje = 0b11101110 | tacka;
	MOVLW       238
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1080 :: 		}
L_Print_Seg173:
;SE9M.c,1081 :: 		if (segm == 7) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg174
;SE9M.c,1082 :: 		napolje = 0b00111000 | tacka;
	MOVLW       56
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1083 :: 		}
L_Print_Seg174:
;SE9M.c,1084 :: 		if (segm == 8) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg175
;SE9M.c,1085 :: 		napolje = 0b11111110 | tacka;
	MOVLW       254
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1086 :: 		}
L_Print_Seg175:
;SE9M.c,1087 :: 		if (segm == 9) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg176
;SE9M.c,1088 :: 		napolje = 0b11111100 | tacka;
	MOVLW       252
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1089 :: 		}
L_Print_Seg176:
;SE9M.c,1091 :: 		if (segm == 10) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg177
;SE9M.c,1092 :: 		napolje = 0b11110010 | tacka;
	MOVLW       242
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1093 :: 		}
L_Print_Seg177:
;SE9M.c,1094 :: 		if (segm == 11) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg178
;SE9M.c,1095 :: 		napolje = 0b01110010 | tacka;
	MOVLW       114
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1096 :: 		}
L_Print_Seg178:
;SE9M.c,1097 :: 		if (segm == 12) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg179
;SE9M.c,1098 :: 		napolje = 0b01111000 | tacka;
	MOVLW       120
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1099 :: 		}
L_Print_Seg179:
;SE9M.c,1100 :: 		if (segm == 13) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg180
;SE9M.c,1101 :: 		napolje = 0b11100110 | tacka;
	MOVLW       230
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1102 :: 		}
L_Print_Seg180:
;SE9M.c,1103 :: 		if (segm == 14) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg181
;SE9M.c,1104 :: 		napolje = 0b00000100 | tacka;
	MOVLW       4
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1105 :: 		}
L_Print_Seg181:
;SE9M.c,1106 :: 		if (segm == 15) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg182
;SE9M.c,1107 :: 		napolje = 0b00000000;
	CLRF        R1 
;SE9M.c,1108 :: 		}
L_Print_Seg182:
;SE9M.c,1109 :: 		if (segm == 16) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg183
;SE9M.c,1110 :: 		napolje = 0b00000001;
	MOVLW       1
	MOVWF       R1 
;SE9M.c,1111 :: 		}
L_Print_Seg183:
;SE9M.c,1112 :: 		if (segm == 17) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg184
;SE9M.c,1113 :: 		napolje = 0b10000000;
	MOVLW       128
	MOVWF       R1 
;SE9M.c,1114 :: 		}
L_Print_Seg184:
;SE9M.c,1116 :: 		return napolje;
	MOVF        R1, 0 
	MOVWF       R0 
;SE9M.c,1117 :: 		}
L_end_Print_Seg:
	RETURN      0
; end of _Print_Seg

_PRINT_S:

;SE9M.c,1119 :: 		void PRINT_S(char ledovi) {
;SE9M.c,1121 :: 		pom = 0;
	CLRF        R3 
;SE9M.c,1122 :: 		for ( ir = 0; ir < 8; ir++ ) {
	CLRF        R4 
L_PRINT_S185:
	MOVLW       8
	SUBWF       R4, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_PRINT_S186
;SE9M.c,1123 :: 		pom1 = (ledovi << pom) & 0b10000000;
	MOVF        R3, 0 
	MOVWF       R1 
	MOVF        FARG_PRINT_S_ledovi+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__PRINT_S409:
	BZ          L__PRINT_S410
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__PRINT_S409
L__PRINT_S410:
	MOVLW       128
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       R2 
;SE9M.c,1124 :: 		if (pom1 == 0b10000000) {
	MOVF        R1, 0 
	XORLW       128
	BTFSS       STATUS+0, 2 
	GOTO        L_PRINT_S188
;SE9M.c,1125 :: 		SV_DATA = 1;
	BSF         RA1_bit+0, BitPos(RA1_bit+0) 
;SE9M.c,1126 :: 		}
L_PRINT_S188:
;SE9M.c,1127 :: 		if (pom1 == 0b00000000) {
	MOVF        R2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_PRINT_S189
;SE9M.c,1128 :: 		SV_DATA = 0;
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;SE9M.c,1129 :: 		}
L_PRINT_S189:
;SE9M.c,1130 :: 		asm nop;
	NOP
;SE9M.c,1131 :: 		asm nop;
	NOP
;SE9M.c,1132 :: 		asm nop;
	NOP
;SE9M.c,1133 :: 		SV_CLK = 0;
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
;SE9M.c,1134 :: 		asm nop;
	NOP
;SE9M.c,1135 :: 		asm nop;
	NOP
;SE9M.c,1136 :: 		asm nop;
	NOP
;SE9M.c,1137 :: 		SV_CLK = 1;
	BSF         RA2_bit+0, BitPos(RA2_bit+0) 
;SE9M.c,1138 :: 		pom++;
	INCF        R3, 1 
;SE9M.c,1122 :: 		for ( ir = 0; ir < 8; ir++ ) {
	INCF        R4, 1 
;SE9M.c,1139 :: 		}
	GOTO        L_PRINT_S185
L_PRINT_S186:
;SE9M.c,1140 :: 		}
L_end_PRINT_S:
	RETURN      0
; end of _PRINT_S

_Display_Time:

;SE9M.c,1142 :: 		void Display_Time() {
;SE9M.c,1144 :: 		sec1 = sekundi / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _sekundi+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _sec1+0 
;SE9M.c,1145 :: 		sec2 = sekundi - sec1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _sekundi+0, 0 
	MOVWF       _sec2+0 
;SE9M.c,1146 :: 		min1 = minuti / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _minuti+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _min1+0 
;SE9M.c,1147 :: 		min2 = minuti - min1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _minuti+0, 0 
	MOVWF       _min2+0 
;SE9M.c,1148 :: 		hr1 = sati / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _sati+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _hr1+0 
;SE9M.c,1149 :: 		hr2 = sati - hr1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _sati+0, 0 
	MOVWF       _hr2+0 
;SE9M.c,1150 :: 		day1 = dan / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _dan+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _day1+0 
;SE9M.c,1151 :: 		day2 = dan - day1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _dan+0, 0 
	MOVWF       _day2+0 
;SE9M.c,1152 :: 		mn1 = mesec / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _mesec+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _mn1+0 
;SE9M.c,1153 :: 		mn2 = mesec - mn1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _mesec+0, 0 
	MOVWF       _mn2+0 
;SE9M.c,1154 :: 		year1 = fingodina / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _fingodina+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _year1+0 
;SE9M.c,1155 :: 		year2 = fingodina - year1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _fingodina+0, 0 
	MOVWF       _year2+0 
;SE9M.c,1157 :: 		if (disp_mode == 1) {
	MOVF        _disp_mode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Display_Time190
;SE9M.c,1158 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1159 :: 		asm nop;
	NOP
;SE9M.c,1160 :: 		asm nop;
	NOP
;SE9M.c,1161 :: 		asm nop;
	NOP
;SE9M.c,1162 :: 		PRINT_S(Print_Seg(sec2, 0));
	MOVF        _sec2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1163 :: 		PRINT_S(Print_Seg(sec1, 0));
	MOVF        _sec1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1164 :: 		PRINT_S(Print_Seg(min2, 0));
	MOVF        _min2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1165 :: 		PRINT_S(Print_Seg(min1, 0));
	MOVF        _min1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1166 :: 		PRINT_S(Print_Seg(hr2, tacka1));
	MOVF        _hr2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka1+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1167 :: 		PRINT_S(Print_Seg(hr1, tacka2));
	MOVF        _hr1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka2+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1168 :: 		asm nop;
	NOP
;SE9M.c,1169 :: 		asm nop;
	NOP
;SE9M.c,1170 :: 		asm nop;
	NOP
;SE9M.c,1171 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1172 :: 		}
L_Display_Time190:
;SE9M.c,1173 :: 		if (disp_mode == 2) {
	MOVF        _disp_mode+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Display_Time191
;SE9M.c,1174 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1175 :: 		asm nop;
	NOP
;SE9M.c,1176 :: 		asm nop;
	NOP
;SE9M.c,1177 :: 		asm nop;
	NOP
;SE9M.c,1178 :: 		PRINT_S(Print_Seg(year2, 0));
	MOVF        _year2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1179 :: 		PRINT_S(Print_Seg(year1, 0));
	MOVF        _year1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1180 :: 		PRINT_S(Print_Seg(mn2, 0));
	MOVF        _mn2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1181 :: 		PRINT_S(Print_Seg(mn1, 0));
	MOVF        _mn1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1182 :: 		PRINT_S(Print_Seg(day2, tacka1));
	MOVF        _day2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka1+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1183 :: 		PRINT_S(Print_Seg(day1, tacka2));
	MOVF        _day1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka2+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1184 :: 		asm nop;
	NOP
;SE9M.c,1185 :: 		asm nop;
	NOP
;SE9M.c,1186 :: 		asm nop;
	NOP
;SE9M.c,1187 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1188 :: 		}
L_Display_Time191:
;SE9M.c,1190 :: 		}
L_end_Display_Time:
	RETURN      0
; end of _Display_Time

_Print_IP:

;SE9M.c,1193 :: 		void Print_IP() {
;SE9M.c,1197 :: 		cif1 =  ipAddr[3] / 100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _ipAddr+3, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       Print_IP_cif1_L0+0 
;SE9M.c,1198 :: 		cif2 = (ipAddr[3] - cif1 * 100) / 10;
	MOVLW       100
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	SUBWF       _ipAddr+3, 0 
	MOVWF       FLOC__Print_IP+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Print_IP+1 
	MOVLW       0
	SUBFWB      FLOC__Print_IP+1, 1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__Print_IP+0, 0 
	MOVWF       R0 
	MOVF        FLOC__Print_IP+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       Print_IP_cif2_L0+0 
;SE9M.c,1199 :: 		cif3 =  ipAddr[3] - cif1 * 100 - cif2 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       FLOC__Print_IP+0, 0 
	MOVWF       Print_IP_cif3_L0+0 
;SE9M.c,1200 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1201 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1202 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1203 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1204 :: 		PRINT_S(Print_Seg(cif3, 0));
	MOVF        Print_IP_cif3_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1205 :: 		PRINT_S(Print_Seg(cif2, 0));
	MOVF        Print_IP_cif2_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1206 :: 		PRINT_S(Print_Seg(cif1, 0));
	MOVF        Print_IP_cif1_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1207 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1208 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,1209 :: 		delay_ms(2000);
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_Print_IP192:
	DECFSZ      R13, 1, 1
	BRA         L_Print_IP192
	DECFSZ      R12, 1, 1
	BRA         L_Print_IP192
	DECFSZ      R11, 1, 1
	BRA         L_Print_IP192
	NOP
;SE9M.c,1210 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,1211 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1212 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1213 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1214 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1215 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1216 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1217 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1218 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1219 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,1220 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_IP193:
	DECFSZ      R13, 1, 1
	BRA         L_Print_IP193
	DECFSZ      R12, 1, 1
	BRA         L_Print_IP193
	DECFSZ      R11, 1, 1
	BRA         L_Print_IP193
	NOP
;SE9M.c,1221 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,1223 :: 		}
L_end_Print_IP:
	RETURN      0
; end of _Print_IP

_Net_Ethernet_28j60_UserUDP:

;SE9M.c,1231 :: 		unsigned int Net_Ethernet_28j60_UserUDP(UDP_28j60_Dsc *udpDsc) {
;SE9M.c,1241 :: 		if (udpDsc->destPort == 10001) {
	MOVLW       12
	ADDWF       FARG_Net_Ethernet_28j60_UserUDP_udpDsc+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserUDP_udpDsc+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	XORLW       39
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserUDP414
	MOVLW       17
	XORWF       R1, 0 
L__Net_Ethernet_28j60_UserUDP414:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP194
;SE9M.c,1243 :: 		if (udpDsc->dataLength == 9) {
	MOVLW       14
	ADDWF       FARG_Net_Ethernet_28j60_UserUDP_udpDsc+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserUDP_udpDsc+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserUDP415
	MOVLW       9
	XORWF       R1, 0 
L__Net_Ethernet_28j60_UserUDP415:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP195
;SE9M.c,1244 :: 		for (i = 0 ; i < 9 ; i++) {
	CLRF        Net_Ethernet_28j60_UserUDP_i_L0+0 
L_Net_Ethernet_28j60_UserUDP196:
	MOVLW       9
	SUBWF       Net_Ethernet_28j60_UserUDP_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserUDP197
;SE9M.c,1245 :: 		broadcmd[i] = Net_Ethernet_28j60_getByte() ;
	MOVLW       Net_Ethernet_28j60_UserUDP_broadcmd_L0+0
	MOVWF       FLOC__Net_Ethernet_28j60_UserUDP+0 
	MOVLW       hi_addr(Net_Ethernet_28j60_UserUDP_broadcmd_L0+0)
	MOVWF       FLOC__Net_Ethernet_28j60_UserUDP+1 
	MOVF        Net_Ethernet_28j60_UserUDP_i_L0+0, 0 
	ADDWF       FLOC__Net_Ethernet_28j60_UserUDP+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__Net_Ethernet_28j60_UserUDP+1, 1 
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVFF       FLOC__Net_Ethernet_28j60_UserUDP+0, FSR1
	MOVFF       FLOC__Net_Ethernet_28j60_UserUDP+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,1244 :: 		for (i = 0 ; i < 9 ; i++) {
	INCF        Net_Ethernet_28j60_UserUDP_i_L0+0, 1 
;SE9M.c,1246 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserUDP196
L_Net_Ethernet_28j60_UserUDP197:
;SE9M.c,1247 :: 		if ( (broadcmd[0] == 'I') && (broadcmd[1] == 'D') && (broadcmd[2] == 'E') && (broadcmd[3] == 'N') && (broadcmd[4] == 'T') && (broadcmd[5] == 'I') && (broadcmd[6] == 'F') && (broadcmd[7] == 'Y') && (broadcmd[8] == '!') ) {
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+0, 0 
	XORLW       73
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP201
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+1, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP201
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+2, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP201
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+3, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP201
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+4, 0 
	XORLW       84
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP201
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+5, 0 
	XORLW       73
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP201
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+6, 0 
	XORLW       70
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP201
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+7, 0 
	XORLW       89
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP201
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+8, 0 
	XORLW       33
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP201
L__Net_Ethernet_28j60_UserUDP350:
;SE9M.c,1249 :: 		Print_IP();
	CALL        _Print_IP+0, 0
;SE9M.c,1251 :: 		}
L_Net_Ethernet_28j60_UserUDP201:
;SE9M.c,1252 :: 		}
L_Net_Ethernet_28j60_UserUDP195:
;SE9M.c,1253 :: 		}
L_Net_Ethernet_28j60_UserUDP194:
;SE9M.c,1256 :: 		if(udpDsc->destPort == 123)             // check SNTP port number
	MOVLW       12
	ADDWF       FARG_Net_Ethernet_28j60_UserUDP_udpDsc+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserUDP_udpDsc+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserUDP416
	MOVLW       123
	XORWF       R1, 0 
L__Net_Ethernet_28j60_UserUDP416:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP202
;SE9M.c,1258 :: 		if (udpDsc->remoteIP[3] == 10 && modeChange == 0){
	MOVLW       3
	ADDWF       FARG_Net_Ethernet_28j60_UserUDP_udpDsc+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserUDP_udpDsc+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP205
	MOVF        _modeChange+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP205
L__Net_Ethernet_28j60_UserUDP349:
;SE9M.c,1259 :: 		return (0);
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_Net_Ethernet_28j60_UserUDP
;SE9M.c,1260 :: 		}
L_Net_Ethernet_28j60_UserUDP205:
;SE9M.c,1262 :: 		else if (udpDsc->dataLength == 48) {
	MOVLW       14
	ADDWF       FARG_Net_Ethernet_28j60_UserUDP_udpDsc+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserUDP_udpDsc+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserUDP417
	MOVLW       48
	XORWF       R1, 0 
L__Net_Ethernet_28j60_UserUDP417:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP207
;SE9M.c,1263 :: 		epoch_fract = presTmr * 274877.906944 ;
	MOVF        _presTmr+0, 0 
	MOVWF       R0 
	MOVF        _presTmr+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       189
	MOVWF       R4 
	MOVLW       55
	MOVWF       R5 
	MOVLW       6
	MOVWF       R6 
	MOVLW       145
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2longint+0, 0
	MOVF        R0, 0 
	MOVWF       _epoch_fract+0 
	MOVF        R1, 0 
	MOVWF       _epoch_fract+1 
	MOVF        R2, 0 
	MOVWF       _epoch_fract+2 
	MOVF        R3, 0 
	MOVWF       _epoch_fract+3 
;SE9M.c,1264 :: 		t_dst = epoch;
	MOVF        _epoch+0, 0 
	MOVWF       _t_dst+0 
	MOVF        _epoch+1, 0 
	MOVWF       _t_dst+1 
	MOVF        _epoch+2, 0 
	MOVWF       _t_dst+2 
	MOVF        _epoch+3, 0 
	MOVWF       _t_dst+3 
;SE9M.c,1265 :: 		t_dst_fract = epoch_fract ;
	MOVF        R0, 0 
	MOVWF       _t_dst_fract+0 
	MOVF        R1, 0 
	MOVWF       _t_dst_fract+1 
	MOVF        R2, 0 
	MOVWF       _t_dst_fract+2 
	MOVF        R3, 0 
	MOVWF       _t_dst_fract+3 
;SE9M.c,1266 :: 		serverFlags = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _serverFlags+0 
;SE9M.c,1267 :: 		serverStratum = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _serverStratum+0 
;SE9M.c,1268 :: 		poll = Net_Ethernet_28j60_getByte() ;        // skip poll
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _poll+0 
;SE9M.c,1269 :: 		serverPrecision = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _serverPrecision+0 
;SE9M.c,1271 :: 		for(i = 0 ; i < 20 ; i++){
	CLRF        Net_Ethernet_28j60_UserUDP_i_L0+0 
L_Net_Ethernet_28j60_UserUDP208:
	MOVLW       20
	SUBWF       Net_Ethernet_28j60_UserUDP_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserUDP209
;SE9M.c,1272 :: 		Net_Ethernet_28j60_getByte() ;// skip all unused fileds
	CALL        _Net_Ethernet_28j60_getByte+0, 0
;SE9M.c,1271 :: 		for(i = 0 ; i < 20 ; i++){
	INCF        Net_Ethernet_28j60_UserUDP_i_L0+0, 1 
;SE9M.c,1273 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserUDP208
L_Net_Ethernet_28j60_UserUDP209:
;SE9M.c,1276 :: 		Highest(t_org) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org+3 
;SE9M.c,1277 :: 		Higher(t_org) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org+2 
;SE9M.c,1278 :: 		Hi(t_org) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org+1 
;SE9M.c,1279 :: 		Lo(t_org) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org+0 
;SE9M.c,1280 :: 		Highest(t_org_fract) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org_fract+3 
;SE9M.c,1281 :: 		Higher(t_org_fract) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org_fract+2 
;SE9M.c,1282 :: 		Hi(t_org_fract) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org_fract+1 
;SE9M.c,1283 :: 		Lo(t_org_fract) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_org_fract+0 
;SE9M.c,1286 :: 		Highest(t_rec) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec+3 
;SE9M.c,1287 :: 		Higher(t_rec) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec+2 
;SE9M.c,1288 :: 		Hi(t_rec) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec+1 
;SE9M.c,1289 :: 		Lo(t_rec) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec+0 
;SE9M.c,1290 :: 		Highest(t_rec_fract) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec_fract+3 
;SE9M.c,1291 :: 		Higher(t_rec_fract) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec_fract+2 
;SE9M.c,1292 :: 		Hi(t_rec_fract) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec_fract+1 
;SE9M.c,1293 :: 		Lo(t_rec_fract) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_rec_fract+0 
;SE9M.c,1295 :: 		Highest(t_xmt) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt+3 
;SE9M.c,1296 :: 		Higher(t_xmt) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt+2 
;SE9M.c,1297 :: 		Hi(t_xmt) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt+1 
;SE9M.c,1298 :: 		Lo(t_xmt) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt+0 
;SE9M.c,1299 :: 		Highest(t_xmt_fract) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt_fract+3 
;SE9M.c,1300 :: 		Higher(t_xmt_fract) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt_fract+2 
;SE9M.c,1301 :: 		Hi(t_xmt_fract) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt_fract+1 
;SE9M.c,1302 :: 		Lo(t_xmt_fract) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _t_xmt_fract+0 
;SE9M.c,1316 :: 		t_rec = t_rec - 2208988800;
	MOVLW       128
	SUBWF       _t_rec+0, 1 
	MOVLW       126
	SUBWFB      _t_rec+1, 1 
	MOVLW       170
	SUBWFB      _t_rec+2, 1 
	MOVLW       131
	SUBWFB      _t_rec+3, 1 
;SE9M.c,1326 :: 		t_xmt =  t_xmt - 2208988800;
	MOVLW       128
	SUBWF       _t_xmt+0, 1 
	MOVLW       126
	SUBWFB      _t_xmt+1, 1 
	MOVLW       170
	SUBWFB      _t_xmt+2, 1 
	MOVLW       131
	SUBWFB      _t_xmt+3, 1 
;SE9M.c,1347 :: 		if (t_dst == t_org){
	MOVF        _t_dst+3, 0 
	XORWF       _t_org+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserUDP418
	MOVF        _t_dst+2, 0 
	XORWF       _t_org+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserUDP418
	MOVF        _t_dst+1, 0 
	XORWF       _t_org+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserUDP418
	MOVF        _t_dst+0, 0 
	XORWF       _t_org+0, 0 
L__Net_Ethernet_28j60_UserUDP418:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP211
;SE9M.c,1348 :: 		delta = ( t_dst_fract - t_org_fract) - (t_xmt_fract - t_rec_fract );
	MOVF        _t_dst_fract+0, 0 
	MOVWF       Net_Ethernet_28j60_UserUDP_delta_L0+0 
	MOVF        _t_dst_fract+1, 0 
	MOVWF       Net_Ethernet_28j60_UserUDP_delta_L0+1 
	MOVF        _t_dst_fract+2, 0 
	MOVWF       Net_Ethernet_28j60_UserUDP_delta_L0+2 
	MOVF        _t_dst_fract+3, 0 
	MOVWF       Net_Ethernet_28j60_UserUDP_delta_L0+3 
	MOVF        _t_org_fract+0, 0 
	SUBWF       Net_Ethernet_28j60_UserUDP_delta_L0+0, 1 
	MOVF        _t_org_fract+1, 0 
	SUBWFB      Net_Ethernet_28j60_UserUDP_delta_L0+1, 1 
	MOVF        _t_org_fract+2, 0 
	SUBWFB      Net_Ethernet_28j60_UserUDP_delta_L0+2, 1 
	MOVF        _t_org_fract+3, 0 
	SUBWFB      Net_Ethernet_28j60_UserUDP_delta_L0+3, 1 
	MOVF        _t_xmt_fract+0, 0 
	MOVWF       R0 
	MOVF        _t_xmt_fract+1, 0 
	MOVWF       R1 
	MOVF        _t_xmt_fract+2, 0 
	MOVWF       R2 
	MOVF        _t_xmt_fract+3, 0 
	MOVWF       R3 
	MOVF        _t_rec_fract+0, 0 
	SUBWF       R0, 1 
	MOVF        _t_rec_fract+1, 0 
	SUBWFB      R1, 1 
	MOVF        _t_rec_fract+2, 0 
	SUBWFB      R2, 1 
	MOVF        _t_rec_fract+3, 0 
	SUBWFB      R3, 1 
	MOVF        R0, 0 
	SUBWF       Net_Ethernet_28j60_UserUDP_delta_L0+0, 1 
	MOVF        R1, 0 
	SUBWFB      Net_Ethernet_28j60_UserUDP_delta_L0+1, 1 
	MOVF        R2, 0 
	SUBWFB      Net_Ethernet_28j60_UserUDP_delta_L0+2, 1 
	MOVF        R3, 0 
	SUBWFB      Net_Ethernet_28j60_UserUDP_delta_L0+3, 1 
;SE9M.c,1354 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserUDP212
L_Net_Ethernet_28j60_UserUDP211:
;SE9M.c,1355 :: 		else if (t_dst != t_org){
	MOVF        _t_dst+3, 0 
	XORWF       _t_org+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserUDP419
	MOVF        _t_dst+2, 0 
	XORWF       _t_org+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserUDP419
	MOVF        _t_dst+1, 0 
	XORWF       _t_org+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserUDP419
	MOVF        _t_dst+0, 0 
	XORWF       _t_org+0, 0 
L__Net_Ethernet_28j60_UserUDP419:
	BTFSC       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP213
;SE9M.c,1356 :: 		delta = (4294967295 -  t_org_fract + t_dst_fract) - (t_xmt_fract - t_rec_fract );
	MOVLW       255
	MOVWF       Net_Ethernet_28j60_UserUDP_delta_L0+0 
	MOVLW       255
	MOVWF       Net_Ethernet_28j60_UserUDP_delta_L0+1 
	MOVLW       255
	MOVWF       Net_Ethernet_28j60_UserUDP_delta_L0+2 
	MOVLW       255
	MOVWF       Net_Ethernet_28j60_UserUDP_delta_L0+3 
	MOVF        _t_org_fract+0, 0 
	SUBWF       Net_Ethernet_28j60_UserUDP_delta_L0+0, 1 
	MOVF        _t_org_fract+1, 0 
	SUBWFB      Net_Ethernet_28j60_UserUDP_delta_L0+1, 1 
	MOVF        _t_org_fract+2, 0 
	SUBWFB      Net_Ethernet_28j60_UserUDP_delta_L0+2, 1 
	MOVF        _t_org_fract+3, 0 
	SUBWFB      Net_Ethernet_28j60_UserUDP_delta_L0+3, 1 
	MOVF        _t_dst_fract+0, 0 
	ADDWF       Net_Ethernet_28j60_UserUDP_delta_L0+0, 1 
	MOVF        _t_dst_fract+1, 0 
	ADDWFC      Net_Ethernet_28j60_UserUDP_delta_L0+1, 1 
	MOVF        _t_dst_fract+2, 0 
	ADDWFC      Net_Ethernet_28j60_UserUDP_delta_L0+2, 1 
	MOVF        _t_dst_fract+3, 0 
	ADDWFC      Net_Ethernet_28j60_UserUDP_delta_L0+3, 1 
	MOVF        _t_xmt_fract+0, 0 
	MOVWF       R0 
	MOVF        _t_xmt_fract+1, 0 
	MOVWF       R1 
	MOVF        _t_xmt_fract+2, 0 
	MOVWF       R2 
	MOVF        _t_xmt_fract+3, 0 
	MOVWF       R3 
	MOVF        _t_rec_fract+0, 0 
	SUBWF       R0, 1 
	MOVF        _t_rec_fract+1, 0 
	SUBWFB      R1, 1 
	MOVF        _t_rec_fract+2, 0 
	SUBWFB      R2, 1 
	MOVF        _t_rec_fract+3, 0 
	SUBWFB      R3, 1 
	MOVF        R0, 0 
	SUBWF       Net_Ethernet_28j60_UserUDP_delta_L0+0, 1 
	MOVF        R1, 0 
	SUBWFB      Net_Ethernet_28j60_UserUDP_delta_L0+1, 1 
	MOVF        R2, 0 
	SUBWFB      Net_Ethernet_28j60_UserUDP_delta_L0+2, 1 
	MOVF        R3, 0 
	SUBWFB      Net_Ethernet_28j60_UserUDP_delta_L0+3, 1 
;SE9M.c,1362 :: 		}
L_Net_Ethernet_28j60_UserUDP213:
L_Net_Ethernet_28j60_UserUDP212:
;SE9M.c,1364 :: 		if ( (presTmr + delta /(2 * 274877.906944))  > 15625 ){
	MOVF        Net_Ethernet_28j60_UserUDP_delta_L0+0, 0 
	MOVWF       R0 
	MOVF        Net_Ethernet_28j60_UserUDP_delta_L0+1, 0 
	MOVWF       R1 
	MOVF        Net_Ethernet_28j60_UserUDP_delta_L0+2, 0 
	MOVWF       R2 
	MOVF        Net_Ethernet_28j60_UserUDP_delta_L0+3, 0 
	MOVWF       R3 
	CALL        _longint2double+0, 0
	MOVLW       189
	MOVWF       R4 
	MOVLW       55
	MOVWF       R5 
	MOVLW       6
	MOVWF       R6 
	MOVLW       146
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserUDP+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserUDP+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserUDP+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserUDP+3 
	MOVF        _presTmr+0, 0 
	MOVWF       R0 
	MOVF        _presTmr+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+0, 0 
	MOVWF       R4 
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+1, 0 
	MOVWF       R5 
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+2, 0 
	MOVWF       R6 
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       36
	MOVWF       R1 
	MOVLW       116
	MOVWF       R2 
	MOVLW       140
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP214
;SE9M.c,1365 :: 		epoch  = t_xmt + 1;
	MOVLW       1
	ADDWF       _t_xmt+0, 0 
	MOVWF       _epoch+0 
	MOVLW       0
	ADDWFC      _t_xmt+1, 0 
	MOVWF       _epoch+1 
	MOVLW       0
	ADDWFC      _t_xmt+2, 0 
	MOVWF       _epoch+2 
	MOVLW       0
	ADDWFC      _t_xmt+3, 0 
	MOVWF       _epoch+3 
;SE9M.c,1366 :: 		presTmr = (presTmr + delta / (2 * 274877.906944)) - 15625;
	MOVF        Net_Ethernet_28j60_UserUDP_delta_L0+0, 0 
	MOVWF       R0 
	MOVF        Net_Ethernet_28j60_UserUDP_delta_L0+1, 0 
	MOVWF       R1 
	MOVF        Net_Ethernet_28j60_UserUDP_delta_L0+2, 0 
	MOVWF       R2 
	MOVF        Net_Ethernet_28j60_UserUDP_delta_L0+3, 0 
	MOVWF       R3 
	CALL        _longint2double+0, 0
	MOVLW       189
	MOVWF       R4 
	MOVLW       55
	MOVWF       R5 
	MOVLW       6
	MOVWF       R6 
	MOVLW       146
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserUDP+0 
	MOVF        R1, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserUDP+1 
	MOVF        R2, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserUDP+2 
	MOVF        R3, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserUDP+3 
	MOVF        _presTmr+0, 0 
	MOVWF       R0 
	MOVF        _presTmr+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+0, 0 
	MOVWF       R4 
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+1, 0 
	MOVWF       R5 
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+2, 0 
	MOVWF       R6 
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       36
	MOVWF       R5 
	MOVLW       116
	MOVWF       R6 
	MOVLW       140
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	CALL        _double2word+0, 0
	MOVF        R0, 0 
	MOVWF       _presTmr+0 
	MOVF        R1, 0 
	MOVWF       _presTmr+1 
;SE9M.c,1367 :: 		epoch_fract = presTmr * 274877.906944 ;
	CALL        _word2double+0, 0
	MOVLW       189
	MOVWF       R4 
	MOVLW       55
	MOVWF       R5 
	MOVLW       6
	MOVWF       R6 
	MOVLW       145
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2longint+0, 0
	MOVF        R0, 0 
	MOVWF       _epoch_fract+0 
	MOVF        R1, 0 
	MOVWF       _epoch_fract+1 
	MOVF        R2, 0 
	MOVWF       _epoch_fract+2 
	MOVF        R3, 0 
	MOVWF       _epoch_fract+3 
;SE9M.c,1369 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserUDP215
L_Net_Ethernet_28j60_UserUDP214:
;SE9M.c,1371 :: 		epoch = t_xmt;
	MOVF        _t_xmt+0, 0 
	MOVWF       _epoch+0 
	MOVF        _t_xmt+1, 0 
	MOVWF       _epoch+1 
	MOVF        _t_xmt+2, 0 
	MOVWF       _epoch+2 
	MOVF        _t_xmt+3, 0 
	MOVWF       _epoch+3 
;SE9M.c,1372 :: 		epoch_fract += delta / 2;
	MOVF        Net_Ethernet_28j60_UserUDP_delta_L0+0, 0 
	MOVWF       R0 
	MOVF        Net_Ethernet_28j60_UserUDP_delta_L0+1, 0 
	MOVWF       R1 
	MOVF        Net_Ethernet_28j60_UserUDP_delta_L0+2, 0 
	MOVWF       R2 
	MOVF        Net_Ethernet_28j60_UserUDP_delta_L0+3, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R3, 7 
	BTFSC       R3, 6 
	BSF         R3, 7 
	BTFSS       R3, 7 
	GOTO        L__Net_Ethernet_28j60_UserUDP420
	BTFSS       STATUS+0, 0 
	GOTO        L__Net_Ethernet_28j60_UserUDP420
	MOVLW       1
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
L__Net_Ethernet_28j60_UserUDP420:
	MOVF        R0, 0 
	ADDWF       _epoch_fract+0, 1 
	MOVF        R1, 0 
	ADDWFC      _epoch_fract+1, 1 
	MOVF        R2, 0 
	ADDWFC      _epoch_fract+2, 1 
	MOVF        R3, 0 
	ADDWFC      _epoch_fract+3, 1 
;SE9M.c,1374 :: 		}
L_Net_Ethernet_28j60_UserUDP215:
;SE9M.c,1376 :: 		lastSync =  epoch;
	MOVF        _epoch+0, 0 
	MOVWF       _lastSync+0 
	MOVF        _epoch+1, 0 
	MOVWF       _lastSync+1 
	MOVF        _epoch+2, 0 
	MOVWF       _lastSync+2 
	MOVF        _epoch+3, 0 
	MOVWF       _lastSync+3 
;SE9M.c,1378 :: 		marquee = bufInfo ;
	MOVLW       _bufInfo+0
	MOVWF       _marquee+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       _marquee+1 
;SE9M.c,1380 :: 		notime = 0;
	CLRF        _notime+0 
;SE9M.c,1381 :: 		notime_ovf = 0;
	CLRF        _notime_ovf+0 
;SE9M.c,1383 :: 		Time_epochToDate(epoch + tmzn * 3600, &ts) ;
	MOVF        _tmzn+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _tmzn+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       16
	MOVWF       R4 
	MOVLW       14
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       _epoch+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        R1, 0 
	ADDWFC      _epoch+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _epoch+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _epoch+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVLW       _ts+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,1385 :: 		presTmr = 0;
	CLRF        _presTmr+0 
	CLRF        _presTmr+1 
;SE9M.c,1386 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,1387 :: 		if (lcdEvent) {
	MOVF        _lcdEvent+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP216
;SE9M.c,1388 :: 		mkLCDLine(1, conf.dhcpen) ; // update lcd: first row
	MOVLW       1
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+0, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,1389 :: 		mkLCDLine(2, conf.lcdL2) ; // update lcd: second row
	MOVLW       2
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+1, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,1390 :: 		lcdEvent = 0 ;             // clear lcd update flag
	CLRF        _lcdEvent+0 
;SE9M.c,1391 :: 		marquee++ ;                // set marquee pointer
	INFSNZ      _marquee+0, 1 
	INCF        _marquee+1, 1 
;SE9M.c,1392 :: 		}
L_Net_Ethernet_28j60_UserUDP216:
;SE9M.c,1394 :: 		presTmr = 0;
	CLRF        _presTmr+0 
	CLRF        _presTmr+1 
;SE9M.c,1395 :: 		lcdTmr = 0;
	CLRF        _lcdTmr+0 
	CLRF        _lcdTmr+1 
;SE9M.c,1396 :: 		Display_Time();
	CALL        _Display_Time+0, 0
;SE9M.c,1397 :: 		} else {
	GOTO        L_Net_Ethernet_28j60_UserUDP217
L_Net_Ethernet_28j60_UserUDP207:
;SE9M.c,1398 :: 		return(0) ;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_Net_Ethernet_28j60_UserUDP
;SE9M.c,1399 :: 		}
L_Net_Ethernet_28j60_UserUDP217:
;SE9M.c,1400 :: 		} else {
	GOTO        L_Net_Ethernet_28j60_UserUDP218
L_Net_Ethernet_28j60_UserUDP202:
;SE9M.c,1401 :: 		return(0) ;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_Net_Ethernet_28j60_UserUDP
;SE9M.c,1402 :: 		}
L_Net_Ethernet_28j60_UserUDP218:
;SE9M.c,1403 :: 		}
L_end_Net_Ethernet_28j60_UserUDP:
	RETURN      0
; end of _Net_Ethernet_28j60_UserUDP

_InitTimer1:

;SE9M.c,1405 :: 		void InitTimer1(){
;SE9M.c,1406 :: 		T1CON         = 0x01;
	MOVLW       1
	MOVWF       T1CON+0 
;SE9M.c,1407 :: 		TMR1IF_bit    = 0;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;SE9M.c,1408 :: 		TMR1H         = 0x63;
	MOVLW       99
	MOVWF       TMR1H+0 
;SE9M.c,1409 :: 		TMR1L         = 0xC0;
	MOVLW       192
	MOVWF       TMR1L+0 
;SE9M.c,1410 :: 		TMR1IE_bit    = 1;
	BSF         TMR1IE_bit+0, BitPos(TMR1IE_bit+0) 
;SE9M.c,1411 :: 		INTCON        = 0xC0;
	MOVLW       192
	MOVWF       INTCON+0 
;SE9M.c,1412 :: 		}
L_end_InitTimer1:
	RETURN      0
; end of _InitTimer1

_interrupt:

;SE9M.c,1413 :: 		void interrupt() {
;SE9M.c,1415 :: 		if (PIR1.RCIF == 1) {
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt219
;SE9M.c,1416 :: 		prkomanda = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _prkomanda+0 
;SE9M.c,1417 :: 		if ( ( (ipt == 0) && (prkomanda == 0xAA) ) || (ipt != 0) ) {
	MOVF        _ipt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt354
	MOVF        _prkomanda+0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt354
	GOTO        L__interrupt353
L__interrupt354:
	MOVF        _ipt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt353
	GOTO        L_interrupt224
L__interrupt353:
;SE9M.c,1418 :: 		comand[ipt] = prkomanda;
	MOVLW       _comand+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_comand+0)
	MOVWF       FSR1H 
	MOVF        _ipt+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        _prkomanda+0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,1419 :: 		ipt++;
	INCF        _ipt+0, 1 
;SE9M.c,1420 :: 		}
L_interrupt224:
;SE9M.c,1421 :: 		if (prkomanda == 0xBB) {
	MOVF        _prkomanda+0, 0 
	XORLW       187
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt225
;SE9M.c,1422 :: 		komgotovo = 1;
	MOVLW       1
	MOVWF       _komgotovo+0 
;SE9M.c,1423 :: 		ipt = 0;
	CLRF        _ipt+0 
;SE9M.c,1424 :: 		}
L_interrupt225:
;SE9M.c,1425 :: 		if (ipt > 18) {
	MOVF        _ipt+0, 0 
	SUBLW       18
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt226
;SE9M.c,1426 :: 		ipt = 0;
	CLRF        _ipt+0 
;SE9M.c,1427 :: 		}
L_interrupt226:
;SE9M.c,1428 :: 		}
L_interrupt219:
;SE9M.c,1430 :: 		if (INTCON.TMR0IF) {
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt227
;SE9M.c,1431 :: 		presTmr++ ;
	INFSNZ      _presTmr+0, 1 
	INCF        _presTmr+1, 1 
;SE9M.c,1433 :: 		if (presTmr == 15625) {
	MOVF        _presTmr+1, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt424
	MOVLW       9
	XORWF       _presTmr+0, 0 
L__interrupt424:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt228
;SE9M.c,1436 :: 		Net_Ethernet_28j60_UserTimerSec++ ;
	MOVLW       1
	ADDWF       _Net_Ethernet_28j60_UserTimerSec+0, 1 
	MOVLW       0
	ADDWFC      _Net_Ethernet_28j60_UserTimerSec+1, 1 
	ADDWFC      _Net_Ethernet_28j60_UserTimerSec+2, 1 
	ADDWFC      _Net_Ethernet_28j60_UserTimerSec+3, 1 
;SE9M.c,1437 :: 		epoch++ ;
	MOVLW       1
	ADDWF       _epoch+0, 1 
	MOVLW       0
	ADDWFC      _epoch+1, 1 
	ADDWFC      _epoch+2, 1 
	ADDWFC      _epoch+3, 1 
;SE9M.c,1438 :: 		presTmr = 0 ;
	CLRF        _presTmr+0 
	CLRF        _presTmr+1 
;SE9M.c,1440 :: 		}
L_interrupt228:
;SE9M.c,1441 :: 		INTCON.TMR0IF = 0 ;              // clear timer0 overflow flag
	BCF         INTCON+0, 2 
;SE9M.c,1443 :: 		}
L_interrupt227:
;SE9M.c,1444 :: 		if (TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
	GOTO        L_interrupt229
;SE9M.c,1446 :: 		lcdTmr++;
	INFSNZ      _lcdTmr+0, 1 
	INCF        _lcdTmr+1, 1 
;SE9M.c,1447 :: 		cnt++;
	INCF        _cnt+0, 1 
;SE9M.c,1448 :: 		if (modeChange == 0){
	MOVF        _modeChange+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt230
;SE9M.c,1449 :: 		modeCnt++;
	INCF        _modeCnt+0, 1 
;SE9M.c,1450 :: 		if (modeCnt == ipAddr[3]){
	MOVF        _modeCnt+0, 0 
	XORWF       _ipAddr+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt231
;SE9M.c,1451 :: 		sntpSync = 0;
	CLRF        _sntpSync+0 
;SE9M.c,1452 :: 		sync_flag = 1;
	MOVLW       1
	MOVWF       _sync_flag+0 
;SE9M.c,1453 :: 		modeChange = 1;
	MOVLW       1
	MOVWF       _modeChange+0 
;SE9M.c,1454 :: 		modeCnt = 0;
	CLRF        _modeCnt+0 
;SE9M.c,1455 :: 		}
L_interrupt231:
;SE9M.c,1457 :: 		}
L_interrupt230:
;SE9M.c,1458 :: 		if (cnt == 200){
	MOVF        _cnt+0, 0 
	XORLW       200
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt232
;SE9M.c,1460 :: 		if (admin == 1){
	MOVF        _admin+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt233
;SE9M.c,1461 :: 		session++;
	INFSNZ      _session+0, 1 
	INCF        _session+1, 1 
;SE9M.c,1462 :: 		}
L_interrupt233:
;SE9M.c,1466 :: 		if (timer_flag < 2555) {
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORLW       9
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt425
	MOVLW       251
	SUBWF       _timer_flag+0, 0 
L__interrupt425:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt234
;SE9M.c,1467 :: 		timer_flag++;
	INCF        _timer_flag+0, 1 
;SE9M.c,1468 :: 		} else {
	GOTO        L_interrupt235
L_interrupt234:
;SE9M.c,1469 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,1470 :: 		}
L_interrupt235:
;SE9M.c,1474 :: 		notime++;
	INCF        _notime+0, 1 
;SE9M.c,1475 :: 		if (notime == 32) {
	MOVF        _notime+0, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt236
;SE9M.c,1476 :: 		notime = 0;
	CLRF        _notime+0 
;SE9M.c,1477 :: 		notime_ovf = 1;
	MOVLW       1
	MOVWF       _notime_ovf+0 
;SE9M.c,1478 :: 		}
L_interrupt236:
;SE9M.c,1482 :: 		if ( (lease_tmr == 1) && (lease_time < 250) ) {
	MOVF        _lease_tmr+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt239
	MOVLW       250
	SUBWF       _lease_time+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt239
L__interrupt352:
;SE9M.c,1483 :: 		lease_time++;
	INCF        _lease_time+0, 1 
;SE9M.c,1484 :: 		} else {
	GOTO        L_interrupt240
L_interrupt239:
;SE9M.c,1485 :: 		lease_time = 0;
	CLRF        _lease_time+0 
;SE9M.c,1486 :: 		}
L_interrupt240:
;SE9M.c,1491 :: 		req_tmr_1++;
	INCF        _req_tmr_1+0, 1 
;SE9M.c,1492 :: 		if (req_tmr_1 == 60) {
	MOVF        _req_tmr_1+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt241
;SE9M.c,1493 :: 		req_tmr_1 = 0;
	CLRF        _req_tmr_1+0 
;SE9M.c,1494 :: 		req_tmr_2++;
	INCF        _req_tmr_2+0, 1 
;SE9M.c,1496 :: 		}
L_interrupt241:
;SE9M.c,1497 :: 		if (req_tmr_2 == 60) {
	MOVF        _req_tmr_2+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt242
;SE9M.c,1498 :: 		req_tmr_2 = 0;
	CLRF        _req_tmr_2+0 
;SE9M.c,1499 :: 		req_tmr_3++;
	INCF        _req_tmr_3+0, 1 
;SE9M.c,1500 :: 		}
L_interrupt242:
;SE9M.c,1504 :: 		if (rst_flag == 1) {
	MOVF        _rst_flag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt243
;SE9M.c,1505 :: 		rst_flag_1++;
	INCF        _rst_flag_1+0, 1 
;SE9M.c,1506 :: 		}
L_interrupt243:
;SE9M.c,1510 :: 		if ( (rst_fab_tmr == 1) && (rst_fab_flag < 200) ) {
	MOVF        _rst_fab_tmr+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt246
	MOVLW       200
	SUBWF       _rst_fab_flag+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt246
L__interrupt351:
;SE9M.c,1511 :: 		rst_fab_flag++;
	INCF        _rst_fab_flag+0, 1 
;SE9M.c,1512 :: 		}
L_interrupt246:
;SE9M.c,1514 :: 		cnt = 0;
	CLRF        _cnt+0 
;SE9M.c,1515 :: 		}
L_interrupt232:
;SE9M.c,1517 :: 		if (session == 120){
	MOVLW       0
	XORWF       _session+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt426
	MOVLW       120
	XORWF       _session+0, 0 
L__interrupt426:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt247
;SE9M.c,1518 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,1519 :: 		session = 0;
	CLRF        _session+0 
	CLRF        _session+1 
;SE9M.c,1520 :: 		sendHTML_mark = 1;
	MOVLW       1
	MOVWF       _sendHTML_mark+0 
;SE9M.c,1521 :: 		}
L_interrupt247:
;SE9M.c,1523 :: 		if (lcdTmr == 40) {
	MOVLW       0
	XORWF       _lcdTmr+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt427
	MOVLW       40
	XORWF       _lcdTmr+0, 0 
L__interrupt427:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt248
;SE9M.c,1524 :: 		lcdEvent = 1;
	MOVLW       1
	MOVWF       _lcdEvent+0 
;SE9M.c,1525 :: 		lcdTmr = 0;
	CLRF        _lcdTmr+0 
	CLRF        _lcdTmr+1 
;SE9M.c,1526 :: 		}
L_interrupt248:
;SE9M.c,1528 :: 		TMR1H         = 0x63;
	MOVLW       99
	MOVWF       TMR1H+0 
;SE9M.c,1529 :: 		TMR1L         = 0xC0;
	MOVLW       192
	MOVWF       TMR1L+0 
;SE9M.c,1530 :: 		TMR1IF_bit = 0;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;SE9M.c,1531 :: 		}
L_interrupt229:
;SE9M.c,1532 :: 		}
L_end_interrupt:
L__interrupt423:
	RETFIE      1
; end of _interrupt

_Print_Blank:

;SE9M.c,1535 :: 		void Print_Blank() {
;SE9M.c,1536 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1537 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1538 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1539 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1540 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1541 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1542 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1543 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1544 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,1545 :: 		delay_ms(1000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_Print_Blank249:
	DECFSZ      R13, 1, 1
	BRA         L_Print_Blank249
	DECFSZ      R12, 1, 1
	BRA         L_Print_Blank249
	DECFSZ      R11, 1, 1
	BRA         L_Print_Blank249
;SE9M.c,1546 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,1547 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1548 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1549 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1550 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1551 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1552 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1553 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1554 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1555 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,1556 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_Blank250:
	DECFSZ      R13, 1, 1
	BRA         L_Print_Blank250
	DECFSZ      R12, 1, 1
	BRA         L_Print_Blank250
	DECFSZ      R11, 1, 1
	BRA         L_Print_Blank250
	NOP
;SE9M.c,1557 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,1558 :: 		}
L_end_Print_Blank:
	RETURN      0
; end of _Print_Blank

_Print_All:

;SE9M.c,1560 :: 		void Print_All() {
;SE9M.c,1564 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1565 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1566 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1567 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1568 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1569 :: 		PRINT_S(Print_Seg(15, 1));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	MOVLW       1
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1570 :: 		PRINT_S(Print_Seg(15, 1));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	MOVLW       1
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1571 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1572 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,1573 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_All251:
	DECFSZ      R13, 1, 1
	BRA         L_Print_All251
	DECFSZ      R12, 1, 1
	BRA         L_Print_All251
	DECFSZ      R11, 1, 1
	BRA         L_Print_All251
	NOP
;SE9M.c,1574 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,1575 :: 		for (pebr = 0; pebr <= 9; pebr++) {
	CLRF        Print_All_pebr_L0+0 
L_Print_All252:
	MOVF        Print_All_pebr_L0+0, 0 
	SUBLW       9
	BTFSS       STATUS+0, 0 
	GOTO        L_Print_All253
;SE9M.c,1576 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1577 :: 		if ( (pebr == 1) || (pebr == 3) || (pebr == 5) || (pebr == 7) || (pebr == 9) ) {
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All355
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All355
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All355
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All355
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All355
	GOTO        L_Print_All257
L__Print_All355:
;SE9M.c,1578 :: 		tck1 = 1;
	MOVLW       1
	MOVWF       Print_All_tck1_L0+0 
;SE9M.c,1579 :: 		tck2 = 0;
	CLRF        Print_All_tck2_L0+0 
;SE9M.c,1580 :: 		} else {
	GOTO        L_Print_All258
L_Print_All257:
;SE9M.c,1581 :: 		tck1 = 0;
	CLRF        Print_All_tck1_L0+0 
;SE9M.c,1582 :: 		tck2 = 1;
	MOVLW       1
	MOVWF       Print_All_tck2_L0+0 
;SE9M.c,1583 :: 		}
L_Print_All258:
;SE9M.c,1584 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1585 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1586 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1587 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1588 :: 		PRINT_S(Print_Seg(pebr, tck1));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        Print_All_tck1_L0+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1589 :: 		PRINT_S(Print_Seg(pebr, tck2));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        Print_All_tck2_L0+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1590 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1591 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,1592 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_All259:
	DECFSZ      R13, 1, 1
	BRA         L_Print_All259
	DECFSZ      R12, 1, 1
	BRA         L_Print_All259
	DECFSZ      R11, 1, 1
	BRA         L_Print_All259
	NOP
;SE9M.c,1593 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,1575 :: 		for (pebr = 0; pebr <= 9; pebr++) {
	INCF        Print_All_pebr_L0+0, 1 
;SE9M.c,1594 :: 		}
	GOTO        L_Print_All252
L_Print_All253:
;SE9M.c,1595 :: 		}
L_end_Print_All:
	RETURN      0
; end of _Print_All

_Print_Pme:

;SE9M.c,1598 :: 		void Print_Pme() {
;SE9M.c,1599 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1600 :: 		PRINT_S(Print_Seg(14, 0));
	MOVLW       14
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1601 :: 		PRINT_S(Print_Seg(14, 0));
	MOVLW       14
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1602 :: 		PRINT_S(Print_Seg(13, 0));
	MOVLW       13
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1603 :: 		PRINT_S(Print_Seg(12, 0));
	MOVLW       12
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1604 :: 		PRINT_S(Print_Seg(11, 0));
	MOVLW       11
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1605 :: 		PRINT_S(Print_Seg(10, 0));
	MOVLW       10
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1606 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1607 :: 		}
L_end_Print_Pme:
	RETURN      0
; end of _Print_Pme

_Print_Light:

;SE9M.c,1610 :: 		void Print_Light() {
;SE9M.c,1611 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;SE9M.c,1612 :: 		light_res = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _light_res+0 
	MOVF        R1, 0 
	MOVWF       _light_res+1 
;SE9M.c,1613 :: 		result = light_res * 0.00322265625;  // scale adc result by 100000 (3.22mV/lsb => 3.3V / 1024 = 0.00322265625...V)
	CALL        _word2double+0, 0
	MOVLW       51
	MOVWF       R4 
	MOVLW       51
	MOVWF       R5 
	MOVLW       83
	MOVWF       R6 
	MOVLW       118
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _result+0 
	MOVF        R1, 0 
	MOVWF       _result+1 
	MOVF        R2, 0 
	MOVWF       _result+2 
	MOVF        R3, 0 
	MOVWF       _result+3 
;SE9M.c,1615 :: 		if (result <= 1.3) {                            // 1.1
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       102
	MOVWF       R0 
	MOVLW       102
	MOVWF       R1 
	MOVLW       38
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Print_Light260
;SE9M.c,1616 :: 		PWM1_Set_Duty(max_light);
	MOVF        _max_light+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,1617 :: 		}
L_Print_Light260:
;SE9M.c,1618 :: 		if ( (result > 1.3) && (result <= 2.3) ) {      // 1.1 - 2.2
	MOVF        _result+0, 0 
	MOVWF       R4 
	MOVF        _result+1, 0 
	MOVWF       R5 
	MOVF        _result+2, 0 
	MOVWF       R6 
	MOVF        _result+3, 0 
	MOVWF       R7 
	MOVLW       102
	MOVWF       R0 
	MOVLW       102
	MOVWF       R1 
	MOVLW       38
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Print_Light263
	MOVF        _result+0, 0 
	MOVWF       R4 
	MOVF        _result+1, 0 
	MOVWF       R5 
	MOVF        _result+2, 0 
	MOVWF       R6 
	MOVF        _result+3, 0 
	MOVWF       R7 
	MOVLW       51
	MOVWF       R0 
	MOVLW       51
	MOVWF       R1 
	MOVLW       19
	MOVWF       R2 
	MOVLW       128
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Print_Light263
L__Print_Light356:
;SE9M.c,1619 :: 		PWM1_Set_Duty((max_light*2)/3);
	MOVF        _max_light+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	RLCF        R1, 1 
	BCF         R0, 0 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,1620 :: 		}
L_Print_Light263:
;SE9M.c,1621 :: 		if (result > 2.3) {
	MOVF        _result+0, 0 
	MOVWF       R4 
	MOVF        _result+1, 0 
	MOVWF       R5 
	MOVF        _result+2, 0 
	MOVWF       R6 
	MOVF        _result+3, 0 
	MOVWF       R7 
	MOVLW       51
	MOVWF       R0 
	MOVLW       51
	MOVWF       R1 
	MOVLW       19
	MOVWF       R2 
	MOVLW       128
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Print_Light264
;SE9M.c,1622 :: 		PWM1_Set_Duty(max_light/3);                  // 2.2
	MOVLW       3
	MOVWF       R4 
	MOVF        _max_light+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,1623 :: 		}
L_Print_Light264:
;SE9M.c,1625 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,1626 :: 		}
L_end_Print_Light:
	RETURN      0
; end of _Print_Light

_Mem_Read:

;SE9M.c,1629 :: 		void Mem_Read() {
;SE9M.c,1631 :: 		MSSPEN  = 1;
	BSF         RE0_bit+0, BitPos(RE0_bit+0) 
;SE9M.c,1632 :: 		asm nop;
	NOP
;SE9M.c,1633 :: 		asm nop;
	NOP
;SE9M.c,1634 :: 		asm nop;
	NOP
;SE9M.c,1635 :: 		I2C1_Init(100000);
	MOVLW       80
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;SE9M.c,1636 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;SE9M.c,1637 :: 		I2C1_Wr(0xA2);
	MOVLW       162
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SE9M.c,1638 :: 		I2C1_Wr(0xFA);
	MOVLW       250
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SE9M.c,1639 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;SE9M.c,1640 :: 		I2C1_Wr(0xA3);
	MOVLW       163
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SE9M.c,1641 :: 		for(membr=0 ; membr<=4 ; membr++) {
	CLRF        Mem_Read_membr_L0+0 
L_Mem_Read265:
	MOVF        Mem_Read_membr_L0+0, 0 
	SUBLW       4
	BTFSS       STATUS+0, 0 
	GOTO        L_Mem_Read266
;SE9M.c,1642 :: 		macAddr[membr] = I2C1_Rd(1);
	MOVLW       _macAddr+0
	MOVWF       FLOC__Mem_Read+0 
	MOVLW       hi_addr(_macAddr+0)
	MOVWF       FLOC__Mem_Read+1 
	MOVF        Mem_Read_membr_L0+0, 0 
	ADDWF       FLOC__Mem_Read+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__Mem_Read+1, 1 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVFF       FLOC__Mem_Read+0, FSR1
	MOVFF       FLOC__Mem_Read+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,1641 :: 		for(membr=0 ; membr<=4 ; membr++) {
	INCF        Mem_Read_membr_L0+0, 1 
;SE9M.c,1643 :: 		}
	GOTO        L_Mem_Read265
L_Mem_Read266:
;SE9M.c,1644 :: 		macAddr[5] = I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _macAddr+5 
;SE9M.c,1645 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;SE9M.c,1646 :: 		MSSPEN  = 0;
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;SE9M.c,1647 :: 		asm nop;
	NOP
;SE9M.c,1648 :: 		asm nop;
	NOP
;SE9M.c,1649 :: 		asm nop;
	NOP
;SE9M.c,1651 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;SE9M.c,1652 :: 		}
L_end_Mem_Read:
	RETURN      0
; end of _Mem_Read

_main:

;SE9M.c,1657 :: 		void main() {
;SE9M.c,1659 :: 		TRISA = 0b00000001;
	MOVLW       1
	MOVWF       TRISA+0 
;SE9M.c,1660 :: 		PORTA = 0;
	CLRF        PORTA+0 
;SE9M.c,1661 :: 		TRISB = 0;
	CLRF        TRISB+0 
;SE9M.c,1662 :: 		PORTB = 0;
	CLRF        PORTB+0 
;SE9M.c,1663 :: 		TRISC = 0;
	CLRF        TRISC+0 
;SE9M.c,1664 :: 		PORTC = 0;
	CLRF        PORTC+0 
;SE9M.c,1666 :: 		Com_En_Direction = 0;
	BCF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;SE9M.c,1667 :: 		Com_En = 1;
	BSF         RB0_bit+0, BitPos(RB0_bit+0) 
;SE9M.c,1669 :: 		Kom_En_1_Direction = 0;
	BCF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;SE9M.c,1670 :: 		Kom_En_1 = 1;
	BSF         RB1_bit+0, BitPos(RB1_bit+0) 
;SE9M.c,1672 :: 		Kom_En_2_Direction = 0;
	BCF         TRISB3_bit+0, BitPos(TRISB3_bit+0) 
;SE9M.c,1673 :: 		Kom_En_2 = 0;
	BCF         RB3_bit+0, BitPos(RB3_bit+0) 
;SE9M.c,1675 :: 		Eth1_Link_Direction = 1;
	BSF         TRISB5_bit+0, BitPos(TRISB5_bit+0) 
;SE9M.c,1677 :: 		Net_Ethernet_28j60_Rst_Direction = 0;
	BCF         TRISA5_bit+0, BitPos(TRISA5_bit+0) 
;SE9M.c,1678 :: 		Net_Ethernet_28j60_Rst = 0;
	BCF         LATA5_bit+0, BitPos(LATA5_bit+0) 
;SE9M.c,1679 :: 		Net_Ethernet_28j60_CS_Direction  = 0;
	BCF         TRISA4_bit+0, BitPos(TRISA4_bit+0) 
;SE9M.c,1680 :: 		Net_Ethernet_28j60_CS  = 0;
	BCF         LATA4_bit+0, BitPos(LATA4_bit+0) 
;SE9M.c,1682 :: 		RSTPIN_Direction = 1;
	BSF         TRISD4_bit+0, BitPos(TRISD4_bit+0) 
;SE9M.c,1684 :: 		DISPEN_Direction = 0;
	BCF         TRISE2_bit+0, BitPos(TRISE2_bit+0) 
;SE9M.c,1685 :: 		DISPEN = 0;
	BCF         RE2_bit+0, BitPos(RE2_bit+0) 
;SE9M.c,1687 :: 		MSSPEN_Direction = 0;
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;SE9M.c,1688 :: 		MSSPEN = 0;
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;SE9M.c,1690 :: 		SV_DATA_Direction = 0;
	BCF         TRISA1_bit+0, BitPos(TRISA1_bit+0) 
;SE9M.c,1691 :: 		SV_DATA = 0;
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;SE9M.c,1692 :: 		SV_CLK_Direction = 0;
	BCF         TRISA2_bit+0, BitPos(TRISA2_bit+0) 
;SE9M.c,1693 :: 		SV_CLK = 0;
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
;SE9M.c,1694 :: 		STROBE_Direction = 0;
	BCF         TRISA3_bit+0, BitPos(TRISA3_bit+0) 
;SE9M.c,1695 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1697 :: 		BCKL_Direction = 0;
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;SE9M.c,1698 :: 		BCKL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;SE9M.c,1700 :: 		ANSEL = 0;
	CLRF        ANSEL+0 
;SE9M.c,1701 :: 		ANSELH = 0;
	CLRF        ANSELH+0 
;SE9M.c,1703 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;SE9M.c,1704 :: 		ADCON1 = 0b00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;SE9M.c,1706 :: 		max_light = 180;
	MOVLW       180
	MOVWF       _max_light+0 
;SE9M.c,1707 :: 		min_light = 30;
	MOVLW       30
	MOVWF       _min_light+0 
;SE9M.c,1709 :: 		PWM1_Init(2000);
	BSF         T2CON+0, 0, 0
	BSF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;SE9M.c,1710 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;SE9M.c,1711 :: 		PWM1_Set_Duty(max_light);      // 90
	MOVF        _max_light+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,1714 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       3
	MOVWF       SPBRGH+0 
	MOVLW       64
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;SE9M.c,1715 :: 		PIE1.RCIE = 1;
	BSF         PIE1+0, 5 
;SE9M.c,1716 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;SE9M.c,1717 :: 		PEIE_bit = 1;
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;SE9M.c,1718 :: 		InitTimer1();
	CALL        _InitTimer1+0, 0
;SE9M.c,1720 :: 		T0CON = 0b11000000 ;
	MOVLW       192
	MOVWF       T0CON+0 
;SE9M.c,1721 :: 		INTCON.TMR0IF = 0 ;
	BCF         INTCON+0, 2 
;SE9M.c,1722 :: 		INTCON.TMR0IE = 1 ;
	BSF         INTCON+0, 5 
;SE9M.c,1723 :: 		Net_Ethernet_28j60_stackInitTCP();
	CALL        _Net_Ethernet_28j60_stackInitTCP+0, 0
;SE9M.c,1725 :: 		while(1) {
L_main268:
;SE9M.c,1727 :: 		pom_time_pom = EEPROM_Read(0);
	CLRF        FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pom_time_pom+0 
;SE9M.c,1729 :: 		if ( (pom_time_pom != 0xAA) || (rst_fab == 1) ) {
	MOVF        R0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L__main363
	MOVF        _rst_fab+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__main363
	GOTO        L_main272
L__main363:
;SE9M.c,1731 :: 		conf.dhcpen = 1;
	MOVLW       1
	MOVWF       _conf+0 
;SE9M.c,1732 :: 		EEPROM_Write(103, conf.dhcpen);
	MOVLW       103
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1733 :: 		mode = 1;
	MOVLW       1
	MOVWF       _mode+0 
;SE9M.c,1734 :: 		EEPROM_Write(104, mode);
	MOVLW       104
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1735 :: 		dhcp_flag = 0;
	CLRF        _dhcp_flag+0 
;SE9M.c,1736 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1738 :: 		strcpy(sifra, "adminpme");
	MOVLW       _sifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr54_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr54_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1739 :: 		for (j=0;j<=8;j++) {
	CLRF        _j+0 
L_main273:
	MOVF        _j+0, 0 
	SUBLW       8
	BTFSS       STATUS+0, 0 
	GOTO        L_main274
;SE9M.c,1740 :: 		EEPROM_Write(j+20, sifra[j]);
	MOVLW       20
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Write_address+1, 1 
	MOVLW       _sifra+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FSR0H 
	MOVF        _j+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1739 :: 		for (j=0;j<=8;j++) {
	INCF        _j+0, 1 
;SE9M.c,1741 :: 		}
	GOTO        L_main273
L_main274:
;SE9M.c,1743 :: 		strcpy(server1, "swisstime.ethz.ch");
	MOVLW       _server1+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_server1+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr55_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr55_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1744 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main276:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main277
;SE9M.c,1745 :: 		EEPROM_Write(j+29, server1[j]);
	MOVLW       29
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Write_address+1, 1 
	MOVLW       _server1+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_server1+0)
	MOVWF       FSR0H 
	MOVF        _j+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1744 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,1746 :: 		}
	GOTO        L_main276
L_main277:
;SE9M.c,1747 :: 		strcpy(server2, "0.rs.pool.ntp.org");
	MOVLW       _server2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_server2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr56_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr56_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1748 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main279:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main280
;SE9M.c,1749 :: 		EEPROM_Write(j+56, server2[j]);
	MOVLW       56
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Write_address+1, 1 
	MOVLW       _server2+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_server2+0)
	MOVWF       FSR0H 
	MOVF        _j+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1748 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,1750 :: 		}
	GOTO        L_main279
L_main280:
;SE9M.c,1751 :: 		strcpy(server3, "pool.ntp.org");
	MOVLW       _server3+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_server3+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr57_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr57_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1752 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main282:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main283
;SE9M.c,1753 :: 		EEPROM_Write(j+110, server3[j]);
	MOVLW       110
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Write_address+1, 1 
	MOVLW       _server3+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_server3+0)
	MOVWF       FSR0H 
	MOVF        _j+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1752 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,1754 :: 		}
	GOTO        L_main282
L_main283:
;SE9M.c,1760 :: 		ipAddr[0]    = 192;
	MOVLW       192
	MOVWF       _ipAddr+0 
;SE9M.c,1761 :: 		ipAddr[1]    = 168;
	MOVLW       168
	MOVWF       _ipAddr+1 
;SE9M.c,1762 :: 		ipAddr[2]    = 1;
	MOVLW       1
	MOVWF       _ipAddr+2 
;SE9M.c,1763 :: 		ipAddr[3]    = 99;
	MOVLW       99
	MOVWF       _ipAddr+3 
;SE9M.c,1764 :: 		gwIpAddr[0]  = 192;
	MOVLW       192
	MOVWF       _gwIpAddr+0 
;SE9M.c,1765 :: 		gwIpAddr[1]  = 168;
	MOVLW       168
	MOVWF       _gwIpAddr+1 
;SE9M.c,1766 :: 		gwIpAddr[2]  = 1;
	MOVLW       1
	MOVWF       _gwIpAddr+2 
;SE9M.c,1767 :: 		gwIpAddr[3]  = 1;
	MOVLW       1
	MOVWF       _gwIpAddr+3 
;SE9M.c,1768 :: 		ipMask[0]    = 255;
	MOVLW       255
	MOVWF       _ipMask+0 
;SE9M.c,1769 :: 		ipMask[1]    = 255;
	MOVLW       255
	MOVWF       _ipMask+1 
;SE9M.c,1770 :: 		ipMask[2]    = 255;
	MOVLW       255
	MOVWF       _ipMask+2 
;SE9M.c,1771 :: 		ipMask[3]    = 0;
	CLRF        _ipMask+3 
;SE9M.c,1772 :: 		dnsIpAddr[0] = 192;
	MOVLW       192
	MOVWF       _dnsIpAddr+0 
;SE9M.c,1773 :: 		dnsIpAddr[1] = 168;
	MOVLW       168
	MOVWF       _dnsIpAddr+1 
;SE9M.c,1774 :: 		dnsIpAddr[2] = 1;
	MOVLW       1
	MOVWF       _dnsIpAddr+2 
;SE9M.c,1775 :: 		dnsIpAddr[3] = 1;
	MOVLW       1
	MOVWF       _dnsIpAddr+3 
;SE9M.c,1778 :: 		EEPROM_Write(1, ipAddr[0]);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1779 :: 		EEPROM_Write(2, ipAddr[1]);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1780 :: 		EEPROM_Write(3, ipAddr[2]);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1781 :: 		EEPROM_Write(4, ipAddr[3]);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1782 :: 		EEPROM_Write(5, gwIpAddr[0]);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1783 :: 		EEPROM_Write(6, gwIpAddr[1]);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1784 :: 		EEPROM_Write(7, gwIpAddr[2]);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1785 :: 		EEPROM_Write(8, gwIpAddr[3]);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1786 :: 		EEPROM_Write(9, ipMask[0]);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1787 :: 		EEPROM_Write(10, ipMask[1]);
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1788 :: 		EEPROM_Write(11, ipMask[2]);
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1789 :: 		EEPROM_Write(12, ipMask[3]);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1790 :: 		EEPROM_Write(13, dnsIpAddr[0]);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1791 :: 		EEPROM_Write(14, dnsIpAddr[1]);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1792 :: 		EEPROM_Write(15, dnsIpAddr[2]);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1793 :: 		EEPROM_Write(16, dnsIpAddr[3]);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1795 :: 		ByteToStr(ipAddr[0], IpAddrPom0);
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1796 :: 		ByteToStr(ipAddr[1], IpAddrPom1);
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1797 :: 		ByteToStr(ipAddr[2], IpAddrPom2);
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1798 :: 		ByteToStr(ipAddr[3], IpAddrPom3);
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1800 :: 		ByteToStr(gwIpAddr[0], gwIpAddrPom0);
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1801 :: 		ByteToStr(gwIpAddr[1], gwIpAddrPom1);
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1802 :: 		ByteToStr(gwIpAddr[2], gwIpAddrPom2);
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1803 :: 		ByteToStr(gwIpAddr[3], gwIpAddrPom3);
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1805 :: 		ByteToStr(ipMask[0], ipMaskPom0);
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1806 :: 		ByteToStr(ipMask[1], ipMaskPom1);
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1807 :: 		ByteToStr(ipMask[2], ipMaskPom2);
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1808 :: 		ByteToStr(ipMask[3], ipMaskPom3);
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1810 :: 		ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1811 :: 		ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1812 :: 		ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1813 :: 		ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1815 :: 		rst_fab = 0;
	CLRF        _rst_fab+0 
;SE9M.c,1816 :: 		pom_time_pom = 0xAA;
	MOVLW       170
	MOVWF       _pom_time_pom+0 
;SE9M.c,1817 :: 		EEPROM_Write(0, pom_time_pom);
	CLRF        FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       170
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1818 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main285:
	DECFSZ      R13, 1, 1
	BRA         L_main285
	DECFSZ      R12, 1, 1
	BRA         L_main285
	DECFSZ      R11, 1, 1
	BRA         L_main285
;SE9M.c,1819 :: 		}
L_main272:
;SE9M.c,1821 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,1823 :: 		sifra[0]    = EEPROM_Read(20);
	MOVLW       20
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+0 
;SE9M.c,1824 :: 		sifra[1]    = EEPROM_Read(21);
	MOVLW       21
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+1 
;SE9M.c,1825 :: 		sifra[2]    = EEPROM_Read(22);
	MOVLW       22
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+2 
;SE9M.c,1826 :: 		sifra[3]    = EEPROM_Read(23);
	MOVLW       23
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+3 
;SE9M.c,1827 :: 		sifra[4]    = EEPROM_Read(24);
	MOVLW       24
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+4 
;SE9M.c,1828 :: 		sifra[5]    = EEPROM_Read(25);
	MOVLW       25
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+5 
;SE9M.c,1829 :: 		sifra[6]    = EEPROM_Read(26);
	MOVLW       26
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+6 
;SE9M.c,1830 :: 		sifra[7]    = EEPROM_Read(27);
	MOVLW       27
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+7 
;SE9M.c,1831 :: 		sifra[8]    = EEPROM_Read(28);
	MOVLW       28
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+8 
;SE9M.c,1833 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main286:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main287
;SE9M.c,1834 :: 		server1[j] = EEPROM_Read(j+29);
	MOVLW       _server1+0
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_server1+0)
	MOVWF       FLOC__main+1 
	MOVF        _j+0, 0 
	ADDWF       FLOC__main+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__main+1, 1 
	MOVLW       29
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Read_address+1, 1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,1833 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,1835 :: 		}
	GOTO        L_main286
L_main287:
;SE9M.c,1836 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main289:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main290
;SE9M.c,1837 :: 		server2[j] = EEPROM_Read(j+56);
	MOVLW       _server2+0
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_server2+0)
	MOVWF       FLOC__main+1 
	MOVF        _j+0, 0 
	ADDWF       FLOC__main+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__main+1, 1 
	MOVLW       56
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Read_address+1, 1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,1836 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,1838 :: 		}
	GOTO        L_main289
L_main290:
;SE9M.c,1839 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main292:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main293
;SE9M.c,1840 :: 		server3[j] = EEPROM_Read(j+110);
	MOVLW       _server3+0
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_server3+0)
	MOVWF       FLOC__main+1 
	MOVF        _j+0, 0 
	ADDWF       FLOC__main+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__main+1, 1 
	MOVLW       110
	ADDWF       _j+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	MOVLW       0
	ADDWFC      FARG_EEPROM_Read_address+1, 1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,1839 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,1841 :: 		}
	GOTO        L_main292
L_main293:
;SE9M.c,1843 :: 		ipAddr[0]    = EEPROM_Read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+0 
;SE9M.c,1844 :: 		ipAddr[1]    = EEPROM_Read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+1 
;SE9M.c,1845 :: 		ipAddr[2]    = EEPROM_Read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+2 
;SE9M.c,1846 :: 		ipAddr[3]    = EEPROM_Read(4);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+3 
;SE9M.c,1847 :: 		gwIpAddr[0]  = EEPROM_Read(5);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+0 
;SE9M.c,1848 :: 		gwIpAddr[1]  = EEPROM_Read(6);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+1 
;SE9M.c,1849 :: 		gwIpAddr[2]  = EEPROM_Read(7);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+2 
;SE9M.c,1850 :: 		gwIpAddr[3]  = EEPROM_Read(8);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+3 
;SE9M.c,1851 :: 		ipMask[0]    = EEPROM_Read(9);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+0 
;SE9M.c,1852 :: 		ipMask[1]    = EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+1 
;SE9M.c,1853 :: 		ipMask[2]    = EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+2 
;SE9M.c,1854 :: 		ipMask[3]    = EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+3 
;SE9M.c,1855 :: 		dnsIpAddr[0] = EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+0 
;SE9M.c,1856 :: 		dnsIpAddr[1] = EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+1 
;SE9M.c,1857 :: 		dnsIpAddr[2] = EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+2 
;SE9M.c,1858 :: 		dnsIpAddr[3] = EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+3 
;SE9M.c,1861 :: 		if (prolaz == 1) {
	MOVF        _prolaz+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main295
;SE9M.c,1862 :: 		ByteToStr(ipAddr[0], IpAddrPom0);
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1863 :: 		ByteToStr(ipAddr[1], IpAddrPom1);
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1864 :: 		ByteToStr(ipAddr[2], IpAddrPom2);
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1865 :: 		ByteToStr(ipAddr[3], IpAddrPom3);
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1867 :: 		ByteToStr(gwIpAddr[0], gwIpAddrPom0);
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1868 :: 		ByteToStr(gwIpAddr[1], gwIpAddrPom1);
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1869 :: 		ByteToStr(gwIpAddr[2], gwIpAddrPom2);
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1870 :: 		ByteToStr(gwIpAddr[3], gwIpAddrPom3);
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1872 :: 		ByteToStr(ipMask[0], ipMaskPom0);
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1873 :: 		ByteToStr(ipMask[1], ipMaskPom1);
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1874 :: 		ByteToStr(ipMask[2], ipMaskPom2);
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1875 :: 		ByteToStr(ipMask[3], ipMaskPom3);
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1877 :: 		ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1878 :: 		ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1879 :: 		ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1880 :: 		ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1882 :: 		prolaz = 0;
	CLRF        _prolaz+0 
;SE9M.c,1883 :: 		Print_All();
	CALL        _Print_All+0, 0
;SE9M.c,1884 :: 		}
L_main295:
;SE9M.c,1886 :: 		conf.tz = EEPROM_Read(102);
	MOVLW       102
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+2 
;SE9M.c,1887 :: 		conf.dhcpen = EEPROM_Read(103);
	MOVLW       103
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+0 
;SE9M.c,1888 :: 		mode = EEPROM_Read(104);
	MOVLW       104
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _mode+0 
;SE9M.c,1889 :: 		dhcp_flag = EEPROM_Read(105);
	MOVLW       105
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dhcp_flag+0 
;SE9M.c,1891 :: 		if ( (conf.dhcpen == 0) && (dhcp_flag == 1) ) {
	MOVF        _conf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main298
	MOVF        _dhcp_flag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main298
L__main362:
;SE9M.c,1892 :: 		conf.dhcpen = 1;
	MOVLW       1
	MOVWF       _conf+0 
;SE9M.c,1893 :: 		EEPROM_Write(103, conf.dhcpen);
	MOVLW       103
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1894 :: 		dhcp_flag = 0;
	CLRF        _dhcp_flag+0 
;SE9M.c,1895 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1896 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main299:
	DECFSZ      R13, 1, 1
	BRA         L_main299
	DECFSZ      R12, 1, 1
	BRA         L_main299
	DECFSZ      R11, 1, 1
	BRA         L_main299
;SE9M.c,1897 :: 		}
L_main298:
;SE9M.c,1899 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,1901 :: 		if (reset_eth == 1) {
	MOVF        _reset_eth+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main300
;SE9M.c,1902 :: 		reset_eth = 0;
	CLRF        _reset_eth+0 
;SE9M.c,1903 :: 		prvi_timer = 1;
	MOVLW       1
	MOVWF       _prvi_timer+0 
;SE9M.c,1904 :: 		drugi_timer = 0;
	CLRF        _drugi_timer+0 
;SE9M.c,1905 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,1906 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,1908 :: 		modeChange = 0;
	CLRF        _modeChange+0 
;SE9M.c,1910 :: 		}
L_main300:
;SE9M.c,1911 :: 		if ( (prvi_timer == 1) && (timer_flag >= 1) ) {
	MOVF        _prvi_timer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main303
	MOVLW       1
	SUBWF       _timer_flag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main303
L__main361:
;SE9M.c,1912 :: 		prvi_timer = 0;
	CLRF        _prvi_timer+0 
;SE9M.c,1913 :: 		drugi_timer = 1;
	MOVLW       1
	MOVWF       _drugi_timer+0 
;SE9M.c,1914 :: 		Net_Ethernet_28j60_Rst = 1;
	BSF         LATA5_bit+0, BitPos(LATA5_bit+0) 
;SE9M.c,1915 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,1916 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,1917 :: 		}
L_main303:
;SE9M.c,1918 :: 		if ( (drugi_timer == 1) && (timer_flag >= 1) ) {
	MOVF        _drugi_timer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main306
	MOVLW       1
	SUBWF       _timer_flag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main306
L__main360:
;SE9M.c,1919 :: 		prvi_timer = 0;
	CLRF        _prvi_timer+0 
;SE9M.c,1920 :: 		drugi_timer = 0;
	CLRF        _drugi_timer+0 
;SE9M.c,1921 :: 		link_enable = 1;
	MOVLW       1
	MOVWF       _link_enable+0 
;SE9M.c,1922 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,1923 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,1924 :: 		}
L_main306:
;SE9M.c,1925 :: 		if ( (Eth1_Link == 0) && (link == 0) && (link_enable == 1) ) {
	BTFSC       RB5_bit+0, BitPos(RB5_bit+0) 
	GOTO        L_main309
	MOVF        _link+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main309
	MOVF        _link_enable+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main309
L__main359:
;SE9M.c,1926 :: 		link = 1;
	MOVLW       1
	MOVWF       _link+0 
;SE9M.c,1927 :: 		tacka1 = 1;
	MOVLW       1
	MOVWF       _tacka1+0 
;SE9M.c,1928 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,1930 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;SE9M.c,1931 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,1932 :: 		if (conf.dhcpen == 0) {
	MOVF        _conf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main310
;SE9M.c,1933 :: 		Mem_Read();
	CALL        _Mem_Read+0, 0
;SE9M.c,1934 :: 		ipAddr[0] = 0;
	CLRF        _ipAddr+0 
;SE9M.c,1935 :: 		ipAddr[1] = 0;
	CLRF        _ipAddr+1 
;SE9M.c,1936 :: 		ipAddr[2] = 0;
	CLRF        _ipAddr+2 
;SE9M.c,1937 :: 		ipAddr[3] = 0;
	CLRF        _ipAddr+3 
;SE9M.c,1939 :: 		dhcp_flag = 1;
	MOVLW       1
	MOVWF       _dhcp_flag+0 
;SE9M.c,1940 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1942 :: 		Net_Ethernet_28j60_Init(macAddr, ipAddr, Net_Ethernet_28j60_FULLDUPLEX) ;
	MOVLW       _macAddr+0
	MOVWF       FARG_Net_Ethernet_28j60_Init_mac+0 
	MOVLW       hi_addr(_macAddr+0)
	MOVWF       FARG_Net_Ethernet_28j60_Init_mac+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_Net_Ethernet_28j60_Init_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_Net_Ethernet_28j60_Init_ip+1 
	MOVLW       1
	MOVWF       FARG_Net_Ethernet_28j60_Init_fullDuplex+0 
	CALL        _Net_Ethernet_28j60_Init+0, 0
;SE9M.c,1944 :: 		while (Net_Ethernet_28j60_initDHCP(5) == 0) ; // try to get one from DHCP until it works
L_main311:
	MOVLW       5
	MOVWF       FARG_Net_Ethernet_28j60_initDHCP_tmax+0 
	CALL        _Net_Ethernet_28j60_initDHCP+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main312
	GOTO        L_main311
L_main312:
;SE9M.c,1945 :: 		memcpy(ipAddr,    Net_Ethernet_28j60_getIpAddress(),    4) ; // get assigned IP address
	CALL        _Net_Ethernet_28j60_getIpAddress+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        R1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,1946 :: 		memcpy(ipMask,    Net_Ethernet_28j60_getIpMask(),       4) ; // get assigned IP mask
	CALL        _Net_Ethernet_28j60_getIpMask+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        R1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       _ipMask+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_ipMask+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,1947 :: 		memcpy(gwIpAddr,  Net_Ethernet_28j60_getGwIpAddress(),  4) ; // get assigned gateway IP address
	CALL        _Net_Ethernet_28j60_getGwIpAddress+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        R1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       _gwIpAddr+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_gwIpAddr+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,1948 :: 		memcpy(dnsIpAddr, Net_Ethernet_28j60_getDnsIpAddress(), 4) ; // get assigned dns IP address
	CALL        _Net_Ethernet_28j60_getDnsIpAddress+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVF        R1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       _dnsIpAddr+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_dnsIpAddr+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;SE9M.c,1950 :: 		lease_tmr = 1;
	MOVLW       1
	MOVWF       _lease_tmr+0 
;SE9M.c,1951 :: 		lease_time = 0;
	CLRF        _lease_time+0 
;SE9M.c,1953 :: 		EEPROM_Write(1, ipAddr[0]);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1954 :: 		EEPROM_Write(2, ipAddr[1]);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1955 :: 		EEPROM_Write(3, ipAddr[2]);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1956 :: 		EEPROM_Write(4, ipAddr[3]);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1957 :: 		EEPROM_Write(5, gwIpAddr[0]);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1958 :: 		EEPROM_Write(6, gwIpAddr[1]);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1959 :: 		EEPROM_Write(7, gwIpAddr[2]);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1960 :: 		EEPROM_Write(8, gwIpAddr[3]);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1961 :: 		EEPROM_Write(9, ipMask[0]);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1962 :: 		EEPROM_Write(10, ipMask[1]);
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1963 :: 		EEPROM_Write(11, ipMask[2]);
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1964 :: 		EEPROM_Write(12, ipMask[3]);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1965 :: 		EEPROM_Write(13, dnsIpAddr[0]);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1966 :: 		EEPROM_Write(14, dnsIpAddr[1]);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1967 :: 		EEPROM_Write(15, dnsIpAddr[2]);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1968 :: 		EEPROM_Write(16, dnsIpAddr[3]);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1970 :: 		ByteToStr(ipAddr[0], IpAddrPom0);
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1971 :: 		ByteToStr(ipAddr[1], IpAddrPom1);
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1972 :: 		ByteToStr(ipAddr[2], IpAddrPom2);
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1973 :: 		ByteToStr(ipAddr[3], IpAddrPom3);
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1975 :: 		ByteToStr(gwIpAddr[0], gwIpAddrPom0);
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1976 :: 		ByteToStr(gwIpAddr[1], gwIpAddrPom1);
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1977 :: 		ByteToStr(gwIpAddr[2], gwIpAddrPom2);
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1978 :: 		ByteToStr(gwIpAddr[3], gwIpAddrPom3);
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1980 :: 		ByteToStr(ipMask[0], ipMaskPom0);
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1981 :: 		ByteToStr(ipMask[1], ipMaskPom1);
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1982 :: 		ByteToStr(ipMask[2], ipMaskPom2);
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1983 :: 		ByteToStr(ipMask[3], ipMaskPom3);
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1985 :: 		ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1986 :: 		ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1987 :: 		ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1988 :: 		ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1990 :: 		dhcp_flag = 0;
	CLRF        _dhcp_flag+0 
;SE9M.c,1991 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1993 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main313:
	DECFSZ      R13, 1, 1
	BRA         L_main313
	DECFSZ      R12, 1, 1
	BRA         L_main313
	DECFSZ      R11, 1, 1
	BRA         L_main313
;SE9M.c,1994 :: 		Print_IP();
	CALL        _Print_IP+0, 0
;SE9M.c,1996 :: 		modeChange = 0;
	CLRF        _modeChange+0 
;SE9M.c,1999 :: 		}
L_main310:
;SE9M.c,2000 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main314
;SE9M.c,2001 :: 		lease_tmr = 0;
	CLRF        _lease_tmr+0 
;SE9M.c,2002 :: 		Mem_Read();
	CALL        _Mem_Read+0, 0
;SE9M.c,2003 :: 		Net_Ethernet_28j60_Init(macAddr, ipAddr, Net_Ethernet_28j60_FULLDUPLEX) ;
	MOVLW       _macAddr+0
	MOVWF       FARG_Net_Ethernet_28j60_Init_mac+0 
	MOVLW       hi_addr(_macAddr+0)
	MOVWF       FARG_Net_Ethernet_28j60_Init_mac+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_Net_Ethernet_28j60_Init_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_Net_Ethernet_28j60_Init_ip+1 
	MOVLW       1
	MOVWF       FARG_Net_Ethernet_28j60_Init_fullDuplex+0 
	CALL        _Net_Ethernet_28j60_Init+0, 0
;SE9M.c,2004 :: 		Net_Ethernet_28j60_confNetwork(ipMask, gwIpAddr, dnsIpAddr) ;
	MOVLW       _ipMask+0
	MOVWF       FARG_Net_Ethernet_28j60_confNetwork_ipMask+0 
	MOVLW       hi_addr(_ipMask+0)
	MOVWF       FARG_Net_Ethernet_28j60_confNetwork_ipMask+1 
	MOVLW       _gwIpAddr+0
	MOVWF       FARG_Net_Ethernet_28j60_confNetwork_gwIpAddr+0 
	MOVLW       hi_addr(_gwIpAddr+0)
	MOVWF       FARG_Net_Ethernet_28j60_confNetwork_gwIpAddr+1 
	MOVLW       _dnsIpAddr+0
	MOVWF       FARG_Net_Ethernet_28j60_confNetwork_dnsIpAddr+0 
	MOVLW       hi_addr(_dnsIpAddr+0)
	MOVWF       FARG_Net_Ethernet_28j60_confNetwork_dnsIpAddr+1 
	CALL        _Net_Ethernet_28j60_confNetwork+0, 0
;SE9M.c,2005 :: 		Print_IP();
	CALL        _Print_IP+0, 0
;SE9M.c,2007 :: 		modeChange = 0;
	CLRF        _modeChange+0 
;SE9M.c,2010 :: 		}
L_main314:
;SE9M.c,2011 :: 		tacka1 = 0;
	CLRF        _tacka1+0 
;SE9M.c,2012 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2014 :: 		}
L_main309:
;SE9M.c,2017 :: 		if (Eth1_Link == 1) {
	BTFSS       RB5_bit+0, BitPos(RB5_bit+0) 
	GOTO        L_main315
;SE9M.c,2018 :: 		link = 0;
	CLRF        _link+0 
;SE9M.c,2019 :: 		lastSync = 0;
	CLRF        _lastSync+0 
	CLRF        _lastSync+1 
	CLRF        _lastSync+2 
	CLRF        _lastSync+3 
;SE9M.c,2020 :: 		}
L_main315:
;SE9M.c,2022 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2025 :: 		if (req_tmr_3 == 12) {
	MOVF        _req_tmr_3+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_main316
;SE9M.c,2026 :: 		sntpSync = 0;
	CLRF        _sntpSync+0 
;SE9M.c,2027 :: 		req_tmr_1 = 0;
	CLRF        _req_tmr_1+0 
;SE9M.c,2028 :: 		req_tmr_2 = 0;
	CLRF        _req_tmr_2+0 
;SE9M.c,2029 :: 		req_tmr_3 = 0;
	CLRF        _req_tmr_3+0 
;SE9M.c,2030 :: 		}
L_main316:
;SE9M.c,2033 :: 		if (RSTPIN == 0) {
	BTFSC       RD4_bit+0, BitPos(RD4_bit+0) 
	GOTO        L_main317
;SE9M.c,2034 :: 		rst_fab_tmr = 1;
	MOVLW       1
	MOVWF       _rst_fab_tmr+0 
;SE9M.c,2035 :: 		} else {
	GOTO        L_main318
L_main317:
;SE9M.c,2036 :: 		rst_fab_tmr = 0;
	CLRF        _rst_fab_tmr+0 
;SE9M.c,2037 :: 		rst_fab_flag = 0;
	CLRF        _rst_fab_flag+0 
;SE9M.c,2038 :: 		}
L_main318:
;SE9M.c,2039 :: 		if (rst_fab_flag >= 5) {
	MOVLW       5
	SUBWF       _rst_fab_flag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main319
;SE9M.c,2040 :: 		rst_fab_tmr = 0;
	CLRF        _rst_fab_tmr+0 
;SE9M.c,2041 :: 		rst_fab_flag = 0;
	CLRF        _rst_fab_flag+0 
;SE9M.c,2042 :: 		rst_fab = 1;
	MOVLW       1
	MOVWF       _rst_fab+0 
;SE9M.c,2043 :: 		Rst_Eth();
	CALL        _Rst_Eth+0, 0
;SE9M.c,2044 :: 		}
L_main319:
;SE9M.c,2046 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2049 :: 		if (komgotovo == 1) {
	MOVF        _komgotovo+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main320
;SE9M.c,2050 :: 		komgotovo = 0;
	CLRF        _komgotovo+0 
;SE9M.c,2051 :: 		chksum = (comand[3] ^ comand[4] ^ comand[5] ^ comand[6] ^ comand[7] ^comand[8] ^ comand[9] ^ comand[10] ^ comand[11]) & 0x7F;
	MOVF        _comand+4, 0 
	XORWF       _comand+3, 0 
	MOVWF       _chksum+0 
	MOVF        _comand+5, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+6, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+7, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+8, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+9, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+10, 0 
	XORWF       _chksum+0, 1 
	MOVF        _comand+11, 0 
	XORWF       _chksum+0, 1 
	MOVLW       127
	ANDWF       _chksum+0, 1 
;SE9M.c,2052 :: 		if ((comand[0] == 0xAA) && (comand[1] == 0xAA) && (comand[2] == 0xAA) && (comand[12] == chksum) && (comand[13] == 0xBB) && (link_enable == 1)) {
	MOVF        _comand+0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main323
	MOVF        _comand+1, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main323
	MOVF        _comand+2, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main323
	MOVF        _comand+12, 0 
	XORWF       _chksum+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main323
	MOVF        _comand+13, 0 
	XORLW       187
	BTFSS       STATUS+0, 2 
	GOTO        L_main323
	MOVF        _link_enable+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main323
L__main358:
;SE9M.c,2053 :: 		sati = comand[3];
	MOVF        _comand+3, 0 
	MOVWF       _sati+0 
;SE9M.c,2054 :: 		minuti = comand[4];
	MOVF        _comand+4, 0 
	MOVWF       _minuti+0 
;SE9M.c,2055 :: 		sekundi = comand[5];
	MOVF        _comand+5, 0 
	MOVWF       _sekundi+0 
;SE9M.c,2056 :: 		dan = comand[6];
	MOVF        _comand+6, 0 
	MOVWF       _dan+0 
;SE9M.c,2057 :: 		mesec = comand[7];
	MOVF        _comand+7, 0 
	MOVWF       _mesec+0 
;SE9M.c,2058 :: 		fingodina = comand[8];
	MOVF        _comand+8, 0 
	MOVWF       _fingodina+0 
;SE9M.c,2059 :: 		notime = 0;
	CLRF        _notime+0 
;SE9M.c,2060 :: 		notime_ovf = 0;
	CLRF        _notime_ovf+0 
;SE9M.c,2061 :: 		}
L_main323:
;SE9M.c,2062 :: 		}
L_main320:
;SE9M.c,2064 :: 		if (pom_mat_sek != sekundi) {
	MOVF        _pom_mat_sek+0, 0 
	XORWF       _sekundi+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main324
;SE9M.c,2065 :: 		pom_mat_sek = sekundi;
	MOVF        _sekundi+0, 0 
	MOVWF       _pom_mat_sek+0 
;SE9M.c,2066 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2068 :: 		if (disp_mode == 1) {
	MOVF        _disp_mode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main325
;SE9M.c,2069 :: 		tacka2 = 0;
	CLRF        _tacka2+0 
;SE9M.c,2070 :: 		if (tacka1 == 0) {
	MOVF        _tacka1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main326
;SE9M.c,2071 :: 		tacka1 = 1;
	MOVLW       1
	MOVWF       _tacka1+0 
;SE9M.c,2072 :: 		goto DALJE2;
	GOTO        ___main_DALJE2
;SE9M.c,2073 :: 		}
L_main326:
;SE9M.c,2074 :: 		if (tacka1 == 1) {
	MOVF        _tacka1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main327
;SE9M.c,2075 :: 		tacka1 = 0;
	CLRF        _tacka1+0 
;SE9M.c,2076 :: 		goto DALJE2;
	GOTO        ___main_DALJE2
;SE9M.c,2077 :: 		}
L_main327:
;SE9M.c,2078 :: 		DALJE2:
___main_DALJE2:
;SE9M.c,2079 :: 		bljump = 0;
	CLRF        _bljump+0 
;SE9M.c,2080 :: 		}
L_main325:
;SE9M.c,2081 :: 		if (disp_mode == 2) {
	MOVF        _disp_mode+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main328
;SE9M.c,2082 :: 		tacka1 = 0;
	CLRF        _tacka1+0 
;SE9M.c,2083 :: 		tacka2 = 1;
	MOVLW       1
	MOVWF       _tacka2+0 
;SE9M.c,2084 :: 		}
L_main328:
;SE9M.c,2085 :: 		if (notime_ovf == 1) {
	MOVF        _notime_ovf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main329
;SE9M.c,2086 :: 		tacka1 = 1;
	MOVLW       1
	MOVWF       _tacka1+0 
;SE9M.c,2087 :: 		tacka2 = 1;
	MOVLW       1
	MOVWF       _tacka2+0 
;SE9M.c,2088 :: 		}
L_main329:
;SE9M.c,2089 :: 		if (notime_ovf == 0) {
	MOVF        _notime_ovf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main330
;SE9M.c,2090 :: 		if ( (sekundi == 0) || (sekundi == 10) || (sekundi == 20) || (sekundi == 30) || (sekundi == 40) || (sekundi == 50) ) {
	MOVF        _sekundi+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__main357
	MOVF        _sekundi+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L__main357
	MOVF        _sekundi+0, 0 
	XORLW       20
	BTFSC       STATUS+0, 2 
	GOTO        L__main357
	MOVF        _sekundi+0, 0 
	XORLW       30
	BTFSC       STATUS+0, 2 
	GOTO        L__main357
	MOVF        _sekundi+0, 0 
	XORLW       40
	BTFSC       STATUS+0, 2 
	GOTO        L__main357
	MOVF        _sekundi+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L__main357
	GOTO        L_main333
L__main357:
;SE9M.c,2091 :: 		Print_Light();
	CALL        _Print_Light+0, 0
;SE9M.c,2092 :: 		}
L_main333:
;SE9M.c,2093 :: 		} else {
	GOTO        L_main334
L_main330:
;SE9M.c,2094 :: 		PWM1_Set_Duty(min_light);
	MOVF        _min_light+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2095 :: 		}
L_main334:
;SE9M.c,2096 :: 		Display_Time();
	CALL        _Display_Time+0, 0
;SE9M.c,2097 :: 		}
L_main324:
;SE9M.c,2099 :: 		Time_epochToDate(epoch + tmzn * 3600, &ts) ;
	MOVF        _tmzn+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _tmzn+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVLW       16
	MOVWF       R4 
	MOVLW       14
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       _epoch+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        R1, 0 
	ADDWFC      _epoch+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _epoch+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _epoch+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVLW       _ts+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,2101 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2102 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,2103 :: 		if (lcdEvent) {
	MOVF        _lcdEvent+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main335
;SE9M.c,2104 :: 		mkLCDLine(1, conf.dhcpen) ; // update lcd: first row
	MOVLW       1
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+0, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2105 :: 		mkLCDLine(2, conf.lcdL2) ; // update lcd: second row
	MOVLW       2
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+1, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2106 :: 		lcdEvent = 0 ;             // clear lcd update flag
	CLRF        _lcdEvent+0 
;SE9M.c,2107 :: 		marquee++ ;                // set marquee pointer
	INFSNZ      _marquee+0, 1 
	INCF        _marquee+1, 1 
;SE9M.c,2108 :: 		}
L_main335:
;SE9M.c,2110 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2111 :: 		}
	GOTO        L_main268
;SE9M.c,2112 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
