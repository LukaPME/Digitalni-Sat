
_Eth_Obrada:

;SE9M.c,459 :: 		void Eth_Obrada() {
;SE9M.c,460 :: 		if (conf.dhcpen == 0) {
	MOVF        _conf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada0
;SE9M.c,462 :: 		if (lease_time >= 60) {
	MOVLW       60
	SUBWF       _lease_time+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Eth_Obrada1
;SE9M.c,463 :: 		lease_time = 0;
	CLRF        _lease_time+0 
;SE9M.c,464 :: 		while (!SPI_Ethernet_renewDHCP(5));  // try to renew until it works
L_Eth_Obrada2:
	MOVLW       5
	MOVWF       FARG_SPI_Ethernet_renewDHCP_tmax+0 
	CALL        _SPI_Ethernet_renewDHCP+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada3
	GOTO        L_Eth_Obrada2
L_Eth_Obrada3:
;SE9M.c,465 :: 		}
L_Eth_Obrada1:
;SE9M.c,466 :: 		}
L_Eth_Obrada0:
;SE9M.c,467 :: 		if (link == 1) {
	MOVF        _link+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Eth_Obrada4
;SE9M.c,469 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;SE9M.c,470 :: 		Spi_Ethernet_doPacket() ;
	CALL        _SPI_Ethernet_doPacket+0, 0
;SE9M.c,472 :: 		}
L_Eth_Obrada4:
;SE9M.c,473 :: 		}
L_end_Eth_Obrada:
	RETURN      0
; end of _Eth_Obrada

_saveConf:

;SE9M.c,478 :: 		void    saveConf()
;SE9M.c,491 :: 		}
L_end_saveConf:
	RETURN      0
; end of _saveConf

_mkMarquee:

;SE9M.c,495 :: 		void    mkMarquee(unsigned char l)
;SE9M.c,500 :: 		if((*marquee == 0) || (marquee == 0))
	MOVFF       _marquee+0, FSR0
	MOVFF       _marquee+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__mkMarquee515
	MOVLW       0
	XORWF       _marquee+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkMarquee581
	MOVLW       0
	XORWF       _marquee+0, 0 
L__mkMarquee581:
	BTFSC       STATUS+0, 2 
	GOTO        L__mkMarquee515
	GOTO        L_mkMarquee7
L__mkMarquee515:
;SE9M.c,502 :: 		marquee = bufInfo ;
	MOVLW       _bufInfo+0
	MOVWF       _marquee+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       _marquee+1 
;SE9M.c,503 :: 		}
L_mkMarquee7:
;SE9M.c,504 :: 		if((len=strlen(marquee)) < 16) {
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
	GOTO        L_mkMarquee8
;SE9M.c,505 :: 		memcpy(marqeeBuff, marquee, len) ;
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
;SE9M.c,506 :: 		memcpy(marqeeBuff+len, bufInfo, 16-len) ;
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
;SE9M.c,507 :: 		}
	GOTO        L_mkMarquee9
L_mkMarquee8:
;SE9M.c,509 :: 		memcpy(marqeeBuff, marquee, 16) ;
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
L_mkMarquee9:
;SE9M.c,510 :: 		marqeeBuff[16] = 0 ;
	CLRF        mkMarquee_marqeeBuff_L0+16 
;SE9M.c,513 :: 		}
L_end_mkMarquee:
	RETURN      0
; end of _mkMarquee

_DNSavings:

;SE9M.c,564 :: 		void DNSavings() {
;SE9M.c,565 :: 		tmzn = 2;
	MOVLW       2
	MOVWF       _tmzn+0 
;SE9M.c,567 :: 		}
L_end_DNSavings:
	RETURN      0
; end of _DNSavings

_int2str:

;SE9M.c,572 :: 		void    int2str(long l, unsigned char *s)
;SE9M.c,576 :: 		if(l == 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       FARG_int2str_l+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str584
	MOVF        R0, 0 
	XORWF       FARG_int2str_l+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str584
	MOVF        R0, 0 
	XORWF       FARG_int2str_l+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str584
	MOVF        FARG_int2str_l+0, 0 
	XORLW       0
L__int2str584:
	BTFSS       STATUS+0, 2 
	GOTO        L_int2str10
;SE9M.c,578 :: 		s[0] = '0' ;
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVLW       48
	MOVWF       POSTINC1+0 
;SE9M.c,579 :: 		s[1] = 0 ;
	MOVLW       1
	ADDWF       FARG_int2str_s+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_int2str_s+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;SE9M.c,580 :: 		}
	GOTO        L_int2str11
L_int2str10:
;SE9M.c,583 :: 		if(l < 0)
	MOVLW       128
	XORWF       FARG_int2str_l+3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str585
	MOVLW       0
	SUBWF       FARG_int2str_l+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str585
	MOVLW       0
	SUBWF       FARG_int2str_l+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str585
	MOVLW       0
	SUBWF       FARG_int2str_l+0, 0 
L__int2str585:
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str12
;SE9M.c,585 :: 		l *= -1 ;
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
;SE9M.c,586 :: 		n = 1 ;
	MOVLW       1
	MOVWF       int2str_n_L0+0 
;SE9M.c,587 :: 		}
	GOTO        L_int2str13
L_int2str12:
;SE9M.c,590 :: 		n = 0 ;
	CLRF        int2str_n_L0+0 
;SE9M.c,591 :: 		}
L_int2str13:
;SE9M.c,592 :: 		s[0] = 0 ;
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	CLRF        POSTINC1+0 
;SE9M.c,593 :: 		i = 0 ;
	CLRF        int2str_i_L0+0 
;SE9M.c,594 :: 		while(l > 0)
L_int2str14:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_int2str_l+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str586
	MOVF        FARG_int2str_l+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str586
	MOVF        FARG_int2str_l+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__int2str586
	MOVF        FARG_int2str_l+0, 0 
	SUBLW       0
L__int2str586:
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str15
;SE9M.c,596 :: 		for(j = i + 1 ; j > 0 ; j--)
	MOVF        int2str_i_L0+0, 0 
	ADDLW       1
	MOVWF       int2str_j_L0+0 
L_int2str16:
	MOVF        int2str_j_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str17
;SE9M.c,598 :: 		s[j] = s[j - 1] ;
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
;SE9M.c,596 :: 		for(j = i + 1 ; j > 0 ; j--)
	DECF        int2str_j_L0+0, 1 
;SE9M.c,599 :: 		}
	GOTO        L_int2str16
L_int2str17:
;SE9M.c,600 :: 		s[0] = l % 10 ;
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
;SE9M.c,601 :: 		s[0] += '0' ;
	MOVFF       FARG_int2str_s+0, FSR0
	MOVFF       FARG_int2str_s+1, FSR0H
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVLW       48
	ADDWF       POSTINC0+0, 1 
;SE9M.c,602 :: 		i++ ;
	INCF        int2str_i_L0+0, 1 
;SE9M.c,603 :: 		l /= 10 ;
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
;SE9M.c,604 :: 		}
	GOTO        L_int2str14
L_int2str15:
;SE9M.c,605 :: 		if(n)
	MOVF        int2str_n_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_int2str19
;SE9M.c,607 :: 		for(j = i + 1 ; j > 0 ; j--)
	MOVF        int2str_i_L0+0, 0 
	ADDLW       1
	MOVWF       int2str_j_L0+0 
L_int2str20:
	MOVF        int2str_j_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_int2str21
;SE9M.c,609 :: 		s[j] = s[j - 1] ;
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
;SE9M.c,607 :: 		for(j = i + 1 ; j > 0 ; j--)
	DECF        int2str_j_L0+0, 1 
;SE9M.c,610 :: 		}
	GOTO        L_int2str20
L_int2str21:
;SE9M.c,611 :: 		s[0] = '-' ;
	MOVFF       FARG_int2str_s+0, FSR1
	MOVFF       FARG_int2str_s+1, FSR1H
	MOVLW       45
	MOVWF       POSTINC1+0 
;SE9M.c,612 :: 		}
L_int2str19:
;SE9M.c,613 :: 		}
L_int2str11:
;SE9M.c,614 :: 		}
L_end_int2str:
	RETURN      0
; end of _int2str

_ip2str:

;SE9M.c,619 :: 		void    ip2str(unsigned char *s, unsigned char *ip)
;SE9M.c,624 :: 		*s = 0 ;
	MOVFF       FARG_ip2str_s+0, FSR1
	MOVFF       FARG_ip2str_s+1, FSR1H
	CLRF        POSTINC1+0 
;SE9M.c,625 :: 		for(i = 0 ; i < 4 ; i++)
	CLRF        ip2str_i_L0+0 
L_ip2str23:
	MOVLW       4
	SUBWF       ip2str_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ip2str24
;SE9M.c,627 :: 		int2str(ip[i], buf) ;
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
;SE9M.c,628 :: 		strcat(s, buf) ;
	MOVF        FARG_ip2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ip2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ip2str_buf_L0+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ip2str_buf_L0+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,629 :: 		if(i != 3)
	MOVF        ip2str_i_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_ip2str26
;SE9M.c,630 :: 		strcat(s, ".") ;
	MOVF        FARG_ip2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ip2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr45_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr45_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
L_ip2str26:
;SE9M.c,625 :: 		for(i = 0 ; i < 4 ; i++)
	INCF        ip2str_i_L0+0, 1 
;SE9M.c,631 :: 		}
	GOTO        L_ip2str23
L_ip2str24:
;SE9M.c,632 :: 		}
L_end_ip2str:
	RETURN      0
; end of _ip2str

_ts2str:

;SE9M.c,638 :: 		void    ts2str(unsigned char *s, TimeStruct *t, unsigned char m)
;SE9M.c,645 :: 		if(m & TS2STR_DATE)
	BTFSS       FARG_ts2str_m+0, 0 
	GOTO        L_ts2str27
;SE9M.c,647 :: 		strcpy(s, wday[t->wd]) ;        // week day
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
;SE9M.c,648 :: 		danuned = t->wd;
	MOVLW       4
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _danuned+0 
;SE9M.c,649 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr46_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr46_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,650 :: 		ByteToStr(t->md, tmp) ;         // day num
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
;SE9M.c,651 :: 		dan = t->md;
	MOVLW       3
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _dan+0 
;SE9M.c,652 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,653 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr47_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr47_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,654 :: 		strcat(s, mon[t->mo]) ;        // month
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
;SE9M.c,655 :: 		mesec = t->mo;
	MOVLW       5
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _mesec+0 
;SE9M.c,656 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr48_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr48_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,657 :: 		WordToStr(t->yy, tmp) ;         // year
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
;SE9M.c,658 :: 		godina = t->yy;
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
;SE9M.c,659 :: 		godyear1 = godina / 1000;
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
;SE9M.c,660 :: 		godyear2 = (godina - godyear1 * 1000) / 100;
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
;SE9M.c,661 :: 		godyear3 = (godina - godyear1 * 1000 - godyear2 * 100) / 10;
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
;SE9M.c,662 :: 		godyear4 = godina - godyear1 * 1000 - godyear2 * 100 - godyear3 * 10;
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
;SE9M.c,663 :: 		fingodina = godyear3 * 10 + godyear4;
	MOVF        R1, 0 
	MOVWF       _fingodina+0 
	MOVF        R0, 0 
	ADDWF       R1, 0 
	MOVWF       _fingodina+0 
;SE9M.c,664 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,665 :: 		strcat(s, " ") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr49_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr49_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,666 :: 		}
	GOTO        L_ts2str28
L_ts2str27:
;SE9M.c,669 :: 		*s = 0 ;
	MOVFF       FARG_ts2str_s+0, FSR1
	MOVFF       FARG_ts2str_s+1, FSR1H
	CLRF        POSTINC1+0 
;SE9M.c,670 :: 		}
L_ts2str28:
;SE9M.c,675 :: 		if(m & TS2STR_TIME)
	BTFSS       FARG_ts2str_m+0, 1 
	GOTO        L_ts2str29
;SE9M.c,677 :: 		ByteToStr(t->hh, tmp) ;         // hour
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
;SE9M.c,678 :: 		sati = t->hh;
	MOVLW       2
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _sati+0 
;SE9M.c,679 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,680 :: 		strcat(s, ":") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr50_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr50_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,681 :: 		ByteToStr(t->mn, tmp) ;         // minute
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
;SE9M.c,682 :: 		minuti = (t->mn);
	MOVLW       1
	ADDWF       FARG_ts2str_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_ts2str_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _minuti+0 
;SE9M.c,683 :: 		if(*(tmp + 1) == ' ')
	MOVF        ts2str_tmp_L0+1, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_ts2str30
;SE9M.c,685 :: 		*(tmp + 1) = '0' ;
	MOVLW       48
	MOVWF       ts2str_tmp_L0+1 
;SE9M.c,686 :: 		}
L_ts2str30:
;SE9M.c,687 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,688 :: 		strcat(s, ":") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr51_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr51_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,689 :: 		ByteToStr(t->ss, tmp) ;         // second
	MOVFF       FARG_ts2str_t+0, FSR0
	MOVFF       FARG_ts2str_t+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ts2str_tmp_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ts2str_tmp_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,690 :: 		sekundi = t->ss;
	MOVFF       FARG_ts2str_t+0, FSR0
	MOVFF       FARG_ts2str_t+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       _sekundi+0 
;SE9M.c,691 :: 		if(*(tmp + 1) == ' ')
	MOVF        ts2str_tmp_L0+1, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_ts2str31
;SE9M.c,693 :: 		*(tmp + 1) = '0' ;
	MOVLW       48
	MOVWF       ts2str_tmp_L0+1 
;SE9M.c,694 :: 		}
L_ts2str31:
;SE9M.c,695 :: 		strcat(s, tmp + 1) ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ts2str_tmp_L0+1
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(ts2str_tmp_L0+1)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,696 :: 		}
L_ts2str29:
;SE9M.c,701 :: 		if(m & TS2STR_TZ)
	BTFSS       FARG_ts2str_m+0, 2 
	GOTO        L_ts2str32
;SE9M.c,703 :: 		strcat(s, " GMT") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr52_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr52_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,704 :: 		if(conf.tz > 0)
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       _conf+2, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ts2str33
;SE9M.c,706 :: 		strcat(s, "+") ;
	MOVF        FARG_ts2str_s+0, 0 
	MOVWF       FARG_strcat_to+0 
	MOVF        FARG_ts2str_s+1, 0 
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr53_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr53_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,707 :: 		}
L_ts2str33:
;SE9M.c,708 :: 		int2str(conf.tz, s + strlen(s)) ;
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
;SE9M.c,709 :: 		}
L_ts2str32:
;SE9M.c,710 :: 		}
L_end_ts2str:
	RETURN      0
; end of _ts2str

_nibble2hex:

;SE9M.c,715 :: 		unsigned char nibble2hex(unsigned char n)
;SE9M.c,717 :: 		n &= 0x0f ;
	MOVLW       15
	ANDWF       FARG_nibble2hex_n+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       FARG_nibble2hex_n+0 
;SE9M.c,718 :: 		if(n >= 0x0a)
	MOVLW       10
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_nibble2hex34
;SE9M.c,720 :: 		return(n + '7') ;
	MOVLW       55
	ADDWF       FARG_nibble2hex_n+0, 0 
	MOVWF       R0 
	GOTO        L_end_nibble2hex
;SE9M.c,721 :: 		}
L_nibble2hex34:
;SE9M.c,722 :: 		return(n + '0') ;
	MOVLW       48
	ADDWF       FARG_nibble2hex_n+0, 0 
	MOVWF       R0 
;SE9M.c,723 :: 		}
L_end_nibble2hex:
	RETURN      0
; end of _nibble2hex

_byte2hex:

;SE9M.c,728 :: 		void    byte2hex(unsigned char *s, unsigned char v)
;SE9M.c,730 :: 		*s++ = nibble2hex(v >> 4) ;
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
;SE9M.c,731 :: 		*s++ = nibble2hex(v) ;
	MOVF        FARG_byte2hex_v+0, 0 
	MOVWF       FARG_nibble2hex_n+0 
	CALL        _nibble2hex+0, 0
	MOVFF       FARG_byte2hex_s+0, FSR1
	MOVFF       FARG_byte2hex_s+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      FARG_byte2hex_s+0, 1 
	INCF        FARG_byte2hex_s+1, 1 
;SE9M.c,732 :: 		*s = '.' ;
	MOVFF       FARG_byte2hex_s+0, FSR1
	MOVFF       FARG_byte2hex_s+1, FSR1H
	MOVLW       46
	MOVWF       POSTINC1+0 
;SE9M.c,733 :: 		}
L_end_byte2hex:
	RETURN      0
; end of _byte2hex

_mkLCDselect:

;SE9M.c,738 :: 		unsigned int    mkLCDselect(unsigned char l, unsigned char m)
;SE9M.c,743 :: 		len = putConstString("<select onChange=\\\"document.location.href = '/admin/") ;
	MOVLW       ?lstr_54_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_54_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_54_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       mkLCDselect_len_L0+0 
	MOVF        R1, 0 
	MOVWF       mkLCDselect_len_L0+1 
;SE9M.c,744 :: 		SPI_Ethernet_putByte('0' + l) ; len++ ;
	MOVF        FARG_mkLCDselect_l+0, 0 
	ADDLW       48
	MOVWF       FARG_SPI_Ethernet_putByte_v+0 
	CALL        _SPI_Ethernet_putByte+0, 0
	INFSNZ      mkLCDselect_len_L0+0, 1 
	INCF        mkLCDselect_len_L0+1, 1 
;SE9M.c,745 :: 		len += putConstString("/' + this.selectedIndex\\\">") ;
	MOVLW       ?lstr_55_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_55_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_55_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,746 :: 		for(i = 0 ; i < 2 ; i++)
	CLRF        mkLCDselect_i_L0+0 
L_mkLCDselect35:
	MOVLW       2
	SUBWF       mkLCDselect_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_mkLCDselect36
;SE9M.c,748 :: 		len += putConstString("<option ") ;
	MOVLW       ?lstr_56_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_56_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_56_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,749 :: 		if(i == m)
	MOVF        mkLCDselect_i_L0+0, 0 
	XORWF       FARG_mkLCDselect_m+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_mkLCDselect38
;SE9M.c,751 :: 		len += putConstString(" selected") ;
	MOVLW       ?lstr_57_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_57_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_57_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,752 :: 		}
L_mkLCDselect38:
;SE9M.c,753 :: 		len += putConstString(">") ;
	MOVLW       ?lstr_58_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_58_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_58_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,754 :: 		len += putConstString(LCDoption[i]) ;
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
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       mkLCDselect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      mkLCDselect_len_L0+1, 1 
;SE9M.c,746 :: 		for(i = 0 ; i < 2 ; i++)
	INCF        mkLCDselect_i_L0+0, 1 
;SE9M.c,755 :: 		}
	GOTO        L_mkLCDselect35
L_mkLCDselect36:
;SE9M.c,756 :: 		len += putConstString("</select>\";") ;
	MOVLW       ?lstr_59_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_59_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_59_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        mkLCDselect_len_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        mkLCDselect_len_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       mkLCDselect_len_L0+0 
	MOVF        R1, 0 
	MOVWF       mkLCDselect_len_L0+1 
;SE9M.c,757 :: 		return(len) ;
;SE9M.c,758 :: 		}
L_end_mkLCDselect:
	RETURN      0
; end of _mkLCDselect

_mkLCDLine:

;SE9M.c,763 :: 		void mkLCDLine(unsigned char l, unsigned char m)
;SE9M.c,765 :: 		switch(m)
	GOTO        L_mkLCDLine39
;SE9M.c,767 :: 		case 0:
L_mkLCDLine41:
;SE9M.c,769 :: 		memset(bufInfo, 0, sizeof(bufInfo)) ;
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
;SE9M.c,770 :: 		if(lastSync)
	MOVF        _lastSync+0, 0 
	IORWF       _lastSync+1, 0 
	IORWF       _lastSync+2, 0 
	IORWF       _lastSync+3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkLCDLine42
;SE9M.c,773 :: 		strcpy(bufInfo, "Today is ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr60_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr60_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,774 :: 		ts2str(bufInfo + strlen(bufInfo), &ts, TS2STR_DATE) ;
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
;SE9M.c,775 :: 		strcat(bufInfo, ". Please visit www.micro-examples.com for more details about the Ethernal Clock. You can browse ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr61_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr61_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,776 :: 		ip2str(bufInfo + strlen(bufInfo), ipAddr) ;
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
;SE9M.c,777 :: 		strcat(bufInfo, " to set the clock preferences.    ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr62_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr62_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,778 :: 		}
	GOTO        L_mkLCDLine43
L_mkLCDLine42:
;SE9M.c,782 :: 		strcpy(bufInfo, "The SNTP server did not respond, please browse ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr63_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr63_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,783 :: 		ip2str(bufInfo + strlen(bufInfo), ipAddr) ;
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
;SE9M.c,784 :: 		strcat(bufInfo, " to check clock settings.    ") ;
	MOVLW       _bufInfo+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr64_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr64_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,785 :: 		}
L_mkLCDLine43:
;SE9M.c,786 :: 		mkMarquee(l) ;           // display marquee
	MOVF        FARG_mkLCDLine_l+0, 0 
	MOVWF       FARG_mkMarquee_l+0 
	CALL        _mkMarquee+0, 0
;SE9M.c,787 :: 		break ;
	GOTO        L_mkLCDLine40
;SE9M.c,788 :: 		case 1:
L_mkLCDLine44:
;SE9M.c,792 :: 		ts2str(bufInfo, &ts, TS2STR_DATE) ;
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
;SE9M.c,798 :: 		break ;
	GOTO        L_mkLCDLine40
;SE9M.c,799 :: 		case 2:
L_mkLCDLine45:
;SE9M.c,803 :: 		ts2str(bufInfo, &ts, TS2STR_TIME) ;
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
;SE9M.c,809 :: 		break ;
	GOTO        L_mkLCDLine40
;SE9M.c,810 :: 		}
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
;SE9M.c,811 :: 		}
L_end_mkLCDLine:
	RETURN      0
; end of _mkLCDLine

_mkSNTPrequest:

;SE9M.c,816 :: 		void    mkSNTPrequest()
;SE9M.c,821 :: 		if (sntpSync)
	MOVF        _sntpSync+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest46
;SE9M.c,822 :: 		if (SPI_Ethernet_UserTimerSec >= sntpTimer)
	MOVF        _sntpTimer+3, 0 
	SUBWF       _SPI_Ethernet_UserTimerSec+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkSNTPrequest594
	MOVF        _sntpTimer+2, 0 
	SUBWF       _SPI_Ethernet_UserTimerSec+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkSNTPrequest594
	MOVF        _sntpTimer+1, 0 
	SUBWF       _SPI_Ethernet_UserTimerSec+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__mkSNTPrequest594
	MOVF        _sntpTimer+0, 0 
	SUBWF       _SPI_Ethernet_UserTimerSec+0, 0 
L__mkSNTPrequest594:
	BTFSS       STATUS+0, 0 
	GOTO        L_mkSNTPrequest47
;SE9M.c,823 :: 		if (!lastSync) {
	MOVF        _lastSync+0, 0 
	IORWF       _lastSync+1, 0 
	IORWF       _lastSync+2, 0 
	IORWF       _lastSync+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_mkSNTPrequest48
;SE9M.c,824 :: 		sntpSync = 0;
	CLRF        _sntpSync+0 
;SE9M.c,825 :: 		if (!memcmp(conf.sntpIP, "\0\0\0\0", 4))
	MOVLW       _conf+3
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr65_SE9M+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr65_SE9M+0)
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
;SE9M.c,826 :: 		reloadDNS = 1 ; // force to solve DNS
	MOVLW       1
	MOVWF       _reloadDNS+0 
L_mkSNTPrequest49:
;SE9M.c,827 :: 		}
L_mkSNTPrequest48:
L_mkSNTPrequest47:
L_mkSNTPrequest46:
;SE9M.c,829 :: 		if(reloadDNS)   // is SNTP ip address to be reloaded from DNS ?
	MOVF        _reloadDNS+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest50
;SE9M.c,832 :: 		if(isalpha(*conf.sntpServer))   // doest host name start with an alphabetic character ?
	MOVF        _conf+7, 0 
	MOVWF       FARG_isalpha_character+0 
	CALL        _isalpha+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest51
;SE9M.c,835 :: 		memset(conf.sntpIP, 0, 4);
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
;SE9M.c,836 :: 		if(remoteIpAddr = SPI_Ethernet_dnsResolve(conf.sntpServer, 5))
	MOVLW       _conf+7
	MOVWF       FARG_SPI_Ethernet_dnsResolve_host+0 
	MOVLW       hi_addr(_conf+7)
	MOVWF       FARG_SPI_Ethernet_dnsResolve_host+1 
	MOVLW       5
	MOVWF       FARG_SPI_Ethernet_dnsResolve_tmax+0 
	CALL        _SPI_Ethernet_dnsResolve+0, 0
	MOVF        R0, 0 
	MOVWF       mkSNTPrequest_remoteIpAddr_L0+0 
	MOVF        R1, 0 
	MOVWF       mkSNTPrequest_remoteIpAddr_L0+1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest52
;SE9M.c,839 :: 		memcpy(conf.sntpIP, remoteIpAddr, 4) ;
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
;SE9M.c,840 :: 		}
L_mkSNTPrequest52:
;SE9M.c,841 :: 		}
	GOTO        L_mkSNTPrequest53
L_mkSNTPrequest51:
;SE9M.c,845 :: 		unsigned char *ptr = conf.sntpServer ;
	MOVLW       _conf+7
	MOVWF       mkSNTPrequest_ptr_L2+0 
	MOVLW       hi_addr(_conf+7)
	MOVWF       mkSNTPrequest_ptr_L2+1 
