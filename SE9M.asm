
_Eth_Obrada:

;SE9M.c,495 :: 		void Eth_Obrada() {
;SE9M.c,496 :: 		if (conf.dhcpen == 0) {
	MOVF        _conf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada0
;SE9M.c,498 :: 		if (lease_time >= 60) {
	MOVLW       60
	SUBWF       _lease_time+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Eth_Obrada1
;SE9M.c,499 :: 		lease_time = 0;
	CLRF        _lease_time+0 
;SE9M.c,500 :: 		while (!Net_Ethernet_28j60_renewDHCP(5));  // try to renew until it works
L_Eth_Obrada2:
	MOVLW       5
	MOVWF       FARG_Net_Ethernet_28j60_renewDHCP_tmax+0 
	CALL        _Net_Ethernet_28j60_renewDHCP+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada3
	GOTO        L_Eth_Obrada2
L_Eth_Obrada3:
;SE9M.c,501 :: 		}
L_Eth_Obrada1:
;SE9M.c,502 :: 		}
L_Eth_Obrada0:
;SE9M.c,503 :: 		if (link == 1) {
	MOVF        _link+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada4
;SE9M.c,507 :: 		Net_Ethernet_28j60_doPacket();
	CALL        _Net_Ethernet_28j60_doPacket+0, 0
;SE9M.c,509 :: 		for (ik = 0; ik < NUM_OF_SOCKET_28j60; ik++) {
	CLRF        _ik+0 
L_Eth_Obrada5:
	MOVLW       _NUM_OF_SOCKET_28j60
	SUBWF       _ik+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Eth_Obrada6
;SE9M.c,510 :: 		if (socket_28j60[ik].open == 0)
	MOVLW       51
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        _ik+0, 0 
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
	GOTO        L_Eth_Obrada8
;SE9M.c,511 :: 		pos[ik] = 0;
	MOVF        _ik+0, 0 
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
L_Eth_Obrada8:
;SE9M.c,509 :: 		for (ik = 0; ik < NUM_OF_SOCKET_28j60; ik++) {
	INCF        _ik+0, 1 
;SE9M.c,512 :: 		}
	GOTO        L_Eth_Obrada5
L_Eth_Obrada6:
;SE9M.c,514 :: 		}
L_Eth_Obrada4:
;SE9M.c,515 :: 		}
L_end_Eth_Obrada:
	RETURN      0
; end of _Eth_Obrada

_saveConf:

;SE9M.c,520 :: 		void    saveConf()
;SE9M.c,533 :: 		}
L_end_saveConf:
	RETURN      0
; end of _saveConf

_mkMarquee:

;SE9M.c,537 :: 		void    mkMarquee(unsigned char l)
;SE9M.c,542 :: 		if((*marquee == 0) || (marquee == 0))
	MOVFF       _marquee+0, FSR0
	MOVFF       _marquee+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__mkMarquee233
	MOVLW       0
	XORWF       _marquee+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkMarquee254
	MOVLW       0
	XORWF       _marquee+0, 0 
L__mkMarquee254:
	BTFSC       STATUS+0, 2 
	GOTO        L__mkMarquee233
	GOTO        L_mkMarquee11
L__mkMarquee233:
;SE9M.c,544 :: 		marquee = bufInfo ;
	MOVLW       _bufInfo+0
	MOVWF       _marquee+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       _marquee+1 
;SE9M.c,545 :: 		}
L_mkMarquee11:
;SE9M.c,546 :: 		if((len=strlen(marquee)) < 16) {
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
	GOTO        L_mkMarquee12
;SE9M.c,547 :: 		memcpy(marqeeBuff, marquee, len) ;
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
;SE9M.c,548 :: 		memcpy(marqeeBuff+len, bufInfo, 16-len) ;
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
;SE9M.c,549 :: 		}
	GOTO        L_mkMarquee13
L_mkMarquee12:
;SE9M.c,551 :: 		memcpy(marqeeBuff, marquee, 16) ;
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
L_mkMarquee13:
;SE9M.c,552 :: 		marqeeBuff[16] = 0 ;
	CLRF        mkMarquee_marqeeBuff_L0+16 
;SE9M.c,555 :: 		}
L_end_mkMarquee:
	RETURN      0
; end of _mkMarquee

_DNSavings:

;SE9M.c,560 :: 		void DNSavings() {
;SE9M.c,561 :: 		tmzn = 2;
	MOVLW       2
	MOVWF       _tmzn+0 
;SE9M.c,563 :: 		}
L_end_DNSavings:
	RETURN      0
; end of _DNSavings

_int2str:

;SE9M.c,568 :: 		void    int2str(long l, unsigned char *s)
;SE9M.c,572 :: 		if(l == 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       FARG_int2str_l+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str257
	MOVF        R0, 0 
	XORWF       FARG_int2str_l+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str257
	MOVF        R0, 0 
	XORWF       FARG_int2str_l+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str257
	MOVF        FARG_int2str_l+0, 0 
	XORLW       0
L__int2str257:
	BTFSS       STATUS+0, 2 
	GOTO        L_int2str14
;SE9M.c,574 :: 		s[0] = '0' ;
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVLW       48
	MOVWF       POSTINC1+0 
;SE9M.c,575 :: 		s[1] = 0 ;
	MOVLW       1
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SE9M.c,576 :: 		}
	GOTO        L_int2str15
L_int2str14:
;SE9M.c,579 :: 		if(l < 0)
	MOVLW       128
	XORWF       FARG_int2str_l+3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str258
	MOVLW       0
	SUBWF       FARG_int2str_l+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str258
	MOVLW       0
	SUBWF       FARG_int2str_l+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str258
	MOVLW       0
	SUBWF       FARG_int2str_l+0, 0 
L__int2str258:
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str16
;SE9M.c,581 :: 		l *= -1 ;
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
;SE9M.c,582 :: 		n = 1 ;
	MOVLW       1
	MOVWF       int2str_n_L0+0 
;SE9M.c,583 :: 		}
	GOTO        L_int2str17
L_int2str16:
;SE9M.c,586 :: 		n = 0 ;
	CLRF        int2str_n_L0+0 
;SE9M.c,587 :: 		}
L_int2str17:
;SE9M.c,588 :: 		s[0] = 0 ;
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	CLRF        POSTINC1+0 
;SE9M.c,589 :: 		i = 0 ;
	CLRF        int2str_i_L0+0 
;SE9M.c,590 :: 		while(l > 0)
L_int2str18:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_int2str_l+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str259
	MOVF        FARG_int2str_l+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str259
	MOVF        FARG_int2str_l+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str259
	MOVF        FARG_int2str_l+0, 0 
	SUBLW       0
L__int2str259:
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str19
;SE9M.c,592 :: 		for(j = i + 1 ; j > 0 ; j--)
	MOVF        int2str_i_L0+0, 0 
	ADDLW       1
	MOVWF       int2str_j_L0+0 
L_int2str20:
	MOVF        int2str_j_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str21
;SE9M.c,594 :: 		s[j] = s[j - 1] ;
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
;SE9M.c,592 :: 		for(j = i + 1 ; j > 0 ; j--)
	DECF        int2str_j_L0+0, 1 
;SE9M.c,595 :: 		}
	GOTO        L_int2str20
L_int2str21:
;SE9M.c,596 :: 		s[0] = l % 10 ;
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
;SE9M.c,597 :: 		s[0] += '0' ;
	MOVFF       FARG_int2str_s+0, FSR0
	MOVFF       FARG_int2str_s+1, FSR0H
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVLW       48
	ADDWF       POSTINC0+0, 1 
;SE9M.c,598 :: 		i++ ;
	INCF        int2str_i_L0+0, 1 
;SE9M.c,599 :: 		l /= 10 ;
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
;SE9M.c,600 :: 		}
	GOTO        L_int2str18
L_int2str19:
;SE9M.c,601 :: 		if(n)
	MOVF        int2str_n_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_int2str23
;SE9M.c,603 :: 		for(j = i + 1 ; j > 0 ; j--)
	MOVF        int2str_i_L0+0, 0 
	ADDLW       1
	MOVWF       int2str_j_L0+0 
L_int2str24:
	MOVF        int2str_j_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str25
;SE9M.c,605 :: 		s[j] = s[j - 1] ;
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
;SE9M.c,603 :: 		for(j = i + 1 ; j > 0 ; j--)
	DECF        int2str_j_L0+0, 1 
;SE9M.c,606 :: 		}
	GOTO        L_int2str24
L_int2str25:
;SE9M.c,607 :: 		s[0] = '-' ;
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVLW       45
	MOVWF       POSTINC1+0 
;SE9M.c,608 :: 		}
L_int2str23:
;SE9M.c,609 :: 		}
L_int2str15:
;SE9M.c,610 :: 		}
L_end_int2str:
	RETURN      0
; end of _int2str

_ip2str:

;SE9M.c,615 :: 		void    ip2str(unsigned char *s, unsigned char *ip)
;SE9M.c,620 :: 		*s = 0 ;
	MOVFF       FARG_ip2str_s+0, FSR1
	MOVFF       FARG_ip2str_s+1, FSR1H
	CLRF        POSTINC1+0 
;SE9M.c,621 :: 		for(i = 0 ; i < 4 ; i++)
	CLRF        ip2str_i_L0+0 
L_ip2str27:
	MOVLW       4
	SUBWF       ip2str_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ip2str28
;SE9M.c,623 :: 		int2str(ip[i], buf) ;
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
;SE9M.c,624 :: 		strcat(s, buf) ;
	MOVF        FARG_ip2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ip2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ip2str_buf_L0+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ip2str_buf_L0+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,625 :: 		if(i != 3)
	MOVF        ip2str_i_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_ip2str30
;SE9M.c,626 :: 		strcat(s, ".") ;
	MOVF        FARG_ip2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ip2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr35_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr35_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
L_ip2str30:
;SE9M.c,621 :: 		for(i = 0 ; i < 4 ; i++)
	INCF        ip2str_i_L0+0, 1 
;SE9M.c,627 :: 		}
	GOTO        L_ip2str27
L_ip2str28:
;SE9M.c,628 :: 		}
L_end_ip2str:
	RETURN      0
; end of _ip2str

_ts2str:

;SE9M.c,634 :: 		void    ts2str(unsigned char *s, TimeStruct *t, unsigned char m)
;SE9M.c,641 :: 		if(m & TS2STR_DATE)
	BTFSS       FARG_ts2str_m+0, 0 
	GOTO        L_ts2str31
;SE9M.c,643 :: 		strcpy(s, wday[t->wd]) ;        // week day
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
;SE9M.c,644 :: 		danuned = t->wd;
	MOVLW       4
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _danuned+0 
;SE9M.c,645 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr36_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr36_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,646 :: 		ByteToStr(t->md, tmp) ;         // day num
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
;SE9M.c,647 :: 		dan = t->md;
	MOVLW       3
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _dan+0 
;SE9M.c,648 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,649 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr37_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr37_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,650 :: 		strcat(s, mon[t->mo]) ;        // month
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
;SE9M.c,651 :: 		mesec = t->mo;
	MOVLW       5
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _mesec+0 
;SE9M.c,652 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr38_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr38_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,653 :: 		WordToStr(t->yy, tmp) ;         // year
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
;SE9M.c,654 :: 		godina = t->yy;
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
;SE9M.c,655 :: 		godyear1 = godina / 1000;
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
;SE9M.c,656 :: 		godyear2 = (godina - godyear1 * 1000) / 100;
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
;SE9M.c,657 :: 		godyear3 = (godina - godyear1 * 1000 - godyear2 * 100) / 10;
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
;SE9M.c,658 :: 		godyear4 = godina - godyear1 * 1000 - godyear2 * 100 - godyear3 * 10;
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
;SE9M.c,659 :: 		fingodina = godyear3 * 10 + godyear4;
	MOVF        R1, 0 
	MOVWF       _fingodina+0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       _fingodina+0 
;SE9M.c,660 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,661 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr39_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr39_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,662 :: 		}
	GOTO        L_ts2str32
L_ts2str31:
;SE9M.c,665 :: 		*s = 0 ;
	MOVFF       FARG_ts2str_s+0, FSR1
	MOVFF       FARG_ts2str_s+1, FSR1H
	CLRF        POSTINC1+0 
;SE9M.c,666 :: 		}
L_ts2str32:
;SE9M.c,671 :: 		if(m & TS2STR_TIME)
	BTFSS       FARG_ts2str_m+0, 1 
	GOTO        L_ts2str33
;SE9M.c,673 :: 		ByteToStr(t->hh, tmp) ;         // hour
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
;SE9M.c,674 :: 		sati = t->hh;
	MOVLW       2
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _sati+0 
;SE9M.c,675 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,676 :: 		strcat(s, ":") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr40_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr40_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,677 :: 		ByteToStr(t->mn, tmp) ;         // minute
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
;SE9M.c,678 :: 		minuti = (t->mn);
	MOVLW       1
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _minuti+0 
;SE9M.c,679 :: 		if(*(tmp + 1) == ' ')
	MOVF        ts2str_tmp_L0+1, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_ts2str34
;SE9M.c,681 :: 		*(tmp + 1) = '0' ;
	MOVLW       48
	MOVWF       ts2str_tmp_L0+1 
;SE9M.c,682 :: 		}
L_ts2str34:
;SE9M.c,683 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,684 :: 		strcat(s, ":") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr41_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr41_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,685 :: 		ByteToStr(t->ss, tmp) ;         // second
	MOVFF       FARG_ts2str_t+0, FSR0
	MOVFF       FARG_ts2str_t+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,686 :: 		sekundi = t->ss;
	MOVFF       FARG_ts2str_t+0, FSR0
	MOVFF       FARG_ts2str_t+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       _sekundi+0 
;SE9M.c,687 :: 		if(*(tmp + 1) == ' ')
	MOVF        ts2str_tmp_L0+1, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_ts2str35
;SE9M.c,689 :: 		*(tmp + 1) = '0' ;
	MOVLW       48
	MOVWF       ts2str_tmp_L0+1 
;SE9M.c,690 :: 		}
L_ts2str35:
;SE9M.c,691 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,692 :: 		}
L_ts2str33:
;SE9M.c,697 :: 		if(m & TS2STR_TZ)
	BTFSS       FARG_ts2str_m+0, 2 
	GOTO        L_ts2str36