;SE9M.c,847 :: 		conf.sntpIP[0] = atoi(ptr) ;
	MOVF        mkSNTPrequest_ptr_L2+0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        mkSNTPrequest_ptr_L2+1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+3 
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
;SE9M.c,849 :: 		conf.sntpIP[1] = atoi(ptr) ;
	MOVF        R0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+4 
;SE9M.c,850 :: 		ptr = strchr(ptr, '.') + 1 ;
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
;SE9M.c,851 :: 		conf.sntpIP[2] = atoi(ptr) ;
	MOVF        R0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+5 
;SE9M.c,852 :: 		ptr = strchr(ptr, '.') + 1 ;
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
;SE9M.c,853 :: 		conf.sntpIP[3] = atoi(ptr) ;
	MOVF        R0, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+6 
;SE9M.c,854 :: 		}
L_mkSNTPrequest53:
;SE9M.c,856 :: 		saveConf() ;            // store to EEPROM
	CALL        _saveConf+0, 0
;SE9M.c,858 :: 		reloadDNS = 0 ;         // no further call to DNS
	CLRF        _reloadDNS+0 
;SE9M.c,860 :: 		sntpSync = 0 ;          // clock is not sync for now
	CLRF        _sntpSync+0 
;SE9M.c,861 :: 		}
L_mkSNTPrequest50:
;SE9M.c,863 :: 		if(sntpSync)                    // is clock already synchronized from sntp ?
	MOVF        _sntpSync+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_mkSNTPrequest54
;SE9M.c,865 :: 		return ;                // yes, no need to request time
	GOTO        L_end_mkSNTPrequest
;SE9M.c,866 :: 		}
L_mkSNTPrequest54:
;SE9M.c,871 :: 		memset(sntpPkt, 0, 48) ;        // clear sntp packet
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
;SE9M.c,874 :: 		sntpPkt[0] = 0b00011001 ;       // LI = 0 ; VN = 3 ; MODE = 1
	MOVLW       25
	MOVWF       mkSNTPrequest_sntpPkt_L0+0 
;SE9M.c,879 :: 		sntpPkt[2] = 0x0a ;             // 1024 sec (arbitrary value)
	MOVLW       10
	MOVWF       mkSNTPrequest_sntpPkt_L0+2 
;SE9M.c,882 :: 		sntpPkt[3] = 0xfa ;             // 0.015625 sec (arbitrary value)
	MOVLW       250
	MOVWF       mkSNTPrequest_sntpPkt_L0+3 
;SE9M.c,885 :: 		sntpPkt[6] = 0x44 ;
	MOVLW       68
	MOVWF       mkSNTPrequest_sntpPkt_L0+6 
;SE9M.c,888 :: 		sntpPkt[9] = 0x10 ;
	MOVLW       16
	MOVWF       mkSNTPrequest_sntpPkt_L0+9 
;SE9M.c,900 :: 		SPI_Ethernet_sendUDP(conf.sntpIP, 123, 123, sntpPkt, 48) ; // transmit UDP packet
	MOVLW       _conf+3
	MOVWF       FARG_SPI_Ethernet_sendUDP_destIP+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_SPI_Ethernet_sendUDP_destIP+1 
	MOVLW       123
	MOVWF       FARG_SPI_Ethernet_sendUDP_sourcePort+0 
	MOVLW       0
	MOVWF       FARG_SPI_Ethernet_sendUDP_sourcePort+1 
	MOVLW       123
	MOVWF       FARG_SPI_Ethernet_sendUDP_destPort+0 
	MOVLW       0
	MOVWF       FARG_SPI_Ethernet_sendUDP_destPort+1 
	MOVLW       mkSNTPrequest_sntpPkt_L0+0
	MOVWF       FARG_SPI_Ethernet_sendUDP_pkt+0 
	MOVLW       hi_addr(mkSNTPrequest_sntpPkt_L0+0)
	MOVWF       FARG_SPI_Ethernet_sendUDP_pkt+1 
	MOVLW       48
	MOVWF       FARG_SPI_Ethernet_sendUDP_pktLen+0 
	MOVLW       0
	MOVWF       FARG_SPI_Ethernet_sendUDP_pktLen+1 
	CALL        _SPI_Ethernet_sendUDP+0, 0
;SE9M.c,902 :: 		sntpSync = 1 ;  // done
	MOVLW       1
	MOVWF       _sntpSync+0 
;SE9M.c,903 :: 		lastSync = 0 ;
	CLRF        _lastSync+0 
	CLRF        _lastSync+1 
	CLRF        _lastSync+2 
	CLRF        _lastSync+3 
;SE9M.c,904 :: 		sntpTimer = SPI_Ethernet_UserTimerSec + 2;
	MOVLW       2
	ADDWF       _SPI_Ethernet_UserTimerSec+0, 0 
	MOVWF       _sntpTimer+0 
	MOVLW       0
	ADDWFC      _SPI_Ethernet_UserTimerSec+1, 0 
	MOVWF       _sntpTimer+1 
	MOVLW       0
	ADDWFC      _SPI_Ethernet_UserTimerSec+2, 0 
	MOVWF       _sntpTimer+2 
	MOVLW       0
	ADDWFC      _SPI_Ethernet_UserTimerSec+3, 0 
	MOVWF       _sntpTimer+3 
;SE9M.c,905 :: 		}
L_end_mkSNTPrequest:
	RETURN      0
; end of _mkSNTPrequest

_Rst_Eth:

;SE9M.c,907 :: 		void Rst_Eth() {
;SE9M.c,908 :: 		SPI_Ethernet_Rst = 0;
	BCF         RA5_bit+0, BitPos(RA5_bit+0) 
;SE9M.c,909 :: 		reset_eth = 1;
	MOVLW       1
	MOVWF       _reset_eth+0 
;SE9M.c,911 :: 		}
L_end_Rst_Eth:
	RETURN      0
; end of _Rst_Eth

_SPI_Ethernet_UserTCP:

;SE9M.c,916 :: 		unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
;SE9M.c,921 :: 		unsigned int    len = 0 ;
	CLRF        SPI_Ethernet_UserTCP_len_L0+0 
	CLRF        SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,931 :: 		if (localPort != 80)                    // I listen only to web request on port 80
	MOVLW       0
	XORWF       FARG_SPI_Ethernet_UserTCP_localPort+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP597
	MOVLW       80
	XORWF       FARG_SPI_Ethernet_UserTCP_localPort+0, 0 
L__SPI_Ethernet_UserTCP597:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP55
;SE9M.c,933 :: 		return(0) ;                     // return without reply
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;SE9M.c,934 :: 		}
L_SPI_Ethernet_UserTCP55:
;SE9M.c,939 :: 		if (HTTP_getRequest(getRequest, &reqLength, HTTP_REQUEST_SIZE) == 0)
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+0
	MOVWF       FARG_HTTP_getRequest_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+0)
	MOVWF       FARG_HTTP_getRequest_ptr+1 
	MOVLW       FARG_SPI_Ethernet_UserTCP_reqLength+0
	MOVWF       FARG_HTTP_getRequest_len+0 
	MOVLW       hi_addr(FARG_SPI_Ethernet_UserTCP_reqLength+0)
	MOVWF       FARG_HTTP_getRequest_len+1 
	MOVLW       128
	MOVWF       FARG_HTTP_getRequest_max+0 
	MOVLW       0
	MOVWF       FARG_HTTP_getRequest_max+1 
	CALL        _HTTP_getRequest+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP56
;SE9M.c,941 :: 		return(0) ;                     // no reply if no GET request
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;SE9M.c,942 :: 		}
L_SPI_Ethernet_UserTCP56:
;SE9M.c,948 :: 		if(memcmp(getRequest, path_private, sizeof(path_private) - 1) == 0)   // is path under private section ?
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       _path_private+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(_path_private+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       6
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP598
	MOVLW       0
	XORWF       R0, 0 
L__SPI_Ethernet_UserTCP598:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP57
;SE9M.c,957 :: 		if(getRequest[sizeof(path_private)] == 's')
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       115
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP58
;SE9M.c,961 :: 		len = putConstString(httpHeader) ;              // HTTP header
	MOVLW       _httpHeader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,962 :: 		len += putConstString(httpMimeTypeScript) ;     // with script MIME type
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,964 :: 		if (admin == 0) {
	MOVF        _admin+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP59
;SE9M.c,967 :: 		len += putConstString("var PASS=\"") ;
	MOVLW       ?lstr_66_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_66_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_66_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,968 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_67_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_67_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_67_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,969 :: 		len += putString("password") ;
	MOVLW       ?lstr68_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(?lstr68_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,970 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/v/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_69_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_69_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_69_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,971 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_70_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_70_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_70_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,973 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP60
L_SPI_Ethernet_UserTCP59:
;SE9M.c,975 :: 		uzobyte = 1;
	MOVLW       1
	MOVWF       _uzobyte+0 
;SE9M.c,977 :: 		len += putConstString("var DHCPEN=\"") ;
	MOVLW       ?lstr_71_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_71_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_71_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,978 :: 		len += mkLCDselect(1, conf.dhcpen) ;
	MOVLW       1
	MOVWF       FARG_mkLCDselect_l+0 
	MOVF        _conf+0, 0 
	MOVWF       FARG_mkLCDselect_m+0 
	CALL        _mkLCDselect+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,982 :: 		len += putConstString("var PASS0=\"") ;
	MOVLW       ?lstr_72_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_72_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_72_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,983 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_73_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_73_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_73_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,984 :: 		len += putString(oldSifra) ;
	MOVLW       _oldSifra+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,985 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/x/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_74_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_74_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_74_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,986 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_75_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_75_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_75_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,989 :: 		len += putConstString("var PASS1=\"") ;
	MOVLW       ?lstr_76_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_76_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_76_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,990 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_77_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_77_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_77_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,991 :: 		len += putString(newSifra) ;
	MOVLW       _newSifra+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,992 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/y/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_78_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_78_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_78_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,993 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_79_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_79_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_79_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,997 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP61
;SE9M.c,999 :: 		len += putConstString("var SIP=\"") ;
	MOVLW       ?lstr_80_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_80_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_80_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1000 :: 		len += putConstString("<select onChange=\\\"document.location.href = '/admin/u/' + this.selectedIndex\\\">") ;
	MOVLW       ?lstr_81_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_81_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_81_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1001 :: 		for(i = 1 ; i < 5 ; i++)
	MOVLW       1
	MOVWF       SPI_Ethernet_UserTCP_i_L0+0 
	MOVLW       0
	MOVWF       SPI_Ethernet_UserTCP_i_L0+1 
L_SPI_Ethernet_UserTCP62:
	MOVLW       128
	XORWF       SPI_Ethernet_UserTCP_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP599
	MOVLW       5
	SUBWF       SPI_Ethernet_UserTCP_i_L0+0, 0 
L__SPI_Ethernet_UserTCP599:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP63
;SE9M.c,1003 :: 		len += putConstString("<option ") ;
	MOVLW       ?lstr_82_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_82_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_82_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1004 :: 		if(i == s_ip)
	MOVLW       0
	XORWF       SPI_Ethernet_UserTCP_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP600
	MOVF        _s_ip+0, 0 
	XORWF       SPI_Ethernet_UserTCP_i_L0+0, 0 
L__SPI_Ethernet_UserTCP600:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP65
;SE9M.c,1006 :: 		len += putConstString(" selected") ;
	MOVLW       ?lstr_83_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_83_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_83_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1007 :: 		}
L_SPI_Ethernet_UserTCP65:
;SE9M.c,1008 :: 		len += putConstString(">") ;
	MOVLW       ?lstr_84_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_84_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_84_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1009 :: 		len += putConstString(IPoption[i-1]) ;
	MOVLW       1
	SUBWF       SPI_Ethernet_UserTCP_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      SPI_Ethernet_UserTCP_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _IPoption+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_IPoption+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1001 :: 		for(i = 1 ; i < 5 ; i++)
	INFSNZ      SPI_Ethernet_UserTCP_i_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_i_L0+1, 1 
;SE9M.c,1012 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP62
L_SPI_Ethernet_UserTCP63:
;SE9M.c,1013 :: 		len += putConstString("</select>\";") ;
	MOVLW       ?lstr_85_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_85_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_85_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1014 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP66
L_SPI_Ethernet_UserTCP61:
;SE9M.c,1015 :: 		s_ip = 1;
	MOVLW       1
	MOVWF       _s_ip+0 
;SE9M.c,1016 :: 		}
L_SPI_Ethernet_UserTCP66:
;SE9M.c,1018 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP67
;SE9M.c,1020 :: 		len += putConstString("var IP0=\"") ;
	MOVLW       ?lstr_86_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_86_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_86_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1021 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_87_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_87_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_87_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1022 :: 		len += putString(ipAddrPom0) ;
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1023 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP68
;SE9M.c,1024 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_88_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_88_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_88_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1025 :: 		}
L_SPI_Ethernet_UserTCP68:
;SE9M.c,1026 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP69
;SE9M.c,1027 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_89_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_89_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_89_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1028 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP70
L_SPI_Ethernet_UserTCP69:
;SE9M.c,1029 :: 		len += putConstString(">\";") ;
	MOVLW       ?lstr_90_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_90_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_90_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1030 :: 		}
L_SPI_Ethernet_UserTCP70:
;SE9M.c,1032 :: 		len += putConstString("var IP1=\"") ;
	MOVLW       ?lstr_91_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_91_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_91_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1033 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_92_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_92_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_92_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1034 :: 		len += putString(ipAddrPom1) ;
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1035 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP71
;SE9M.c,1036 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_93_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_93_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_93_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1037 :: 		}
L_SPI_Ethernet_UserTCP71:
;SE9M.c,1038 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP72
;SE9M.c,1039 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_94_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_94_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_94_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1040 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP73
L_SPI_Ethernet_UserTCP72:
;SE9M.c,1041 :: 		len += putConstString(">\";") ;
	MOVLW       ?lstr_95_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_95_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_95_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1042 :: 		}
L_SPI_Ethernet_UserTCP73:
;SE9M.c,1044 :: 		len += putConstString("var IP2=\"") ;
	MOVLW       ?lstr_96_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_96_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_96_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1045 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_97_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_97_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_97_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1046 :: 		len += putString(ipAddrPom2) ;
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1047 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP74
;SE9M.c,1048 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_98_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_98_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_98_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1049 :: 		}
L_SPI_Ethernet_UserTCP74:
;SE9M.c,1050 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP75
;SE9M.c,1051 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_99_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_99_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_99_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1052 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP76
L_SPI_Ethernet_UserTCP75:
;SE9M.c,1053 :: 		len += putConstString(">\";") ;
	MOVLW       ?lstr_100_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_100_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_100_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1054 :: 		}
L_SPI_Ethernet_UserTCP76:
;SE9M.c,1056 :: 		len += putConstString("var IP3=\"") ;
	MOVLW       ?lstr_101_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_101_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_101_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1057 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_102_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_102_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_102_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1058 :: 		len += putString(ipAddrPom3) ;
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1059 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP77
;SE9M.c,1060 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_103_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_103_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_103_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1061 :: 		}
L_SPI_Ethernet_UserTCP77:
;SE9M.c,1062 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP78
;SE9M.c,1063 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_104_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_104_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_104_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1064 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP79
L_SPI_Ethernet_UserTCP78:
;SE9M.c,1065 :: 		len += putConstString(">\";") ;
	MOVLW       ?lstr_105_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_105_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_105_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1066 :: 		}
L_SPI_Ethernet_UserTCP79:
;SE9M.c,1067 :: 		}
L_SPI_Ethernet_UserTCP67:
;SE9M.c,1070 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP80
;SE9M.c,1072 :: 		len += putConstString("var M0=\"") ;
	MOVLW       ?lstr_106_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_106_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_106_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1073 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP81
;SE9M.c,1074 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_107_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_107_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_107_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1075 :: 		len += putString(ipMaskPom0) ;
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1076 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_108_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_108_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_108_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1077 :: 		}
L_SPI_Ethernet_UserTCP81:
;SE9M.c,1080 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP82
;SE9M.c,1081 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_109_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_109_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_109_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1082 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP83
L_SPI_Ethernet_UserTCP82:
;SE9M.c,1083 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_110_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_110_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_110_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1084 :: 		}
L_SPI_Ethernet_UserTCP83:
;SE9M.c,1086 :: 		len += putConstString("var M1=\"") ;
	MOVLW       ?lstr_111_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_111_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_111_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1087 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP84
;SE9M.c,1088 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_112_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_112_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_112_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1089 :: 		len += putString(ipMaskPom1) ;
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1090 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_113_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_113_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_113_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1091 :: 		}
L_SPI_Ethernet_UserTCP84:
;SE9M.c,1094 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP85
;SE9M.c,1095 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_114_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_114_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_114_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1096 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP86
L_SPI_Ethernet_UserTCP85:
;SE9M.c,1097 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_115_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_115_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_115_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1098 :: 		}
L_SPI_Ethernet_UserTCP86:
;SE9M.c,1100 :: 		len += putConstString("var M2=\"") ;
	MOVLW       ?lstr_116_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_116_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_116_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1101 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP87
;SE9M.c,1102 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_117_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_117_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_117_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1103 :: 		len += putString(ipMaskPom2) ;
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1104 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_118_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_118_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_118_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1105 :: 		}
L_SPI_Ethernet_UserTCP87:
;SE9M.c,1108 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP88
;SE9M.c,1109 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_119_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_119_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_119_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1110 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP89
L_SPI_Ethernet_UserTCP88:
;SE9M.c,1111 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_120_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_120_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_120_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1112 :: 		}
L_SPI_Ethernet_UserTCP89:
;SE9M.c,1114 :: 		len += putConstString("var M3=\"") ;
	MOVLW       ?lstr_121_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_121_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_121_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1115 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP90
;SE9M.c,1116 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_122_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_122_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_122_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1117 :: 		len += putString(ipMaskPom3) ;
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1118 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_123_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_123_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_123_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1119 :: 		}
L_SPI_Ethernet_UserTCP90:
;SE9M.c,1122 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP91
;SE9M.c,1123 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_124_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_124_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_124_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1124 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP92
L_SPI_Ethernet_UserTCP91:
;SE9M.c,1125 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_125_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_125_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_125_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1126 :: 		}
L_SPI_Ethernet_UserTCP92:
;SE9M.c,1127 :: 		}
L_SPI_Ethernet_UserTCP80:
;SE9M.c,1130 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP93
;SE9M.c,1132 :: 		len += putConstString("var G0=\"") ;
	MOVLW       ?lstr_126_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_126_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_126_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1133 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP94
;SE9M.c,1134 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_127_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_127_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_127_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1135 :: 		len += putString(gwIpAddrPom0) ;
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1136 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_128_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_128_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_128_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1137 :: 		}
L_SPI_Ethernet_UserTCP94:
;SE9M.c,1140 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP95
;SE9M.c,1141 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_129_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_129_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_129_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1142 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP96
L_SPI_Ethernet_UserTCP95:
;SE9M.c,1143 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_130_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_130_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_130_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1144 :: 		}
L_SPI_Ethernet_UserTCP96:
;SE9M.c,1146 :: 		len += putConstString("var G1=\"") ;
	MOVLW       ?lstr_131_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_131_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_131_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1147 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP97
;SE9M.c,1148 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_132_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_132_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_132_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1149 :: 		len += putString(gwIpAddrPom1) ;
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1150 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_133_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_133_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_133_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1151 :: 		}
L_SPI_Ethernet_UserTCP97:
;SE9M.c,1154 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP98
;SE9M.c,1155 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_134_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_134_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_134_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1156 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP99
L_SPI_Ethernet_UserTCP98:
;SE9M.c,1157 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_135_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_135_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_135_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1158 :: 		}
L_SPI_Ethernet_UserTCP99:
;SE9M.c,1160 :: 		len += putConstString("var G2=\"") ;
	MOVLW       ?lstr_136_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_136_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_136_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1161 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP100
;SE9M.c,1162 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_137_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_137_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_137_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1163 :: 		len += putString(gwIpAddrPom2) ;
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1164 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_138_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_138_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_138_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1165 :: 		}
L_SPI_Ethernet_UserTCP100:
;SE9M.c,1168 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP101
;SE9M.c,1169 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_139_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_139_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_139_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1170 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP102
L_SPI_Ethernet_UserTCP101:
;SE9M.c,1171 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_140_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_140_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_140_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1172 :: 		}
L_SPI_Ethernet_UserTCP102:
;SE9M.c,1174 :: 		len += putConstString("var G3=\"") ;
	MOVLW       ?lstr_141_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_141_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_141_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1175 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP103
;SE9M.c,1176 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_142_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_142_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_142_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1177 :: 		len += putString(gwIpAddrPom3) ;
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1178 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_143_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_143_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_143_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1179 :: 		}
L_SPI_Ethernet_UserTCP103:
;SE9M.c,1182 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP104
;SE9M.c,1183 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_144_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_144_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_144_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1184 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP105
L_SPI_Ethernet_UserTCP104:
;SE9M.c,1185 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_145_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_145_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_145_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1186 :: 		}
L_SPI_Ethernet_UserTCP105:
;SE9M.c,1187 :: 		}
L_SPI_Ethernet_UserTCP93:
;SE9M.c,1189 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP106
;SE9M.c,1191 :: 		len += putConstString("var D0=\"") ;
	MOVLW       ?lstr_146_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_146_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_146_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1192 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP107
;SE9M.c,1193 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_147_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_147_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_147_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1194 :: 		len += putString(dnsIpAddrPom0) ;
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1195 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_148_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_148_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_148_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1196 :: 		}
L_SPI_Ethernet_UserTCP107:
;SE9M.c,1199 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP108
;SE9M.c,1200 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_149_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_149_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_149_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1201 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP109
L_SPI_Ethernet_UserTCP108:
;SE9M.c,1202 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_150_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_150_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_150_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1203 :: 		}
L_SPI_Ethernet_UserTCP109:
;SE9M.c,1205 :: 		len += putConstString("var D1=\"") ;
	MOVLW       ?lstr_151_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_151_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_151_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1206 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP110
;SE9M.c,1207 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_152_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_152_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_152_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1208 :: 		len += putString(dnsIpAddrPom1) ;
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1209 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/o/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_153_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_153_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_153_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1210 :: 		}
L_SPI_Ethernet_UserTCP110:
;SE9M.c,1213 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP111
;SE9M.c,1214 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_154_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_154_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_154_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1215 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP112
L_SPI_Ethernet_UserTCP111:
;SE9M.c,1216 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_155_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_155_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_155_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1217 :: 		}
L_SPI_Ethernet_UserTCP112:
;SE9M.c,1219 :: 		len += putConstString("var D2=\"") ;
	MOVLW       ?lstr_156_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_156_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_156_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1220 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP113
;SE9M.c,1221 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_157_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_157_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_157_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1222 :: 		len += putString(dnsIpAddrPom2) ;
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1223 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/p/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_158_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_158_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_158_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1224 :: 		}
L_SPI_Ethernet_UserTCP113:
;SE9M.c,1226 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP114
;SE9M.c,1227 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_159_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_159_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_159_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1228 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP115
L_SPI_Ethernet_UserTCP114:
;SE9M.c,1229 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_160_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_160_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_160_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1230 :: 		}
L_SPI_Ethernet_UserTCP115:
;SE9M.c,1232 :: 		len += putConstString("var D3=\"") ;
	MOVLW       ?lstr_161_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_161_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_161_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1233 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP116
;SE9M.c,1234 :: 		len += putConstString("<input placeholder=") ;
	MOVLW       ?lstr_162_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_162_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_162_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1235 :: 		len += putString(dnsIpAddrPom3) ;
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1236 :: 		len += putConstString(" onChange=\\\"document.location.href = '/admin/q/' + this.value\\\" value=\\\"") ;
	MOVLW       ?lstr_163_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_163_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_163_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1237 :: 		}
L_SPI_Ethernet_UserTCP116:
;SE9M.c,1239 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP117
;SE9M.c,1240 :: 		len += putConstString("\\\">\" ;") ;
	MOVLW       ?lstr_164_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_164_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_164_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1241 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP118
L_SPI_Ethernet_UserTCP117:
;SE9M.c,1242 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_165_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_165_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_165_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1243 :: 		}
L_SPI_Ethernet_UserTCP118:
;SE9M.c,1244 :: 		}
L_SPI_Ethernet_UserTCP106:
;SE9M.c,1246 :: 		}
L_SPI_Ethernet_UserTCP60:
;SE9M.c,1248 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP119
L_SPI_Ethernet_UserTCP58:
;SE9M.c,1252 :: 		switch(getRequest[sizeof(path_private)])
	GOTO        L_SPI_Ethernet_UserTCP120
;SE9M.c,1254 :: 		case '1' :
L_SPI_Ethernet_UserTCP122:
;SE9M.c,1256 :: 		conf.dhcpen = getRequest[sizeof(path_private) + 2] - '0' ;
	MOVLW       48
	SUBWF       SPI_Ethernet_UserTCP_getRequest_L0+9, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _conf+0 
;SE9M.c,1257 :: 		EEPROM_Write(103, conf.dhcpen);
	MOVLW       103
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1258 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_SPI_Ethernet_UserTCP123:
	DECFSZ      R13, 1, 1
	BRA         L_SPI_Ethernet_UserTCP123
	DECFSZ      R12, 1, 1
	BRA         L_SPI_Ethernet_UserTCP123
	DECFSZ      R11, 1, 1
	BRA         L_SPI_Ethernet_UserTCP123
;SE9M.c,1259 :: 		Rst_Eth();
	CALL        _Rst_Eth+0, 0
;SE9M.c,1260 :: 		saveConf() ;
	CALL        _saveConf+0, 0
;SE9M.c,1261 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1263 :: 		case 'r':
L_SPI_Ethernet_UserTCP124:
;SE9M.c,1265 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP125
;SE9M.c,1270 :: 		if ( (ipAddrPom0[0] >= '1') && (ipAddrPom0[0] <= '9') && (ipAddrPom0[1] >= '0') && (ipAddrPom0[1] <= '9') && (ipAddrPom0[2] >= '0') && (ipAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP128
	MOVF        _ipAddrPom0+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP128
	MOVLW       48
	SUBWF       _ipAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP128
	MOVF        _ipAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP128
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP128
	MOVF        _ipAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP128
L__SPI_Ethernet_UserTCP563:
;SE9M.c,1271 :: 		EEPROM_Write(1, (ipAddrPom0[0]-48)*100 + (ipAddrPom0[1]-48)*10 + (ipAddrPom0[2]-48));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom0+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1272 :: 		}
L_SPI_Ethernet_UserTCP128:
;SE9M.c,1273 :: 		if ( (ipAddrPom0[0] < '1') && (ipAddrPom0[1] >= '1') && (ipAddrPom0[1] <= '9') && (ipAddrPom0[2] >= '0') && (ipAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP131
	MOVLW       49
	SUBWF       _ipAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP131
	MOVF        _ipAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP131
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP131
	MOVF        _ipAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP131
L__SPI_Ethernet_UserTCP562:
;SE9M.c,1274 :: 		EEPROM_Write(1, (ipAddrPom0[1]-48)*10 + (ipAddrPom0[2]-48));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom0+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1275 :: 		}
L_SPI_Ethernet_UserTCP131:
;SE9M.c,1276 :: 		if ( (ipAddrPom0[0] < '1') && (ipAddrPom0[1] < '1') && (ipAddrPom0[2] >= '0') && (ipAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP134
	MOVLW       49
	SUBWF       _ipAddrPom0+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP134
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP134
	MOVF        _ipAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP134
L__SPI_Ethernet_UserTCP561:
;SE9M.c,1277 :: 		EEPROM_Write(1, (ipAddrPom0[2]-48));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom0+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1278 :: 		}
L_SPI_Ethernet_UserTCP134:
;SE9M.c,1280 :: 		if ( (ipAddrPom1[0] >= '1') && (ipAddrPom1[0] <= '9') && (ipAddrPom1[1] >= '0') && (ipAddrPom1[1] <= '9') && (ipAddrPom1[2] >= '0') && (ipAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP137
	MOVF        _ipAddrPom1+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP137
	MOVLW       48
	SUBWF       _ipAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP137
	MOVF        _ipAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP137
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP137
	MOVF        _ipAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP137
L__SPI_Ethernet_UserTCP560:
;SE9M.c,1281 :: 		EEPROM_Write(2, (ipAddrPom1[0]-48)*100 + (ipAddrPom1[1]-48)*10 + (ipAddrPom1[2]-48));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom1+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1282 :: 		}
L_SPI_Ethernet_UserTCP137:
;SE9M.c,1283 :: 		if ( (ipAddrPom1[0] < '1') && (ipAddrPom1[1] >= '1') && (ipAddrPom1[1] <= '9') && (ipAddrPom1[2] >= '0') && (ipAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP140
	MOVLW       49
	SUBWF       _ipAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP140
	MOVF        _ipAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP140
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP140
	MOVF        _ipAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP140
L__SPI_Ethernet_UserTCP559:
;SE9M.c,1284 :: 		EEPROM_Write(2, (ipAddrPom1[1]-48)*10 + (ipAddrPom1[2]-48));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom1+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1285 :: 		}
L_SPI_Ethernet_UserTCP140:
;SE9M.c,1286 :: 		if ( (ipAddrPom1[0] < '1') && (ipAddrPom1[1] < '1') && (ipAddrPom1[2] >= '0') && (ipAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP143
	MOVLW       49
	SUBWF       _ipAddrPom1+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP143
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP143
	MOVF        _ipAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP143
L__SPI_Ethernet_UserTCP558:
;SE9M.c,1287 :: 		EEPROM_Write(2, (ipAddrPom1[2]-48));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom1+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1288 :: 		}
L_SPI_Ethernet_UserTCP143:
;SE9M.c,1290 :: 		if ( (ipAddrPom2[0] >= '1') && (ipAddrPom2[0] <= '9') && (ipAddrPom2[1] >= '0') && (ipAddrPom2[1] <= '9') && (ipAddrPom2[2] >= '0') && (ipAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP146
	MOVF        _ipAddrPom2+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP146
	MOVLW       48
	SUBWF       _ipAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP146
	MOVF        _ipAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP146
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP146
	MOVF        _ipAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP146
L__SPI_Ethernet_UserTCP557:
;SE9M.c,1291 :: 		EEPROM_Write(3, (ipAddrPom2[0]-48)*100 + (ipAddrPom2[1]-48)*10 + (ipAddrPom2[2]-48));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom2+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1292 :: 		}
L_SPI_Ethernet_UserTCP146:
;SE9M.c,1293 :: 		if ( (ipAddrPom2[0] < '1') && (ipAddrPom2[1] >= '1') && (ipAddrPom2[1] <= '9') && (ipAddrPom2[2] >= '0') && (ipAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP149
	MOVLW       49
	SUBWF       _ipAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP149
	MOVF        _ipAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP149
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP149
	MOVF        _ipAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP149
L__SPI_Ethernet_UserTCP556:
;SE9M.c,1294 :: 		EEPROM_Write(3, (ipAddrPom2[1]-48)*10 + (ipAddrPom2[2]-48));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom2+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1295 :: 		}
L_SPI_Ethernet_UserTCP149:
;SE9M.c,1296 :: 		if ( (ipAddrPom2[0] < '1') && (ipAddrPom2[1] < '1') && (ipAddrPom2[2] >= '0') && (ipAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP152
	MOVLW       49
	SUBWF       _ipAddrPom2+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP152
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP152
	MOVF        _ipAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP152
L__SPI_Ethernet_UserTCP555:
;SE9M.c,1297 :: 		EEPROM_Write(3, (ipAddrPom2[2]-48));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom2+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1298 :: 		}
L_SPI_Ethernet_UserTCP152:
;SE9M.c,1300 :: 		if ( (ipAddrPom3[0] >= '1') && (ipAddrPom3[0] <= '9') && (ipAddrPom3[1] >= '0') && (ipAddrPom3[1] <= '9') && (ipAddrPom3[2] >= '0') && (ipAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom3+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP155
	MOVF        _ipAddrPom3+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP155
	MOVLW       48
	SUBWF       _ipAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP155
	MOVF        _ipAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP155
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP155
	MOVF        _ipAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP155
L__SPI_Ethernet_UserTCP554:
;SE9M.c,1301 :: 		EEPROM_Write(4, (ipAddrPom3[0]-48)*100 + (ipAddrPom3[1]-48)*10 + (ipAddrPom3[2]-48));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom3+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom3+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1302 :: 		}
L_SPI_Ethernet_UserTCP155:
;SE9M.c,1303 :: 		if ( (ipAddrPom3[0] < '1') && (ipAddrPom3[1] >= '1') && (ipAddrPom3[1] <= '9') && (ipAddrPom3[2] >= '0') && (ipAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP158
	MOVLW       49
	SUBWF       _ipAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP158
	MOVF        _ipAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP158
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP158
	MOVF        _ipAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP158
L__SPI_Ethernet_UserTCP553:
;SE9M.c,1304 :: 		EEPROM_Write(4, (ipAddrPom3[1]-48)*10 + (ipAddrPom3[2]-48));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom3+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1305 :: 		}
L_SPI_Ethernet_UserTCP158:
;SE9M.c,1306 :: 		if ( (ipAddrPom3[0] < '1') && (ipAddrPom3[1] < '1') && (ipAddrPom3[2] >= '0') && (ipAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP161
	MOVLW       49
	SUBWF       _ipAddrPom3+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP161
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP161
	MOVF        _ipAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP161
L__SPI_Ethernet_UserTCP552:
;SE9M.c,1307 :: 		EEPROM_Write(4, (ipAddrPom3[2]-48));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipAddrPom3+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1308 :: 		}
L_SPI_Ethernet_UserTCP161:
;SE9M.c,1312 :: 		if ( (gwIpAddrPom0[0] >= '1') && (gwIpAddrPom0[0] <= '9') && (gwIpAddrPom0[1] >= '0') && (gwIpAddrPom0[1] <= '9') && (gwIpAddrPom0[2] >= '0') && (gwIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP164
	MOVF        _gwIpAddrPom0+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP164
	MOVLW       48
	SUBWF       _gwIpAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP164
	MOVF        _gwIpAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP164
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP164
	MOVF        _gwIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP164
L__SPI_Ethernet_UserTCP551:
;SE9M.c,1313 :: 		EEPROM_Write(5, (gwIpAddrPom0[0]-48)*100 + (gwIpAddrPom0[1]-48)*10 + (gwIpAddrPom0[2]-48));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1314 :: 		}
L_SPI_Ethernet_UserTCP164:
;SE9M.c,1315 :: 		if ( (gwIpAddrPom0[0] < '1') && (gwIpAddrPom0[1] >= '1') && (gwIpAddrPom0[1] <= '9') && (gwIpAddrPom0[2] >= '0') && (gwIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP167
	MOVLW       49
	SUBWF       _gwIpAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP167
	MOVF        _gwIpAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP167
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP167
	MOVF        _gwIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP167
L__SPI_Ethernet_UserTCP550:
;SE9M.c,1316 :: 		EEPROM_Write(5, (gwIpAddrPom0[1]-48)*10 + (gwIpAddrPom0[2]-48));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1317 :: 		}
L_SPI_Ethernet_UserTCP167:
;SE9M.c,1318 :: 		if ( (gwIpAddrPom0[0] < '1') && (gwIpAddrPom0[1] < '1') && (gwIpAddrPom0[2] >= '0') && (gwIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP170
	MOVLW       49
	SUBWF       _gwIpAddrPom0+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP170
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP170
	MOVF        _gwIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP170
L__SPI_Ethernet_UserTCP549:
;SE9M.c,1319 :: 		EEPROM_Write(5, (gwIpAddrPom0[2]-48));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom0+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1320 :: 		}
L_SPI_Ethernet_UserTCP170:
;SE9M.c,1322 :: 		if ( (gwIpAddrPom1[0] >= '1') && (gwIpAddrPom1[0] <= '9') && (gwIpAddrPom1[1] >= '0') && (gwIpAddrPom1[1] <= '9') && (gwIpAddrPom1[2] >= '0') && (gwIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP173
	MOVF        _gwIpAddrPom1+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP173
	MOVLW       48
	SUBWF       _gwIpAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP173
	MOVF        _gwIpAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP173
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP173
	MOVF        _gwIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP173
L__SPI_Ethernet_UserTCP548:
;SE9M.c,1323 :: 		EEPROM_Write(6, (gwIpAddrPom1[0]-48)*100 + (gwIpAddrPom1[1]-48)*10 + (gwIpAddrPom1[2]-48));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1324 :: 		}
L_SPI_Ethernet_UserTCP173:
;SE9M.c,1325 :: 		if ( (gwIpAddrPom1[0] < '1') && (gwIpAddrPom1[1] >= '1') && (gwIpAddrPom1[1] <= '9') && (gwIpAddrPom1[2] >= '0') && (gwIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP176
	MOVLW       49
	SUBWF       _gwIpAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP176
	MOVF        _gwIpAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP176
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP176
	MOVF        _gwIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP176
L__SPI_Ethernet_UserTCP547:
;SE9M.c,1326 :: 		EEPROM_Write(6, (gwIpAddrPom1[1]-48)*10 + (gwIpAddrPom1[2]-48));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1327 :: 		}
L_SPI_Ethernet_UserTCP176:
;SE9M.c,1328 :: 		if ( (gwIpAddrPom1[0] < '1') && (gwIpAddrPom1[1] < '1') && (gwIpAddrPom1[2] >= '0') && (gwIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP179
	MOVLW       49
	SUBWF       _gwIpAddrPom1+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP179
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP179
	MOVF        _gwIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP179
L__SPI_Ethernet_UserTCP546:
;SE9M.c,1329 :: 		EEPROM_Write(6, (gwIpAddrPom1[2]-48));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom1+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1330 :: 		}
L_SPI_Ethernet_UserTCP179:
;SE9M.c,1332 :: 		if ( (gwIpAddrPom2[0] >= '1') && (gwIpAddrPom2[0] <= '9') && (gwIpAddrPom2[1] >= '0') && (gwIpAddrPom2[1] <= '9') && (gwIpAddrPom2[2] >= '0') && (gwIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP182
	MOVF        _gwIpAddrPom2+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP182
	MOVLW       48
	SUBWF       _gwIpAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP182
	MOVF        _gwIpAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP182
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP182
	MOVF        _gwIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP182
L__SPI_Ethernet_UserTCP545:
;SE9M.c,1333 :: 		EEPROM_Write(7, (gwIpAddrPom2[0]-48)*100 + (gwIpAddrPom2[1]-48)*10 + (gwIpAddrPom2[2]-48));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1334 :: 		}
L_SPI_Ethernet_UserTCP182:
;SE9M.c,1335 :: 		if ( (gwIpAddrPom2[0] < '1') && (gwIpAddrPom2[1] >= '1') && (gwIpAddrPom2[1] <= '9') && (gwIpAddrPom2[2] >= '0') && (gwIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP185
	MOVLW       49
	SUBWF       _gwIpAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP185
	MOVF        _gwIpAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP185
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP185
	MOVF        _gwIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP185
L__SPI_Ethernet_UserTCP544:
;SE9M.c,1336 :: 		EEPROM_Write(7, (gwIpAddrPom2[1]-48)*10 + (gwIpAddrPom2[2]-48));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1337 :: 		}
L_SPI_Ethernet_UserTCP185:
;SE9M.c,1338 :: 		if ( (gwIpAddrPom2[0] < '1') && (gwIpAddrPom2[1] < '1') && (gwIpAddrPom2[2] >= '0') && (gwIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP188
	MOVLW       49
	SUBWF       _gwIpAddrPom2+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP188
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP188
	MOVF        _gwIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP188
L__SPI_Ethernet_UserTCP543:
;SE9M.c,1339 :: 		EEPROM_Write(7, (gwIpAddrPom2[2]-48));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom2+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1340 :: 		}
L_SPI_Ethernet_UserTCP188:
;SE9M.c,1342 :: 		if ( (gwIpAddrPom3[0] >= '1') && (gwIpAddrPom3[0] <= '9') && (gwIpAddrPom3[1] >= '0') && (gwIpAddrPom3[1] <= '9') && (gwIpAddrPom3[2] >= '0') && (gwIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom3+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP191
	MOVF        _gwIpAddrPom3+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP191
	MOVLW       48
	SUBWF       _gwIpAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP191
	MOVF        _gwIpAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP191
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP191
	MOVF        _gwIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP191
L__SPI_Ethernet_UserTCP542:
;SE9M.c,1343 :: 		EEPROM_Write(8, (gwIpAddrPom3[0]-48)*100 + (gwIpAddrPom3[1]-48)*10 + (gwIpAddrPom3[2]-48));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1344 :: 		}
L_SPI_Ethernet_UserTCP191:
;SE9M.c,1345 :: 		if ( (gwIpAddrPom3[0] < '1') && (gwIpAddrPom3[1] >= '1') && (gwIpAddrPom3[1] <= '9') && (gwIpAddrPom3[2] >= '0') && (gwIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP194
	MOVLW       49
	SUBWF       _gwIpAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP194
	MOVF        _gwIpAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP194
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP194
	MOVF        _gwIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP194
L__SPI_Ethernet_UserTCP541:
;SE9M.c,1346 :: 		EEPROM_Write(8, (gwIpAddrPom3[1]-48)*10 + (gwIpAddrPom3[2]-48));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1347 :: 		}
L_SPI_Ethernet_UserTCP194:
;SE9M.c,1348 :: 		if ( (gwIpAddrPom3[0] < '1') && (gwIpAddrPom3[1] < '1') && (gwIpAddrPom3[2] >= '0') && (gwIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _gwIpAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP197
	MOVLW       49
	SUBWF       _gwIpAddrPom3+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP197
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP197
	MOVF        _gwIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP197
L__SPI_Ethernet_UserTCP540:
;SE9M.c,1349 :: 		EEPROM_Write(8, (gwIpAddrPom3[2]-48));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _gwIpAddrPom3+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1350 :: 		}
L_SPI_Ethernet_UserTCP197:
;SE9M.c,1354 :: 		if ( (ipMaskPom0[0] >= '1') && (ipMaskPom0[0] <= '9') && (ipMaskPom0[1] >= '0') && (ipMaskPom0[1] <= '9') && (ipMaskPom0[2] >= '0') && (ipMaskPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP200
	MOVF        _ipMaskPom0+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP200
	MOVLW       48
	SUBWF       _ipMaskPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP200
	MOVF        _ipMaskPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP200
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP200
	MOVF        _ipMaskPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP200
L__SPI_Ethernet_UserTCP539:
;SE9M.c,1355 :: 		EEPROM_Write(9, (ipMaskPom0[0]-48)*100 + (ipMaskPom0[1]-48)*10 + (ipMaskPom0[2]-48));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom0+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1356 :: 		}
L_SPI_Ethernet_UserTCP200:
;SE9M.c,1357 :: 		if ( (ipMaskPom0[0] < '1') && (ipMaskPom0[1] >= '1') && (ipMaskPom0[1] <= '9') && (ipMaskPom0[2] >= '0') && (ipMaskPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP203
	MOVLW       49
	SUBWF       _ipMaskPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP203
	MOVF        _ipMaskPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP203
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP203
	MOVF        _ipMaskPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP203
L__SPI_Ethernet_UserTCP538:
;SE9M.c,1358 :: 		EEPROM_Write(9, (ipMaskPom0[1]-48)*10 + (ipMaskPom0[2]-48));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom0+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1359 :: 		}
L_SPI_Ethernet_UserTCP203:
;SE9M.c,1360 :: 		if ( (ipMaskPom0[0] < '1') && (ipMaskPom0[1] < '1') && (ipMaskPom0[2] >= '0') && (ipMaskPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP206
	MOVLW       49
	SUBWF       _ipMaskPom0+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP206
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP206
	MOVF        _ipMaskPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP206
L__SPI_Ethernet_UserTCP537:
;SE9M.c,1361 :: 		EEPROM_Write(9, (ipMaskPom0[2]-48));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom0+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1362 :: 		}
L_SPI_Ethernet_UserTCP206:
;SE9M.c,1364 :: 		if ( (ipMaskPom1[0] >= '1') && (ipMaskPom1[0] <= '9') && (ipMaskPom1[1] >= '0') && (ipMaskPom1[1] <= '9') && (ipMaskPom1[2] >= '0') && (ipMaskPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP209
	MOVF        _ipMaskPom1+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP209
	MOVLW       48
	SUBWF       _ipMaskPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP209
	MOVF        _ipMaskPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP209
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP209
	MOVF        _ipMaskPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP209
L__SPI_Ethernet_UserTCP536:
;SE9M.c,1365 :: 		EEPROM_Write(10, (ipMaskPom1[0]-48)*100 + (ipMaskPom1[1]-48)*10 + (ipMaskPom1[2]-48));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom1+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1366 :: 		}
L_SPI_Ethernet_UserTCP209:
;SE9M.c,1367 :: 		if ( (ipMaskPom1[0] < '1') && (ipMaskPom1[1] >= '1') && (ipMaskPom1[1] <= '9') && (ipMaskPom1[2] >= '0') && (ipMaskPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP212
	MOVLW       49
	SUBWF       _ipMaskPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP212
	MOVF        _ipMaskPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP212
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP212
	MOVF        _ipMaskPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP212
L__SPI_Ethernet_UserTCP535:
;SE9M.c,1368 :: 		EEPROM_Write(10, (ipMaskPom1[1]-48)*10 + (ipMaskPom1[2]-48));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom1+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1369 :: 		}
L_SPI_Ethernet_UserTCP212:
;SE9M.c,1370 :: 		if ( (ipMaskPom1[0] < '1') && (ipMaskPom1[1] < '1') && (ipMaskPom1[2] >= '0') && (ipMaskPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP215
	MOVLW       49
	SUBWF       _ipMaskPom1+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP215
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP215
	MOVF        _ipMaskPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP215
L__SPI_Ethernet_UserTCP534:
;SE9M.c,1371 :: 		EEPROM_Write(10, (ipMaskPom1[2]-48));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom1+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1372 :: 		}
L_SPI_Ethernet_UserTCP215:
;SE9M.c,1374 :: 		if ( (ipMaskPom2[0] >= '1') && (ipMaskPom2[0] <= '9') && (ipMaskPom2[1] >= '0') && (ipMaskPom2[1] <= '9') && (ipMaskPom2[2] >= '0') && (ipMaskPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP218
	MOVF        _ipMaskPom2+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP218
	MOVLW       48
	SUBWF       _ipMaskPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP218
	MOVF        _ipMaskPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP218
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP218
	MOVF        _ipMaskPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP218
L__SPI_Ethernet_UserTCP533:
;SE9M.c,1375 :: 		EEPROM_Write(11, (ipMaskPom2[0]-48)*100 + (ipMaskPom2[1]-48)*10 + (ipMaskPom2[2]-48));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom2+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1376 :: 		}
L_SPI_Ethernet_UserTCP218:
;SE9M.c,1377 :: 		if ( (ipMaskPom2[0] < '1') && (ipMaskPom2[1] >= '1') && (ipMaskPom2[1] <= '9') && (ipMaskPom2[2] >= '0') && (ipMaskPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP221
	MOVLW       49
	SUBWF       _ipMaskPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP221
	MOVF        _ipMaskPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP221
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP221
	MOVF        _ipMaskPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP221
L__SPI_Ethernet_UserTCP532:
;SE9M.c,1378 :: 		EEPROM_Write(11, (ipMaskPom2[1]-48)*10 + (ipMaskPom2[2]-48));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom2+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1379 :: 		}
L_SPI_Ethernet_UserTCP221:
;SE9M.c,1380 :: 		if ( (ipMaskPom2[0] < '1') && (ipMaskPom2[1] < '1') && (ipMaskPom2[2] >= '0') && (ipMaskPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP224
	MOVLW       49
	SUBWF       _ipMaskPom2+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP224
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP224
	MOVF        _ipMaskPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP224
L__SPI_Ethernet_UserTCP531:
;SE9M.c,1381 :: 		EEPROM_Write(11, (ipMaskPom2[2]-48));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom2+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1382 :: 		}
L_SPI_Ethernet_UserTCP224:
;SE9M.c,1384 :: 		if ( (ipMaskPom3[0] >= '1') && (ipMaskPom3[0] <= '9') && (ipMaskPom3[1] >= '0') && (ipMaskPom3[1] <= '9') && (ipMaskPom3[2] >= '0') && (ipMaskPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom3+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP227
	MOVF        _ipMaskPom3+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP227
	MOVLW       48
	SUBWF       _ipMaskPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP227
	MOVF        _ipMaskPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP227
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP227
	MOVF        _ipMaskPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP227
L__SPI_Ethernet_UserTCP530:
;SE9M.c,1385 :: 		EEPROM_Write(12, (ipMaskPom3[0]-48)*100 + (ipMaskPom3[1]-48)*10 + (ipMaskPom3[2]-48));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom3+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom3+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1386 :: 		}
L_SPI_Ethernet_UserTCP227:
;SE9M.c,1387 :: 		if ( (ipMaskPom3[0] < '1') && (ipMaskPom3[1] >= '1') && (ipMaskPom3[1] <= '9') && (ipMaskPom3[2] >= '0') && (ipMaskPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP230
	MOVLW       49
	SUBWF       _ipMaskPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP230
	MOVF        _ipMaskPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP230
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP230
	MOVF        _ipMaskPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP230
L__SPI_Ethernet_UserTCP529:
;SE9M.c,1388 :: 		EEPROM_Write(12, (ipMaskPom3[1]-48)*10 + (ipMaskPom3[2]-48));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom3+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1389 :: 		}
L_SPI_Ethernet_UserTCP230:
;SE9M.c,1390 :: 		if ( (ipMaskPom3[0] < '1') && (ipMaskPom3[1] < '1') && (ipMaskPom3[2] >= '0') && (ipMaskPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _ipMaskPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP233
	MOVLW       49
	SUBWF       _ipMaskPom3+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP233
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP233
	MOVF        _ipMaskPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP233
L__SPI_Ethernet_UserTCP528:
;SE9M.c,1391 :: 		EEPROM_Write(12, (ipMaskPom3[2]-48));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _ipMaskPom3+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1392 :: 		}
L_SPI_Ethernet_UserTCP233:
;SE9M.c,1396 :: 		if ( (dnsIpAddrPom0[0] >= '1') && (dnsIpAddrPom0[0] <= '9') && (dnsIpAddrPom0[1] >= '0') && (dnsIpAddrPom0[1] <= '9') && (dnsIpAddrPom0[2] >= '0') && (dnsIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP236
	MOVF        _dnsIpAddrPom0+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP236
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP236
	MOVF        _dnsIpAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP236
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP236
	MOVF        _dnsIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP236
L__SPI_Ethernet_UserTCP527:
;SE9M.c,1397 :: 		EEPROM_Write(13, (dnsIpAddrPom0[0]-48)*100 + (dnsIpAddrPom0[1]-48)*10 + (dnsIpAddrPom0[2]-48));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1398 :: 		}
L_SPI_Ethernet_UserTCP236:
;SE9M.c,1399 :: 		if ( (dnsIpAddrPom0[0] < '1') && (dnsIpAddrPom0[1] >= '1') && (dnsIpAddrPom0[1] <= '9') && (dnsIpAddrPom0[2] >= '0') && (dnsIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP239
	MOVLW       49
	SUBWF       _dnsIpAddrPom0+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP239
	MOVF        _dnsIpAddrPom0+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP239
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP239
	MOVF        _dnsIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP239
L__SPI_Ethernet_UserTCP526:
;SE9M.c,1400 :: 		EEPROM_Write(13, (dnsIpAddrPom0[1]-48)*10 + (dnsIpAddrPom0[2]-48));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1401 :: 		}
L_SPI_Ethernet_UserTCP239:
;SE9M.c,1402 :: 		if ( (dnsIpAddrPom0[0] < '1') && (dnsIpAddrPom0[1] < '1') && (dnsIpAddrPom0[2] >= '0') && (dnsIpAddrPom0[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP242
	MOVLW       49
	SUBWF       _dnsIpAddrPom0+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP242
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP242
	MOVF        _dnsIpAddrPom0+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP242
L__SPI_Ethernet_UserTCP525:
;SE9M.c,1403 :: 		EEPROM_Write(13, (dnsIpAddrPom0[2]-48));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom0+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1404 :: 		}
L_SPI_Ethernet_UserTCP242:
;SE9M.c,1406 :: 		if ( (dnsIpAddrPom1[0] >= '1') && (dnsIpAddrPom1[0] <= '9') && (dnsIpAddrPom1[1] >= '0') && (dnsIpAddrPom1[1] <= '9') && (dnsIpAddrPom1[2] >= '0') && (dnsIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP245
	MOVF        _dnsIpAddrPom1+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP245
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP245
	MOVF        _dnsIpAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP245
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP245
	MOVF        _dnsIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP245
L__SPI_Ethernet_UserTCP524:
;SE9M.c,1407 :: 		EEPROM_Write(14, (dnsIpAddrPom1[0]-48)*100 + (dnsIpAddrPom1[1]-48)*10 + (dnsIpAddrPom1[2]-48));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1408 :: 		}
L_SPI_Ethernet_UserTCP245:
;SE9M.c,1409 :: 		if ( (dnsIpAddrPom1[0] < '1') && (dnsIpAddrPom1[1] >= '1') && (dnsIpAddrPom1[1] <= '9') && (dnsIpAddrPom1[2] >= '0') && (dnsIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP248
	MOVLW       49
	SUBWF       _dnsIpAddrPom1+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP248
	MOVF        _dnsIpAddrPom1+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP248
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP248
	MOVF        _dnsIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP248
L__SPI_Ethernet_UserTCP523:
;SE9M.c,1410 :: 		EEPROM_Write(14, (dnsIpAddrPom1[1]-48)*10 + (dnsIpAddrPom1[2]-48));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1411 :: 		}
L_SPI_Ethernet_UserTCP248:
;SE9M.c,1412 :: 		if ( (dnsIpAddrPom1[0] < '1') && (dnsIpAddrPom1[1] < '1') && (dnsIpAddrPom1[2] >= '0') && (dnsIpAddrPom1[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP251
	MOVLW       49
	SUBWF       _dnsIpAddrPom1+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP251
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP251
	MOVF        _dnsIpAddrPom1+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP251
L__SPI_Ethernet_UserTCP522:
;SE9M.c,1413 :: 		EEPROM_Write(14, (dnsIpAddrPom1[2]-48));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom1+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1414 :: 		}
L_SPI_Ethernet_UserTCP251:
;SE9M.c,1416 :: 		if ( (dnsIpAddrPom2[0] >= '1') && (dnsIpAddrPom2[0] <= '9') && (dnsIpAddrPom2[1] >= '0') && (dnsIpAddrPom2[1] <= '9') && (dnsIpAddrPom2[2] >= '0') && (dnsIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP254
	MOVF        _dnsIpAddrPom2+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP254
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP254
	MOVF        _dnsIpAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP254
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP254
	MOVF        _dnsIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP254
L__SPI_Ethernet_UserTCP521:
;SE9M.c,1417 :: 		EEPROM_Write(15, (dnsIpAddrPom2[0]-48)*100 + (dnsIpAddrPom2[1]-48)*10 + (dnsIpAddrPom2[2]-48));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1418 :: 		}
L_SPI_Ethernet_UserTCP254:
;SE9M.c,1419 :: 		if ( (dnsIpAddrPom2[0] < '1') && (dnsIpAddrPom2[1] >= '1') && (dnsIpAddrPom2[1] <= '9') && (dnsIpAddrPom2[2] >= '0') && (dnsIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP257
	MOVLW       49
	SUBWF       _dnsIpAddrPom2+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP257
	MOVF        _dnsIpAddrPom2+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP257
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP257
	MOVF        _dnsIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP257
L__SPI_Ethernet_UserTCP520:
;SE9M.c,1420 :: 		EEPROM_Write(15, (dnsIpAddrPom2[1]-48)*10 + (dnsIpAddrPom2[2]-48));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1421 :: 		}
L_SPI_Ethernet_UserTCP257:
;SE9M.c,1422 :: 		if ( (dnsIpAddrPom2[0] < '1') && (dnsIpAddrPom2[1] < '1') && (dnsIpAddrPom2[2] >= '0') && (dnsIpAddrPom2[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP260
	MOVLW       49
	SUBWF       _dnsIpAddrPom2+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP260
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP260
	MOVF        _dnsIpAddrPom2+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP260
L__SPI_Ethernet_UserTCP519:
;SE9M.c,1423 :: 		EEPROM_Write(15, (dnsIpAddrPom2[2]-48));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom2+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1424 :: 		}
L_SPI_Ethernet_UserTCP260:
;SE9M.c,1426 :: 		if ( (dnsIpAddrPom3[0] >= '1') && (dnsIpAddrPom3[0] <= '9') && (dnsIpAddrPom3[1] >= '0') && (dnsIpAddrPom3[1] <= '9') && (dnsIpAddrPom3[2] >= '0') && (dnsIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom3+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP263
	MOVF        _dnsIpAddrPom3+0, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP263
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP263
	MOVF        _dnsIpAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP263
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP263
	MOVF        _dnsIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP263
L__SPI_Ethernet_UserTCP518:
;SE9M.c,1427 :: 		EEPROM_Write(16, (dnsIpAddrPom3[0]-48)*100 + (dnsIpAddrPom3[1]-48)*10 + (dnsIpAddrPom3[2]-48));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       100
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+1, 0 
	MOVWF       R0 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1428 :: 		}
L_SPI_Ethernet_UserTCP263:
;SE9M.c,1429 :: 		if ( (dnsIpAddrPom3[0] < '1') && (dnsIpAddrPom3[1] >= '1') && (dnsIpAddrPom3[1] <= '9') && (dnsIpAddrPom3[2] >= '0') && (dnsIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP266
	MOVLW       49
	SUBWF       _dnsIpAddrPom3+1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP266
	MOVF        _dnsIpAddrPom3+1, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP266
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP266
	MOVF        _dnsIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP266
L__SPI_Ethernet_UserTCP517:
;SE9M.c,1430 :: 		EEPROM_Write(16, (dnsIpAddrPom3[1]-48)*10 + (dnsIpAddrPom3[2]-48));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       10
	MULWF       FARG_EEPROM_Write_data_+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_EEPROM_Write_data_+0, 1 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1431 :: 		}
L_SPI_Ethernet_UserTCP266:
;SE9M.c,1432 :: 		if ( (dnsIpAddrPom3[0] < '1') && (dnsIpAddrPom3[1] < '1') && (dnsIpAddrPom3[2] >= '0') && (dnsIpAddrPom3[2] <= '9') ) {
	MOVLW       49
	SUBWF       _dnsIpAddrPom3+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP269
	MOVLW       49
	SUBWF       _dnsIpAddrPom3+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP269
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP269
	MOVF        _dnsIpAddrPom3+2, 0 
	SUBLW       57
	BTFSS       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP269
L__SPI_Ethernet_UserTCP516:
;SE9M.c,1433 :: 		EEPROM_Write(16, (dnsIpAddrPom3[2]-48));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       48
	SUBWF       _dnsIpAddrPom3+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1434 :: 		}
L_SPI_Ethernet_UserTCP269:
;SE9M.c,1435 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_SPI_Ethernet_UserTCP270:
	DECFSZ      R13, 1, 1
	BRA         L_SPI_Ethernet_UserTCP270
	DECFSZ      R12, 1, 1
	BRA         L_SPI_Ethernet_UserTCP270
	DECFSZ      R11, 1, 1
	BRA         L_SPI_Ethernet_UserTCP270
;SE9M.c,1436 :: 		Rst_Eth();
	CALL        _Rst_Eth+0, 0
;SE9M.c,1437 :: 		}
L_SPI_Ethernet_UserTCP125:
;SE9M.c,1438 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1439 :: 		case 'n':
L_SPI_Ethernet_UserTCP271:
;SE9M.c,1441 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP272
;SE9M.c,1442 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP273
;SE9M.c,1443 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1444 :: 		ByteToStr(pomocni,IpAddrPom0);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1445 :: 		}
L_SPI_Ethernet_UserTCP273:
;SE9M.c,1446 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP274
;SE9M.c,1447 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1448 :: 		ByteToStr(pomocni,ipMaskPom0);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1449 :: 		}
L_SPI_Ethernet_UserTCP274:
;SE9M.c,1450 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP275
;SE9M.c,1451 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1452 :: 		ByteToStr(pomocni,gwIpAddrPom0);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1453 :: 		}
L_SPI_Ethernet_UserTCP275:
;SE9M.c,1454 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP276
;SE9M.c,1455 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1456 :: 		ByteToStr(pomocni,dnsIpAddrPom0);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1457 :: 		}
L_SPI_Ethernet_UserTCP276:
;SE9M.c,1458 :: 		}
L_SPI_Ethernet_UserTCP272:
;SE9M.c,1459 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1460 :: 		case 'o':
L_SPI_Ethernet_UserTCP277:
;SE9M.c,1462 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP278
;SE9M.c,1463 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP279
;SE9M.c,1464 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1465 :: 		ByteToStr(pomocni,IpAddrPom1);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1466 :: 		}
L_SPI_Ethernet_UserTCP279:
;SE9M.c,1467 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP280
;SE9M.c,1468 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1469 :: 		ByteToStr(pomocni,ipMaskPom1);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1470 :: 		}
L_SPI_Ethernet_UserTCP280:
;SE9M.c,1471 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP281
;SE9M.c,1472 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1473 :: 		ByteToStr(pomocni,gwIpAddrPom1);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1474 :: 		}
L_SPI_Ethernet_UserTCP281:
;SE9M.c,1475 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP282
;SE9M.c,1476 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1477 :: 		ByteToStr(pomocni,dnsIpAddrPom1);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1478 :: 		}
L_SPI_Ethernet_UserTCP282:
;SE9M.c,1479 :: 		}
L_SPI_Ethernet_UserTCP278:
;SE9M.c,1480 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1481 :: 		case 'p':
L_SPI_Ethernet_UserTCP283:
;SE9M.c,1483 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP284
;SE9M.c,1484 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP285
;SE9M.c,1485 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1486 :: 		ByteToStr(pomocni,IpAddrPom2);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1487 :: 		}
L_SPI_Ethernet_UserTCP285:
;SE9M.c,1488 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP286
;SE9M.c,1489 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1490 :: 		ByteToStr(pomocni,ipMaskPom2);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1491 :: 		}
L_SPI_Ethernet_UserTCP286:
;SE9M.c,1492 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP287
;SE9M.c,1493 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1494 :: 		ByteToStr(pomocni,gwIpAddrPom2);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1495 :: 		}
L_SPI_Ethernet_UserTCP287:
;SE9M.c,1496 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP288
;SE9M.c,1497 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1498 :: 		ByteToStr(pomocni,dnsIpAddrPom2);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1499 :: 		}
L_SPI_Ethernet_UserTCP288:
;SE9M.c,1500 :: 		}
L_SPI_Ethernet_UserTCP284:
;SE9M.c,1501 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1502 :: 		case 'q':
L_SPI_Ethernet_UserTCP289:
;SE9M.c,1504 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP290
;SE9M.c,1505 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP291
;SE9M.c,1506 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1507 :: 		ByteToStr(pomocni,IpAddrPom3);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1508 :: 		}
L_SPI_Ethernet_UserTCP291:
;SE9M.c,1509 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP292
;SE9M.c,1510 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1511 :: 		ByteToStr(pomocni,ipMaskPom3);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1512 :: 		}
L_SPI_Ethernet_UserTCP292:
;SE9M.c,1513 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP293
;SE9M.c,1514 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1515 :: 		ByteToStr(pomocni,gwIpAddrPom3);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1516 :: 		}
L_SPI_Ethernet_UserTCP293:
;SE9M.c,1517 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP294
;SE9M.c,1518 :: 		pomocni = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _pomocni+0 
;SE9M.c,1519 :: 		ByteToStr(pomocni,dnsIpAddrPom3);
	MOVF        R0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,1520 :: 		}
L_SPI_Ethernet_UserTCP294:
;SE9M.c,1521 :: 		}
L_SPI_Ethernet_UserTCP290:
;SE9M.c,1522 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1523 :: 		case 'v':
L_SPI_Ethernet_UserTCP295:
;SE9M.c,1526 :: 		pomocnaSifra[0] = getRequest[sizeof(path_private) + 2] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+9, 0 
	MOVWF       _pomocnaSifra+0 
;SE9M.c,1527 :: 		pomocnaSifra[1] = getRequest[sizeof(path_private) + 3] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+10, 0 
	MOVWF       _pomocnaSifra+1 
;SE9M.c,1528 :: 		pomocnaSifra[2] = getRequest[sizeof(path_private) + 4] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+11, 0 
	MOVWF       _pomocnaSifra+2 
;SE9M.c,1529 :: 		pomocnaSifra[3] = getRequest[sizeof(path_private) + 5] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+12, 0 
	MOVWF       _pomocnaSifra+3 
;SE9M.c,1530 :: 		pomocnaSifra[4] = getRequest[sizeof(path_private) + 6] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+13, 0 
	MOVWF       _pomocnaSifra+4 
;SE9M.c,1531 :: 		pomocnaSifra[5] = getRequest[sizeof(path_private) + 7] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+14, 0 
	MOVWF       _pomocnaSifra+5 
;SE9M.c,1532 :: 		pomocnaSifra[6] = getRequest[sizeof(path_private) + 8] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+15, 0 
	MOVWF       _pomocnaSifra+6 
;SE9M.c,1533 :: 		pomocnaSifra[7] = getRequest[sizeof(path_private) + 9] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+16, 0 
	MOVWF       _pomocnaSifra+7 
;SE9M.c,1534 :: 		pomocnaSifra[8] = 0;
	CLRF        _pomocnaSifra+8 
;SE9M.c,1537 :: 		if (strcmp(sifra,pomocnaSifra) == 0) {
	MOVLW       _sifra+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       _pomocnaSifra+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(_pomocnaSifra+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP601
	MOVLW       0
	XORWF       R0, 0 
L__SPI_Ethernet_UserTCP601:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP296
;SE9M.c,1538 :: 		tmr_rst_en = 1;
	MOVLW       1
	MOVWF       _tmr_rst_en+0 
;SE9M.c,1539 :: 		admin = 1;
	MOVLW       1
	MOVWF       _admin+0 
;SE9M.c,1540 :: 		len = 0;
	CLRF        SPI_Ethernet_UserTCP_len_L0+0 
	CLRF        SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1541 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1542 :: 		len += putConstString(HTMLredirect) ;
	MOVF        _HTMLredirect+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLredirect+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLredirect+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1543 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1544 :: 		goto ZAVRSI;
	GOTO        ___SPI_Ethernet_UserTCP_ZAVRSI
;SE9M.c,1546 :: 		}
L_SPI_Ethernet_UserTCP296:
;SE9M.c,1547 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1548 :: 		case 'x':
L_SPI_Ethernet_UserTCP297:
;SE9M.c,1551 :: 		oldSifra[0] = getRequest[sizeof(path_private) + 2] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+9, 0 
	MOVWF       _oldSifra+0 
;SE9M.c,1552 :: 		oldSifra[1] = getRequest[sizeof(path_private) + 3] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+10, 0 
	MOVWF       _oldSifra+1 
;SE9M.c,1553 :: 		oldSifra[2] = getRequest[sizeof(path_private) + 4] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+11, 0 
	MOVWF       _oldSifra+2 
;SE9M.c,1554 :: 		oldSifra[3] = getRequest[sizeof(path_private) + 5] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+12, 0 
	MOVWF       _oldSifra+3 
;SE9M.c,1555 :: 		oldSifra[4] = getRequest[sizeof(path_private) + 6] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+13, 0 
	MOVWF       _oldSifra+4 
;SE9M.c,1556 :: 		oldSifra[5] = getRequest[sizeof(path_private) + 7] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+14, 0 
	MOVWF       _oldSifra+5 
;SE9M.c,1557 :: 		oldSifra[6] = getRequest[sizeof(path_private) + 8] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+15, 0 
	MOVWF       _oldSifra+6 
;SE9M.c,1558 :: 		oldSifra[7] = getRequest[sizeof(path_private) + 9] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+16, 0 
	MOVWF       _oldSifra+7 
;SE9M.c,1559 :: 		oldSifra[8] = 0;
	CLRF        _oldSifra+8 
;SE9M.c,1560 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1561 :: 		case 'y':
L_SPI_Ethernet_UserTCP298:
;SE9M.c,1564 :: 		newSifra[0] = getRequest[sizeof(path_private) + 2] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+9, 0 
	MOVWF       _newSifra+0 
;SE9M.c,1565 :: 		newSifra[1] = getRequest[sizeof(path_private) + 3] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+10, 0 
	MOVWF       _newSifra+1 
;SE9M.c,1566 :: 		newSifra[2] = getRequest[sizeof(path_private) + 4] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+11, 0 
	MOVWF       _newSifra+2 
;SE9M.c,1567 :: 		newSifra[3] = getRequest[sizeof(path_private) + 5] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+12, 0 
	MOVWF       _newSifra+3 
;SE9M.c,1568 :: 		newSifra[4] = getRequest[sizeof(path_private) + 6] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+13, 0 
	MOVWF       _newSifra+4 
;SE9M.c,1569 :: 		newSifra[5] = getRequest[sizeof(path_private) + 7] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+14, 0 
	MOVWF       _newSifra+5 
;SE9M.c,1570 :: 		newSifra[6] = getRequest[sizeof(path_private) + 8] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+15, 0 
	MOVWF       _newSifra+6 
;SE9M.c,1571 :: 		newSifra[7] = getRequest[sizeof(path_private) + 9] ;
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+16, 0 
	MOVWF       _newSifra+7 
;SE9M.c,1572 :: 		newSifra[8] = 0;
	CLRF        _newSifra+8 
;SE9M.c,1573 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1575 :: 		case 'w' :
L_SPI_Ethernet_UserTCP299:
;SE9M.c,1577 :: 		if (strcmp(sifra, oldSifra) == 0) {
	MOVLW       _sifra+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP602
	MOVLW       0
	XORWF       R0, 0 
L__SPI_Ethernet_UserTCP602:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP300
;SE9M.c,1578 :: 		rest = strcpy(sifra, newSifra);
	MOVLW       _sifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	MOVF        R0, 0 
	MOVWF       _rest+0 
	MOVF        R1, 0 
	MOVWF       _rest+1 
;SE9M.c,1579 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,1580 :: 		}
L_SPI_Ethernet_UserTCP300:
;SE9M.c,1581 :: 		EEPROM_Write(20, sifra[0]);
	MOVLW       20
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1582 :: 		EEPROM_Write(21, sifra[1]);
	MOVLW       21
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1583 :: 		EEPROM_Write(22, sifra[2]);
	MOVLW       22
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1584 :: 		EEPROM_Write(23, sifra[3]);
	MOVLW       23
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1585 :: 		EEPROM_Write(24, sifra[4]);
	MOVLW       24
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1586 :: 		EEPROM_Write(25, sifra[5]);
	MOVLW       25
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1587 :: 		EEPROM_Write(26, sifra[6]);
	MOVLW       26
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1588 :: 		EEPROM_Write(27, sifra[7]);
	MOVLW       27
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1589 :: 		EEPROM_Write(28, sifra[8]);
	MOVLW       28
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _sifra+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1590 :: 		strcpy(oldSifra, "OLD     ");
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr166_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr166_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1591 :: 		strcpy(newSifra, "NEW     ");
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr167_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr167_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1592 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_SPI_Ethernet_UserTCP301:
	DECFSZ      R13, 1, 1
	BRA         L_SPI_Ethernet_UserTCP301
	DECFSZ      R12, 1, 1
	BRA         L_SPI_Ethernet_UserTCP301
	DECFSZ      R11, 1, 1
	BRA         L_SPI_Ethernet_UserTCP301
;SE9M.c,1593 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1594 :: 		case 'u':
L_SPI_Ethernet_UserTCP302:
;SE9M.c,1595 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP303
;SE9M.c,1596 :: 		s_ip = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _s_ip+0 
;SE9M.c,1597 :: 		s_ip += 1 ;
	MOVF        R0, 0 
	ADDLW       1
	MOVWF       _s_ip+0 
;SE9M.c,1598 :: 		}
L_SPI_Ethernet_UserTCP303:
;SE9M.c,1599 :: 		saveConf() ;
	CALL        _saveConf+0, 0
;SE9M.c,1600 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1602 :: 		case 't':
L_SPI_Ethernet_UserTCP304:
;SE9M.c,1604 :: 		conf.tz = atoi(&getRequest[sizeof(path_private) + 2]) ;
	MOVLW       SPI_Ethernet_UserTCP_getRequest_L0+9
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_getRequest_L0+9)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+2 
;SE9M.c,1605 :: 		conf.tz -= 11 ;
	MOVLW       11
	SUBWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _conf+2 
;SE9M.c,1606 :: 		Eeprom_Write(102, conf.tz);
	MOVLW       102
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,1607 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_SPI_Ethernet_UserTCP305:
	DECFSZ      R13, 1, 1
	BRA         L_SPI_Ethernet_UserTCP305
	DECFSZ      R12, 1, 1
	BRA         L_SPI_Ethernet_UserTCP305
	DECFSZ      R11, 1, 1
	BRA         L_SPI_Ethernet_UserTCP305
;SE9M.c,1608 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP121
;SE9M.c,1609 :: 		}
L_SPI_Ethernet_UserTCP120:
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP122
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       114
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP124
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       110
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP271
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       111
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP277
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       112
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP283
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       113
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP289
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       118
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP295
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       120
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP297
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       121
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP298
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       119
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP299
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       117
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP302
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+7, 0 
	XORLW       116
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP304
L_SPI_Ethernet_UserTCP121:
;SE9M.c,1611 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1612 :: 		if (admin == 0) {
	MOVF        _admin+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP306
;SE9M.c,1613 :: 		len += putConstString(HTMLadmin0);
	MOVF        _HTMLadmin0+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLadmin0+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLadmin0+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1614 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP307
L_SPI_Ethernet_UserTCP306:
;SE9M.c,1615 :: 		if (s_ip == 1) {
	MOVF        _s_ip+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP308
;SE9M.c,1616 :: 		len += putConstString(HTMLadmin1) ;
	MOVF        _HTMLadmin1+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLadmin1+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLadmin1+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1617 :: 		}
L_SPI_Ethernet_UserTCP308:
;SE9M.c,1618 :: 		if (s_ip == 2) {
	MOVF        _s_ip+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP309
;SE9M.c,1619 :: 		len += putConstString(HTMLadmin2) ;
	MOVF        _HTMLadmin2+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLadmin2+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLadmin2+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1620 :: 		}
L_SPI_Ethernet_UserTCP309:
;SE9M.c,1621 :: 		if (s_ip == 3) {
	MOVF        _s_ip+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP310
;SE9M.c,1622 :: 		len += putConstString(HTMLadmin3) ;
	MOVF        _HTMLadmin3+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLadmin3+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLadmin3+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1623 :: 		}
L_SPI_Ethernet_UserTCP310:
;SE9M.c,1624 :: 		if (s_ip == 4) {
	MOVF        _s_ip+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP311
;SE9M.c,1625 :: 		len += putConstString(HTMLadmin4) ;
	MOVF        _HTMLadmin4+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLadmin4+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLadmin4+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1626 :: 		}
L_SPI_Ethernet_UserTCP311:
;SE9M.c,1627 :: 		}
L_SPI_Ethernet_UserTCP307:
;SE9M.c,1628 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1629 :: 		}
L_SPI_Ethernet_UserTCP119:
;SE9M.c,1631 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP312
L_SPI_Ethernet_UserTCP57:
;SE9M.c,1632 :: 		else switch(getRequest[1])
	GOTO        L_SPI_Ethernet_UserTCP313
;SE9M.c,1635 :: 		case 's':
L_SPI_Ethernet_UserTCP315:
;SE9M.c,1637 :: 		if(lastSync == 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       _lastSync+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP603
	MOVF        R0, 0 
	XORWF       _lastSync+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP603
	MOVF        R0, 0 
	XORWF       _lastSync+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP603
	MOVF        _lastSync+0, 0 
	XORLW       0
L__SPI_Ethernet_UserTCP603:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP316
;SE9M.c,1639 :: 		len = putConstString(CSSred) ;          // not sync
	MOVF        _CSSred+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _CSSred+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _CSSred+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1640 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP317
L_SPI_Ethernet_UserTCP316:
;SE9M.c,1643 :: 		len = putConstString(CSSgreen) ;        // sync
	MOVF        _CSSgreen+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _CSSgreen+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _CSSgreen+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1644 :: 		}
L_SPI_Ethernet_UserTCP317:
;SE9M.c,1645 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,1646 :: 		case 'a':
L_SPI_Ethernet_UserTCP318:
;SE9M.c,1649 :: 		len = putConstString(httpHeader) ;
	MOVLW       _httpHeader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1650 :: 		len += putConstString(httpMimeTypeScript) ;
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1653 :: 		ts2str(dyna, &ts, TS2STR_ALL | TS2STR_TZ) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _ts+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       7
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,1654 :: 		len += putConstString("var NOW=\"") ;
	MOVLW       ?lstr_168_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_168_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_168_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1655 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1656 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_169_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_169_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_169_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1659 :: 		int2str(epoch, dyna) ;
	MOVF        _epoch+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVF        _epoch+1, 0 
	MOVWF       FARG_int2str_l+1 
	MOVF        _epoch+2, 0 
	MOVWF       FARG_int2str_l+2 
	MOVF        _epoch+3, 0 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1660 :: 		len += putConstString("var EPOCH=") ;
	MOVLW       ?lstr_170_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_170_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_170_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1661 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1662 :: 		len += putConstString(";") ;
	MOVLW       ?lstr_171_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_171_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_171_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1665 :: 		if(lastSync == 0)
	MOVLW       0
	MOVWF       R0 
	XORWF       _lastSync+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP604
	MOVF        R0, 0 
	XORWF       _lastSync+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP604
	MOVF        R0, 0 
	XORWF       _lastSync+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP604
	MOVF        _lastSync+0, 0 
	XORLW       0
L__SPI_Ethernet_UserTCP604:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP319
;SE9M.c,1667 :: 		strcpy(dyna, "???") ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr172_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr172_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1668 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP320
L_SPI_Ethernet_UserTCP319:
;SE9M.c,1671 :: 		Time_epochToDate(lastSync + tmzn * 3600, &ls) ;
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
	ADDWF       _lastSync+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        R1, 0 
	ADDWFC      _lastSync+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _lastSync+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      _lastSync+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVLW       _ls+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(_ls+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,1672 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,1673 :: 		ts2str(dyna, &ls, TS2STR_ALL | TS2STR_TZ) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       _ls+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(_ls+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       7
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,1674 :: 		}
L_SPI_Ethernet_UserTCP320:
;SE9M.c,1675 :: 		len += putConstString("var LAST=\"") ;
	MOVLW       ?lstr_173_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_173_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_173_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1676 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1677 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_174_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_174_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_174_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1679 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,1681 :: 		case 'b':
L_SPI_Ethernet_UserTCP321:
;SE9M.c,1684 :: 		len = putConstString(httpHeader) ;
	MOVLW       _httpHeader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1685 :: 		len += putConstString(httpMimeTypeScript) ;
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1688 :: 		ip2str(dyna, conf.sntpIP) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _conf+3
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_conf+3)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1689 :: 		len += putConstString("var SNTP=\"") ;
	MOVLW       ?lstr_175_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_175_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_175_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1690 :: 		len += putString(conf.sntpServer) ;
	MOVLW       _conf+7
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_conf+7)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1691 :: 		len += putConstString(" (") ;
	MOVLW       ?lstr_176_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_176_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_176_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1692 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1693 :: 		len += putConstString(")") ;
	MOVLW       ?lstr_177_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_177_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_177_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1694 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_178_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_178_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_178_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1697 :: 		if(serverStratum == 0)
	MOVF        _serverStratum+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP322
;SE9M.c,1699 :: 		strcpy(dyna, "Unspecified") ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr179_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr179_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1700 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP323
L_SPI_Ethernet_UserTCP322:
;SE9M.c,1701 :: 		else if(serverStratum == 1)
	MOVF        _serverStratum+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP324
;SE9M.c,1703 :: 		strcpy(dyna, "1 (primary)") ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr180_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr180_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1704 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP325
L_SPI_Ethernet_UserTCP324:
;SE9M.c,1705 :: 		else if(serverStratum < 16)
	MOVLW       16
	SUBWF       _serverStratum+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP326
;SE9M.c,1707 :: 		int2str(serverStratum, dyna) ;
	MOVF        _serverStratum+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVLW       0
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1708 :: 		strcat(dyna, "(secondary)") ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr181_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr181_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,1709 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP327
L_SPI_Ethernet_UserTCP326:
;SE9M.c,1712 :: 		int2str(serverStratum, dyna) ;
	MOVF        _serverStratum+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVLW       0
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1713 :: 		strcat(dyna, " (reserved)") ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr182_SE9M+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr182_SE9M+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;SE9M.c,1714 :: 		}
L_SPI_Ethernet_UserTCP327:
L_SPI_Ethernet_UserTCP325:
L_SPI_Ethernet_UserTCP323:
;SE9M.c,1715 :: 		len += putConstString("var STRATUM=\"") ;
	MOVLW       ?lstr_183_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_183_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_183_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1716 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1717 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_184_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_184_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_184_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1720 :: 		switch(serverFlags & 0b11000000)
	MOVLW       192
	ANDWF       _serverFlags+0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserTCP+0 
	GOTO        L_SPI_Ethernet_UserTCP328
;SE9M.c,1722 :: 		case 0b00000000: strcpy(dyna, "No warning") ; break ;
L_SPI_Ethernet_UserTCP330:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr185_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr185_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP329
;SE9M.c,1723 :: 		case 0b01000000: strcpy(dyna, "Last minute has 61 seconds") ; break ;
L_SPI_Ethernet_UserTCP331:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr186_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr186_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP329
;SE9M.c,1724 :: 		case 0b10000000: strcpy(dyna, "Last minute has 59 seconds") ; break ;
L_SPI_Ethernet_UserTCP332:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr187_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr187_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP329
;SE9M.c,1725 :: 		case 0b11000000: strcpy(dyna, "SNTP server not synchronized") ; break ;
L_SPI_Ethernet_UserTCP333:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr188_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr188_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP329
;SE9M.c,1726 :: 		}
L_SPI_Ethernet_UserTCP328:
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP330
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       64
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP331
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       128
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP332
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       192
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP333
L_SPI_Ethernet_UserTCP329:
;SE9M.c,1727 :: 		len += putConstString("var LEAP=\"") ;
	MOVLW       ?lstr_189_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_189_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_189_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1728 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1729 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_190_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_190_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_190_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1731 :: 		int2str(serverPrecision, dyna) ;
	MOVF        _serverPrecision+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVLW       0
	MOVWF       FARG_int2str_l+1 
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1732 :: 		len += putConstString("var PRECISION=\"") ;
	MOVLW       ?lstr_191_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_191_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_191_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1733 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1734 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_192_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_192_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_192_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1736 :: 		switch(serverFlags & 0b00111000)
	MOVLW       56
	ANDWF       _serverFlags+0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserTCP+0 
	GOTO        L_SPI_Ethernet_UserTCP334
;SE9M.c,1738 :: 		case 0b00011000: strcpy(dyna, "IPv4 only") ; break ;
L_SPI_Ethernet_UserTCP336:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr193_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr193_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP335
;SE9M.c,1739 :: 		case 0b00110000: strcpy(dyna, "IPv4, IPv6 and OSI") ; break ;
L_SPI_Ethernet_UserTCP337:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr194_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr194_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP335
;SE9M.c,1740 :: 		default: strcpy(dyna, "Undefined") ; break ;
L_SPI_Ethernet_UserTCP338:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr195_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr195_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP335
;SE9M.c,1741 :: 		}
L_SPI_Ethernet_UserTCP334:
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       24
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP336
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP337
	GOTO        L_SPI_Ethernet_UserTCP338
L_SPI_Ethernet_UserTCP335:
;SE9M.c,1742 :: 		len += putConstString("var VN=\"") ;
	MOVLW       ?lstr_196_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_196_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_196_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1743 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1744 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_197_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_197_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_197_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1746 :: 		switch(serverFlags & 0b00000111)
	MOVLW       7
	ANDWF       _serverFlags+0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserTCP+0 
	GOTO        L_SPI_Ethernet_UserTCP339
;SE9M.c,1748 :: 		case 0b00000000: strcpy(dyna, "Reserved") ; break ;
L_SPI_Ethernet_UserTCP341:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr198_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr198_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1749 :: 		case 0b00000001: strcpy(dyna, "Symmetric active") ; break ;
L_SPI_Ethernet_UserTCP342:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr199_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr199_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1750 :: 		case 0b00000010: strcpy(dyna, "Symmetric passive") ; break ;
L_SPI_Ethernet_UserTCP343:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr200_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr200_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1751 :: 		case 0b00000011: strcpy(dyna, "Client") ; break ;
L_SPI_Ethernet_UserTCP344:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr201_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr201_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1752 :: 		case 0b00000100: strcpy(dyna, "Server") ; break ;
L_SPI_Ethernet_UserTCP345:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr202_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr202_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1753 :: 		case 0b00000101: strcpy(dyna, "Broadcast") ; break ;
L_SPI_Ethernet_UserTCP346:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr203_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr203_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1754 :: 		case 0b00000110: strcpy(dyna, "Reserved for NTP control message") ; break ;
L_SPI_Ethernet_UserTCP347:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr204_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr204_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1755 :: 		case 0b00000111: strcpy(dyna, "Reserved for private use") ; break ;
L_SPI_Ethernet_UserTCP348:
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr205_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr205_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
	GOTO        L_SPI_Ethernet_UserTCP340
;SE9M.c,1756 :: 		}
L_SPI_Ethernet_UserTCP339:
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP341
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP342
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP343
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP344
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP345
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP346
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP347
	MOVF        FLOC__SPI_Ethernet_UserTCP+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP348
L_SPI_Ethernet_UserTCP340:
;SE9M.c,1757 :: 		len += putConstString("var MODE=\"") ;
	MOVLW       ?lstr_206_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_206_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_206_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1758 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1759 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_207_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_207_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_207_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1761 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,1763 :: 		case 'c':
L_SPI_Ethernet_UserTCP349:
;SE9M.c,1766 :: 		len = putConstString(httpHeader) ;              // HTTP header
	MOVLW       _httpHeader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1767 :: 		len += putConstString(httpMimeTypeScript) ;     // with text MIME type
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1770 :: 		ip2str(dyna, ipAddr) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1771 :: 		len += putConstString("var IP=\"") ;
	MOVLW       ?lstr_208_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_208_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_208_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1772 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1773 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_209_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_209_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_209_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1775 :: 		byte2hex(dyna, macAddr[0]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+0, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1776 :: 		byte2hex(dyna + 3, macAddr[1]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+3
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+3)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+1, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1777 :: 		byte2hex(dyna + 6, macAddr[2]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+6
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+6)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+2, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1778 :: 		byte2hex(dyna + 9, macAddr[3]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+9
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+9)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+3, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1779 :: 		byte2hex(dyna + 12, macAddr[4]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+12
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+12)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+4, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1780 :: 		byte2hex(dyna + 15, macAddr[5]) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+15
	MOVWF       FARG_byte2hex_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+15)
	MOVWF       FARG_byte2hex_s+1 
	MOVF        _macAddr+5, 0 
	MOVWF       FARG_byte2hex_v+0 
	CALL        _byte2hex+0, 0
;SE9M.c,1781 :: 		*(dyna + 17) = 0 ;
	CLRF        SPI_Ethernet_UserTCP_dyna_L0+17 
;SE9M.c,1782 :: 		len += putConstString("var MAC=\"") ;
	MOVLW       ?lstr_210_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_210_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_210_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1783 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1784 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_211_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_211_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_211_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1787 :: 		ip2str(dyna, remoteHost) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVF        FARG_SPI_Ethernet_UserTCP_remoteHost+0, 0 
	MOVWF       FARG_ip2str_ip+0 
	MOVF        FARG_SPI_Ethernet_UserTCP_remoteHost+1, 0 
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1788 :: 		len += putConstString("var CLIENT=\"") ;
	MOVLW       ?lstr_212_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_212_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_212_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1789 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1790 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_213_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_213_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_213_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1793 :: 		ip2str(dyna, gwIpAddr) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _gwIpAddr+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_gwIpAddr+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1794 :: 		len += putConstString("var GW=\"") ;
	MOVLW       ?lstr_214_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_214_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_214_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1795 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1796 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_215_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_215_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_215_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1799 :: 		ip2str(dyna, ipMask) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _ipMask+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_ipMask+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1800 :: 		len += putConstString("var MASK=\"") ;
	MOVLW       ?lstr_216_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_216_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_216_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1801 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1802 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_217_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_217_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_217_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1805 :: 		ip2str(dyna, dnsIpAddr) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ip2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ip2str_s+1 
	MOVLW       _dnsIpAddr+0
	MOVWF       FARG_ip2str_ip+0 
	MOVLW       hi_addr(_dnsIpAddr+0)
	MOVWF       FARG_ip2str_ip+1 
	CALL        _ip2str+0, 0
;SE9M.c,1806 :: 		len += putConstString("var DNS=\"") ;
	MOVLW       ?lstr_218_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_218_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_218_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1807 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1808 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_219_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_219_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_219_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1810 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,1812 :: 		case 'd':
L_SPI_Ethernet_UserTCP350:
;SE9M.c,1817 :: 		len = putConstString(httpHeader) ;              // HTTP header
	MOVLW       _httpHeader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpHeader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_len_L0+1 
;SE9M.c,1818 :: 		len += putConstString(httpMimeTypeScript) ;     // with text MIME type
	MOVLW       _httpMimeTypeScript+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_httpMimeTypeScript+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1820 :: 		len += putConstString("var SYSTEM=\"ENC28J60\";") ;
	MOVLW       ?lstr_220_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_220_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_220_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1822 :: 		int2str(Clock_kHz(), dyna) ;
	MOVLW       0
	MOVWF       FARG_int2str_l+0 
	MOVLW       125
	MOVWF       FARG_int2str_l+1 
	MOVLW       0
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1823 :: 		len += putConstString("var CLK=\"") ;
	MOVLW       ?lstr_221_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_221_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_221_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1824 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1825 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_222_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_222_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_222_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1828 :: 		int2str(httpCounter, dyna) ;
	MOVF        _httpCounter+0, 0 
	MOVWF       FARG_int2str_l+0 
	MOVF        _httpCounter+1, 0 
	MOVWF       FARG_int2str_l+1 
	MOVLW       0
	MOVWF       FARG_int2str_l+2 
	MOVWF       FARG_int2str_l+3 
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_int2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_int2str_s+1 
	CALL        _int2str+0, 0
;SE9M.c,1829 :: 		len += putConstString("var REQ=") ;
	MOVLW       ?lstr_223_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_223_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_223_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1830 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1831 :: 		len += putConstString(";") ;
	MOVLW       ?lstr_224_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_224_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_224_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1833 :: 		Time_epochToDate(epoch - SPI_Ethernet_UserTimerSec + tmzn * 3600, &t) ;
	MOVF        _epoch+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        _epoch+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVF        _epoch+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVF        _epoch+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVF        _SPI_Ethernet_UserTimerSec+0, 0 
	SUBWF       FARG_Time_epochToDate_e+0, 1 
	MOVF        _SPI_Ethernet_UserTimerSec+1, 0 
	SUBWFB      FARG_Time_epochToDate_e+1, 1 
	MOVF        _SPI_Ethernet_UserTimerSec+2, 0 
	SUBWFB      FARG_Time_epochToDate_e+2, 1 
	MOVF        _SPI_Ethernet_UserTimerSec+3, 0 
	SUBWFB      FARG_Time_epochToDate_e+3, 1 
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
	ADDWF       FARG_Time_epochToDate_e+0, 1 
	MOVF        R1, 0 
	ADDWFC      FARG_Time_epochToDate_e+1, 1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      FARG_Time_epochToDate_e+2, 1 
	ADDWFC      FARG_Time_epochToDate_e+3, 1 
	MOVLW       SPI_Ethernet_UserTCP_t_L2+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_t_L2+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,1834 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,1835 :: 		ts2str(dyna, &t, TS2STR_ALL | TS2STR_TZ) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_ts2str_s+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_ts2str_s+1 
	MOVLW       SPI_Ethernet_UserTCP_t_L2+0
	MOVWF       FARG_ts2str_t+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_t_L2+0)
	MOVWF       FARG_ts2str_t+1 
	MOVLW       7
	MOVWF       FARG_ts2str_m+0 
	CALL        _ts2str+0, 0
;SE9M.c,1836 :: 		len += putConstString("var UP=\"") ;
	MOVLW       ?lstr_225_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_225_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_225_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1837 :: 		len += putString(dyna) ;
	MOVLW       SPI_Ethernet_UserTCP_dyna_L0+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(SPI_Ethernet_UserTCP_dyna_L0+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1838 :: 		len += putConstString("\";") ;
	MOVLW       ?lstr_226_SE9M+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_226_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_226_SE9M+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1841 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,1844 :: 		case '4':
L_SPI_Ethernet_UserTCP351:
;SE9M.c,1845 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,1846 :: 		strcpy(oldSifra, "OLD     ");
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr227_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr227_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1847 :: 		strcpy(newSifra, "NEW     ");
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr228_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr228_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1849 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1850 :: 		len += putConstString(HTMLsystem) ;
	MOVF        _HTMLsystem+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLsystem+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLsystem+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1851 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1852 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,1854 :: 		case '3':
L_SPI_Ethernet_UserTCP352:
;SE9M.c,1855 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,1856 :: 		strcpy(oldSifra, "OLD     ");
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr229_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr229_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1857 :: 		strcpy(newSifra, "NEW     ");
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr230_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr230_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1859 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1860 :: 		len += putConstString(HTMLnetwork) ;
	MOVF        _HTMLnetwork+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLnetwork+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLnetwork+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1861 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1862 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,1864 :: 		case '2':
L_SPI_Ethernet_UserTCP353:
;SE9M.c,1865 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,1866 :: 		strcpy(oldSifra, "OLD     ");
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr231_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr231_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1867 :: 		strcpy(newSifra, "NEW     ");
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr232_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr232_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1869 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1870 :: 		len += putConstString(HTMLsntp) ;
	MOVF        _HTMLsntp+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLsntp+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLsntp+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1871 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1872 :: 		break ;
	GOTO        L_SPI_Ethernet_UserTCP314
;SE9M.c,1874 :: 		case '1':
L_SPI_Ethernet_UserTCP354:
;SE9M.c,1875 :: 		default:
L_SPI_Ethernet_UserTCP355:
;SE9M.c,1876 :: 		if (uzobyte == 1) {
	MOVF        _uzobyte+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP356
;SE9M.c,1877 :: 		uzobyte = 0;
	CLRF        _uzobyte+0 
;SE9M.c,1878 :: 		} else {
	GOTO        L_SPI_Ethernet_UserTCP357
L_SPI_Ethernet_UserTCP356:
;SE9M.c,1879 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,1880 :: 		strcpy(oldSifra, "OLD     ");
	MOVLW       _oldSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_oldSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr233_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr233_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1881 :: 		strcpy(newSifra, "NEW     ");
	MOVLW       _newSifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_newSifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr234_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr234_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,1882 :: 		}
L_SPI_Ethernet_UserTCP357:
;SE9M.c,1884 :: 		len += putConstString(HTMLheader) ;
	MOVF        _HTMLheader+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLheader+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLheader+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1885 :: 		len += putConstString(HTMLtime) ;
	MOVF        _HTMLtime+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLtime+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLtime+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1886 :: 		len += putConstString(HTMLfooter) ;
	MOVF        _HTMLfooter+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        _HTMLfooter+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        _HTMLfooter+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_len_L0+1, 1 
;SE9M.c,1887 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP314
L_SPI_Ethernet_UserTCP313:
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       115
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP315
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       97
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP318
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       98
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP321
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       99
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP349
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       100
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP350
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       52
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP351
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       51
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP352
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP353
	MOVF        SPI_Ethernet_UserTCP_getRequest_L0+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP354
	GOTO        L_SPI_Ethernet_UserTCP355
L_SPI_Ethernet_UserTCP314:
L_SPI_Ethernet_UserTCP312:
;SE9M.c,1889 :: 		httpCounter++ ;                             // one more request done
	INFSNZ      _httpCounter+0, 1 
	INCF        _httpCounter+1, 1 
;SE9M.c,1892 :: 		ZAVRSI:
___SPI_Ethernet_UserTCP_ZAVRSI:
;SE9M.c,1894 :: 		return(len) ;                               // return to the library with the number of bytes to transmit
	MOVF        SPI_Ethernet_UserTCP_len_L0+0, 0 
	MOVWF       R0 
	MOVF        SPI_Ethernet_UserTCP_len_L0+1, 0 
	MOVWF       R1 
;SE9M.c,1895 :: 		}
L_end_SPI_Ethernet_UserTCP:
	RETURN      0
; end of _SPI_Ethernet_UserTCP

_Print_Seg:

;SE9M.c,1898 :: 		char Print_Seg(char segm, char tacka) {
;SE9M.c,1900 :: 		if (segm == 0) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg358
;SE9M.c,1901 :: 		napolje = 0b01111110 | tacka;
	MOVLW       126
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1902 :: 		}
L_Print_Seg358:
;SE9M.c,1903 :: 		if (segm == 1) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg359
;SE9M.c,1904 :: 		napolje = 0b00011000 | tacka;
	MOVLW       24
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1905 :: 		}
L_Print_Seg359:
;SE9M.c,1906 :: 		if (segm == 2) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg360
;SE9M.c,1907 :: 		napolje = 0b10110110 | tacka;
	MOVLW       182
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1908 :: 		}
L_Print_Seg360:
;SE9M.c,1909 :: 		if (segm == 3) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg361
;SE9M.c,1910 :: 		napolje = 0b10111100 | tacka;
	MOVLW       188
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1911 :: 		}
L_Print_Seg361:
;SE9M.c,1912 :: 		if (segm == 4) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg362
;SE9M.c,1913 :: 		napolje = 0b11011000 | tacka;
	MOVLW       216
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1914 :: 		}
L_Print_Seg362:
;SE9M.c,1915 :: 		if (segm == 5) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg363
;SE9M.c,1916 :: 		napolje = 0b11101100 | tacka;
	MOVLW       236
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1917 :: 		}
L_Print_Seg363:
;SE9M.c,1918 :: 		if (segm == 6) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg364
;SE9M.c,1919 :: 		napolje = 0b11101110 | tacka;
	MOVLW       238
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1920 :: 		}
L_Print_Seg364:
;SE9M.c,1921 :: 		if (segm == 7) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg365
;SE9M.c,1922 :: 		napolje = 0b00111000 | tacka;
	MOVLW       56
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1923 :: 		}
L_Print_Seg365:
;SE9M.c,1924 :: 		if (segm == 8) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg366
;SE9M.c,1925 :: 		napolje = 0b11111110 | tacka;
	MOVLW       254
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1926 :: 		}
L_Print_Seg366:
;SE9M.c,1927 :: 		if (segm == 9) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg367
;SE9M.c,1928 :: 		napolje = 0b11111100 | tacka;
	MOVLW       252
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1929 :: 		}
L_Print_Seg367:
;SE9M.c,1931 :: 		if (segm == 10) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg368
;SE9M.c,1932 :: 		napolje = 0b11110010 | tacka;
	MOVLW       242
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1933 :: 		}
L_Print_Seg368:
;SE9M.c,1934 :: 		if (segm == 11) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg369
;SE9M.c,1935 :: 		napolje = 0b01110010 | tacka;
	MOVLW       114
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1936 :: 		}
L_Print_Seg369:
;SE9M.c,1937 :: 		if (segm == 12) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg370
;SE9M.c,1938 :: 		napolje = 0b01111000 | tacka;
	MOVLW       120
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1939 :: 		}
L_Print_Seg370:
;SE9M.c,1940 :: 		if (segm == 13) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg371
;SE9M.c,1941 :: 		napolje = 0b11100110 | tacka;
	MOVLW       230
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1942 :: 		}
L_Print_Seg371:
;SE9M.c,1943 :: 		if (segm == 14) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg372
;SE9M.c,1944 :: 		napolje = 0b00000100 | tacka;
	MOVLW       4
	IORWF       FARG_Print_Seg_tacka+0, 0 
	MOVWF       R1 
;SE9M.c,1945 :: 		}
L_Print_Seg372:
;SE9M.c,1946 :: 		if (segm == 15) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg373
;SE9M.c,1947 :: 		napolje = 0b00000000;
	CLRF        R1 
;SE9M.c,1948 :: 		}
L_Print_Seg373:
;SE9M.c,1949 :: 		if (segm == 16) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg374
;SE9M.c,1950 :: 		napolje = 0b00000001;
	MOVLW       1
	MOVWF       R1 
;SE9M.c,1951 :: 		}
L_Print_Seg374:
;SE9M.c,1952 :: 		if (segm == 17) {
	MOVF        FARG_Print_Seg_segm+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Print_Seg375
;SE9M.c,1953 :: 		napolje = 0b10000000;
	MOVLW       128
	MOVWF       R1 
;SE9M.c,1954 :: 		}
L_Print_Seg375:
;SE9M.c,1956 :: 		return napolje;
	MOVF        R1, 0 
	MOVWF       R0 
;SE9M.c,1957 :: 		}
L_end_Print_Seg:
	RETURN      0
; end of _Print_Seg

_PRINT_S:

;SE9M.c,1959 :: 		void PRINT_S(char ledovi) {
;SE9M.c,1961 :: 		pom = 0;
	CLRF        R3 
;SE9M.c,1962 :: 		for ( ir = 0; ir < 8; ir++ ) {
	CLRF        R4 
L_PRINT_S376:
	MOVLW       8
	SUBWF       R4, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_PRINT_S377
;SE9M.c,1963 :: 		pom1 = (ledovi << pom) & 0b10000000;
	MOVF        R3, 0 
	MOVWF       R1 
	MOVF        FARG_PRINT_S_ledovi+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__PRINT_S607:
	BZ          L__PRINT_S608
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__PRINT_S607
L__PRINT_S608:
	MOVLW       128
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       R2 
;SE9M.c,1964 :: 		if (pom1 == 0b10000000) {
	MOVF        R1, 0 
	XORLW       128
	BTFSS       STATUS+0, 2 
	GOTO        L_PRINT_S379
;SE9M.c,1965 :: 		SV_DATA = 1;
	BSF         RA1_bit+0, BitPos(RA1_bit+0) 
;SE9M.c,1966 :: 		}
L_PRINT_S379:
;SE9M.c,1967 :: 		if (pom1 == 0b00000000) {
	MOVF        R2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_PRINT_S380
;SE9M.c,1968 :: 		SV_DATA = 0;
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;SE9M.c,1969 :: 		}
L_PRINT_S380:
;SE9M.c,1970 :: 		asm nop;
	NOP
;SE9M.c,1971 :: 		asm nop;
	NOP
;SE9M.c,1972 :: 		asm nop;
	NOP
;SE9M.c,1973 :: 		SV_CLK = 0;
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
;SE9M.c,1974 :: 		asm nop;
	NOP
;SE9M.c,1975 :: 		asm nop;
	NOP
;SE9M.c,1976 :: 		asm nop;
	NOP
;SE9M.c,1977 :: 		SV_CLK = 1;
	BSF         RA2_bit+0, BitPos(RA2_bit+0) 
;SE9M.c,1978 :: 		pom++;
	INCF        R3, 1 
;SE9M.c,1962 :: 		for ( ir = 0; ir < 8; ir++ ) {
	INCF        R4, 1 
;SE9M.c,1979 :: 		}
	GOTO        L_PRINT_S376
L_PRINT_S377:
;SE9M.c,1980 :: 		}
L_end_PRINT_S:
	RETURN      0
; end of _PRINT_S

_Display_Time:

;SE9M.c,1982 :: 		void Display_Time() {
;SE9M.c,1984 :: 		sec1 = sekundi / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _sekundi+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _sec1+0 
;SE9M.c,1985 :: 		sec2 = sekundi - sec1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _sekundi+0, 0 
	MOVWF       _sec2+0 
;SE9M.c,1986 :: 		min1 = minuti / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _minuti+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _min1+0 
;SE9M.c,1987 :: 		min2 = minuti - min1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _minuti+0, 0 
	MOVWF       _min2+0 
;SE9M.c,1988 :: 		hr1 = sati / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _sati+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _hr1+0 
;SE9M.c,1989 :: 		hr2 = sati - hr1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _sati+0, 0 
	MOVWF       _hr2+0 
;SE9M.c,1990 :: 		day1 = dan / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _dan+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _day1+0 
;SE9M.c,1991 :: 		day2 = dan - day1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _dan+0, 0 
	MOVWF       _day2+0 
;SE9M.c,1992 :: 		mn1 = mesec / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _mesec+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _mn1+0 
;SE9M.c,1993 :: 		mn2 = mesec - mn1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _mesec+0, 0 
	MOVWF       _mn2+0 
;SE9M.c,1994 :: 		year1 = fingodina / 10;
	MOVLW       10
	MOVWF       R4 
	MOVF        _fingodina+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       _year1+0 
;SE9M.c,1995 :: 		year2 = fingodina - year1 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _fingodina+0, 0 
	MOVWF       _year2+0 
;SE9M.c,1997 :: 		if (disp_mode == 1) {
	MOVF        _disp_mode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Display_Time381
;SE9M.c,1998 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,1999 :: 		asm nop;
	NOP
;SE9M.c,2000 :: 		asm nop;
	NOP
;SE9M.c,2001 :: 		asm nop;
	NOP
;SE9M.c,2002 :: 		PRINT_S(Print_Seg(sec2, 0));
	MOVF        _sec2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2003 :: 		PRINT_S(Print_Seg(sec1, 0));
	MOVF        _sec1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2004 :: 		PRINT_S(Print_Seg(min2, 0));
	MOVF        _min2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2005 :: 		PRINT_S(Print_Seg(min1, 0));
	MOVF        _min1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2006 :: 		PRINT_S(Print_Seg(hr2, tacka1));
	MOVF        _hr2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka1+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2007 :: 		PRINT_S(Print_Seg(hr1, tacka2));
	MOVF        _hr1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka2+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2008 :: 		asm nop;
	NOP
;SE9M.c,2009 :: 		asm nop;
	NOP
;SE9M.c,2010 :: 		asm nop;
	NOP
;SE9M.c,2011 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2012 :: 		}
L_Display_Time381:
;SE9M.c,2013 :: 		if (disp_mode == 2) {
	MOVF        _disp_mode+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Display_Time382
;SE9M.c,2014 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2015 :: 		asm nop;
	NOP
;SE9M.c,2016 :: 		asm nop;
	NOP
;SE9M.c,2017 :: 		asm nop;
	NOP
;SE9M.c,2018 :: 		PRINT_S(Print_Seg(year2, 0));
	MOVF        _year2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2019 :: 		PRINT_S(Print_Seg(year1, 0));
	MOVF        _year1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2020 :: 		PRINT_S(Print_Seg(mn2, 0));
	MOVF        _mn2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2021 :: 		PRINT_S(Print_Seg(mn1, 0));
	MOVF        _mn1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2022 :: 		PRINT_S(Print_Seg(day2, tacka1));
	MOVF        _day2+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka1+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2023 :: 		PRINT_S(Print_Seg(day1, tacka2));
	MOVF        _day1+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        _tacka2+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2024 :: 		asm nop;
	NOP
;SE9M.c,2025 :: 		asm nop;
	NOP
;SE9M.c,2026 :: 		asm nop;
	NOP
;SE9M.c,2027 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2028 :: 		}
L_Display_Time382:
;SE9M.c,2030 :: 		}
L_end_Display_Time:
	RETURN      0
; end of _Display_Time

_Print_IP:

;SE9M.c,2033 :: 		void Print_IP() {
;SE9M.c,2037 :: 		cif1 =  ipAddr[3] / 100;
	MOVLW       100
	MOVWF       R4 
	MOVF        _ipAddr+3, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       Print_IP_cif1_L0+0 
;SE9M.c,2038 :: 		cif2 = (ipAddr[3] - cif1 * 100) / 10;
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
;SE9M.c,2039 :: 		cif3 =  ipAddr[3] - cif1 * 100 - cif2 * 10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       FLOC__Print_IP+0, 0 
	MOVWF       Print_IP_cif3_L0+0 
;SE9M.c,2040 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2041 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2042 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2043 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2044 :: 		PRINT_S(Print_Seg(cif3, 0));
	MOVF        Print_IP_cif3_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2045 :: 		PRINT_S(Print_Seg(cif2, 0));
	MOVF        Print_IP_cif2_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2046 :: 		PRINT_S(Print_Seg(cif1, 0));
	MOVF        Print_IP_cif1_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2047 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2048 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2049 :: 		delay_ms(2000);
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_Print_IP383:
	DECFSZ      R13, 1, 1
	BRA         L_Print_IP383
	DECFSZ      R12, 1, 1
	BRA         L_Print_IP383
	DECFSZ      R11, 1, 1
	BRA         L_Print_IP383
	NOP
;SE9M.c,2050 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2051 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2052 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2053 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2054 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2055 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2056 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2057 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2058 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2059 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2060 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_IP384:
	DECFSZ      R13, 1, 1
	BRA         L_Print_IP384
	DECFSZ      R12, 1, 1
	BRA         L_Print_IP384
	DECFSZ      R11, 1, 1
	BRA         L_Print_IP384
	NOP
;SE9M.c,2061 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2062 :: 		}
L_end_Print_IP:
	RETURN      0
; end of _Print_IP

_SPI_Ethernet_UserUDP:

;SE9M.c,2067 :: 		unsigned int  SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags)
;SE9M.c,2072 :: 		if (destPort == 10001) {
	MOVF        FARG_SPI_Ethernet_UserUDP_destPort+1, 0 
	XORLW       39
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP612
	MOVLW       17
	XORWF       FARG_SPI_Ethernet_UserUDP_destPort+0, 0 
L__SPI_Ethernet_UserUDP612:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP385
;SE9M.c,2073 :: 		if (reqLength == 9) {
	MOVLW       0
	XORWF       FARG_SPI_Ethernet_UserUDP_reqLength+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP613
	MOVLW       9
	XORWF       FARG_SPI_Ethernet_UserUDP_reqLength+0, 0 
L__SPI_Ethernet_UserUDP613:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP386
;SE9M.c,2074 :: 		for (i = 0 ; i < 9 ; i++) {
	CLRF        SPI_Ethernet_UserUDP_i_L0+0 
L_SPI_Ethernet_UserUDP387:
	MOVLW       9
	SUBWF       SPI_Ethernet_UserUDP_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserUDP388
;SE9M.c,2075 :: 		broadcmd[i] = SPI_Ethernet_getByte() ;
	MOVLW       SPI_Ethernet_UserUDP_broadcmd_L0+0
	MOVWF       FLOC__SPI_Ethernet_UserUDP+0 
	MOVLW       hi_addr(SPI_Ethernet_UserUDP_broadcmd_L0+0)
	MOVWF       FLOC__SPI_Ethernet_UserUDP+1 
	MOVF        SPI_Ethernet_UserUDP_i_L0+0, 0 
	ADDWF       FLOC__SPI_Ethernet_UserUDP+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__SPI_Ethernet_UserUDP+1, 1 
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVFF       FLOC__SPI_Ethernet_UserUDP+0, FSR1
	MOVFF       FLOC__SPI_Ethernet_UserUDP+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SE9M.c,2074 :: 		for (i = 0 ; i < 9 ; i++) {
	INCF        SPI_Ethernet_UserUDP_i_L0+0, 1 
;SE9M.c,2076 :: 		}
	GOTO        L_SPI_Ethernet_UserUDP387
L_SPI_Ethernet_UserUDP388:
;SE9M.c,2077 :: 		if ( (broadcmd[0] == 'I') && (broadcmd[1] == 'D') && (broadcmd[2] == 'E') && (broadcmd[3] == 'N') && (broadcmd[4] == 'T') && (broadcmd[5] == 'I') && (broadcmd[6] == 'F') && (broadcmd[7] == 'Y') && (broadcmd[8] == '!') ) {
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+0, 0 
	XORLW       73
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+1, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+2, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+3, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+4, 0 
	XORLW       84
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+5, 0 
	XORLW       73
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+6, 0 
	XORLW       70
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+7, 0 
	XORLW       89
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
	MOVF        SPI_Ethernet_UserUDP_broadcmd_L0+8, 0 
	XORLW       33
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP392
L__SPI_Ethernet_UserUDP564:
;SE9M.c,2078 :: 		Print_IP();
	CALL        _Print_IP+0, 0
;SE9M.c,2079 :: 		}
L_SPI_Ethernet_UserUDP392:
;SE9M.c,2080 :: 		}
L_SPI_Ethernet_UserUDP386:
;SE9M.c,2081 :: 		}
L_SPI_Ethernet_UserUDP385:
;SE9M.c,2083 :: 		if(destPort == 123)             // check SNTP port number
	MOVLW       0
	XORWF       FARG_SPI_Ethernet_UserUDP_destPort+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP614
	MOVLW       123
	XORWF       FARG_SPI_Ethernet_UserUDP_destPort+0, 0 
L__SPI_Ethernet_UserUDP614:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP393
;SE9M.c,2085 :: 		if (reqLength == 48) {
	MOVLW       0
	XORWF       FARG_SPI_Ethernet_UserUDP_reqLength+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserUDP615
	MOVLW       48
	XORWF       FARG_SPI_Ethernet_UserUDP_reqLength+0, 0 
L__SPI_Ethernet_UserUDP615:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP394
;SE9M.c,2089 :: 		serverFlags = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _serverFlags+0 
;SE9M.c,2090 :: 		serverStratum = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _serverStratum+0 
;SE9M.c,2091 :: 		SPI_Ethernet_getByte() ;        // skip poll
	CALL        _SPI_Ethernet_getByte+0, 0
;SE9M.c,2092 :: 		serverPrecision = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       _serverPrecision+0 
;SE9M.c,2094 :: 		for(i = 0 ; i < 36 ; i++)
	CLRF        SPI_Ethernet_UserUDP_i_L0+0 
L_SPI_Ethernet_UserUDP395:
	MOVLW       36
	SUBWF       SPI_Ethernet_UserUDP_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserUDP396
;SE9M.c,2096 :: 		SPI_Ethernet_getByte() ; // skip all unused fileds
	CALL        _SPI_Ethernet_getByte+0, 0
;SE9M.c,2094 :: 		for(i = 0 ; i < 36 ; i++)
	INCF        SPI_Ethernet_UserUDP_i_L0+0, 1 
;SE9M.c,2097 :: 		}
	GOTO        L_SPI_Ethernet_UserUDP395
L_SPI_Ethernet_UserUDP396:
;SE9M.c,2100 :: 		Highest(tts) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserUDP_tts_L2+3 
;SE9M.c,2101 :: 		Higher(tts) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserUDP_tts_L2+2 
;SE9M.c,2102 :: 		Hi(tts) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserUDP_tts_L2+1 
;SE9M.c,2103 :: 		Lo(tts) = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserUDP_tts_L2+0 
;SE9M.c,2106 :: 		epoch = tts - 2208988800 ;
	MOVF        SPI_Ethernet_UserUDP_tts_L2+0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+0 
	MOVF        SPI_Ethernet_UserUDP_tts_L2+1, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+1 
	MOVF        SPI_Ethernet_UserUDP_tts_L2+2, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+2 
	MOVF        SPI_Ethernet_UserUDP_tts_L2+3, 0 
	MOVWF       FLOC__SPI_Ethernet_UserUDP+3 
	MOVLW       128
	SUBWF       FLOC__SPI_Ethernet_UserUDP+0, 1 
	MOVLW       126
	SUBWFB      FLOC__SPI_Ethernet_UserUDP+1, 1 
	MOVLW       170
	SUBWFB      FLOC__SPI_Ethernet_UserUDP+2, 1 
	MOVLW       131
	SUBWFB      FLOC__SPI_Ethernet_UserUDP+3, 1 
	MOVF        FLOC__SPI_Ethernet_UserUDP+0, 0 
	MOVWF       _epoch+0 
	MOVF        FLOC__SPI_Ethernet_UserUDP+1, 0 
	MOVWF       _epoch+1 
	MOVF        FLOC__SPI_Ethernet_UserUDP+2, 0 
	MOVWF       _epoch+2 
	MOVF        FLOC__SPI_Ethernet_UserUDP+3, 0 
	MOVWF       _epoch+3 
;SE9M.c,2109 :: 		lastSync = epoch ;
	MOVF        FLOC__SPI_Ethernet_UserUDP+0, 0 
	MOVWF       _lastSync+0 
	MOVF        FLOC__SPI_Ethernet_UserUDP+1, 0 
	MOVWF       _lastSync+1 
	MOVF        FLOC__SPI_Ethernet_UserUDP+2, 0 
	MOVWF       _lastSync+2 
	MOVF        FLOC__SPI_Ethernet_UserUDP+3, 0 
	MOVWF       _lastSync+3 
;SE9M.c,2112 :: 		marquee = bufInfo ;
	MOVLW       _bufInfo+0
	MOVWF       _marquee+0 
	MOVLW       hi_addr(_bufInfo+0)
	MOVWF       _marquee+1 
;SE9M.c,2114 :: 		notime = 0;
	CLRF        _notime+0 
;SE9M.c,2115 :: 		notime_ovf = 0;
	CLRF        _notime_ovf+0 
;SE9M.c,2117 :: 		Time_epochToDate(epoch + tmzn * 3600l, &ts) ;
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
	ADDWF       FLOC__SPI_Ethernet_UserUDP+0, 0 
	MOVWF       FARG_Time_epochToDate_e+0 
	MOVF        R1, 0 
	ADDWFC      FLOC__SPI_Ethernet_UserUDP+1, 0 
	MOVWF       FARG_Time_epochToDate_e+1 
	MOVF        R2, 0 
	ADDWFC      FLOC__SPI_Ethernet_UserUDP+2, 0 
	MOVWF       FARG_Time_epochToDate_e+2 
	MOVF        R3, 0 
	ADDWFC      FLOC__SPI_Ethernet_UserUDP+3, 0 
	MOVWF       FARG_Time_epochToDate_e+3 
	MOVLW       _ts+0
	MOVWF       FARG_Time_epochToDate_ts+0 
	MOVLW       hi_addr(_ts+0)
	MOVWF       FARG_Time_epochToDate_ts+1 
	CALL        _Time_epochToDate+0, 0
;SE9M.c,2118 :: 		presTmr = 0;
	CLRF        _presTmr+0 
	CLRF        _presTmr+1 
;SE9M.c,2119 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,2120 :: 		if (lcdEvent) {
	MOVF        _lcdEvent+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserUDP398
;SE9M.c,2121 :: 		mkLCDLine(1, conf.dhcpen) ; // update lcd: first row
	MOVLW       1
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+0, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2122 :: 		mkLCDLine(2, conf.lcdL2) ; // update lcd: second row
	MOVLW       2
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+1, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2123 :: 		lcdEvent = 0 ;             // clear lcd update flag
	CLRF        _lcdEvent+0 
;SE9M.c,2124 :: 		marquee++ ;                // set marquee pointer
	INFSNZ      _marquee+0, 1 
	INCF        _marquee+1, 1 
;SE9M.c,2125 :: 		}
L_SPI_Ethernet_UserUDP398:
;SE9M.c,2127 :: 		presTmr = 0;
	CLRF        _presTmr+0 
	CLRF        _presTmr+1 
;SE9M.c,2128 :: 		lcdTmr = 0;
	CLRF        _lcdTmr+0 
	CLRF        _lcdTmr+1 
;SE9M.c,2129 :: 		Display_Time();
	CALL        _Display_Time+0, 0
;SE9M.c,2130 :: 		} else {
	GOTO        L_SPI_Ethernet_UserUDP399
L_SPI_Ethernet_UserUDP394:
;SE9M.c,2131 :: 		return(0) ;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserUDP
;SE9M.c,2132 :: 		}
L_SPI_Ethernet_UserUDP399:
;SE9M.c,2133 :: 		} else {
	GOTO        L_SPI_Ethernet_UserUDP400
L_SPI_Ethernet_UserUDP393:
;SE9M.c,2134 :: 		return(0) ;
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserUDP
;SE9M.c,2135 :: 		}
L_SPI_Ethernet_UserUDP400:
;SE9M.c,2136 :: 		}
L_end_SPI_Ethernet_UserUDP:
	RETURN      0
; end of _SPI_Ethernet_UserUDP

_interrupt:

;SE9M.c,2138 :: 		void interrupt() {
;SE9M.c,2140 :: 		if (PIR1.RCIF == 1) {
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt401
;SE9M.c,2141 :: 		prkomanda = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _prkomanda+0 
;SE9M.c,2142 :: 		if ( ( (ipt == 0) && (prkomanda == 0xAA) ) || (ipt != 0) ) {
	MOVF        _ipt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt568
	MOVF        _prkomanda+0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt568
	GOTO        L__interrupt567
L__interrupt568:
	MOVF        _ipt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt567
	GOTO        L_interrupt406
L__interrupt567:
;SE9M.c,2143 :: 		comand[ipt] = prkomanda;
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
;SE9M.c,2144 :: 		ipt++;
	INCF        _ipt+0, 1 
;SE9M.c,2145 :: 		}
L_interrupt406:
;SE9M.c,2146 :: 		if (prkomanda == 0xBB) {
	MOVF        _prkomanda+0, 0 
	XORLW       187
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt407
;SE9M.c,2147 :: 		komgotovo = 1;
	MOVLW       1
	MOVWF       _komgotovo+0 
;SE9M.c,2148 :: 		ipt = 0;
	CLRF        _ipt+0 
;SE9M.c,2149 :: 		}
L_interrupt407:
;SE9M.c,2150 :: 		if (ipt > 18) {
	MOVF        _ipt+0, 0 
	SUBLW       18
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt408
;SE9M.c,2151 :: 		ipt = 0;
	CLRF        _ipt+0 
;SE9M.c,2152 :: 		}
L_interrupt408:
;SE9M.c,2153 :: 		}
L_interrupt401:
;SE9M.c,2155 :: 		if (INTCON.TMR0IF) {
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt409
;SE9M.c,2156 :: 		presTmr++ ;
	INFSNZ      _presTmr+0, 1 
	INCF        _presTmr+1, 1 
;SE9M.c,2157 :: 		lcdTmr++ ;
	INFSNZ      _lcdTmr+0, 1 
	INCF        _lcdTmr+1, 1 
;SE9M.c,2158 :: 		if (presTmr == 15625) {
	MOVF        _presTmr+1, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt618
	MOVLW       9
	XORWF       _presTmr+0, 0 
L__interrupt618:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt410
;SE9M.c,2161 :: 		if (tmr_rst_en == 1) {
	MOVF        _tmr_rst_en+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt411
;SE9M.c,2162 :: 		tmr_rst++;
	INCF        _tmr_rst+0, 1 
;SE9M.c,2163 :: 		if (tmr_rst == 178) {
	MOVF        _tmr_rst+0, 0 
	XORLW       178
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt412
;SE9M.c,2164 :: 		tmr_rst = 0;
	CLRF        _tmr_rst+0 
;SE9M.c,2165 :: 		tmr_rst_en = 0;
	CLRF        _tmr_rst_en+0 
;SE9M.c,2166 :: 		admin = 0;
	CLRF        _admin+0 
;SE9M.c,2167 :: 		}
L_interrupt412:
;SE9M.c,2168 :: 		} else {
	GOTO        L_interrupt413
L_interrupt411:
;SE9M.c,2169 :: 		tmr_rst = 0;
	CLRF        _tmr_rst+0 
;SE9M.c,2170 :: 		}
L_interrupt413:
;SE9M.c,2174 :: 		notime++;
	INCF        _notime+0, 1 
;SE9M.c,2175 :: 		if (notime == 32) {
	MOVF        _notime+0, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt414
;SE9M.c,2176 :: 		notime = 0;
	CLRF        _notime+0 
;SE9M.c,2177 :: 		notime_ovf = 1;
	MOVLW       1
	MOVWF       _notime_ovf+0 
;SE9M.c,2178 :: 		}
L_interrupt414:
;SE9M.c,2182 :: 		if ( (lease_tmr == 1) && (lease_time < 250) ) {
	MOVF        _lease_tmr+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt417
	MOVLW       250
	SUBWF       _lease_time+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt417
L__interrupt566:
;SE9M.c,2183 :: 		lease_time++;
	INCF        _lease_time+0, 1 
;SE9M.c,2184 :: 		} else {
	GOTO        L_interrupt418
L_interrupt417:
;SE9M.c,2185 :: 		lease_time = 0;
	CLRF        _lease_time+0 
;SE9M.c,2186 :: 		}
L_interrupt418:
;SE9M.c,2190 :: 		SPI_Ethernet_UserTimerSec++ ;
	MOVLW       1
	ADDWF       _SPI_Ethernet_UserTimerSec+0, 1 
	MOVLW       0
	ADDWFC      _SPI_Ethernet_UserTimerSec+1, 1 
	ADDWFC      _SPI_Ethernet_UserTimerSec+2, 1 
	ADDWFC      _SPI_Ethernet_UserTimerSec+3, 1 
;SE9M.c,2191 :: 		epoch++ ;
	MOVLW       1
	ADDWF       _epoch+0, 1 
	MOVLW       0
	ADDWFC      _epoch+1, 1 
	ADDWFC      _epoch+2, 1 
	ADDWFC      _epoch+3, 1 
;SE9M.c,2192 :: 		presTmr = 0 ;
	CLRF        _presTmr+0 
	CLRF        _presTmr+1 
;SE9M.c,2196 :: 		if (timer_flag < 2555) {
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORLW       9
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt619
	MOVLW       251
	SUBWF       _timer_flag+0, 0 
L__interrupt619:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt419
;SE9M.c,2197 :: 		timer_flag++;
	INCF        _timer_flag+0, 1 
;SE9M.c,2198 :: 		} else {
	GOTO        L_interrupt420
L_interrupt419:
;SE9M.c,2199 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2200 :: 		}
L_interrupt420:
;SE9M.c,2205 :: 		req_tmr_1++;
	INCF        _req_tmr_1+0, 1 
;SE9M.c,2206 :: 		if (req_tmr_1 == 60) {
	MOVF        _req_tmr_1+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt421
;SE9M.c,2207 :: 		req_tmr_1 = 0;
	CLRF        _req_tmr_1+0 
;SE9M.c,2208 :: 		req_tmr_2++;
	INCF        _req_tmr_2+0, 1 
;SE9M.c,2209 :: 		}
L_interrupt421:
;SE9M.c,2210 :: 		if (req_tmr_2 == 60) {
	MOVF        _req_tmr_2+0, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt422
;SE9M.c,2211 :: 		req_tmr_2 = 0;
	CLRF        _req_tmr_2+0 
;SE9M.c,2212 :: 		req_tmr_3++;
	INCF        _req_tmr_3+0, 1 
;SE9M.c,2213 :: 		}
L_interrupt422:
;SE9M.c,2217 :: 		if (rst_flag == 1) {
	MOVF        _rst_flag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt423
;SE9M.c,2218 :: 		rst_flag_1++;
	INCF        _rst_flag_1+0, 1 
;SE9M.c,2219 :: 		}
L_interrupt423:
;SE9M.c,2223 :: 		if ( (rst_fab_tmr == 1) && (rst_fab_flag < 200) ) {
	MOVF        _rst_fab_tmr+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt426
	MOVLW       200
	SUBWF       _rst_fab_flag+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt426
L__interrupt565:
;SE9M.c,2224 :: 		rst_fab_flag++;
	INCF        _rst_fab_flag+0, 1 
;SE9M.c,2225 :: 		}
L_interrupt426:
;SE9M.c,2228 :: 		}
L_interrupt410:
;SE9M.c,2230 :: 		if (lcdTmr == 3125) {
	MOVF        _lcdTmr+1, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt620
	MOVLW       53
	XORWF       _lcdTmr+0, 0 
L__interrupt620:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt427
;SE9M.c,2231 :: 		lcdEvent = 1;
	MOVLW       1
	MOVWF       _lcdEvent+0 
;SE9M.c,2232 :: 		lcdTmr = 0;
	CLRF        _lcdTmr+0 
	CLRF        _lcdTmr+1 
;SE9M.c,2233 :: 		}
L_interrupt427:
;SE9M.c,2234 :: 		INTCON.TMR0IF = 0 ;              // clear timer0 overflow flag
	BCF         INTCON+0, 2 
;SE9M.c,2235 :: 		}
L_interrupt409:
;SE9M.c,2236 :: 		}
L_end_interrupt:
L__interrupt617:
	RETFIE      1
; end of _interrupt

_Print_Blank:

;SE9M.c,2239 :: 		void Print_Blank() {
;SE9M.c,2240 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2241 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2242 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2243 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2244 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2245 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2246 :: 		PRINT_S(Print_Seg(8, 0));
	MOVLW       8
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2247 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2248 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2249 :: 		delay_ms(1000);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_Print_Blank428:
	DECFSZ      R13, 1, 1
	BRA         L_Print_Blank428
	DECFSZ      R12, 1, 1
	BRA         L_Print_Blank428
	DECFSZ      R11, 1, 1
	BRA         L_Print_Blank428
;SE9M.c,2250 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2251 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2252 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2253 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2254 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2255 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2256 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2257 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2258 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2259 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2260 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_Blank429:
	DECFSZ      R13, 1, 1
	BRA         L_Print_Blank429
	DECFSZ      R12, 1, 1
	BRA         L_Print_Blank429
	DECFSZ      R11, 1, 1
	BRA         L_Print_Blank429
	NOP
;SE9M.c,2261 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2262 :: 		}
L_end_Print_Blank:
	RETURN      0
; end of _Print_Blank

_Print_All:

;SE9M.c,2264 :: 		void Print_All() {
;SE9M.c,2268 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2269 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2270 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2271 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2272 :: 		PRINT_S(Print_Seg(15, 0));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2273 :: 		PRINT_S(Print_Seg(15, 1));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	MOVLW       1
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2274 :: 		PRINT_S(Print_Seg(15, 1));
	MOVLW       15
	MOVWF       FARG_Print_Seg_segm+0 
	MOVLW       1
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2275 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2276 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2277 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_All430:
	DECFSZ      R13, 1, 1
	BRA         L_Print_All430
	DECFSZ      R12, 1, 1
	BRA         L_Print_All430
	DECFSZ      R11, 1, 1
	BRA         L_Print_All430
	NOP
;SE9M.c,2278 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2279 :: 		for (pebr = 0; pebr <= 9; pebr++) {
	CLRF        Print_All_pebr_L0+0 
L_Print_All431:
	MOVF        Print_All_pebr_L0+0, 0 
	SUBLW       9
	BTFSS       STATUS+0, 0 
	GOTO        L_Print_All432
;SE9M.c,2280 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2281 :: 		if ( (pebr == 1) || (pebr == 3) || (pebr == 5) || (pebr == 7) || (pebr == 9) ) {
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All569
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All569
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All569
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All569
	MOVF        Print_All_pebr_L0+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L__Print_All569
	GOTO        L_Print_All436
L__Print_All569:
;SE9M.c,2282 :: 		tck1 = 1;
	MOVLW       1
	MOVWF       Print_All_tck1_L0+0 
;SE9M.c,2283 :: 		tck2 = 0;
	CLRF        Print_All_tck2_L0+0 
;SE9M.c,2284 :: 		} else {
	GOTO        L_Print_All437
L_Print_All436:
;SE9M.c,2285 :: 		tck1 = 0;
	CLRF        Print_All_tck1_L0+0 
;SE9M.c,2286 :: 		tck2 = 1;
	MOVLW       1
	MOVWF       Print_All_tck2_L0+0 
;SE9M.c,2287 :: 		}
L_Print_All437:
;SE9M.c,2288 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2289 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2290 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2291 :: 		PRINT_S(Print_Seg(pebr, 0));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2292 :: 		PRINT_S(Print_Seg(pebr, tck1));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        Print_All_tck1_L0+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2293 :: 		PRINT_S(Print_Seg(pebr, tck2));
	MOVF        Print_All_pebr_L0+0, 0 
	MOVWF       FARG_Print_Seg_segm+0 
	MOVF        Print_All_tck2_L0+0, 0 
	MOVWF       FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2294 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2295 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2296 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Print_All438:
	DECFSZ      R13, 1, 1
	BRA         L_Print_All438
	DECFSZ      R12, 1, 1
	BRA         L_Print_All438
	DECFSZ      R11, 1, 1
	BRA         L_Print_All438
	NOP
;SE9M.c,2297 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2279 :: 		for (pebr = 0; pebr <= 9; pebr++) {
	INCF        Print_All_pebr_L0+0, 1 
;SE9M.c,2298 :: 		}
	GOTO        L_Print_All431
L_Print_All432:
;SE9M.c,2299 :: 		}
L_end_Print_All:
	RETURN      0
; end of _Print_All

_Print_Pme:

;SE9M.c,2302 :: 		void Print_Pme() {
;SE9M.c,2303 :: 		STROBE = 0;
	BCF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2304 :: 		PRINT_S(Print_Seg(14, 0));
	MOVLW       14
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2305 :: 		PRINT_S(Print_Seg(14, 0));
	MOVLW       14
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2306 :: 		PRINT_S(Print_Seg(13, 0));
	MOVLW       13
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2307 :: 		PRINT_S(Print_Seg(12, 0));
	MOVLW       12
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2308 :: 		PRINT_S(Print_Seg(11, 0));
	MOVLW       11
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2309 :: 		PRINT_S(Print_Seg(10, 0));
	MOVLW       10
	MOVWF       FARG_Print_Seg_segm+0 
	CLRF        FARG_Print_Seg_tacka+0 
	CALL        _Print_Seg+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PRINT_S_ledovi+0 
	CALL        _PRINT_S+0, 0
;SE9M.c,2310 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2311 :: 		}
L_end_Print_Pme:
	RETURN      0
; end of _Print_Pme

_Print_Light:

;SE9M.c,2314 :: 		void Print_Light() {
;SE9M.c,2315 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;SE9M.c,2316 :: 		light_res = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _light_res+0 
	MOVF        R1, 0 
	MOVWF       _light_res+1 
;SE9M.c,2317 :: 		result = light_res * 0.00322265625;  // scale adc result by 100000 (3.22mV/lsb => 3.3V / 1024 = 0.00322265625...V)
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
;SE9M.c,2319 :: 		if (result <= 1.3) {                            // 1.1
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
	GOTO        L_Print_Light439
;SE9M.c,2320 :: 		PWM1_Set_Duty(max_light);
	MOVF        _max_light+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2321 :: 		}
L_Print_Light439:
;SE9M.c,2322 :: 		if ( (result > 1.3) && (result <= 2.3) ) {      // 1.1 - 2.2
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
	GOTO        L_Print_Light442
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
	GOTO        L_Print_Light442
L__Print_Light570:
;SE9M.c,2323 :: 		PWM1_Set_Duty((max_light*2)/3);
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
;SE9M.c,2324 :: 		}
L_Print_Light442:
;SE9M.c,2325 :: 		if (result > 2.3) {
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
	GOTO        L_Print_Light443
;SE9M.c,2326 :: 		PWM1_Set_Duty(max_light/3);                  // 2.2
	MOVLW       3
	MOVWF       R4 
	MOVF        _max_light+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2327 :: 		}
L_Print_Light443:
;SE9M.c,2329 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2330 :: 		}
L_end_Print_Light:
	RETURN      0
; end of _Print_Light

_Mem_Read:

;SE9M.c,2333 :: 		void Mem_Read() {
;SE9M.c,2335 :: 		MSSPEN  = 1;
	BSF         RE0_bit+0, BitPos(RE0_bit+0) 
;SE9M.c,2336 :: 		asm nop;
	NOP
;SE9M.c,2337 :: 		asm nop;
	NOP
;SE9M.c,2338 :: 		asm nop;
	NOP
;SE9M.c,2339 :: 		I2C1_Init(100000);
	MOVLW       80
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;SE9M.c,2340 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;SE9M.c,2341 :: 		I2C1_Wr(0xA2);
	MOVLW       162
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SE9M.c,2342 :: 		I2C1_Wr(0xFA);
	MOVLW       250
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SE9M.c,2343 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;SE9M.c,2344 :: 		I2C1_Wr(0xA3);
	MOVLW       163
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;SE9M.c,2345 :: 		for(membr=0 ; membr<=4 ; membr++) {
	CLRF        Mem_Read_membr_L0+0 
L_Mem_Read444:
	MOVF        Mem_Read_membr_L0+0, 0 
	SUBLW       4
	BTFSS       STATUS+0, 0 
	GOTO        L_Mem_Read445
;SE9M.c,2346 :: 		macAddr[membr] = I2C1_Rd(1);
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
;SE9M.c,2345 :: 		for(membr=0 ; membr<=4 ; membr++) {
	INCF        Mem_Read_membr_L0+0, 1 
;SE9M.c,2347 :: 		}
	GOTO        L_Mem_Read444
L_Mem_Read445:
;SE9M.c,2348 :: 		macAddr[5] = I2C1_Rd(0);
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _macAddr+5 
;SE9M.c,2349 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;SE9M.c,2350 :: 		MSSPEN  = 0;
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;SE9M.c,2351 :: 		asm nop;
	NOP
;SE9M.c,2352 :: 		asm nop;
	NOP
;SE9M.c,2353 :: 		asm nop;
	NOP
;SE9M.c,2355 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;SE9M.c,2356 :: 		}
L_end_Mem_Read:
	RETURN      0
; end of _Mem_Read

_main:

;SE9M.c,2361 :: 		void main() {
;SE9M.c,2363 :: 		TRISA = 0b00000001;
	MOVLW       1
	MOVWF       TRISA+0 
;SE9M.c,2364 :: 		PORTA = 0;
	CLRF        PORTA+0 
;SE9M.c,2365 :: 		TRISB = 0;
	CLRF        TRISB+0 
;SE9M.c,2366 :: 		PORTB = 0;
	CLRF        PORTB+0 
;SE9M.c,2367 :: 		TRISC = 0;
	CLRF        TRISC+0 
;SE9M.c,2368 :: 		PORTC = 0;
	CLRF        PORTC+0 
;SE9M.c,2370 :: 		Com_En_Direction = 0;
	BCF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;SE9M.c,2371 :: 		Com_En = 0;
	BCF         RB0_bit+0, BitPos(RB0_bit+0) 
;SE9M.c,2373 :: 		Kom_En_1_Direction = 0;
	BCF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;SE9M.c,2374 :: 		Kom_En_1 = 1;
	BSF         RB1_bit+0, BitPos(RB1_bit+0) 
;SE9M.c,2376 :: 		Kom_En_2_Direction = 0;
	BCF         TRISB3_bit+0, BitPos(TRISB3_bit+0) 
;SE9M.c,2377 :: 		Kom_En_2 = 0;
	BCF         RB3_bit+0, BitPos(RB3_bit+0) 
;SE9M.c,2379 :: 		Eth1_Link_Direction = 1;
	BSF         TRISB5_bit+0, BitPos(TRISB5_bit+0) 
;SE9M.c,2381 :: 		SPI_Ethernet_Rst_Direction = 0;
	BCF         TRISA5_bit+0, BitPos(TRISA5_bit+0) 
;SE9M.c,2382 :: 		SPI_Ethernet_Rst = 0;
	BCF         RA5_bit+0, BitPos(RA5_bit+0) 
;SE9M.c,2383 :: 		SPI_Ethernet_CS_Direction  = 0;
	BCF         TRISA4_bit+0, BitPos(TRISA4_bit+0) 
;SE9M.c,2384 :: 		SPI_Ethernet_CS  = 0;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
;SE9M.c,2386 :: 		RSTPIN_Direction = 1;
	BSF         TRISD4_bit+0, BitPos(TRISD4_bit+0) 
;SE9M.c,2388 :: 		DISPEN_Direction = 0;
	BCF         TRISE2_bit+0, BitPos(TRISE2_bit+0) 
;SE9M.c,2389 :: 		DISPEN = 0;
	BCF         RE2_bit+0, BitPos(RE2_bit+0) 
;SE9M.c,2391 :: 		MSSPEN_Direction = 0;
	BCF         TRISE0_bit+0, BitPos(TRISE0_bit+0) 
;SE9M.c,2392 :: 		MSSPEN = 0;
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;SE9M.c,2394 :: 		SV_DATA_Direction = 0;
	BCF         TRISA1_bit+0, BitPos(TRISA1_bit+0) 
;SE9M.c,2395 :: 		SV_DATA = 0;
	BCF         RA1_bit+0, BitPos(RA1_bit+0) 
;SE9M.c,2396 :: 		SV_CLK_Direction = 0;
	BCF         TRISA2_bit+0, BitPos(TRISA2_bit+0) 
;SE9M.c,2397 :: 		SV_CLK = 0;
	BCF         RA2_bit+0, BitPos(RA2_bit+0) 
;SE9M.c,2398 :: 		STROBE_Direction = 0;
	BCF         TRISA3_bit+0, BitPos(TRISA3_bit+0) 
;SE9M.c,2399 :: 		STROBE = 1;
	BSF         RA3_bit+0, BitPos(RA3_bit+0) 
;SE9M.c,2401 :: 		BCKL_Direction = 0;
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;SE9M.c,2402 :: 		BCKL = 0;
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;SE9M.c,2404 :: 		ANSEL = 0;
	CLRF        ANSEL+0 
;SE9M.c,2405 :: 		ANSELH = 0;
	CLRF        ANSELH+0 
;SE9M.c,2407 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;SE9M.c,2408 :: 		ADCON1 = 0b00001110;
	MOVLW       14
	MOVWF       ADCON1+0 
;SE9M.c,2410 :: 		max_light = 180;
	MOVLW       180
	MOVWF       _max_light+0 
;SE9M.c,2411 :: 		min_light = 30;
	MOVLW       30
	MOVWF       _min_light+0 
;SE9M.c,2413 :: 		PWM1_Init(2000);
	BSF         T2CON+0, 0, 0
	BSF         T2CON+0, 1, 0
	MOVLW       249
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;SE9M.c,2414 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;SE9M.c,2415 :: 		PWM1_Set_Duty(max_light);      // 90
	MOVF        _max_light+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2418 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       3
	MOVWF       SPBRGH+0 
	MOVLW       64
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;SE9M.c,2419 :: 		PIE1.RCIE = 1;
	BSF         PIE1+0, 5 
;SE9M.c,2420 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;SE9M.c,2421 :: 		PEIE_bit = 1;
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;SE9M.c,2423 :: 		T0CON = 0b11000000 ;
	MOVLW       192
	MOVWF       T0CON+0 
;SE9M.c,2424 :: 		INTCON.TMR0IF = 0 ;
	BCF         INTCON+0, 2 
;SE9M.c,2425 :: 		INTCON.TMR0IE = 1 ;
	BSF         INTCON+0, 5 
;SE9M.c,2428 :: 		while(1) {
L_main447:
;SE9M.c,2430 :: 		pom_time_pom = EEPROM_Read(0);
	CLRF        FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pom_time_pom+0 
;SE9M.c,2432 :: 		if ( (pom_time_pom != 0xAA) || (rst_fab == 1) ) {
	MOVF        R0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L__main577
	MOVF        _rst_fab+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__main577
	GOTO        L_main451
L__main577:
;SE9M.c,2434 :: 		conf.dhcpen = 1;
	MOVLW       1
	MOVWF       _conf+0 
;SE9M.c,2435 :: 		EEPROM_Write(103, conf.dhcpen);
	MOVLW       103
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2436 :: 		mode = 1;
	MOVLW       1
	MOVWF       _mode+0 
;SE9M.c,2437 :: 		EEPROM_Write(104, mode);
	MOVLW       104
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2438 :: 		dhcp_flag = 0;
	CLRF        _dhcp_flag+0 
;SE9M.c,2439 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2441 :: 		strcpy(sifra, "adminpme");
	MOVLW       _sifra+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_sifra+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr235_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr235_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2442 :: 		for (j=0;j<=8;j++) {
	CLRF        _j+0 
L_main452:
	MOVF        _j+0, 0 
	SUBLW       8
	BTFSS       STATUS+0, 0 
	GOTO        L_main453
;SE9M.c,2443 :: 		EEPROM_Write(j+20, sifra[j]);
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
;SE9M.c,2442 :: 		for (j=0;j<=8;j++) {
	INCF        _j+0, 1 
;SE9M.c,2444 :: 		}
	GOTO        L_main452
L_main453:
;SE9M.c,2446 :: 		strcpy(server1, "swisstime.ethz.ch");
	MOVLW       _server1+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_server1+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr236_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr236_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2447 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main455:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main456
;SE9M.c,2448 :: 		EEPROM_Write(j+29, server1[j]);
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
;SE9M.c,2447 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2449 :: 		}
	GOTO        L_main455
L_main456:
;SE9M.c,2450 :: 		strcpy(server2, "0.rs.pool.ntp.org");
	MOVLW       _server2+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_server2+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr237_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr237_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2451 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main458:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main459
;SE9M.c,2452 :: 		EEPROM_Write(j+56, server2[j]);
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
;SE9M.c,2451 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2453 :: 		}
	GOTO        L_main458
L_main459:
;SE9M.c,2454 :: 		strcpy(server3, "pool.ntp.org");
	MOVLW       _server3+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_server3+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr238_SE9M+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr238_SE9M+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;SE9M.c,2455 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main461:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main462
;SE9M.c,2456 :: 		EEPROM_Write(j+110, server3[j]);
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
;SE9M.c,2455 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2457 :: 		}
	GOTO        L_main461
L_main462:
;SE9M.c,2460 :: 		ipAddr[0]    = 192;
	MOVLW       192
	MOVWF       _ipAddr+0 
;SE9M.c,2461 :: 		ipAddr[1]    = 168;
	MOVLW       168
	MOVWF       _ipAddr+1 
;SE9M.c,2462 :: 		ipAddr[2]    = 1;
	MOVLW       1
	MOVWF       _ipAddr+2 
;SE9M.c,2463 :: 		ipAddr[3]    = 99;
	MOVLW       99
	MOVWF       _ipAddr+3 
;SE9M.c,2464 :: 		gwIpAddr[0]  = 192;
	MOVLW       192
	MOVWF       _gwIpAddr+0 
;SE9M.c,2465 :: 		gwIpAddr[1]  = 168;
	MOVLW       168
	MOVWF       _gwIpAddr+1 
;SE9M.c,2466 :: 		gwIpAddr[2]  = 1;
	MOVLW       1
	MOVWF       _gwIpAddr+2 
;SE9M.c,2467 :: 		gwIpAddr[3]  = 1;
	MOVLW       1
	MOVWF       _gwIpAddr+3 
;SE9M.c,2468 :: 		ipMask[0]    = 255;
	MOVLW       255
	MOVWF       _ipMask+0 
;SE9M.c,2469 :: 		ipMask[1]    = 255;
	MOVLW       255
	MOVWF       _ipMask+1 
;SE9M.c,2470 :: 		ipMask[2]    = 255;
	MOVLW       255
	MOVWF       _ipMask+2 
;SE9M.c,2471 :: 		ipMask[3]    = 0;
	CLRF        _ipMask+3 
;SE9M.c,2472 :: 		dnsIpAddr[0] = 192;
	MOVLW       192
	MOVWF       _dnsIpAddr+0 
;SE9M.c,2473 :: 		dnsIpAddr[1] = 168;
	MOVLW       168
	MOVWF       _dnsIpAddr+1 
;SE9M.c,2474 :: 		dnsIpAddr[2] = 1;
	MOVLW       1
	MOVWF       _dnsIpAddr+2 
;SE9M.c,2475 :: 		dnsIpAddr[3] = 1;
	MOVLW       1
	MOVWF       _dnsIpAddr+3 
;SE9M.c,2478 :: 		EEPROM_Write(1, ipAddr[0]);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2479 :: 		EEPROM_Write(2, ipAddr[1]);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2480 :: 		EEPROM_Write(3, ipAddr[2]);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2481 :: 		EEPROM_Write(4, ipAddr[3]);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2482 :: 		EEPROM_Write(5, gwIpAddr[0]);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2483 :: 		EEPROM_Write(6, gwIpAddr[1]);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2484 :: 		EEPROM_Write(7, gwIpAddr[2]);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2485 :: 		EEPROM_Write(8, gwIpAddr[3]);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2486 :: 		EEPROM_Write(9, ipMask[0]);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2487 :: 		EEPROM_Write(10, ipMask[1]);
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2488 :: 		EEPROM_Write(11, ipMask[2]);
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2489 :: 		EEPROM_Write(12, ipMask[3]);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2490 :: 		EEPROM_Write(13, dnsIpAddr[0]);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2491 :: 		EEPROM_Write(14, dnsIpAddr[1]);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2492 :: 		EEPROM_Write(15, dnsIpAddr[2]);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2493 :: 		EEPROM_Write(16, dnsIpAddr[3]);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2495 :: 		ByteToStr(ipAddr[0], IpAddrPom0);
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2496 :: 		ByteToStr(ipAddr[1], IpAddrPom1);
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2497 :: 		ByteToStr(ipAddr[2], IpAddrPom2);
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2498 :: 		ByteToStr(ipAddr[3], IpAddrPom3);
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2500 :: 		ByteToStr(gwIpAddr[0], gwIpAddrPom0);
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2501 :: 		ByteToStr(gwIpAddr[1], gwIpAddrPom1);
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2502 :: 		ByteToStr(gwIpAddr[2], gwIpAddrPom2);
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2503 :: 		ByteToStr(gwIpAddr[3], gwIpAddrPom3);
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2505 :: 		ByteToStr(ipMask[0], ipMaskPom0);
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2506 :: 		ByteToStr(ipMask[1], ipMaskPom1);
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2507 :: 		ByteToStr(ipMask[2], ipMaskPom2);
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2508 :: 		ByteToStr(ipMask[3], ipMaskPom3);
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2510 :: 		ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2511 :: 		ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2512 :: 		ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2513 :: 		ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2515 :: 		rst_fab = 0;
	CLRF        _rst_fab+0 
;SE9M.c,2516 :: 		pom_time_pom = 0xAA;
	MOVLW       170
	MOVWF       _pom_time_pom+0 
;SE9M.c,2517 :: 		EEPROM_Write(0, pom_time_pom);
	CLRF        FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVLW       170
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2518 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main464:
	DECFSZ      R13, 1, 1
	BRA         L_main464
	DECFSZ      R12, 1, 1
	BRA         L_main464
	DECFSZ      R11, 1, 1
	BRA         L_main464
;SE9M.c,2519 :: 		}
L_main451:
;SE9M.c,2521 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2523 :: 		sifra[0]    = EEPROM_Read(20);
	MOVLW       20
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+0 
;SE9M.c,2524 :: 		sifra[1]    = EEPROM_Read(21);
	MOVLW       21
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+1 
;SE9M.c,2525 :: 		sifra[2]    = EEPROM_Read(22);
	MOVLW       22
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+2 
;SE9M.c,2526 :: 		sifra[3]    = EEPROM_Read(23);
	MOVLW       23
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+3 
;SE9M.c,2527 :: 		sifra[4]    = EEPROM_Read(24);
	MOVLW       24
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+4 
;SE9M.c,2528 :: 		sifra[5]    = EEPROM_Read(25);
	MOVLW       25
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+5 
;SE9M.c,2529 :: 		sifra[6]    = EEPROM_Read(26);
	MOVLW       26
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+6 
;SE9M.c,2530 :: 		sifra[7]    = EEPROM_Read(27);
	MOVLW       27
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+7 
;SE9M.c,2531 :: 		sifra[8]    = EEPROM_Read(28);
	MOVLW       28
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _sifra+8 
;SE9M.c,2533 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main465:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main466
;SE9M.c,2534 :: 		server1[j] = EEPROM_Read(j+29);
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
;SE9M.c,2533 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2535 :: 		}
	GOTO        L_main465
L_main466:
;SE9M.c,2536 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main468:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main469
;SE9M.c,2537 :: 		server2[j] = EEPROM_Read(j+56);
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
;SE9M.c,2536 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2538 :: 		}
	GOTO        L_main468
L_main469:
;SE9M.c,2539 :: 		for (j=0;j<=26;j++) {
	CLRF        _j+0 
L_main471:
	MOVF        _j+0, 0 
	SUBLW       26
	BTFSS       STATUS+0, 0 
	GOTO        L_main472
;SE9M.c,2540 :: 		server3[j] = EEPROM_Read(j+110);
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
;SE9M.c,2539 :: 		for (j=0;j<=26;j++) {
	INCF        _j+0, 1 
;SE9M.c,2541 :: 		}
	GOTO        L_main471
L_main472:
;SE9M.c,2543 :: 		ipAddr[0]    = EEPROM_Read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+0 
;SE9M.c,2544 :: 		ipAddr[1]    = EEPROM_Read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+1 
;SE9M.c,2545 :: 		ipAddr[2]    = EEPROM_Read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+2 
;SE9M.c,2546 :: 		ipAddr[3]    = EEPROM_Read(4);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipAddr+3 
;SE9M.c,2547 :: 		gwIpAddr[0]  = EEPROM_Read(5);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+0 
;SE9M.c,2548 :: 		gwIpAddr[1]  = EEPROM_Read(6);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+1 
;SE9M.c,2549 :: 		gwIpAddr[2]  = EEPROM_Read(7);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+2 
;SE9M.c,2550 :: 		gwIpAddr[3]  = EEPROM_Read(8);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _gwIpAddr+3 
;SE9M.c,2551 :: 		ipMask[0]    = EEPROM_Read(9);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+0 
;SE9M.c,2552 :: 		ipMask[1]    = EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+1 
;SE9M.c,2553 :: 		ipMask[2]    = EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+2 
;SE9M.c,2554 :: 		ipMask[3]    = EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ipMask+3 
;SE9M.c,2555 :: 		dnsIpAddr[0] = EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+0 
;SE9M.c,2556 :: 		dnsIpAddr[1] = EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+1 
;SE9M.c,2557 :: 		dnsIpAddr[2] = EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+2 
;SE9M.c,2558 :: 		dnsIpAddr[3] = EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dnsIpAddr+3 
;SE9M.c,2561 :: 		if (prolaz == 1) {
	MOVF        _prolaz+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main474
;SE9M.c,2562 :: 		ByteToStr(ipAddr[0], IpAddrPom0);
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2563 :: 		ByteToStr(ipAddr[1], IpAddrPom1);
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2564 :: 		ByteToStr(ipAddr[2], IpAddrPom2);
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2565 :: 		ByteToStr(ipAddr[3], IpAddrPom3);
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2567 :: 		ByteToStr(gwIpAddr[0], gwIpAddrPom0);
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2568 :: 		ByteToStr(gwIpAddr[1], gwIpAddrPom1);
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2569 :: 		ByteToStr(gwIpAddr[2], gwIpAddrPom2);
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2570 :: 		ByteToStr(gwIpAddr[3], gwIpAddrPom3);
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2572 :: 		ByteToStr(ipMask[0], ipMaskPom0);
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2573 :: 		ByteToStr(ipMask[1], ipMaskPom1);
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2574 :: 		ByteToStr(ipMask[2], ipMaskPom2);
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2575 :: 		ByteToStr(ipMask[3], ipMaskPom3);
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2577 :: 		ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2578 :: 		ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2579 :: 		ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2580 :: 		ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2582 :: 		prolaz = 0;
	CLRF        _prolaz+0 
;SE9M.c,2583 :: 		Print_All();
	CALL        _Print_All+0, 0
;SE9M.c,2584 :: 		}
L_main474:
;SE9M.c,2586 :: 		conf.tz = EEPROM_Read(102);
	MOVLW       102
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+2 
;SE9M.c,2587 :: 		conf.dhcpen = EEPROM_Read(103);
	MOVLW       103
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _conf+0 
;SE9M.c,2588 :: 		mode = EEPROM_Read(104);
	MOVLW       104
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _mode+0 
;SE9M.c,2589 :: 		dhcp_flag = EEPROM_Read(105);
	MOVLW       105
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _dhcp_flag+0 
;SE9M.c,2591 :: 		if ( (conf.dhcpen == 0) && (dhcp_flag == 1) ) {
	MOVF        _conf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main477
	MOVF        _dhcp_flag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main477
L__main576:
;SE9M.c,2592 :: 		conf.dhcpen = 1;
	MOVLW       1
	MOVWF       _conf+0 
;SE9M.c,2593 :: 		EEPROM_Write(103, conf.dhcpen);
	MOVLW       103
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2594 :: 		dhcp_flag = 0;
	CLRF        _dhcp_flag+0 
;SE9M.c,2595 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2596 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main478:
	DECFSZ      R13, 1, 1
	BRA         L_main478
	DECFSZ      R12, 1, 1
	BRA         L_main478
	DECFSZ      R11, 1, 1
	BRA         L_main478
;SE9M.c,2597 :: 		}
L_main477:
;SE9M.c,2599 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2601 :: 		if (reset_eth == 1) {
	MOVF        _reset_eth+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main479
;SE9M.c,2602 :: 		reset_eth = 0;
	CLRF        _reset_eth+0 
;SE9M.c,2603 :: 		prvi_timer = 1;
	MOVLW       1
	MOVWF       _prvi_timer+0 
;SE9M.c,2604 :: 		drugi_timer = 0;
	CLRF        _drugi_timer+0 
;SE9M.c,2605 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2606 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2607 :: 		}
L_main479:
;SE9M.c,2608 :: 		if ( (prvi_timer == 1) && (timer_flag >= 1) ) {
	MOVF        _prvi_timer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main482
	MOVLW       1
	SUBWF       _timer_flag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main482
L__main575:
;SE9M.c,2609 :: 		prvi_timer = 0;
	CLRF        _prvi_timer+0 
;SE9M.c,2610 :: 		drugi_timer = 1;
	MOVLW       1
	MOVWF       _drugi_timer+0 
;SE9M.c,2611 :: 		SPI_Ethernet_Rst = 1;
	BSF         RA5_bit+0, BitPos(RA5_bit+0) 
;SE9M.c,2612 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2613 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2614 :: 		}
L_main482:
;SE9M.c,2615 :: 		if ( (drugi_timer == 1) && (timer_flag >= 1) ) {
	MOVF        _drugi_timer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main485
	MOVLW       1
	SUBWF       _timer_flag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main485
L__main574:
;SE9M.c,2616 :: 		prvi_timer = 0;
	CLRF        _prvi_timer+0 
;SE9M.c,2617 :: 		drugi_timer = 0;
	CLRF        _drugi_timer+0 
;SE9M.c,2618 :: 		link_enable = 1;
	MOVLW       1
	MOVWF       _link_enable+0 
;SE9M.c,2619 :: 		timer_flag = 0;
	CLRF        _timer_flag+0 
;SE9M.c,2620 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2621 :: 		}
L_main485:
;SE9M.c,2622 :: 		if ( (Eth1_Link == 0) && (link == 0) && (link_enable == 1) ) {
	BTFSC       RB5_bit+0, BitPos(RB5_bit+0) 
	GOTO        L_main488
	MOVF        _link+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main488
	MOVF        _link_enable+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main488
L__main573:
;SE9M.c,2623 :: 		link = 1;
	MOVLW       1
	MOVWF       _link+0 
;SE9M.c,2624 :: 		tacka1 = 1;
	MOVLW       1
	MOVWF       _tacka1+0 
;SE9M.c,2625 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2627 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;SE9M.c,2628 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2629 :: 		if (conf.dhcpen == 0) {
	MOVF        _conf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main489
;SE9M.c,2630 :: 		Mem_Read();
	CALL        _Mem_Read+0, 0
;SE9M.c,2631 :: 		ipAddr[0] = 0;
	CLRF        _ipAddr+0 
;SE9M.c,2632 :: 		ipAddr[1] = 0;
	CLRF        _ipAddr+1 
;SE9M.c,2633 :: 		ipAddr[2] = 0;
	CLRF        _ipAddr+2 
;SE9M.c,2634 :: 		ipAddr[3] = 0;
	CLRF        _ipAddr+3 
;SE9M.c,2636 :: 		dhcp_flag = 1;
	MOVLW       1
	MOVWF       _dhcp_flag+0 
;SE9M.c,2637 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2639 :: 		Spi_Ethernet_Init(macAddr, ipAddr, Spi_Ethernet_FULLDUPLEX) ;
	MOVLW       _macAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_mac+0 
	MOVLW       hi_addr(_macAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_mac+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_ip+1 
	MOVLW       1
	MOVWF       FARG_SPI_Ethernet_Init_fullDuplex+0 
	CALL        _SPI_Ethernet_Init+0, 0
;SE9M.c,2641 :: 		while (SPI_Ethernet_initDHCP(5) == 0) ; // try to get one from DHCP until it works
L_main490:
	MOVLW       5
	MOVWF       FARG_SPI_Ethernet_initDHCP_tmax+0 
	CALL        _SPI_Ethernet_initDHCP+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main491
	GOTO        L_main490
L_main491:
;SE9M.c,2642 :: 		memcpy(ipAddr,    SPI_Ethernet_getIpAddress(),    4) ; // get assigned IP address
	CALL        _SPI_Ethernet_getIpAddress+0, 0
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
;SE9M.c,2643 :: 		memcpy(ipMask,    SPI_Ethernet_getIpMask(),       4) ; // get assigned IP mask
	CALL        _SPI_Ethernet_getIpMask+0, 0
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
;SE9M.c,2644 :: 		memcpy(gwIpAddr,  SPI_Ethernet_getGwIpAddress(),  4) ; // get assigned gateway IP address
	CALL        _SPI_Ethernet_getGwIpAddress+0, 0
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
;SE9M.c,2645 :: 		memcpy(dnsIpAddr, SPI_Ethernet_getDnsIpAddress(), 4) ; // get assigned dns IP address
	CALL        _SPI_Ethernet_getDnsIpAddress+0, 0
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
;SE9M.c,2647 :: 		lease_tmr = 1;
	MOVLW       1
	MOVWF       _lease_tmr+0 
;SE9M.c,2648 :: 		lease_time = 0;
	CLRF        _lease_time+0 
;SE9M.c,2650 :: 		EEPROM_Write(1, ipAddr[0]);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2651 :: 		EEPROM_Write(2, ipAddr[1]);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2652 :: 		EEPROM_Write(3, ipAddr[2]);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2653 :: 		EEPROM_Write(4, ipAddr[3]);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2654 :: 		EEPROM_Write(5, gwIpAddr[0]);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2655 :: 		EEPROM_Write(6, gwIpAddr[1]);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2656 :: 		EEPROM_Write(7, gwIpAddr[2]);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2657 :: 		EEPROM_Write(8, gwIpAddr[3]);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2658 :: 		EEPROM_Write(9, ipMask[0]);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2659 :: 		EEPROM_Write(10, ipMask[1]);
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2660 :: 		EEPROM_Write(11, ipMask[2]);
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2661 :: 		EEPROM_Write(12, ipMask[3]);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2662 :: 		EEPROM_Write(13, dnsIpAddr[0]);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2663 :: 		EEPROM_Write(14, dnsIpAddr[1]);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2664 :: 		EEPROM_Write(15, dnsIpAddr[2]);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2665 :: 		EEPROM_Write(16, dnsIpAddr[3]);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2667 :: 		ByteToStr(ipAddr[0], IpAddrPom0);
	MOVF        _ipAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2668 :: 		ByteToStr(ipAddr[1], IpAddrPom1);
	MOVF        _ipAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2669 :: 		ByteToStr(ipAddr[2], IpAddrPom2);
	MOVF        _ipAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2670 :: 		ByteToStr(ipAddr[3], IpAddrPom3);
	MOVF        _ipAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2672 :: 		ByteToStr(gwIpAddr[0], gwIpAddrPom0);
	MOVF        _gwIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2673 :: 		ByteToStr(gwIpAddr[1], gwIpAddrPom1);
	MOVF        _gwIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2674 :: 		ByteToStr(gwIpAddr[2], gwIpAddrPom2);
	MOVF        _gwIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2675 :: 		ByteToStr(gwIpAddr[3], gwIpAddrPom3);
	MOVF        _gwIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _gwIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_gwIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2677 :: 		ByteToStr(ipMask[0], ipMaskPom0);
	MOVF        _ipMask+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2678 :: 		ByteToStr(ipMask[1], ipMaskPom1);
	MOVF        _ipMask+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2679 :: 		ByteToStr(ipMask[2], ipMaskPom2);
	MOVF        _ipMask+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2680 :: 		ByteToStr(ipMask[3], ipMaskPom3);
	MOVF        _ipMask+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _ipMaskPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_ipMaskPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2682 :: 		ByteToStr(dnsIpAddr[0], dnsIpAddrPom0);
	MOVF        _dnsIpAddr+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2683 :: 		ByteToStr(dnsIpAddr[1], dnsIpAddrPom1);
	MOVF        _dnsIpAddr+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2684 :: 		ByteToStr(dnsIpAddr[2], dnsIpAddrPom2);
	MOVF        _dnsIpAddr+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2685 :: 		ByteToStr(dnsIpAddr[3], dnsIpAddrPom3);
	MOVF        _dnsIpAddr+3, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _dnsIpAddrPom3+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_dnsIpAddrPom3+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;SE9M.c,2687 :: 		dhcp_flag = 0;
	CLRF        _dhcp_flag+0 
;SE9M.c,2688 :: 		EEPROM_Write(105, dhcp_flag);
	MOVLW       105
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;SE9M.c,2690 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main492:
	DECFSZ      R13, 1, 1
	BRA         L_main492
	DECFSZ      R12, 1, 1
	BRA         L_main492
	DECFSZ      R11, 1, 1
	BRA         L_main492
;SE9M.c,2691 :: 		Print_IP();
	CALL        _Print_IP+0, 0
;SE9M.c,2692 :: 		}
L_main489:
;SE9M.c,2693 :: 		if (conf.dhcpen == 1) {
	MOVF        _conf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main493
;SE9M.c,2694 :: 		lease_tmr = 0;
	CLRF        _lease_tmr+0 
;SE9M.c,2695 :: 		Mem_Read();
	CALL        _Mem_Read+0, 0
;SE9M.c,2696 :: 		Spi_Ethernet_Init(macAddr, ipAddr, Spi_Ethernet_FULLDUPLEX) ;
	MOVLW       _macAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_mac+0 
	MOVLW       hi_addr(_macAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_mac+1 
	MOVLW       _ipAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_ip+0 
	MOVLW       hi_addr(_ipAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_ip+1 
	MOVLW       1
	MOVWF       FARG_SPI_Ethernet_Init_fullDuplex+0 
	CALL        _SPI_Ethernet_Init+0, 0
;SE9M.c,2697 :: 		SPI_Ethernet_confNetwork(ipMask, gwIpAddr, dnsIpAddr) ;
	MOVLW       _ipMask+0
	MOVWF       FARG_SPI_Ethernet_confNetwork_ipMask+0 
	MOVLW       hi_addr(_ipMask+0)
	MOVWF       FARG_SPI_Ethernet_confNetwork_ipMask+1 
	MOVLW       _gwIpAddr+0
	MOVWF       FARG_SPI_Ethernet_confNetwork_gwIpAddr+0 
	MOVLW       hi_addr(_gwIpAddr+0)
	MOVWF       FARG_SPI_Ethernet_confNetwork_gwIpAddr+1 
	MOVLW       _dnsIpAddr+0
	MOVWF       FARG_SPI_Ethernet_confNetwork_dnsIpAddr+0 
	MOVLW       hi_addr(_dnsIpAddr+0)
	MOVWF       FARG_SPI_Ethernet_confNetwork_dnsIpAddr+1 
	CALL        _SPI_Ethernet_confNetwork+0, 0
;SE9M.c,2698 :: 		Print_IP();
	CALL        _Print_IP+0, 0
;SE9M.c,2699 :: 		}
L_main493:
;SE9M.c,2700 :: 		tacka1 = 0;
	CLRF        _tacka1+0 
;SE9M.c,2701 :: 		Print_Pme();
	CALL        _Print_Pme+0, 0
;SE9M.c,2703 :: 		}
L_main488:
;SE9M.c,2706 :: 		if (Eth1_Link == 1) {
	BTFSS       RB5_bit+0, BitPos(RB5_bit+0) 
	GOTO        L_main494
;SE9M.c,2707 :: 		link = 0;
	CLRF        _link+0 
;SE9M.c,2708 :: 		lastSync = 0;
	CLRF        _lastSync+0 
	CLRF        _lastSync+1 
	CLRF        _lastSync+2 
	CLRF        _lastSync+3 
;SE9M.c,2709 :: 		}
L_main494:
;SE9M.c,2711 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2714 :: 		if (req_tmr_3 == 12) {
	MOVF        _req_tmr_3+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_main495
;SE9M.c,2715 :: 		sntpSync = 0;
	CLRF        _sntpSync+0 
;SE9M.c,2716 :: 		req_tmr_1 = 0;
	CLRF        _req_tmr_1+0 
;SE9M.c,2717 :: 		req_tmr_2 = 0;
	CLRF        _req_tmr_2+0 
;SE9M.c,2718 :: 		req_tmr_3 = 0;
	CLRF        _req_tmr_3+0 
;SE9M.c,2719 :: 		}
L_main495:
;SE9M.c,2722 :: 		if (RSTPIN == 0) {
	BTFSC       RD4_bit+0, BitPos(RD4_bit+0) 
	GOTO        L_main496
;SE9M.c,2723 :: 		rst_fab_tmr = 1;
	MOVLW       1
	MOVWF       _rst_fab_tmr+0 
;SE9M.c,2724 :: 		} else {
	GOTO        L_main497
L_main496:
;SE9M.c,2725 :: 		rst_fab_tmr = 0;
	CLRF        _rst_fab_tmr+0 
;SE9M.c,2726 :: 		rst_fab_flag = 0;
	CLRF        _rst_fab_flag+0 
;SE9M.c,2727 :: 		}
L_main497:
;SE9M.c,2728 :: 		if (rst_fab_flag >= 5) {
	MOVLW       5
	SUBWF       _rst_fab_flag+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main498
;SE9M.c,2729 :: 		rst_fab_tmr = 0;
	CLRF        _rst_fab_tmr+0 
;SE9M.c,2730 :: 		rst_fab_flag = 0;
	CLRF        _rst_fab_flag+0 
;SE9M.c,2731 :: 		rst_fab = 1;
	MOVLW       1
	MOVWF       _rst_fab+0 
;SE9M.c,2732 :: 		Rst_Eth();
	CALL        _Rst_Eth+0, 0
;SE9M.c,2733 :: 		}
L_main498:
;SE9M.c,2735 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2738 :: 		if (komgotovo == 1) {
	MOVF        _komgotovo+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main499
;SE9M.c,2739 :: 		komgotovo = 0;
	CLRF        _komgotovo+0 
;SE9M.c,2740 :: 		chksum = (comand[3] ^ comand[4] ^ comand[5] ^ comand[6] ^ comand[7] ^comand[8] ^ comand[9] ^ comand[10] ^ comand[11]) & 0x7F;
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
;SE9M.c,2741 :: 		if ((comand[0] == 0xAA) && (comand[1] == 0xAA) && (comand[2] == 0xAA) && (comand[12] == chksum) && (comand[13] == 0xBB) && (link_enable == 1)) {
	MOVF        _comand+0, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main502
	MOVF        _comand+1, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main502
	MOVF        _comand+2, 0 
	XORLW       170
	BTFSS       STATUS+0, 2 
	GOTO        L_main502
	MOVF        _comand+12, 0 
	XORWF       _chksum+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main502
	MOVF        _comand+13, 0 
	XORLW       187
	BTFSS       STATUS+0, 2 
	GOTO        L_main502
	MOVF        _link_enable+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main502
L__main572:
;SE9M.c,2742 :: 		sati = comand[3];
	MOVF        _comand+3, 0 
	MOVWF       _sati+0 
;SE9M.c,2743 :: 		minuti = comand[4];
	MOVF        _comand+4, 0 
	MOVWF       _minuti+0 
;SE9M.c,2744 :: 		sekundi = comand[5];
	MOVF        _comand+5, 0 
	MOVWF       _sekundi+0 
;SE9M.c,2745 :: 		dan = comand[6];
	MOVF        _comand+6, 0 
	MOVWF       _dan+0 
;SE9M.c,2746 :: 		mesec = comand[7];
	MOVF        _comand+7, 0 
	MOVWF       _mesec+0 
;SE9M.c,2747 :: 		fingodina = comand[8];
	MOVF        _comand+8, 0 
	MOVWF       _fingodina+0 
;SE9M.c,2748 :: 		notime = 0;
	CLRF        _notime+0 
;SE9M.c,2749 :: 		notime_ovf = 0;
	CLRF        _notime_ovf+0 
;SE9M.c,2750 :: 		}
L_main502:
;SE9M.c,2751 :: 		}
L_main499:
;SE9M.c,2753 :: 		if (pom_mat_sek != sekundi) {
	MOVF        _pom_mat_sek+0, 0 
	XORWF       _sekundi+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main503
;SE9M.c,2754 :: 		pom_mat_sek = sekundi;
	MOVF        _sekundi+0, 0 
	MOVWF       _pom_mat_sek+0 
;SE9M.c,2755 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2757 :: 		if (disp_mode == 1) {
	MOVF        _disp_mode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main504
;SE9M.c,2758 :: 		tacka2 = 0;
	CLRF        _tacka2+0 
;SE9M.c,2759 :: 		if (tacka1 == 0) {
	MOVF        _tacka1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main505
;SE9M.c,2760 :: 		tacka1 = 1;
	MOVLW       1
	MOVWF       _tacka1+0 
;SE9M.c,2761 :: 		goto DALJE2;
	GOTO        ___main_DALJE2
;SE9M.c,2762 :: 		}
L_main505:
;SE9M.c,2763 :: 		if (tacka1 == 1) {
	MOVF        _tacka1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main506
;SE9M.c,2764 :: 		tacka1 = 0;
	CLRF        _tacka1+0 
;SE9M.c,2765 :: 		goto DALJE2;
	GOTO        ___main_DALJE2
;SE9M.c,2766 :: 		}
L_main506:
;SE9M.c,2767 :: 		DALJE2:
___main_DALJE2:
;SE9M.c,2768 :: 		bljump = 0;
	CLRF        _bljump+0 
;SE9M.c,2769 :: 		}
L_main504:
;SE9M.c,2770 :: 		if (disp_mode == 2) {
	MOVF        _disp_mode+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main507
;SE9M.c,2771 :: 		tacka1 = 0;
	CLRF        _tacka1+0 
;SE9M.c,2772 :: 		tacka2 = 1;
	MOVLW       1
	MOVWF       _tacka2+0 
;SE9M.c,2773 :: 		}
L_main507:
;SE9M.c,2774 :: 		if (notime_ovf == 1) {
	MOVF        _notime_ovf+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main508
;SE9M.c,2775 :: 		tacka1 = 1;
	MOVLW       1
	MOVWF       _tacka1+0 
;SE9M.c,2776 :: 		tacka2 = 1;
	MOVLW       1
	MOVWF       _tacka2+0 
;SE9M.c,2777 :: 		}
L_main508:
;SE9M.c,2778 :: 		if (notime_ovf == 0) {
	MOVF        _notime_ovf+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main509
;SE9M.c,2779 :: 		if ( (sekundi == 0) || (sekundi == 10) || (sekundi == 20) || (sekundi == 30) || (sekundi == 40) || (sekundi == 50) ) {
	MOVF        _sekundi+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__main571
	MOVF        _sekundi+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L__main571
	MOVF        _sekundi+0, 0 
	XORLW       20
	BTFSC       STATUS+0, 2 
	GOTO        L__main571
	MOVF        _sekundi+0, 0 
	XORLW       30
	BTFSC       STATUS+0, 2 
	GOTO        L__main571
	MOVF        _sekundi+0, 0 
	XORLW       40
	BTFSC       STATUS+0, 2 
	GOTO        L__main571
	MOVF        _sekundi+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L__main571
	GOTO        L_main512
L__main571:
;SE9M.c,2780 :: 		Print_Light();
	CALL        _Print_Light+0, 0
;SE9M.c,2781 :: 		}
L_main512:
;SE9M.c,2782 :: 		} else {
	GOTO        L_main513
L_main509:
;SE9M.c,2783 :: 		PWM1_Set_Duty(min_light);
	MOVF        _min_light+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;SE9M.c,2784 :: 		}
L_main513:
;SE9M.c,2785 :: 		Display_Time();
	CALL        _Display_Time+0, 0
;SE9M.c,2786 :: 		}
L_main503:
;SE9M.c,2788 :: 		Time_epochToDate(epoch + tmzn * 3600l, &ts) ;
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
;SE9M.c,2789 :: 		Eth_Obrada();
	CALL        _Eth_Obrada+0, 0
;SE9M.c,2790 :: 		DNSavings();
	CALL        _DNSavings+0, 0
;SE9M.c,2791 :: 		if (lcdEvent) {
	MOVF        _lcdEvent+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main514
;SE9M.c,2792 :: 		mkLCDLine(1, conf.dhcpen) ; // update lcd: first row
	MOVLW       1
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+0, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2793 :: 		mkLCDLine(2, conf.lcdL2) ; // update lcd: second row
	MOVLW       2
	MOVWF       FARG_mkLCDLine_l+0 
	MOVF        _conf+1, 0 
	MOVWF       FARG_mkLCDLine_m+0 
	CALL        _mkLCDLine+0, 0
;SE9M.c,2794 :: 		lcdEvent = 0 ;             // clear lcd update flag
	CLRF        _lcdEvent+0 
;SE9M.c,2795 :: 		marquee++ ;                // set marquee pointer
	INFSNZ      _marquee+0, 1 
	INCF        _marquee+1, 1 
;SE9M.c,2796 :: 		}
L_main514:
;SE9M.c,2798 :: 		asm CLRWDT;
	CLRWDT
;SE9M.c,2799 :: 		}
	GOTO        L_main447
;SE9M.c,2800 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