;SE9M.c,699 :: 		strcat(s, " GMT") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr42_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr42_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,700 :: 		if(conf.tz > 0)
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _conf+2, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ts2str37
;SE9M.c,702 :: 		strcat(s, "+") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr43_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr43_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,703 :: 		}
L_ts2str37:
;SE9M.c,704 :: 		int2str(conf.tz, s + strlen(s)) ;
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
;SE9M.c,705 :: 		}
L_ts2str36:
;SE9M.c,706 :: 		}
L_end_ts2str:
	RETURN      0
; end of _ts2str

_nibble2hex:

;SE9M.c,711 :: 		unsigned char nibble2hex(unsigned char n)
;SE9M.c,713 :: 		n &= 0x0f ;
	MOVLW       15
	ANDWF       FARG_nibble2hex_n+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_nibble2hex_n+0 
;SE9M.c,714 :: 		if(n >= 0x0a)
	MOVLW       10
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_nibble2hex38
;SE9M.c,716 :: 		return(n + '7') ;
	MOVLW       55
	ADDWF       FARG_nibble2hex_n+0, 0 
	MOVWF       R0 
	GOTO        L_end_nibble2hex
;SE9M.c,717 :: 		}
L_nibble2hex38:
;SE9M.c,718 :: 		return(n + '0') ;
	MOVLW       48
	ADDWF       FARG_nibble2hex_n+0, 0 
	MOVWF       R0 
;SE9M.c,719 :: 		}
L_end_nibble2hex:
	RETURN      0
; end of _nibble2hex

_byte2hex:

;SE9M.c,724 :: 		void    byte2hex(unsigned char *s, unsigned char v)
;SE9M.c,726 :: 		*s++ = nibble2hex(v >> 4) ;
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
;SE9M.c,727 :: 		*s++ = nibble2hex(v) ;
	MOVF        FARG_byte2hex_v+0, 0 
	MOVWF       FARG_nibble2hex_n+0 
	CALL        _nibble2hex+0, 0
	MOVFF       FARG_byte2hex_s+0, FSR1
	MOVFF       FARG_byte2hex_s+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_byte2hex_s+0, 1 
	INCF        FARG_byte2hex_s+1, 1 
;SE9M.c,728 :: 		*s = '.' ;
	MOVFF       FARG_byte2hex_s+0, FSR1
	MOVFF       FARG_byte2hex_s+1, FSR1H
	MOVLW       46
	MOVWF       POSTINC1+0 
;SE9M.c,729 :: 		}
L_end_byte2hex:
	RETURN      0
; end of _byte2hex

_mkLCDLine:

;SE9M.c,759 :: 		void mkLCDLine(unsigned char l, unsigned char m)
;SE9M.c,761 :: 		switch(m)
	GOTO        L_mkLCDLine39
;SE9M.c,763 :: 		case 0:
L_mkLCDLine41:
;SE9M.c,765 :: 		memset(bufInfo, 0, sizeof(bufInfo)) ;
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
;SE9M.c,766 :: 		if(lastSync)
	MOVF        _lastSync+0, 0 
	IORWF       _lastSync+1, 0 
	IORWF       _lastSync+2, 0 
	IORWF       _lastSync+3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine42
;SE9M.c,769 :: 		strcpy(bufInfo, "Today is ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr44_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr44_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,770 :: 		ts2str(bufInfo + strlen(bufInfo), &ts, TS2STR_DATE) ;
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
;SE9M.c,771 :: 		strcat(bufInfo, ". Please visit www.micro-examples.com for more details about the Ethernal Clock. You can browse ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr45_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr45_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,772 :: 		ip2str(bufInfo + strlen(bufInfo), ipAddr) ;
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
;SE9M.c,773 :: 		strcat(bufInfo, " to set the clock preferences.    ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr46_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr46_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,774 :: 		}
	GOTO        L_mkLCDLine43
L_mkLCDLine42:
;SE9M.c,778 :: 		strcpy(bufInfo, "The SNTP server did not respond, please browse ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr47_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr47_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,779 :: 		ip2str(bufInfo + strlen(bufInfo), ipAddr) ;
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
;SE9M.c,780 :: 		strcat(bufInfo, " to check clock settings.    ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr48_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr48_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,781 :: 		}
L_mkLCDLine43:
;SE9M.c,782 :: 		mkMarquee(l) ;           // display marquee
	MOVF        FARG_mkLCDLine_l+0, 0 
	MOVWF       FARG_mkMarquee_l+0 
	CALL        _mkMarquee+0, 0
;SE9M.c,783 :: 		break ;
	GOTO        L_mkLCDLine40
;SE9M.c,784 :: 		case 1:
L_mkLCDLine44:
;SE9M.c,788 :: 		ts2str(bufInfo, &ts, TS2STR_DATE) ;
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
;SE9M.c,794 :: 		break ;
	GOTO        L_mkLCDLine40
;SE9M.c,795 :: 		case 2:
L_mkLCDLine45:
;SE9M.c,799 :: 		ts2str(bufInfo, &ts, TS2STR_TIME) ;
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
;SE9M.c,805 :: 		break ;
	GOTO        L_mkLCDLine40
;SE9M.c,806 :: 		}
L_mkLCDLine39:
	MOVF        FARG_mkLCDLine_m+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine41
	MOVF        FARG_mkLCDLine_m+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine44
	MOVF        FARG_mkLCDLine_m+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine45
L_mkLCDLine40:
;SE9M.c,807 :: 		}
L_end_mkLCDLine:
	RETURN      0
; end of _mkLCDLine

_mkSNTPrequest:

;SE9M.c,812 :: 		void    mkSNTPrequest()
;SE9M.c,817 :: 		if (sntpSync)
	MOVF        _sntpSync+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest46
;SE9M.c,818 :: 		if (Net_Ethernet_28j60_UserTimerSec >= sntpTimer)
	MOVF        _sntpTimer+3, 0 
	SUBWF       _Net_Ethernet_28j60_UserTimerSec+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkSNTPrequest266
	MOVF        _sntpTimer+2, 0 
	SUBWF       _Net_Ethernet_28j60_UserTimerSec+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkSNTPrequest266
	MOVF        _sntpTimer+1, 0 
	SUBWF       _Net_Ethernet_28j60_UserTimerSec+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkSNTPrequest266
	MOVF        _sntpTimer+0, 0 
	SUBWF       _Net_Ethernet_28j60_UserTimerSec+0, 0 
L__mkSNTPrequest266:
	BTFSS       STATUS+0, 0 
	GOTO        L_mkSNTPrequest47
;SE9M.c,819 :: 		if (!lastSync) {
	MOVF        _lastSync+0, 0 
	IORWF       _lastSync+1, 0 
	IORWF       _lastSync+2, 0 
	IORWF       _lastSync+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_mkSNTPrequest48
;SE9M.c,820 :: 		sntpSync = 0;
	CLRF        _sntpSync+0 
;SE9M.c,821 :: 		if (!memcmp(conf.sntpIP, "\0\0\0\0", 4))
	MOVLW       _conf+3
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr49_SE9M+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr49_SE9M+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       4
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_mkSNTPrequest49
;SE9M.c,822 :: 		reloadDNS = 1 ; // force to solve DNS
	MOVLW       1
	MOVWF       _reloadDNS+0 
L_mkSNTPrequest49:
;SE9M.c,823 :: 		}
L_mkSNTPrequest48:
L_mkSNTPrequest47:
L_mkSNTPrequest46:
;SE9M.c,825 :: 		if(reloadDNS)   // is SNTP ip address to be reloaded from DNS ?
	MOVF        _reloadDNS+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest50
;SE9M.c,828 :: 		if(isalpha(*conf.sntpServer))   // doest host name start with an alphabetic character ?
	MOVF        _conf+7, 0 
	MOVWF       FARG_isalpha_character+0 
	CALL        _isalpha+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest51
;SE9M.c,831 :: 		memset(conf.sntpIP, 0, 4);
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
;SE9M.c,832 :: 		if(remoteIpAddr = Net_Ethernet_28j60_dnsResolve(conf.sntpServer, 5))
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
	GOTO        L_mkSNTPrequest52
;SE9M.c,835 :: 		memcpy(conf.sntpIP, remoteIpAddr, 4) ;
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
;SE9M.c,836 :: 		}
L_mkSNTPrequest52:
;SE9M.c,837 :: 		}
	GOTO        L_mkSNTPrequest53
L_mkSNTPrequest51:
;SE9M.c,841 :: 		unsigned char *ptr = conf.sntpServer ;
	MOVLW       _conf+7
	MOVWF       mkSNTPrequest_ptr_L2+0 
	MOVLW       hi_addr(_conf+7)
	MOVWF       mkSNTPrequest_ptr_L2+1 
;SE9M.c,843 :: 		conf.sntpIP[0] = atoi(ptr) ;
	MOVF        mkSNTPrequest_ptr_L2+0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        mkSNTPrequest_ptr_L2+1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+3 
;SE9M.c,844 :: 		ptr = strchr(ptr, '.') + 1 ;
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
;SE9M.c,845 :: 		conf.sntpIP[1] = atoi(ptr) ;
	MOVF        R0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+4 
;SE9M.c,846 :: 		ptr = strchr(ptr, '.') + 1 ;
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
;SE9M.c,847 :: 		conf.sntpIP[2] = atoi(ptr) ;
	MOVF        R0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+5 
;SE9M.c,848 :: 		ptr = strchr(ptr, '.') + 1 ;
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
;SE9M.c,849 :: 		conf.sntpIP[3] = atoi(ptr) ;
	MOVF        R0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+6 
;SE9M.c,850 :: 		}
L_mkSNTPrequest53:
;SE9M.c,852 :: 		saveConf() ;            // store to EEPROM
	CALL        _saveConf+0, 0
;SE9M.c,854 :: 		reloadDNS = 0 ;         // no further call to DNS
	CLRF        _reloadDNS+0 
;SE9M.c,856 :: 		sntpSync = 0 ;          // clock is not sync for now
	CLRF        _sntpSync+0 
;SE9M.c,857 :: 		}
L_mkSNTPrequest50:
;SE9M.c,859 :: 		if(sntpSync)                    // is clock already synchronized from sntp ?
	MOVF        _sntpSync+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest54
;SE9M.c,861 :: 		return ;                // yes, no need to request time
	GOTO        L_end_mkSNTPrequest
;SE9M.c,862 :: 		}
L_mkSNTPrequest54:
;SE9M.c,867 :: 		memset(sntpPkt, 0, 48) ;        // clear sntp packet
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
;SE9M.c,870 :: 		sntpPkt[0] = 0b00011001 ;       // LI = 0 ; VN = 3 ; MODE = 1
	MOVLW       25
	MOVWF       mkSNTPrequest_sntpPkt_L0+0 
;SE9M.c,875 :: 		sntpPkt[2] = 0x0a ;             // 1024 sec (arbitrary value)
	MOVLW       10
	MOVWF       mkSNTPrequest_sntpPkt_L0+2 
;SE9M.c,878 :: 		sntpPkt[3] = 0xfa ;             // 0.015625 sec (arbitrary value)
	MOVLW       250
	MOVWF       mkSNTPrequest_sntpPkt_L0+3 
;SE9M.c,881 :: 		sntpPkt[6] = 0x44 ;
	MOVLW       68
	MOVWF       mkSNTPrequest_sntpPkt_L0+6 
;SE9M.c,884 :: 		sntpPkt[9] = 0x10 ;
	MOVLW       16
	MOVWF       mkSNTPrequest_sntpPkt_L0+9 
;SE9M.c,896 :: 		Net_Ethernet_28j60_sendUDP(conf.sntpIP, 123, 123, sntpPkt, 48) ; // transmit UDP packet
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
;SE9M.c,898 :: 		sntpSync = 1 ;  // done
	MOVLW       1
	MOVWF       _sntpSync+0 
;SE9M.c,899 :: 		lastSync = 0 ;
	CLRF        _lastSync+0 
	CLRF        _lastSync+1 
	CLRF        _lastSync+2 
	CLRF        _lastSync+3 
;SE9M.c,900 :: 		sntpTimer = Net_Ethernet_28j60_UserTimerSec + 2;
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
;SE9M.c,901 :: 		}
L_end_mkSNTPrequest:
	RETURN      0
; end of _mkSNTPrequest

_Rst_Eth:

;SE9M.c,903 :: 		void Rst_Eth() {
;SE9M.c,904 :: 		Net_Ethernet_28j60_Rst = 0;
	BCF         LATA5_bit+0, BitPos(LATA5_bit+0) 
;SE9M.c,905 :: 		reset_eth = 1;
	MOVLW       1
	MOVWF       _reset_eth+0 
;SE9M.c,907 :: 		}
L_end_Rst_Eth:
	RETURN      0
; end of _Rst_Eth

_Print_Seg:

;SE9M.c,910 :: 		char Print_Seg(char segm, char tacka) {
;SE9M.c,912 :: 		if (segm == 0) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg55
;SE9M.c,913 :: 		napolje = 0b01111110 | tacka;
	MOVLW       126
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,914 :: 		}
L_Print_Seg55:
;SE9M.c,915 :: 		if (segm == 1) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg56
;SE9M.c,916 :: 		napolje = 0b00011000 | tacka;
	MOVLW       24
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,917 :: 		}
L_Print_Seg56:
;SE9M.c,918 :: 		if (segm == 2) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg57
;SE9M.c,919 :: 		napolje = 0b10110110 | tacka;
	MOVLW       182
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,920 :: 		}
L_Print_Seg57:
;SE9M.c,921 :: 		if (segm == 3) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg58
;SE9M.c,922 :: 		napolje = 0b10111100 | tacka;
	MOVLW       188
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,923 :: 		}
L_Print_Seg58:
;SE9M.c,924 :: 		if (segm == 4) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg59
;SE9M.c,925 :: 		napolje = 0b11011000 | tacka;
	MOVLW       216
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,926 :: 		}
L_Print_Seg59:
;SE9M.c,927 :: 		if (segm == 5) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg60
;SE9M.c,928 :: 		napolje = 0b11101100 | tacka;
	MOVLW       236
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,929 :: 		}
L_Print_Seg60:
;SE9M.c,930 :: 		if (segm == 6) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg61
;SE9M.c,931 :: 		napolje = 0b11101110 | tacka;
	MOVLW       238
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,932 :: 		}
L_Print_Seg61:
;SE9M.c,933 :: 		if (segm == 7) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg62
;SE9M.c,934 :: 		napolje = 0b00111000 | tacka;
	MOVLW       56
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,935 :: 		}
L_Print_Seg62:
;SE9M.c,936 :: 		if (segm == 8) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg63
;SE9M.c,937 :: 		napolje = 0b11111110 | tacka;
	MOVLW       254
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,938 :: 		}
L_Print_Seg63:
;SE9M.c,939 :: 		if (segm == 9) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg64
;SE9M.c,940 :: 		napolje = 0b11111100 | tacka;
	MOVLW       252
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,941 :: 		}
L_Print_Seg64:
;SE9M.c,943 :: 		if (segm == 10) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg65
;SE9M.c,944 :: 		napolje = 0b11110010 | tacka;
	MOVLW       242
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,945 :: 		}
L_Print_Seg65:
;SE9M.c,946 :: 		if (segm == 11) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg66
;SE9M.c,947 :: 		napolje = 0b01110010 | tacka;
	MOVLW       114
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,948 :: 		}
L_Print_Seg66:
;SE9M.c,949 :: 		if (segm == 12) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg67
;SE9M.c,950 :: 		napolje = 0b01111000 | tacka;
	MOVLW       120
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,951 :: 		}
L_Print_Seg67:
;SE9M.c,952 :: 		if (segm == 13) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg68
;SE9M.c,953 :: 		napolje = 0b11100110 | tacka;
	MOVLW       230
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,954 :: 		}
L_Print_Seg68:
;SE9M.c,955 :: 		if (segm == 14) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg69
;SE9M.c,956 :: 		napolje = 0b00000100 | tacka;
	MOVLW       4
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,957 :: 		}
L_Print_Seg69:
;SE9M.c,958 :: 		if (segm == 15) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg70
;SE9M.c,959 :: 		napolje = 0b00000000;
	CLRF        R1 
;SE9M.c,960 :: 		}
L_Print_Seg70:
;SE9M.c,961 :: 		if (segm == 16) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg71
;SE9M.c,962 :: 		napolje = 0b00000001;
	MOVLW       1
	MOVWF       R1 
;SE9M.c,963 :: 		}
L_Print_Seg71:
;SE9M.c,964 :: 		if (segm == 17) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg72
;SE9M.c,965 :: 		napolje = 0b10000000;
	MOVLW       128
	MOVWF       R1 
;SE9M.c,966 :: 		}
L_Print_Seg72:
;SE9M.c,968 :: 		return napolje;
	MOVF        R1, 0 
	MOVWF       R0 
;SE9M.c,969 :: 		}
L_end_Print_Seg:
	RETURN      0
; end of _Print_Seg

_PRINT_S:

;SE9M.c,971 :: 		void PRINT_S(char ledovi) {
;SE9M.c,973 :: 		pom = 0;
	CLRF        R3 
;SE9M.c,974 :: 		for ( ir = 0; ir < 8; ir++ ) {
	CLRF        R4 
L_PRINT_S73:
	MOVLW       8
	SUBWF       R4, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_PRINT_S74
;SE9M.c,975 :: 		pom1 = (ledovi << pom) & 0b10000000;
	MOVF        R3, 0 
	MOVWF       R1 
	MOVF        FARG_PRINT_S_ledovi+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__PRINT_S270:
	BZ          L__PRINT_S271
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__PRINT_S270
L__PRINT_S271:
	MOVLW       128
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       R2 
;SE9M.c,976 :: 		if (pom1 == 0b10000000) {
	MOVF        R1, 0 
	XORLW       128
	BTFSS       STATUS+0, 2 
	GOTO        L_PRINT_S76
;SE9M.c,977 :: 		SV_DATA = 1;
	BSF         RA1_bit+0, BitPos(RA1_bit+0) 
;SE9M.c,978 :: 		}
L_PRINT_S76:
;SE9M.c,979 :: 		if (pom1 == 0b00000000) {
	MOVF        R2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_PRINT_S77
;SE9M.c,980 :: 		SV_DATA = 0;
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;SE9M.c,981 :: 		}
L_PRINT_S77:
;SE9M.c,982 :: 		asm nop;
	NOP
;SE9M.c,983 :: 		asm nop;
	NOP
;SE9M.c,984 :: 		asm nop;
	NOP
;SE9M.c,985 :: 		SV_CLK = 0;
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
;SE9M.c,986 :: 		asm nop;
	NOP
;SE9M.c,987 :: 		asm nop;
	NOP
;SE9M.c,988 :: 		asm nop;
	NOP
;SE9M.c,989 :: 		SV_CLK = 1;
	BSF         RA2_bit+0, BitPos(RA2_bit+0) 
;SE9M.c,990 :: 		pom++;
	INCF        R3, 1 
;SE9M.c,974 :: 		for ( ir = 0; ir < 8; ir++ ) {
	INCF        R4, 1 
;SE9M.c,991 :: 		}
	GOTO        L_PRINT_S73
L_PRINT_S74:
;SE9M.c,992 :: 		}
L_end_PRINT_S:
	RETURN      0
; end of _PRINT_S

_Display_Time:

;SE9M.c,995 :: 		void Display_Time() {
;SE9M.c,997 :: 		sec1 = sekundi / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _sekundi+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _sec1+0 
;SE9M.c,998 :: 		sec2 = sekundi - sec1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _sekundi+0, 0 
	MOVWF       _sec2+0 
;SE9M.c,999 :: 		min1 = minuti / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _minuti+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _min1+0 
;SE9M.c,1000 :: 		min2 = minuti - min1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _minuti+0, 0 
	MOVWF       _min2+0 
;SE9M.c,1001 :: 		hr1 = sati / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _sati+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _hr1+0 
;SE9M.c,1002 :: 		hr2 = sati - hr1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _sati+0, 0 
	MOVWF       _hr2+0 
;SE9M.c,1003 :: 		day1 = dan / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _dan+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _day1+0 
;SE9M.c,1004 :: 		day2 = dan - day1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _dan+0, 0 
	MOVWF       _day2+0 
;SE9M.c,1005 :: 		mn1 = mesec / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _mesec+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _mn1+0 
;SE9M.c,1006 :: 		mn2 = mesec - mn1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _mesec+0, 0 
	MOVWF       _mn2+0 
;SE9M.c,1007 :: 		year1 = fingodina / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _fingodina+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _year1+0 
;SE9M.c,1008 :: 		year2 = fingodina - year1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _fingodina+0, 0 
	MOVWF       _year2+0 
;SE9M.c,1010 :: 		if (disp_mode == 1) {
	MOVF        _disp_mode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Display_Time78
;SE9M.c,1011 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1012 :: 		asm nop;
	NOP
;SE9M.c,1013 :: 		asm nop;
	NOP
;SE9M.c,1014 :: 		asm nop;
	NOP
;SE9M.c,1021 :: 		PRINT_S(Print_Seg(sta, 0));
	MOVF        _sta+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1022 :: 		PRINT_S(Print_Seg(sta, 0));
	MOVF        _sta+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1023 :: 		PRINT_S(Print_Seg(sta, 0));
	MOVF        _sta+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1024 :: 		PRINT_S(Print_Seg(sta, 0));
	MOVF        _sta+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1025 :: 		PRINT_S(Print_Seg(sta, 0));
	MOVF        _sta+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1026 :: 		PRINT_S(Print_Seg(sta, 0));
	MOVF        _sta+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1027 :: 		asm nop;
	NOP
;SE9M.c,1028 :: 		asm nop;
	NOP
;SE9M.c,1029 :: 		asm nop;
	NOP
;SE9M.c,1030 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1031 :: 		}
L_Display_Time78:
;SE9M.c,1032 :: 		if (disp_mode == 2) {
	MOVF        _disp_mode+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Display_Time79
;SE9M.c,1033 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1034 :: 		asm nop;
	NOP
;SE9M.c,1035 :: 		asm nop;
	NOP
;SE9M.c,1036 :: 		asm nop;
	NOP
;SE9M.c,1037 :: 		PRINT_S(Print_Seg(year2, 0));
	MOVF        _year2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1038 :: 		PRINT_S(Print_Seg(year1, 0));
	MOVF        _year1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1039 :: 		PRINT_S(Print_Seg(mn2, 0));
	MOVF        _mn2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1040 :: 		PRINT_S(Print_Seg(mn1, 0));
	MOVF        _mn1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1041 :: 		PRINT_S(Print_Seg(day2, tacka1));
	MOVF        _day2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka1+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1042 :: 		PRINT_S(Print_Seg(day1, tacka2));
	MOVF        _day1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka2+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,1043 :: 		asm nop;
	NOP
;SE9M.c,1044 :: 		asm nop;
	NOP
;SE9M.c,1045 :: 		asm nop;
	NOP
;SE9M.c,1046 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1047 :: 		}
L_Display_Time79:
;SE9M.c,1049 :: 		}
L_end_Display_Time:
	RETURN      0
; end of _Display_Time

_Net_Ethernet_28j60_UserTCP:

;SE9M.c,1055 :: 		void Net_Ethernet_28j60_UserTCP(SOCKET_28j60_Dsc *socket) {
;SE9M.c,1059 :: 		unsigned int    len = 0 ;
	CLRF        Net_Ethernet_28j60_UserTCP_len_L0+0 
	CLRF        Net_Ethernet_28j60_UserTCP_len_L0+1 
;SE9M.c,1066 :: 		if (socket->destPort != 80)                    // I listen only to web request on port 80
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
	GOTO        L__Net_Ethernet_28j60_UserTCP274
	MOVLW       80
	XORWF       R1, 0 
L__Net_Ethernet_28j60_UserTCP274:
	BTFSC       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP80
;SE9M.c,1068 :: 		return;                     // return without reply
	GOTO        L_end_Net_Ethernet_28j60_UserTCP
;SE9M.c,1069 :: 		}
L_Net_Ethernet_28j60_UserTCP80:
;SE9M.c,1070 :: 		for(len = 0; len < 10; len++){
	CLRF        Net_Ethernet_28j60_UserTCP_len_L0+0 
	CLRF        Net_Ethernet_28j60_UserTCP_len_L0+1 
L_Net_Ethernet_28j60_UserTCP81:
	MOVLW       0
	SUBWF       Net_Ethernet_28j60_UserTCP_len_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP275
	MOVLW       10
	SUBWF       Net_Ethernet_28j60_UserTCP_len_L0+0, 0 
L__Net_Ethernet_28j60_UserTCP275:
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP82
;SE9M.c,1071 :: 		getRequest[len] = Net_Ethernet_28j60_getByte();
	MOVLW       Net_Ethernet_28j60_UserTCP_getRequest_L0+0
	ADDWF       Net_Ethernet_28j60_UserTCP_len_L0+0, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserTCP+0 
	MOVLW       hi_addr(Net_Ethernet_28j60_UserTCP_getRequest_L0+0)
	ADDWFC      Net_Ethernet_28j60_UserTCP_len_L0+1, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserTCP+1 
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVFF       FLOC__Net_Ethernet_28j60_UserTCP+0, FSR1
	MOVFF       FLOC__Net_Ethernet_28j60_UserTCP+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,1070 :: 		for(len = 0; len < 10; len++){
	INFSNZ      Net_Ethernet_28j60_UserTCP_len_L0+0, 1 
	INCF        Net_Ethernet_28j60_UserTCP_len_L0+1, 1 
;SE9M.c,1072 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserTCP81
L_Net_Ethernet_28j60_UserTCP82:
;SE9M.c,1073 :: 		getRequest[len] = 0;
	MOVLW       Net_Ethernet_28j60_UserTCP_getRequest_L0+0
	ADDWF       Net_Ethernet_28j60_UserTCP_len_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(Net_Ethernet_28j60_UserTCP_getRequest_L0+0)
	ADDWFC      Net_Ethernet_28j60_UserTCP_len_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SE9M.c,1083 :: 		if(memcmp(getRequest, httpMethod, 5)&&(socket->state != 3)){
	MOVLW       Net_Ethernet_28j60_UserTCP_getRequest_L0+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(Net_Ethernet_28j60_UserTCP_getRequest_L0+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _httpMethod+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_httpMethod+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       5
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP86
	MOVLW       37
	ADDWF       FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP86
L__Net_Ethernet_28j60_UserTCP236:
;SE9M.c,1084 :: 		return;
	GOTO        L_end_Net_Ethernet_28j60_UserTCP
;SE9M.c,1085 :: 		}
L_Net_Ethernet_28j60_UserTCP86:
;SE9M.c,1087 :: 		if(memcmp(getRequest, httpRequ, 9)==0){
	MOVLW       Net_Ethernet_28j60_UserTCP_getRequest_L0+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(Net_Ethernet_28j60_UserTCP_getRequest_L0+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _httpRequ+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_httpRequ+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       9
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP276
	MOVLW       0
	XORWF       R0, 0 
L__Net_Ethernet_28j60_UserTCP276:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP87
;SE9M.c,1088 :: 		sendHTML_mark = 1;
	MOVLW       1
	MOVWF       _sendHTML_mark+0 
;SE9M.c,1089 :: 		socketHTML = socket;
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       _socketHTML+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       _socketHTML+1 
;SE9M.c,1090 :: 		}
L_Net_Ethernet_28j60_UserTCP87:
;SE9M.c,1092 :: 		if((sendHTML_mark == 1)&&(socketHTML == socket)) {
	MOVF        _sendHTML_mark+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP90
	MOVF        _socketHTML+1, 0 
	XORWF       FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP277
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	XORWF       _socketHTML+0, 0 
L__Net_Ethernet_28j60_UserTCP277:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP90
L__Net_Ethernet_28j60_UserTCP235:
;SE9M.c,1094 :: 		if(pos[socket->ID]==0) {
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
	GOTO        L__Net_Ethernet_28j60_UserTCP278
	MOVLW       0
	XORWF       R1, 0 
L__Net_Ethernet_28j60_UserTCP278:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP91
;SE9M.c,1096 :: 		sta = 1;
	MOVLW       1
	MOVWF       _sta+0 
;SE9M.c,1097 :: 		Net_Ethernet_28j60_putStringTCP(httpHeader, socket);
	MOVLW       _httpHeader+0
	MOVWF       FARG_Net_Ethernet_28j60_putStringTCP_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_Net_Ethernet_28j60_putStringTCP_ptr+1 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putStringTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putStringTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_putStringTCP+0, 0
;SE9M.c,1098 :: 		Net_Ethernet_28j60_putStringTCP(httpMimeTypeHTML, socket);
	MOVLW       _httpMimeTypeHTML+0
	MOVWF       FARG_Net_Ethernet_28j60_putStringTCP_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeHTML+0)
	MOVWF       FARG_Net_Ethernet_28j60_putStringTCP_ptr+1 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putStringTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putStringTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_putStringTCP+0, 0
;SE9M.c,1099 :: 		}
L_Net_Ethernet_28j60_UserTCP91:
;SE9M.c,1101 :: 		while(pos[socket->ID] < (strlen(HTMLheader+1)) ) {
L_Net_Ethernet_28j60_UserTCP92:
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
	MOVWF       FLOC__Net_Ethernet_28j60_UserTCP+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserTCP+1 
	MOVLW       _HTMLheader+1
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_HTMLheader+1)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R1, 0 
	SUBWF       FLOC__Net_Ethernet_28j60_UserTCP+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP279
	MOVF        R0, 0 
	SUBWF       FLOC__Net_Ethernet_28j60_UserTCP+0, 0 
L__Net_Ethernet_28j60_UserTCP279:
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP93
;SE9M.c,1102 :: 		sta = 2;
	MOVLW       2
	MOVWF       _sta+0 
;SE9M.c,1103 :: 		if(Net_Ethernet_28j60_putByteTCP(HTMLheader[pos[socket->ID]++], socket) == 0) {
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
	MOVLW       _HTMLheader+0
	ADDWF       R2, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_HTMLheader+0)
	ADDWFC      R3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putByteTCP_ch+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putByteTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_putByteTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_putByteTCP+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP94
;SE9M.c,1104 :: 		pos[socket->ID]--;
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
;SE9M.c,1105 :: 		sta = 3;
	MOVLW       3
	MOVWF       _sta+0 
;SE9M.c,1106 :: 		break;
	GOTO        L_Net_Ethernet_28j60_UserTCP93
;SE9M.c,1107 :: 		}
L_Net_Ethernet_28j60_UserTCP94:
;SE9M.c,1108 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserTCP92
L_Net_Ethernet_28j60_UserTCP93:
;SE9M.c,1122 :: 		if( Net_Ethernet_28j60_bufferEmptyTCP(socket) && (pos[socket->ID] >= (strlen(HTMLheader)+1))) {
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_bufferEmptyTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_bufferEmptyTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_bufferEmptyTCP+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserTCP97
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
	MOVWF       FLOC__Net_Ethernet_28j60_UserTCP+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserTCP+1 
	MOVLW       _HTMLheader+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_HTMLheader+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	SUBWF       FLOC__Net_Ethernet_28j60_UserTCP+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Net_Ethernet_28j60_UserTCP280
	MOVF        R2, 0 
	SUBWF       FLOC__Net_Ethernet_28j60_UserTCP+0, 0 
L__Net_Ethernet_28j60_UserTCP280:
	BTFSS       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserTCP97
L__Net_Ethernet_28j60_UserTCP234:
;SE9M.c,1124 :: 		Net_Ethernet_28j60_disconnectTCP(socket);
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+0, 0 
	MOVWF       FARG_Net_Ethernet_28j60_disconnectTCP_socket_28j60+0 
	MOVF        FARG_Net_Ethernet_28j60_UserTCP_socket+1, 0 
	MOVWF       FARG_Net_Ethernet_28j60_disconnectTCP_socket_28j60+1 
	CALL        _Net_Ethernet_28j60_disconnectTCP+0, 0
;SE9M.c,1125 :: 		socket_28j60[socket->ID].state = 0;
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
;SE9M.c,1126 :: 		sendHTML_mark = 0;
	CLRF        _sendHTML_mark+0 
;SE9M.c,1127 :: 		pos[socket->ID] = 0;
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
;SE9M.c,1128 :: 		}
L_Net_Ethernet_28j60_UserTCP97:
;SE9M.c,2081 :: 		httpCounter++ ;                             // one more request done
	INFSNZ      _httpCounter+0, 1 
	INCF        _httpCounter+1, 1 
;SE9M.c,2087 :: 		junk = 0;
	CLRF        _junk+0 
;SE9M.c,2089 :: 		}
L_Net_Ethernet_28j60_UserTCP90:
;SE9M.c,2090 :: 		}
L_end_Net_Ethernet_28j60_UserTCP:
	RETURN      0
; end of _Net_Ethernet_28j60_UserTCP

_Print_IP:

;SE9M.c,2093 :: 		void Print_IP() {
;SE9M.c,2097 :: 		cif1 =  ipAddr[3] / 100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _ipAddr+3, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       Print_IP_cif1_L0+0 
;SE9M.c,2098 :: 		cif2 = (ipAddr[3] - cif1 * 100) / 10;
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
;SE9M.c,2099 :: 		cif3 =  ipAddr[3] - cif1 * 100 - cif2 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       FLOC__Print_IP+0, 0 
	MOVWF       Print_IP_cif3_L0+0 
;SE9M.c,2100 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2101 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2102 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2103 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2104 :: 		PRINT_S(Print_Seg(cif3, 0));
	MOVF        Print_IP_cif3_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2105 :: 		PRINT_S(Print_Seg(cif2, 0));
	MOVF        Print_IP_cif2_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2106 :: 		PRINT_S(Print_Seg(cif1, 0));
	MOVF        Print_IP_cif1_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2107 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2108 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2109 :: 		delay_ms(2000);
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_Print_IP98:
	DECFSZ      R13, 1, 1
	BRA         L_Print_IP98
	DECFSZ      R12, 1, 1
	BRA         L_Print_IP98
	DECFSZ      R11, 1, 1
	BRA         L_Print_IP98
	NOP
;SE9M.c,2110 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2111 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2112 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2113 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2114 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2115 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2116 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2117 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2118 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2119 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2120 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_IP99:
	DECFSZ      R13, 1, 1
	BRA         L_Print_IP99
	DECFSZ      R12, 1, 1
	BRA         L_Print_IP99
	DECFSZ      R11, 1, 1
	BRA         L_Print_IP99
	NOP
;SE9M.c,2121 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2122 :: 		}
L_end_Print_IP:
	RETURN      0
; end of _Print_IP

_Net_Ethernet_28j60_UserUDP:

;SE9M.c,2128 :: 		unsigned int Net_Ethernet_28j60_UserUDP(UDP_28j60_Dsc *udpDsc)
;SE9M.c,2133 :: 		if (udpDsc->destPort == 10001) {
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
	GOTO        L__Net_Ethernet_28j60_UserUDP283
	MOVLW       17
	XORWF       R1, 0 
L__Net_Ethernet_28j60_UserUDP283:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP100
;SE9M.c,2134 :: 		if (udpDsc->dataLength == 9) {
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
	GOTO        L__Net_Ethernet_28j60_UserUDP284
	MOVLW       9
	XORWF       R1, 0 
L__Net_Ethernet_28j60_UserUDP284:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP101
;SE9M.c,2135 :: 		for (i = 0 ; i < 9 ; i++) {
	CLRF        Net_Ethernet_28j60_UserUDP_i_L0+0 
L_Net_Ethernet_28j60_UserUDP102:
	MOVLW       9
	SUBWF       Net_Ethernet_28j60_UserUDP_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserUDP103
;SE9M.c,2136 :: 		broadcmd[i] = Net_Ethernet_28j60_getByte() ;
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
;SE9M.c,2135 :: 		for (i = 0 ; i < 9 ; i++) {
	INCF        Net_Ethernet_28j60_UserUDP_i_L0+0, 1 
;SE9M.c,2137 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserUDP102
L_Net_Ethernet_28j60_UserUDP103:
;SE9M.c,2138 :: 		if ( (broadcmd[0] == 'I') && (broadcmd[1] == 'D') && (broadcmd[2] == 'E') && (broadcmd[3] == 'N') && (broadcmd[4] == 'T') && (broadcmd[5] == 'I') && (broadcmd[6] == 'F') && (broadcmd[7] == 'Y') && (broadcmd[8] == '!') ) {
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+0, 0 
	XORLW       73
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP107
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+1, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP107
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+2, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP107
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+3, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP107
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+4, 0 
	XORLW       84
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP107
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+5, 0 
	XORLW       73
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP107
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+6, 0 
	XORLW       70
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP107
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+7, 0 
	XORLW       89
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP107
	MOVF        Net_Ethernet_28j60_UserUDP_broadcmd_L0+8, 0 
	XORLW       33
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP107
L__Net_Ethernet_28j60_UserUDP237:
;SE9M.c,2139 :: 		Print_IP();
	CALL        _Print_IP+0, 0
;SE9M.c,2140 :: 		}
L_Net_Ethernet_28j60_UserUDP107:
;SE9M.c,2141 :: 		}
L_Net_Ethernet_28j60_UserUDP101:
;SE9M.c,2142 :: 		}
L_Net_Ethernet_28j60_UserUDP100:
;SE9M.c,2144 :: 		if(udpDsc->destPort == 123)             // check SNTP port number
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
	GOTO        L__Net_Ethernet_28j60_UserUDP285
	MOVLW       123
	XORWF       R1, 0 
L__Net_Ethernet_28j60_UserUDP285:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP108
;SE9M.c,2146 :: 		if (udpDsc->dataLength == 48) {
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
	GOTO        L__Net_Ethernet_28j60_UserUDP286
	MOVLW       48
	XORWF       R1, 0 
L__Net_Ethernet_28j60_UserUDP286:
	BTFSS       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP109
;SE9M.c,2150 :: 		serverFlags = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _serverFlags+0 
;SE9M.c,2151 :: 		serverStratum = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _serverStratum+0 
;SE9M.c,2152 :: 		Net_Ethernet_28j60_getByte() ;        // skip poll
	CALL        _Net_Ethernet_28j60_getByte+0, 0
;SE9M.c,2153 :: 		serverPrecision = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _serverPrecision+0 
;SE9M.c,2155 :: 		for(i = 0 ; i < 36 ; i++)
	CLRF        Net_Ethernet_28j60_UserUDP_i_L0+0 
L_Net_Ethernet_28j60_UserUDP110:
	MOVLW       36
	SUBWF       Net_Ethernet_28j60_UserUDP_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Net_Ethernet_28j60_UserUDP111
;SE9M.c,2157 :: 		Net_Ethernet_28j60_getByte() ; // skip all unused fileds
	CALL        _Net_Ethernet_28j60_getByte+0, 0
;SE9M.c,2155 :: 		for(i = 0 ; i < 36 ; i++)
	INCF        Net_Ethernet_28j60_UserUDP_i_L0+0, 1 
;SE9M.c,2158 :: 		}
	GOTO        L_Net_Ethernet_28j60_UserUDP110
L_Net_Ethernet_28j60_UserUDP111:
;SE9M.c,2161 :: 		Highest(tts) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       Net_Ethernet_28j60_UserUDP_tts_L2+3 
;SE9M.c,2162 :: 		Higher(tts) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       Net_Ethernet_28j60_UserUDP_tts_L2+2 
;SE9M.c,2163 :: 		Hi(tts) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       Net_Ethernet_28j60_UserUDP_tts_L2+1 
;SE9M.c,2164 :: 		Lo(tts) = Net_Ethernet_28j60_getByte() ;
	CALL        _Net_Ethernet_28j60_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       Net_Ethernet_28j60_UserUDP_tts_L2+0 
;SE9M.c,2167 :: 		epoch = tts - 2208988800 ;
	MOVF        Net_Ethernet_28j60_UserUDP_tts_L2+0, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserUDP+0 
	MOVF        Net_Ethernet_28j60_UserUDP_tts_L2+1, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserUDP+1 
	MOVF        Net_Ethernet_28j60_UserUDP_tts_L2+2, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserUDP+2 
	MOVF        Net_Ethernet_28j60_UserUDP_tts_L2+3, 0 
	MOVWF       FLOC__Net_Ethernet_28j60_UserUDP+3 
	MOVLW       128
	SUBWF       FLOC__Net_Ethernet_28j60_UserUDP+0, 1 
	MOVLW       126
	SUBWFB      FLOC__Net_Ethernet_28j60_UserUDP+1, 1 
	MOVLW       170
	SUBWFB      FLOC__Net_Ethernet_28j60_UserUDP+2, 1 
	MOVLW       131
	SUBWFB      FLOC__Net_Ethernet_28j60_UserUDP+3, 1 
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+0, 0 
	MOVWF       _epoch+0 
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+1, 0 
	MOVWF       _epoch+1 
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+2, 0 
	MOVWF       _epoch+2 
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+3, 0 
	MOVWF       _epoch+3 
;SE9M.c,2170 :: 		lastSync = epoch ;
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+0, 0 
	MOVWF       _lastSync+0 
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+1, 0 
	MOVWF       _lastSync+1 
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+2, 0 
	MOVWF       _lastSync+2 
	MOVF        FLOC__Net_Ethernet_28j60_UserUDP+3, 0 
	MOVWF       _lastSync+3 
;SE9M.c,2173 :: 		marquee = bufInfo ;
	MOVLW       _bufInfo+0
	MOVWF       _marquee+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       _marquee+1 
;SE9M.c,2175 :: 		notime = 0;
	CLRF        _notime+0 
;SE9M.c,2176 :: 		notime_ovf = 0;
	CLRF        _notime_ovf+0 
;SE9M.c,2178 :: 		Time_epochToDate(epoch + tmzn * 3600l, &ts) ;
	MOVF        _tmzn+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _tmzn+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVLW       16
	MOVWF       R4 
	MOVLW       14
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       0
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__Net_Ethernet_28j60_UserUDP+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        R1, 0 
	ADDWFC      FLOC__Net_Ethernet_28j60_UserUDP+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVF        R2, 0 
	ADDWFC      FLOC__Net_Ethernet_28j60_UserUDP+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVF        R3, 0 
	ADDWFC      FLOC__Net_Ethernet_28j60_UserUDP+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVLW       _ts+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,2179 :: 		presTmr = 0;
	CLRF        _presTmr+0 
	CLRF        _presTmr+1 
;SE9M.c,2180 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,2181 :: 		if (lcdEvent) {
	MOVF        _lcdEvent+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Net_Ethernet_28j60_UserUDP113
;SE9M.c,2182 :: 		mkLCDLine(1, conf.dhcpen) ; // update lcd: first row
	MOVLW       1
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+0, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2183 :: 		mkLCDLine(2, conf.lcdL2) ; // update lcd: second row
	MOVLW       2
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+1, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2184 :: 		lcdEvent = 0 ;             // clear lcd update flag
	CLRF        _lcdEvent+0 
;SE9M.c,2185 :: 		marquee++ ;                // set marquee pointer
	INFSNZ      _marquee+0, 1 
	INCF        _marquee+1, 1 
;SE9M.c,2186 :: 		}
L_Net_Ethernet_28j60_UserUDP113:
;SE9M.c,2188 :: 		presTmr = 0;
	CLRF        _presTmr+0 
	CLRF        _presTmr+1 
;SE9M.c,2189 :: 		lcdTmr = 0;
	CLRF        _lcdTmr+0 
	CLRF        _lcdTmr+1 
;SE9M.c,2190 :: 		Display_Time();
	CALL        _Display_Time+0, 0
;SE9M.c,2191 :: 		} else {
	GOTO        L_Net_Ethernet_28j60_UserUDP114
L_Net_Ethernet_28j60_UserUDP109:
;SE9M.c,2192 :: 		return(0) ;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_Net_Ethernet_28j60_UserUDP
;SE9M.c,2193 :: 		}
L_Net_Ethernet_28j60_UserUDP114:
;SE9M.c,2194 :: 		} else {
	GOTO        L_Net_Ethernet_28j60_UserUDP115
L_Net_Ethernet_28j60_UserUDP108:
;SE9M.c,2195 :: 		return(0) ;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_Net_Ethernet_28j60_UserUDP
;SE9M.c,2196 :: 		}
L_Net_Ethernet_28j60_UserUDP115:
;SE9M.c,2197 :: 		}
L_end_Net_Ethernet_28j60_UserUDP:
	RETURN      0
; end of _Net_Ethernet_28j60_UserUDP

_interrupt:

;SE9M.c,2199 :: 		void interrupt() {
;SE9M.c,2201 :: 		if (PIR1.RCIF == 1) {
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt116
;SE9M.c,2202 :: 		prkomanda = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _prkomanda+0 
;SE9M.c,2203 :: 		if ( ( (ipt == 0) && (prkomanda == 0xAA) ) || (ipt != 0) ) {
	MOVF        _ipt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt241
	MOVF        _prkomanda+0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt241
	GOTO        L__interrupt240
L__interrupt241:
	MOVF        _ipt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt240
	GOTO        L_interrupt121
L__interrupt240:
;SE9M.c,2204 :: 		comand[ipt] = prkomanda;
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
;SE9M.c,2205 :: 		ipt++;
	INCF        _ipt+0, 1 
;SE9M.c,2206 :: 		}
L_interrupt121:
;SE9M.c,2207 :: 		if (prkomanda == 0xBB) {
	MOVF        _prkomanda+0, 0 
	XORLW       187
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt122
;SE9M.c,2208 :: 		komgotovo = 1;
	MOVLW       1
	MOVWF       _komgotovo+0 
;SE9M.c,2209 :: 		ipt = 0;
	CLRF        _ipt+0 
;SE9M.c,2210 :: 		}
L_interrupt122:
;SE9M.c,2211 :: 		if (ipt > 18) {
	MOVF        _ipt+0, 0 
	SUBLW       18
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt123
;SE9M.c,2212 :: 		ipt = 0;
	CLRF        _ipt+0 
;SE9M.c,2213 :: 		}
L_interrupt123:
;SE9M.c,2214 :: 		}
L_interrupt116:
;SE9M.c,2216 :: 		if (INTCON.TMR0IF) {
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt124
;SE9M.c,2217 :: 		presTmr++ ;
	INFSNZ      _presTmr+0, 1 
	INCF        _presTmr+1, 1 
;SE9M.c,2218 :: 		lcdTmr++ ;
	INFSNZ      _lcdTmr+0, 1 
	INCF        _lcdTmr+1, 1 
;SE9M.c,2219 :: 		if (presTmr == 15625) {
	MOVF        _presTmr+1, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt289
	MOVLW       9
	XORWF       _presTmr+0, 0 
L__interrupt289:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt125
;SE9M.c,2222 :: 		if (tmr_rst_en == 1) {
	MOVF        _tmr_rst_en+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt126
;SE9M.c,2223 :: 		tmr_rst++;
	INCF        _tmr_rst+0, 1 
;SE9M.c,2224 :: 		if (tmr_rst == 178) {
	MOVF        _tmr_rst+0, 0 
	XORLW       178
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt127
;SE9M.c,2225 :: 		tmr_rst = 0;
	CLRF        _tmr_rst+0 
;SE9M.c,2226 :: 		tmr_rst_en = 0;
	CLRF        _tmr_rst_en+0 
;SE9M.c,2227 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,2228 :: 		}
L_interrupt127:
;SE9M.c,2229 :: 		} else {
	GOTO        L_interrupt128
L_interrupt126:
;SE9M.c,2230 :: 		tmr_rst = 0;
	CLRF        _tmr_rst+0 
;SE9M.c,2231 :: 		}
L_interrupt128:
;SE9M.c,2235 :: 		notime++;
	INCF        _notime+0, 1 
;SE9M.c,2236 :: 		if (notime == 32) {
	MOVF        _notime+0, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt129
;SE9M.c,2237 :: 		notime = 0;
	CLRF        _notime+0 
;SE9M.c,2238 :: 		notime_ovf = 1;
	MOVLW       1
	MOVWF       _notime_ovf+0 
;SE9M.c,2239 :: 		}
L_interrupt129:
;SE9M.c,2243 :: 		if ( (lease_tmr == 1) && (lease_time < 250) ) {
	MOVF        _lease_tmr+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt132
	MOVLW       250
	SUBWF       _lease_time+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt132
L__interrupt239:
;SE9M.c,2244 :: 		lease_time++;
	INCF        _lease_time+0, 1 
;SE9M.c,2245 :: 		} else {
	GOTO        L_interrupt133
L_interrupt132:
;SE9M.c,2246 :: 		lease_time = 0;
	CLRF        _lease_time+0 
;SE9M.c,2247 :: 		}
L_interrupt133:
;SE9M.c,2251 :: 		Net_Ethernet_28j60_UserTimerSec++ ;
	MOVLW       1
	ADDWF       _Net_Ethernet_28j60_UserTimerSec+0, 1 
	MOVLW       0
	ADDWFC      _Net_Ethernet_28j60_UserTimerSec+1, 1 
	ADDWFC      _Net_Ethernet_28j60_UserTimerSec+2, 1 
	ADDWFC      _Net_Ethernet_28j60_UserTimerSec+3, 1 
;SE9M.c,2252 :: 		epoch++ ;
	MOVLW       1
	ADDWF       _epoch+0, 1 
	MOVLW       0
	ADDWFC      _epoch+1, 1 
	ADDWFC      _epoch+2, 1 
	ADDWFC      _epoch+3, 1 
;SE9M.c,2253 :: 		presTmr = 0 ;
	CLRF        _presTmr+0 
	CLRF        _presTmr+1 
;SE9M.c,2257 :: 		if (timer_flag < 2555) {
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORLW       9
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt290
	MOVLW       251
	SUBWF       _timer_flag+0, 0 
L__interrupt290:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt134
;SE9M.c,2258 :: 		timer_flag++;
	INCF        _timer_flag+0, 1 
;SE9M.c,2259 :: 		} else {
	GOTO        L_interrupt135
L_interrupt134:
;SE9M.c,2260 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2261 :: 		}
L_interrupt135:
;SE9M.c,2266 :: 		req_tmr_1++;
	INCF        _req_tmr_1+0, 1 
;SE9M.c,2267 :: 		if (req_tmr_1 == 60) {
	MOVF        _req_tmr_1+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt136
;SE9M.c,2268 :: 		req_tmr_1 = 0;
	CLRF        _req_tmr_1+0 
;SE9M.c,2269 :: 		req_tmr_2++;
	INCF        _req_tmr_2+0, 1 
;SE9M.c,2270 :: 		}
L_interrupt136:
;SE9M.c,2271 :: 		if (req_tmr_2 == 60) {
	MOVF        _req_tmr_2+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt137
;SE9M.c,2272 :: 		req_tmr_2 = 0;
	CLRF        _req_tmr_2+0 
;SE9M.c,2273 :: 		req_tmr_3++;
	INCF        _req_tmr_3+0, 1 
;SE9M.c,2274 :: 		}
L_interrupt137:
;SE9M.c,2278 :: 		if (rst_flag == 1) {
	MOVF        _rst_flag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt138
;SE9M.c,2279 :: 		rst_flag_1++;
	INCF        _rst_flag_1+0, 1 
;SE9M.c,2280 :: 		}
L_interrupt138:
;SE9M.c,2284 :: 		if ( (rst_fab_tmr == 1) && (rst_fab_flag < 200) ) {
	MOVF        _rst_fab_tmr+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt141
	MOVLW       200
	SUBWF       _rst_fab_flag+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt141
L__interrupt238:
;SE9M.c,2285 :: 		rst_fab_flag++;
	INCF        _rst_fab_flag+0, 1 
;SE9M.c,2286 :: 		}
L_interrupt141:
;SE9M.c,2289 :: 		}
L_interrupt125:
;SE9M.c,2291 :: 		if (lcdTmr == 3125) {
	MOVF        _lcdTmr+1, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt291
	MOVLW       53
	XORWF       _lcdTmr+0, 0 
L__interrupt291:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt142
;SE9M.c,2292 :: 		lcdEvent = 1;
	MOVLW       1
	MOVWF       _lcdEvent+0 
;SE9M.c,2293 :: 		lcdTmr = 0;
	CLRF        _lcdTmr+0 
	CLRF        _lcdTmr+1 
;SE9M.c,2294 :: 		}
L_interrupt142:
;SE9M.c,2295 :: 		INTCON.TMR0IF = 0 ;              // clear timer0 overflow flag
	BCF         INTCON+0, 2 
;SE9M.c,2296 :: 		}
L_interrupt124:
;SE9M.c,2297 :: 		}
L_end_interrupt:
L__interrupt288:
	RETFIE      1
; end of _interrupt

_Print_Blank:

;SE9M.c,2300 :: 		void Print_Blank() {
;SE9M.c,2301 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2302 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2303 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2304 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2305 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2306 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2307 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2308 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2309 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2310 :: 		delay_ms(1000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_Print_Blank143:
	DECFSZ      R13, 1, 1
	BRA         L_Print_Blank143
	DECFSZ      R12, 1, 1
	BRA         L_Print_Blank143
	DECFSZ      R11, 1, 1
	BRA         L_Print_Blank143
;SE9M.c,2311 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2312 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2313 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2314 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2315 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2316 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2317 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2318 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2319 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2320 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2321 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_Blank144:
	DECFSZ      R13, 1, 1
	BRA         L_Print_Blank144
	DECFSZ      R12, 1, 1
	BRA         L_Print_Blank144
	DECFSZ      R11, 1, 1
	BRA         L_Print_Blank144
	NOP
;SE9M.c,2322 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2323 :: 		}
L_end_Print_Blank:
	RETURN      0
; end of _Print_Blank

_Print_All:

;SE9M.c,2325 :: 		void Print_All() {
;SE9M.c,2329 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2330 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2331 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2332 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2333 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2334 :: 		PRINT_S(Print_Seg(15, 1));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	MOVLW       1
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2335 :: 		PRINT_S(Print_Seg(15, 1));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	MOVLW       1
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2336 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2337 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2338 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_All145:
	DECFSZ      R13, 1, 1
	BRA         L_Print_All145
	DECFSZ      R12, 1, 1
	BRA         L_Print_All145
	DECFSZ      R11, 1, 1
	BRA         L_Print_All145
	NOP
;SE9M.c,2339 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2340 :: 		for (pebr = 0; pebr <= 9; pebr++) {
	CLRF        Print_All_pebr_L0+0 
L_Print_All146:
	MOVF        Print_All_pebr_L0+0, 0 
	SUBLW       9
	BTFSS       STATUS+0, 0 
	GOTO        L_Print_All147
;SE9M.c,2341 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2342 :: 		if ( (pebr == 1) || (pebr == 3) || (pebr == 5) || (pebr == 7) || (pebr == 9) ) {
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All242
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All242
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All242
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All242
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All242
	GOTO        L_Print_All151
L__Print_All242:
;SE9M.c,2343 :: 		tck1 = 1;
	MOVLW       1
	MOVWF       Print_All_tck1_L0+0 
;SE9M.c,2344 :: 		tck2 = 0;
	CLRF        Print_All_tck2_L0+0 
;SE9M.c,2345 :: 		} else {
	GOTO        L_Print_All152
L_Print_All151:
;SE9M.c,2346 :: 		tck1 = 0;
	CLRF        Print_All_tck1_L0+0 
;SE9M.c,2347 :: 		tck2 = 1;
	MOVLW       1
	MOVWF       Print_All_tck2_L0+0 
;SE9M.c,2348 :: 		}
L_Print_All152:
;SE9M.c,2349 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2350 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2351 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2352 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2353 :: 		PRINT_S(Print_Seg(pebr, tck1));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        Print_All_tck1_L0+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2354 :: 		PRINT_S(Print_Seg(pebr, tck2));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        Print_All_tck2_L0+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2355 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2356 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2357 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_All153:
	DECFSZ      R13, 1, 1
	BRA         L_Print_All153
	DECFSZ      R12, 1, 1
	BRA         L_Print_All153
	DECFSZ      R11, 1, 1
	BRA         L_Print_All153
	NOP
;SE9M.c,2358 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2340 :: 		for (pebr = 0; pebr <= 9; pebr++) {
	INCF        Print_All_pebr_L0+0, 1 
;SE9M.c,2359 :: 		}
	GOTO        L_Print_All146
L_Print_All147:
;SE9M.c,2360 :: 		}
L_end_Print_All:
	RETURN      0
; end of _Print_All

_Print_Pme:

;SE9M.c,2363 :: 		void Print_Pme() {
;SE9M.c,2364 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2365 :: 		PRINT_S(Print_Seg(14, 0));
	MOVLW       14
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2366 :: 		PRINT_S(Print_Seg(14, 0));
	MOVLW       14
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2367 :: 		PRINT_S(Print_Seg(13, 0));
	MOVLW       13
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2368 :: 		PRINT_S(Print_Seg(12, 0));
	MOVLW       12
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2369 :: 		PRINT_S(Print_Seg(11, 0));
	MOVLW       11
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2370 :: 		PRINT_S(Print_Seg(10, 0));
	MOVLW       10
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2371 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2372 :: 		}
L_end_Print_Pme:
	RETURN      0
; end of _Print_Pme

_Print_Light:

;SE9M.c,2375 :: 		void Print_Light() {
;SE9M.c,2376 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;SE9M.c,2377 :: 		light_res = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _light_res+0 
	MOVF        R1, 0 
	MOVWF       _light_res+1 
;SE9M.c,2378 :: 		result = light_res * 0.00322265625;  // scale adc result by 100000 (3.22mV/lsb => 3.3V / 1024 = 0.00322265625...V)
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
;SE9M.c,2380 :: 		if (result <= 1.3) {                            // 1.1
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
	GOTO        L_Print_Light154
;SE9M.c,2381 :: 		PWM1_Set_Duty(max_light);
	MOVF        _max_light+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2382 :: 		}
L_Print_Light154:
;SE9M.c,2383 :: 		if ( (result > 1.3) && (result <= 2.3) ) {      // 1.1 - 2.2
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
	GOTO        L_Print_Light157
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
	GOTO        L_Print_Light157
L__Print_Light243:
;SE9M.c,2384 :: 		PWM1_Set_Duty((max_light*2)/3);
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
;SE9M.c,2385 :: 		}
L_Print_Light157:
;SE9M.c,2386 :: 		if (result > 2.3) {
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
	GOTO        L_Print_Light158
;SE9M.c,2387 :: 		PWM1_Set_Duty(max_light/3);                  // 2.2
	MOVLW       3
	MOVWF       R4 
	MOVF        _max_light+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2388 :: 		}
L_Print_Light158:
;SE9M.c,2390 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2391 :: 		}
L_end_Print_Light:
	RETURN      0
; end of _Print_Light

_Mem_Read:

;SE9M.c,2394 :: 		void Mem_Read() {
;SE9M.c,2396 :: 		MSSPEN  = 1;
	BSF         RE0_bit+0, BitPos(RE0_bit+0) 
;SE9M.c,2397 :: 		asm nop;
	NOP
;SE9M.c,2398 :: 		asm nop;
	NOP
;SE9M.c,2399 :: 		asm nop;
	NOP
;SE9M.c,2400 :: 		I2C1_Init(100000);
	MOVLW       80
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;SE9M.c,2401 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;SE9M.c,2402 :: 		I2C1_Wr(0xA2);
	MOVLW       162
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SE9M.c,2403 :: 		I2C1_Wr(0xFA);
	MOVLW       250
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SE9M.c,2404 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;SE9M.c,2405 :: 		I2C1_Wr(0xA3);
	MOVLW       163
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SE9M.c,2406 :: 		for(membr=0 ; membr<=4 ; membr++) {
	CLRF        Mem_Read_membr_L0+0 
L_Mem_Read159:
	MOVF        Mem_Read_membr_L0+0, 0 
	SUBLW       4
	BTFSS       STATUS+0, 0 
	GOTO        L_Mem_Read160
;SE9M.c,2407 :: 		macAddr[membr] = I2C1_Rd(1);
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
;SE9M.c,2406 :: 		for(membr=0 ; membr<=4 ; membr++) {
	INCF        Mem_Read_membr_L0+0, 1 
;SE9M.c,2408 :: 		}
	GOTO        L_Mem_Read159
L_Mem_Read160:
;SE9M.c,2409 :: 		macAddr[5] = I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _macAddr+5 
;SE9M.c,2410 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;SE9M.c,2411 :: 		MSSPEN  = 0;
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;SE9M.c,2412 :: 		asm nop;
	NOP
;SE9M.c,2413 :: 		asm nop;
	NOP
;SE9M.c,2414 :: 		asm nop;
	NOP
;SE9M.c,2416 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;SE9M.c,2418 :: 		}
L_end_Mem_Read:
	RETURN      0
; end of _Mem_Read

_main:

;SE9M.c,2423 :: 		void main() {
;SE9M.c,2425 :: 		TRISA = 0b00000001;
	MOVLW       1
	MOVWF       TRISA+0 
;SE9M.c,2426 :: 		PORTA = 0;
	CLRF        PORTA+0 
;SE9M.c,2427 :: 		TRISB = 0;
	CLRF        TRISB+0 
;SE9M.c,2428 :: 		PORTB = 0;
	CLRF        PORTB+0 
;SE9M.c,2429 :: 		TRISC = 0;
	CLRF        TRISC+0 
;SE9M.c,2430 :: 		PORTC = 0;
	CLRF        PORTC+0 
;SE9M.c,2432 :: 		Com_En_Direction = 0;
	BCF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;SE9M.c,2433 :: 		Com_En = 0;
	BCF         RB0_bit+0, BitPos(RB0_bit+0) 
;SE9M.c,2435 :: 		Kom_En_1_Direction = 0;
	BCF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;SE9M.c,2436 :: 		Kom_En_1 = 1;
	BSF         RB1_bit+0, BitPos(RB1_bit+0) 
;SE9M.c,2438 :: 		Kom_En_2_Direction = 0;
	BCF         TRISB3_bit+0, BitPos(TRISB3_bit+0) 
;SE9M.c,2439 :: 		Kom_En_2 = 0;
	BCF         RB3_bit+0, BitPos(RB3_bit+0) 
;SE9M.c,2441 :: 		Eth1_Link_Direction = 1;
	BSF         TRISB5_bit+0, BitPos(TRISB5_bit+0) 
;SE9M.c,2443 :: 		Net_Ethernet_28j60_Rst_Direction = 0;
	BCF         TRISA5_bit+0, BitPos(TRISA5_bit+0) 
;SE9M.c,2444 :: 		Net_Ethernet_28j60_Rst = 0;
	BCF         LATA5_bit+0, BitPos(LATA5_bit+0) 
;SE9M.c,2445 :: 		Net_Ethernet_28j60_CS_Direction  = 0;
	BCF         TRISA4_bit+0, BitPos(TRISA4_bit+0) 
;SE9M.c,2446 :: 		Net_Ethernet_28j60_CS  = 0;
	BCF         LATA4_bit+0, BitPos(LATA4_bit+0) 
;SE9M.c,2448 :: 		RSTPIN_Direction = 1;
	BSF         TRISD4_bit+0, BitPos(TRISD4_bit+0) 
;SE9M.c,2450 :: 		DISPEN_Direction = 0;
	BCF         TRISE2_bit+0, BitPos(TRISE2_bit+0) 
;SE9M.c,2451 :: 		DISPEN = 0;
	BCF         RE2_bit+0, BitPos(RE2_bit+0) 
;SE9M.c,2453 :: 		MSSPEN_Direction = 0;
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;SE9M.c,2454 :: 		MSSPEN = 0;
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;SE9M.c,2456 :: 		SV_DATA_Direction = 0;
	BCF         TRISA1_bit+0, BitPos(TRISA1_bit+0) 
;SE9M.c,2457 :: 		SV_DATA = 0;
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;SE9M.c,2458 :: 		SV_CLK_Direction = 0;
	BCF         TRISA2_bit+0, BitPos(TRISA2_bit+0) 
;SE9M.c,2459 :: 		SV_CLK = 0;
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
;SE9M.c,2460 :: 		STROBE_Direction = 0;
	BCF         TRISA3_bit+0, BitPos(TRISA3_bit+0) 
;SE9M.c,2461 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2463 :: 		BCKL_Direction = 0;
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;SE9M.c,2464 :: 		BCKL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;SE9M.c,2466 :: 		ANSEL = 0;
	CLRF        ANSEL+0 
;SE9M.c,2467 :: 		ANSELH = 0;
	CLRF        ANSELH+0 
;SE9M.c,2469 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;SE9M.c,2470 :: 		ADCON1 = 0b00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;SE9M.c,2472 :: 		max_light = 180;
	MOVLW       180
	MOVWF       _max_light+0 
;SE9M.c,2473 :: 		min_light = 30;
	MOVLW       30
	MOVWF       _min_light+0 
;SE9M.c,2475 :: 		PWM1_Init(2000);
	BSF         T2CON+0, 0, 0
	BSF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;SE9M.c,2476 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;SE9M.c,2477 :: 		PWM1_Set_Duty(max_light);      // 90
	MOVF        _max_light+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2480 :: 		for(ik = 0; ik < NUM_OF_SOCKET_28j60; ik++)
	CLRF        _ik+0 
L_main162:
	MOVLW       _NUM_OF_SOCKET_28j60
	SUBWF       _ik+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main163
;SE9M.c,2481 :: 		pos[ik] = 0;
	MOVF        _ik+0, 0 
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
;SE9M.c,2480 :: 		for(ik = 0; ik < NUM_OF_SOCKET_28j60; ik++)
	INCF        _ik+0, 1 
;SE9M.c,2481 :: 		pos[ik] = 0;
	GOTO        L_main162
L_main163:
;SE9M.c,2483 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       3
	MOVWF       SPBRGH+0 
	MOVLW       64
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;SE9M.c,2484 :: 		PIE1.RCIE = 1;
	BSF         PIE1+0, 5 
;SE9M.c,2485 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;SE9M.c,2486 :: 		PEIE_bit = 1;
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;SE9M.c,2488 :: 		T0CON = 0b11000000 ;
	MOVLW       192
	MOVWF       T0CON+0 
;SE9M.c,2489 :: 		INTCON.TMR0IF = 0 ;
	BCF         INTCON+0, 2 
;SE9M.c,2490 :: 		INTCON.TMR0IE = 1 ;
	BSF         INTCON+0, 5 
;SE9M.c,2494 :: 		while(1) {
L_main165:
;SE9M.c,2496 :: 		pom_time_pom = EEPROM_Read(0);
	CLRF        FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pom_time_pom+0 
;SE9M.c,2498 :: 		if ( (pom_time_pom != 0xAA) || (rst_fab == 1) ) {
	MOVF        R0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L__main250
	MOVF        _rst_fab+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__main250
	GOTO        L_main169
L__main250:
;SE9M.c,2500 :: 		conf.dhcpen = 1;
	MOVLW       1
	MOVWF       _conf+0 
;SE9M.c,2501 :: 		EEPROM_Write(103, conf.dhcpen);
	MOVLW       103
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2502 :: 		mode = 1;
	MOVLW       1
	MOVWF       _mode+0 
;SE9M.c,2503 :: 		EEPROM_Write(104, mode);
	MOVLW       104
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2504 :: 		dhcp_flag = 0;
	CLRF        _dhcp_flag+0 
;SE9M.c,2505 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2507 :: 		strcpy(sifra, "adminpme");
	MOVLW       _sifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr50_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr50_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2508 :: 		for (j=0;j<=8;j++) {
	CLRF        _j+0 
L_main170:
	MOVF        _j+0, 0 
	SUBLW       8
	BTFSS       STATUS+0, 0 
	GOTO        L_main171
;SE9M.c,2509 :: 		EEPROM_Write(j+20, sifra[j]);
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
;SE9M.c,2508 :: 		for (j=0;j<=8;j++) {
	INCF        _j+0, 1 
;SE9M.c,2510 :: 		}
	GOTO        L_main170
L_main171:
;SE9M.c,2512 :: 		strcpy(server1, "swisstime.ethz.ch");
	MOVLW       _server1+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_server1+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr51_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr51_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2513 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main173:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main174
;SE9M.c,2514 :: 		EEPROM_Write(j+29, server1[j]);
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
;SE9M.c,2513 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2515 :: 		}
	GOTO        L_main173
L_main174:
;SE9M.c,2516 :: 		strcpy(server2, "0.rs.pool.ntp.org");
	MOVLW       _server2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_server2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr52_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr52_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2517 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main176:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main177
;SE9M.c,2518 :: 		EEPROM_Write(j+56, server2[j]);
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
;SE9M.c,2517 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2519 :: 		}
	GOTO        L_main176
L_main177:
;SE9M.c,2520 :: 		strcpy(server3, "pool.ntp.org");
	MOVLW       _server3+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_server3+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr53_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr53_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2521 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main179:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main180
;SE9M.c,2522 :: 		EEPROM_Write(j+110, server3[j]);
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
;SE9M.c,2521 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2523 :: 		}
	GOTO        L_main179
L_main180:
;SE9M.c,2526 :: 		ipAddr[0]    = 192;
	MOVLW       192
	MOVWF       _ipAddr+0 
;SE9M.c,2527 :: 		ipAddr[1]    = 168;
	MOVLW       168
	MOVWF       _ipAddr+1 
;SE9M.c,2528 :: 		ipAddr[2]    = 1;
	MOVLW       1
	MOVWF       _ipAddr+2 
;SE9M.c,2529 :: 		ipAddr[3]    = 99;
	MOVLW       99
	MOVWF       _ipAddr+3 
;SE9M.c,2530 :: 		gwIpAddr[0]  = 192;
	MOVLW       192
	MOVWF       _gwIpAddr+0 
;SE9M.c,2531 :: 		gwIpAddr[1]  = 168;
	MOVLW       168
	MOVWF       _gwIpAddr+1 
;SE9M.c,2532 :: 		gwIpAddr[2]  = 1;
	MOVLW       1
	MOVWF       _gwIpAddr+2 
;SE9M.c,2533 :: 		gwIpAddr[3]  = 1;
	MOVLW       1
	MOVWF       _gwIpAddr+3 
;SE9M.c,2534 :: 		ipMask[0]    = 255;
	MOVLW       255
	MOVWF       _ipMask+0 
;SE9M.c,2535 :: 		ipMask[1]    = 255;
	MOVLW       255
	MOVWF       _ipMask+1 
;SE9M.c,2536 :: 		ipMask[2]    = 255;
	MOVLW       255
	MOVWF       _ipMask+2 
;SE9M.c,2537 :: 		ipMask[3]    = 0;
	CLRF        _ipMask+3 
;SE9M.c,2538 :: 		dnsIpAddr[0] = 192;
	MOVLW       192
	MOVWF       _dnsIpAddr+0 
;SE9M.c,2539 :: 		dnsIpAddr[1] = 168;
	MOVLW       168
	MOVWF       _dnsIpAddr+1 
;SE9M.c,2540 :: 		dnsIpAddr[2] = 1;
	MOVLW       1
	MOVWF       _dnsIpAddr+2 
;SE9M.c,2541 :: 		dnsIpAddr[3] = 1;
	MOVLW       1
	MOVWF       _dnsIpAddr+3 
;SE9M.c,2544 :: 		EEPROM_Write(1, ipAddr[0]);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2545 :: 		EEPROM_Write(2, ipAddr[1]);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2546 :: 		EEPROM_Write(3, ipAddr[2]);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2547 :: 		EEPROM_Write(4, ipAddr[3]);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2548 :: 		EEPROM_Write(5, gwIpAddr[0]);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2549 :: 		EEPROM_Write(6, gwIpAddr[1]);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2550 :: 		EEPROM_Write(7, gwIpAddr[2]);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2551 :: 		EEPROM_Write(8, gwIpAddr[3]);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2552 :: 		EEPROM_Write(9, ipMask[0]);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2553 :: 		EEPROM_Write(10, ipMask[1]);
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2554 :: 		EEPROM_Write(11, ipMask[2]);
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2555 :: 		EEPROM_Write(12, ipMask[3]);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2556 :: 		EEPROM_Write(13, dnsIpAddr[0]);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2557 :: 		EEPROM_Write(14, dnsIpAddr[1]);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2558 :: 		EEPROM_Write(15, dnsIpAddr[2]);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2559 :: 		EEPROM_Write(16, dnsIpAddr[3]);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2561 :: 		ByteToStr(ipAddr[0], IpAddrPom0);
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2562 :: 		ByteToStr(ipAddr[1], IpAddrPom1);
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2563 :: 		ByteToStr(ipAddr[2], IpAddrPom2);
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2564 :: 		ByteToStr(ipAddr[3], IpAddrPom3);
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2566 :: 		ByteToStr(gwIpAddr[0], gwIpAddrPom0);
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2567 :: 		ByteToStr(gwIpAddr[1], gwIpAddrPom1);
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2568 :: 		ByteToStr(gwIpAddr[2], gwIpAddrPom2);
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2569 :: 		ByteToStr(gwIpAddr[3], gwIpAddrPom3);
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2571 :: 		ByteToStr(ipMask[0], ipMaskPom0);
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2572 :: 		ByteToStr(ipMask[1], ipMaskPom1);
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2573 :: 		ByteToStr(ipMask[2], ipMaskPom2);
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2574 :: 		ByteToStr(ipMask[3], ipMaskPom3);
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2576 :: 		ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2577 :: 		ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2578 :: 		ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2579 :: 		ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2581 :: 		rst_fab = 0;
	CLRF        _rst_fab+0 
;SE9M.c,2582 :: 		pom_time_pom = 0xAA;
	MOVLW       170
	MOVWF       _pom_time_pom+0 
;SE9M.c,2583 :: 		EEPROM_Write(0, pom_time_pom);
	CLRF        FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       170
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2584 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main182:
	DECFSZ      R13, 1, 1
	BRA         L_main182
	DECFSZ      R12, 1, 1
	BRA         L_main182
	DECFSZ      R11, 1, 1
	BRA         L_main182
;SE9M.c,2585 :: 		}
L_main169:
;SE9M.c,2587 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2589 :: 		sifra[0]    = EEPROM_Read(20);
	MOVLW       20
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+0 
;SE9M.c,2590 :: 		sifra[1]    = EEPROM_Read(21);
	MOVLW       21
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+1 
;SE9M.c,2591 :: 		sifra[2]    = EEPROM_Read(22);
	MOVLW       22
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+2 
;SE9M.c,2592 :: 		sifra[3]    = EEPROM_Read(23);
	MOVLW       23
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+3 
;SE9M.c,2593 :: 		sifra[4]    = EEPROM_Read(24);
	MOVLW       24
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+4 
;SE9M.c,2594 :: 		sifra[5]    = EEPROM_Read(25);
	MOVLW       25
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+5 
;SE9M.c,2595 :: 		sifra[6]    = EEPROM_Read(26);
	MOVLW       26
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+6 
;SE9M.c,2596 :: 		sifra[7]    = EEPROM_Read(27);
	MOVLW       27
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+7 
;SE9M.c,2597 :: 		sifra[8]    = EEPROM_Read(28);
	MOVLW       28
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+8 
;SE9M.c,2599 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main183:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main184
;SE9M.c,2600 :: 		server1[j] = EEPROM_Read(j+29);
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
;SE9M.c,2599 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2601 :: 		}
	GOTO        L_main183
L_main184:
;SE9M.c,2602 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main186:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main187
;SE9M.c,2603 :: 		server2[j] = EEPROM_Read(j+56);
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
;SE9M.c,2602 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2604 :: 		}
	GOTO        L_main186
L_main187:
;SE9M.c,2605 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main189:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main190
;SE9M.c,2606 :: 		server3[j] = EEPROM_Read(j+110);
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
;SE9M.c,2605 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2607 :: 		}
	GOTO        L_main189
L_main190:
;SE9M.c,2609 :: 		ipAddr[0]    = EEPROM_Read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+0 
;SE9M.c,2610 :: 		ipAddr[1]    = EEPROM_Read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+1 
;SE9M.c,2611 :: 		ipAddr[2]    = EEPROM_Read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+2 
;SE9M.c,2612 :: 		ipAddr[3]    = EEPROM_Read(4);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+3 
;SE9M.c,2613 :: 		gwIpAddr[0]  = EEPROM_Read(5);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+0 
;SE9M.c,2614 :: 		gwIpAddr[1]  = EEPROM_Read(6);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+1 
;SE9M.c,2615 :: 		gwIpAddr[2]  = EEPROM_Read(7);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+2 
;SE9M.c,2616 :: 		gwIpAddr[3]  = EEPROM_Read(8);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+3 
;SE9M.c,2617 :: 		ipMask[0]    = EEPROM_Read(9);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+0 
;SE9M.c,2618 :: 		ipMask[1]    = EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+1 
;SE9M.c,2619 :: 		ipMask[2]    = EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+2 
;SE9M.c,2620 :: 		ipMask[3]    = EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+3 
;SE9M.c,2621 :: 		dnsIpAddr[0] = EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+0 
;SE9M.c,2622 :: 		dnsIpAddr[1] = EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+1 
;SE9M.c,2623 :: 		dnsIpAddr[2] = EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+2 
;SE9M.c,2624 :: 		dnsIpAddr[3] = EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+3 
;SE9M.c,2627 :: 		if (prolaz == 1) {
	MOVF        _prolaz+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main192
;SE9M.c,2628 :: 		ByteToStr(ipAddr[0], IpAddrPom0);
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2629 :: 		ByteToStr(ipAddr[1], IpAddrPom1);
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2630 :: 		ByteToStr(ipAddr[2], IpAddrPom2);
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2631 :: 		ByteToStr(ipAddr[3], IpAddrPom3);
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2633 :: 		ByteToStr(gwIpAddr[0], gwIpAddrPom0);
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2634 :: 		ByteToStr(gwIpAddr[1], gwIpAddrPom1);
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2635 :: 		ByteToStr(gwIpAddr[2], gwIpAddrPom2);
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2636 :: 		ByteToStr(gwIpAddr[3], gwIpAddrPom3);
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2638 :: 		ByteToStr(ipMask[0], ipMaskPom0);
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2639 :: 		ByteToStr(ipMask[1], ipMaskPom1);
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2640 :: 		ByteToStr(ipMask[2], ipMaskPom2);
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2641 :: 		ByteToStr(ipMask[3], ipMaskPom3);
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2643 :: 		ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2644 :: 		ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2645 :: 		ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2646 :: 		ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2648 :: 		prolaz = 0;
	CLRF        _prolaz+0 
;SE9M.c,2649 :: 		Print_All();
	CALL        _Print_All+0, 0
;SE9M.c,2650 :: 		}
L_main192:
;SE9M.c,2652 :: 		conf.tz = EEPROM_Read(102);
	MOVLW       102
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+2 
;SE9M.c,2653 :: 		conf.dhcpen = EEPROM_Read(103);
	MOVLW       103
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+0 
;SE9M.c,2654 :: 		mode = EEPROM_Read(104);
	MOVLW       104
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _mode+0 
;SE9M.c,2655 :: 		dhcp_flag = EEPROM_Read(105);
	MOVLW       105
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dhcp_flag+0 
;SE9M.c,2657 :: 		if ( (conf.dhcpen == 0) && (dhcp_flag == 1) ) {
	MOVF        _conf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main195
	MOVF        _dhcp_flag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main195
L__main249:
;SE9M.c,2658 :: 		conf.dhcpen = 1;
	MOVLW       1
	MOVWF       _conf+0 
;SE9M.c,2659 :: 		EEPROM_Write(103, conf.dhcpen);
	MOVLW       103
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2660 :: 		dhcp_flag = 0;
	CLRF        _dhcp_flag+0 
;SE9M.c,2661 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2662 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main196:
	DECFSZ      R13, 1, 1
	BRA         L_main196
	DECFSZ      R12, 1, 1
	BRA         L_main196
	DECFSZ      R11, 1, 1
	BRA         L_main196
;SE9M.c,2663 :: 		}
L_main195:
;SE9M.c,2665 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2667 :: 		if (reset_eth == 1) {
	MOVF        _reset_eth+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main197
;SE9M.c,2668 :: 		reset_eth = 0;
	CLRF        _reset_eth+0 
;SE9M.c,2669 :: 		prvi_timer = 1;
	MOVLW       1
	MOVWF       _prvi_timer+0 
;SE9M.c,2670 :: 		drugi_timer = 0;
	CLRF        _drugi_timer+0 
;SE9M.c,2671 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2673 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2674 :: 		}
L_main197:
;SE9M.c,2675 :: 		if ( (prvi_timer == 1) && (timer_flag >= 1) ) {
	MOVF        _prvi_timer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main200
	MOVLW       1
	SUBWF       _timer_flag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main200
L__main248:
;SE9M.c,2676 :: 		prvi_timer = 0;
	CLRF        _prvi_timer+0 
;SE9M.c,2677 :: 		drugi_timer = 1;
	MOVLW       1
	MOVWF       _drugi_timer+0 
;SE9M.c,2678 :: 		Net_Ethernet_28j60_Rst = 1;
	BSF         LATA5_bit+0, BitPos(LATA5_bit+0) 
;SE9M.c,2679 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2680 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2681 :: 		}
L_main200:
;SE9M.c,2682 :: 		if ( (drugi_timer == 1) && (timer_flag >= 1) ) {
	MOVF        _drugi_timer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main203
	MOVLW       1
	SUBWF       _timer_flag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main203
L__main247:
;SE9M.c,2683 :: 		prvi_timer = 0;
	CLRF        _prvi_timer+0 
;SE9M.c,2684 :: 		drugi_timer = 0;
	CLRF        _drugi_timer+0 
;SE9M.c,2685 :: 		link_enable = 1;
	MOVLW       1
	MOVWF       _link_enable+0 
;SE9M.c,2686 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2687 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2688 :: 		}
L_main203:
;SE9M.c,2689 :: 		if ( (Eth1_Link == 0) && (link == 0) && (link_enable == 1) ) {
	BTFSC       RB5_bit+0, BitPos(RB5_bit+0) 
	GOTO        L_main206
	MOVF        _link+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main206
	MOVF        _link_enable+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main206
L__main246:
;SE9M.c,2690 :: 		link = 1;
	MOVLW       1
	MOVWF       _link+0 
;SE9M.c,2691 :: 		tacka1 = 1;
	MOVLW       1
	MOVWF       _tacka1+0 
;SE9M.c,2692 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2695 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2696 :: 		if (conf.dhcpen == 0) {
	MOVF        _conf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main207
;SE9M.c,2697 :: 		Mem_Read();
	CALL        _Mem_Read+0, 0
;SE9M.c,2698 :: 		ipAddr[0] = 0;
	CLRF        _ipAddr+0 
;SE9M.c,2699 :: 		ipAddr[1] = 0;
	CLRF        _ipAddr+1 
;SE9M.c,2700 :: 		ipAddr[2] = 0;
	CLRF        _ipAddr+2 
;SE9M.c,2701 :: 		ipAddr[3] = 0;
	CLRF        _ipAddr+3 
;SE9M.c,2703 :: 		dhcp_flag = 1;
	MOVLW       1
	MOVWF       _dhcp_flag+0 
;SE9M.c,2704 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2705 :: 		Net_Ethernet_28j60_Init(macAddr, ipAddr, Net_Ethernet_28j60_FULLDUPLEX) ;
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
;SE9M.c,2706 :: 		Net_Ethernet_28j60_stackInitTCP();
	CALL        _Net_Ethernet_28j60_stackInitTCP+0, 0
;SE9M.c,2707 :: 		while (Net_Ethernet_28j60_initDHCP(5) == 0) ; // try to get one from DHCP until it works
L_main208:
	MOVLW       5
	MOVWF       FARG_Net_Ethernet_28j60_initDHCP_tmax+0 
	CALL        _Net_Ethernet_28j60_initDHCP+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main209
	GOTO        L_main208
L_main209:
;SE9M.c,2708 :: 		memcpy(ipAddr,    Net_Ethernet_28j60_getIpAddress(),    4) ; // get assigned IP address
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
;SE9M.c,2709 :: 		memcpy(ipMask,    Net_Ethernet_28j60_getIpMask(),       4) ; // get assigned IP mask
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
;SE9M.c,2710 :: 		memcpy(gwIpAddr,  Net_Ethernet_28j60_getGwIpAddress(),  4) ; // get assigned gateway IP address
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
;SE9M.c,2711 :: 		memcpy(dnsIpAddr, Net_Ethernet_28j60_getDnsIpAddress(), 4) ; // get assigned dns IP address
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
;SE9M.c,2713 :: 		lease_tmr = 1;
	MOVLW       1
	MOVWF       _lease_tmr+0 
;SE9M.c,2714 :: 		lease_time = 0;
	CLRF        _lease_time+0 
;SE9M.c,2716 :: 		EEPROM_Write(1, ipAddr[0]);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2717 :: 		EEPROM_Write(2, ipAddr[1]);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2718 :: 		EEPROM_Write(3, ipAddr[2]);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2719 :: 		EEPROM_Write(4, ipAddr[3]);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2720 :: 		EEPROM_Write(5, gwIpAddr[0]);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2721 :: 		EEPROM_Write(6, gwIpAddr[1]);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2722 :: 		EEPROM_Write(7, gwIpAddr[2]);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2723 :: 		EEPROM_Write(8, gwIpAddr[3]);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2724 :: 		EEPROM_Write(9, ipMask[0]);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2725 :: 		EEPROM_Write(10, ipMask[1]);
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2726 :: 		EEPROM_Write(11, ipMask[2]);
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2727 :: 		EEPROM_Write(12, ipMask[3]);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2728 :: 		EEPROM_Write(13, dnsIpAddr[0]);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2729 :: 		EEPROM_Write(14, dnsIpAddr[1]);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2730 :: 		EEPROM_Write(15, dnsIpAddr[2]);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2731 :: 		EEPROM_Write(16, dnsIpAddr[3]);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2733 :: 		ByteToStr(ipAddr[0], IpAddrPom0);
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2734 :: 		ByteToStr(ipAddr[1], IpAddrPom1);
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2735 :: 		ByteToStr(ipAddr[2], IpAddrPom2);
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2736 :: 		ByteToStr(ipAddr[3], IpAddrPom3);
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2738 :: 		ByteToStr(gwIpAddr[0], gwIpAddrPom0);
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2739 :: 		ByteToStr(gwIpAddr[1], gwIpAddrPom1);
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2740 :: 		ByteToStr(gwIpAddr[2], gwIpAddrPom2);
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2741 :: 		ByteToStr(gwIpAddr[3], gwIpAddrPom3);
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2743 :: 		ByteToStr(ipMask[0], ipMaskPom0);
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2744 :: 		ByteToStr(ipMask[1], ipMaskPom1);
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2745 :: 		ByteToStr(ipMask[2], ipMaskPom2);
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2746 :: 		ByteToStr(ipMask[3], ipMaskPom3);
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2748 :: 		ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2749 :: 		ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2750 :: 		ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2751 :: 		ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2753 :: 		dhcp_flag = 0;
	CLRF        _dhcp_flag+0 
;SE9M.c,2754 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2755 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main210:
	DECFSZ      R13, 1, 1
	BRA         L_main210
	DECFSZ      R12, 1, 1
	BRA         L_main210
	DECFSZ      R11, 1, 1
	BRA         L_main210
;SE9M.c,2756 :: 		Print_IP();
	CALL        _Print_IP+0, 0
;SE9M.c,2757 :: 		}
L_main207:
;SE9M.c,2758 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main211
;SE9M.c,2759 :: 		lease_tmr = 0;
	CLRF        _lease_tmr+0 
;SE9M.c,2760 :: 		Mem_Read();
	CALL        _Mem_Read+0, 0
;SE9M.c,2761 :: 		Net_Ethernet_28j60_stackInitTCP();
	CALL        _Net_Ethernet_28j60_stackInitTCP+0, 0
;SE9M.c,2762 :: 		SPI1_Init();
	CALL        _SPI1_Init+0, 0
;SE9M.c,2763 :: 		SPI_Rd_Ptr = SPI1_Read;
	MOVLW       _SPI1_Read+0
	MOVWF       _SPI_Rd_Ptr+0 
	MOVLW       hi_addr(_SPI1_Read+0)
	MOVWF       _SPI_Rd_Ptr+1 
	MOVLW       FARG_SPI1_Read_buffer+0
	MOVWF       _SPI_Rd_Ptr+2 
	MOVLW       hi_addr(FARG_SPI1_Read_buffer+0)
	MOVWF       _SPI_Rd_Ptr+3 
;SE9M.c,2764 :: 		Net_Ethernet_28j60_Init(macAddr, ipAddr, Net_Ethernet_28j60_FULLDUPLEX) ;
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
;SE9M.c,2765 :: 		Net_Ethernet_28j60_confNetwork(ipMask, gwIpAddr, dnsIpAddr) ;
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
;SE9M.c,2767 :: 		Print_IP();
	CALL        _Print_IP+0, 0
;SE9M.c,2768 :: 		}
L_main211:
;SE9M.c,2769 :: 		tacka1 = 0;
	CLRF        _tacka1+0 
;SE9M.c,2770 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2772 :: 		}
L_main206:
;SE9M.c,2775 :: 		if (Eth1_Link == 1) {
	BTFSS       RB5_bit+0, BitPos(RB5_bit+0) 
	GOTO        L_main212
;SE9M.c,2776 :: 		link = 0;
	CLRF        _link+0 
;SE9M.c,2777 :: 		lastSync = 0;
	CLRF        _lastSync+0 
	CLRF        _lastSync+1 
	CLRF        _lastSync+2 
	CLRF        _lastSync+3 
;SE9M.c,2778 :: 		}
L_main212:
;SE9M.c,2780 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2783 :: 		if (req_tmr_3 == 12) {
	MOVF        _req_tmr_3+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_main213
;SE9M.c,2784 :: 		sntpSync = 0;
	CLRF        _sntpSync+0 
;SE9M.c,2785 :: 		req_tmr_1 = 0;
	CLRF        _req_tmr_1+0 
;SE9M.c,2786 :: 		req_tmr_2 = 0;
	CLRF        _req_tmr_2+0 
;SE9M.c,2787 :: 		req_tmr_3 = 0;
	CLRF        _req_tmr_3+0 
;SE9M.c,2788 :: 		}
L_main213:
;SE9M.c,2791 :: 		if (RSTPIN == 0) {
	BTFSC       RD4_bit+0, BitPos(RD4_bit+0) 
	GOTO        L_main214
;SE9M.c,2792 :: 		rst_fab_tmr = 1;
	MOVLW       1
	MOVWF       _rst_fab_tmr+0 
;SE9M.c,2793 :: 		} else {
	GOTO        L_main215
L_main214:
;SE9M.c,2794 :: 		rst_fab_tmr = 0;
	CLRF        _rst_fab_tmr+0 
;SE9M.c,2795 :: 		rst_fab_flag = 0;
	CLRF        _rst_fab_flag+0 
;SE9M.c,2796 :: 		}
L_main215:
;SE9M.c,2797 :: 		if (rst_fab_flag >= 5) {
	MOVLW       5
	SUBWF       _rst_fab_flag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main216
;SE9M.c,2798 :: 		rst_fab_tmr = 0;
	CLRF        _rst_fab_tmr+0 
;SE9M.c,2799 :: 		rst_fab_flag = 0;
	CLRF        _rst_fab_flag+0 
;SE9M.c,2800 :: 		rst_fab = 1;
	MOVLW       1
	MOVWF       _rst_fab+0 
;SE9M.c,2801 :: 		Rst_Eth();
	CALL        _Rst_Eth+0, 0
;SE9M.c,2802 :: 		}
L_main216:
;SE9M.c,2804 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2807 :: 		if (komgotovo == 1) {
	MOVF        _komgotovo+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main217
;SE9M.c,2808 :: 		komgotovo = 0;
	CLRF        _komgotovo+0 
;SE9M.c,2809 :: 		chksum = (comand[3] ^ comand[4] ^ comand[5] ^ comand[6] ^ comand[7] ^comand[8] ^ comand[9] ^ comand[10] ^ comand[11]) & 0x7F;
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
;SE9M.c,2810 :: 		if ((comand[0] == 0xAA) && (comand[1] == 0xAA) && (comand[2] == 0xAA) && (comand[12] == chksum) && (comand[13] == 0xBB) && (link_enable == 1)) {
	MOVF        _comand+0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main220
	MOVF        _comand+1, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main220
	MOVF        _comand+2, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main220
	MOVF        _comand+12, 0 
	XORWF       _chksum+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main220
	MOVF        _comand+13, 0 
	XORLW       187
	BTFSS       STATUS+0, 2 
	GOTO        L_main220
	MOVF        _link_enable+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main220
L__main245:
;SE9M.c,2811 :: 		sati = comand[3];
	MOVF        _comand+3, 0 
	MOVWF       _sati+0 
;SE9M.c,2812 :: 		minuti = comand[4];
	MOVF        _comand+4, 0 
	MOVWF       _minuti+0 
;SE9M.c,2813 :: 		sekundi = comand[5];
	MOVF        _comand+5, 0 
	MOVWF       _sekundi+0 
;SE9M.c,2814 :: 		dan = comand[6];
	MOVF        _comand+6, 0 
	MOVWF       _dan+0 
;SE9M.c,2815 :: 		mesec = comand[7];
	MOVF        _comand+7, 0 
	MOVWF       _mesec+0 
;SE9M.c,2816 :: 		fingodina = comand[8];
	MOVF        _comand+8, 0 
	MOVWF       _fingodina+0 
;SE9M.c,2817 :: 		notime = 0;
	CLRF        _notime+0 
;SE9M.c,2818 :: 		notime_ovf = 0;
	CLRF        _notime_ovf+0 
;SE9M.c,2819 :: 		}
L_main220:
;SE9M.c,2820 :: 		}
L_main217:
;SE9M.c,2822 :: 		if (pom_mat_sek != sekundi) {
	MOVF        _pom_mat_sek+0, 0 
	XORWF       _sekundi+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main221
;SE9M.c,2823 :: 		pom_mat_sek = sekundi;
	MOVF        _sekundi+0, 0 
	MOVWF       _pom_mat_sek+0 
;SE9M.c,2824 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2826 :: 		if (disp_mode == 1) {
	MOVF        _disp_mode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main222
;SE9M.c,2827 :: 		tacka2 = 0;
	CLRF        _tacka2+0 
;SE9M.c,2828 :: 		if (tacka1 == 0) {
	MOVF        _tacka1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main223
;SE9M.c,2829 :: 		tacka1 = 1;
	MOVLW       1
	MOVWF       _tacka1+0 
;SE9M.c,2830 :: 		goto DALJE2;
	GOTO        ___main_DALJE2
;SE9M.c,2831 :: 		}
L_main223:
;SE9M.c,2832 :: 		if (tacka1 == 1) {
	MOVF        _tacka1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main224
;SE9M.c,2833 :: 		tacka1 = 0;
	CLRF        _tacka1+0 
;SE9M.c,2834 :: 		goto DALJE2;
	GOTO        ___main_DALJE2
;SE9M.c,2835 :: 		}
L_main224:
;SE9M.c,2836 :: 		DALJE2:
___main_DALJE2:
;SE9M.c,2837 :: 		bljump = 0;
	CLRF        _bljump+0 
;SE9M.c,2838 :: 		}
L_main222:
;SE9M.c,2839 :: 		if (disp_mode == 2) {
	MOVF        _disp_mode+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main225
;SE9M.c,2840 :: 		tacka1 = 0;
	CLRF        _tacka1+0 
;SE9M.c,2841 :: 		tacka2 = 1;
	MOVLW       1
	MOVWF       _tacka2+0 
;SE9M.c,2842 :: 		}
L_main225:
;SE9M.c,2843 :: 		if (notime_ovf == 1) {
	MOVF        _notime_ovf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main226
;SE9M.c,2844 :: 		tacka1 = 1;
	MOVLW       1
	MOVWF       _tacka1+0 
;SE9M.c,2845 :: 		tacka2 = 1;
	MOVLW       1
	MOVWF       _tacka2+0 
;SE9M.c,2846 :: 		}
L_main226:
;SE9M.c,2847 :: 		if (notime_ovf == 0) {
	MOVF        _notime_ovf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main227
;SE9M.c,2848 :: 		if ( (sekundi == 0) || (sekundi == 10) || (sekundi == 20) || (sekundi == 30) || (sekundi == 40) || (sekundi == 50) ) {
	MOVF        _sekundi+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__main244
	MOVF        _sekundi+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L__main244
	MOVF        _sekundi+0, 0 
	XORLW       20
	BTFSC       STATUS+0, 2 
	GOTO        L__main244
	MOVF        _sekundi+0, 0 
	XORLW       30
	BTFSC       STATUS+0, 2 
	GOTO        L__main244
	MOVF        _sekundi+0, 0 
	XORLW       40
	BTFSC       STATUS+0, 2 
	GOTO        L__main244
	MOVF        _sekundi+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L__main244
	GOTO        L_main230
L__main244:
;SE9M.c,2849 :: 		Print_Light();
	CALL        _Print_Light+0, 0
;SE9M.c,2850 :: 		}
L_main230:
;SE9M.c,2851 :: 		} else {
	GOTO        L_main231
L_main227:
;SE9M.c,2852 :: 		PWM1_Set_Duty(min_light);
	MOVF        _min_light+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2853 :: 		}
L_main231:
;SE9M.c,2854 :: 		Display_Time();
	CALL        _Display_Time+0, 0
;SE9M.c,2855 :: 		}
L_main221:
;SE9M.c,2857 :: 		Time_epochToDate(epoch + tmzn * 3600l, &ts) ;
	MOVF        _tmzn+0, 0 
	MOVWF       R0 
	MOVLW       0
	BTFSC       _tmzn+0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVLW       16
	MOVWF       R4 
	MOVLW       14
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       0
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	ADDWF       _epoch+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        R1, 0 
	ADDWFC      _epoch+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVF        R2, 0 
	ADDWFC      _epoch+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVF        R3, 0 
	ADDWFC      _epoch+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVLW       _ts+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,2858 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2859 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,2860 :: 		if (lcdEvent) {
	MOVF        _lcdEvent+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main232
;SE9M.c,2861 :: 		mkLCDLine(1, conf.dhcpen) ; // update lcd: first row
	MOVLW       1
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+0, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2862 :: 		mkLCDLine(2, conf.lcdL2) ; // update lcd: second row
	MOVLW       2
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+1, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2863 :: 		lcdEvent = 0 ;             // clear lcd update flag
	CLRF        _lcdEvent+0 
;SE9M.c,2864 :: 		marquee++ ;                // set marquee pointer
	INFSNZ      _marquee+0, 1 
	INCF        _marquee+1, 1 
;SE9M.c,2865 :: 		}
L_main232:
;SE9M.c,2867 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2868 :: 		}
	GOTO        L_main165
;SE9M.c,2869 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
