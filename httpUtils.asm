
_HTTP_b64_decode4:

;httpUtils.c,89 :: 		void    HTTP_b64_decode4(unsigned char in[4], unsigned char out[3])
;httpUtils.c,91 :: 		out[0] = (in[0] << 2) | (in[1] >> 4) ;
	MOVFF       FARG_HTTP_b64_decode4_in+0, FSR0
	MOVFF       FARG_HTTP_b64_decode4_in+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       R3 
	RLCF        R3, 1 
	BCF         R3, 0 
	RLCF        R3, 1 
	BCF         R3, 0 
	MOVLW       1
	ADDWF       FARG_HTTP_b64_decode4_in+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_HTTP_b64_decode4_in+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVFF       FARG_HTTP_b64_decode4_out+0, FSR1
	MOVFF       FARG_HTTP_b64_decode4_out+1, FSR1H
	MOVF        R0, 0 
	IORWF       R3, 0 
	MOVWF       POSTINC1+0 
;httpUtils.c,92 :: 		out[1] = (in[1] << 4) | (in[2] >> 2) ;
	MOVLW       1
	ADDWF       FARG_HTTP_b64_decode4_out+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_HTTP_b64_decode4_out+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	ADDWF       FARG_HTTP_b64_decode4_in+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_HTTP_b64_decode4_in+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       R3 
	RLCF        R3, 1 
	BCF         R3, 0 
	RLCF        R3, 1 
	BCF         R3, 0 
	RLCF        R3, 1 
	BCF         R3, 0 
	RLCF        R3, 1 
	BCF         R3, 0 
	MOVLW       2
	ADDWF       FARG_HTTP_b64_decode4_in+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_HTTP_b64_decode4_in+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R3, 0 
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;httpUtils.c,93 :: 		out[2] = ((in[2] << 6) & 0xc0) | in[3] ;
	MOVLW       2
	ADDWF       FARG_HTTP_b64_decode4_out+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_HTTP_b64_decode4_out+1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	ADDWF       FARG_HTTP_b64_decode4_in+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_HTTP_b64_decode4_in+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       6
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__HTTP_b64_decode449:
	BZ          L__HTTP_b64_decode450
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__HTTP_b64_decode449
L__HTTP_b64_decode450:
	MOVLW       192
	ANDWF       R0, 1 
	MOVLW       3
	ADDWF       FARG_HTTP_b64_decode4_in+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_HTTP_b64_decode4_in+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;httpUtils.c,94 :: 		}
L_end_HTTP_b64_decode4:
	RETURN      0
; end of _HTTP_b64_decode4

_HTTP_b64_unencode:

;httpUtils.c,99 :: 		void    HTTP_b64_unencode(char *src, char *dst)
;httpUtils.c,104 :: 		while(*src)
L_HTTP_b64_unencode0:
	MOVFF       FARG_HTTP_b64_unencode_src+0, FSR0
	MOVFF       FARG_HTTP_b64_unencode_src+1, FSR0H
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_HTTP_b64_unencode1
;httpUtils.c,106 :: 		for(len = 0, i = 0 ; i < 4 && *src ; i++)
	CLRF        HTTP_b64_unencode_len_L0+0 
	CLRF        HTTP_b64_unencode_len_L0+1 
	CLRF        HTTP_b64_unencode_i_L0+0 
	CLRF        HTTP_b64_unencode_i_L0+1 
L_HTTP_b64_unencode2:
	MOVLW       128
	XORWF       HTTP_b64_unencode_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__HTTP_b64_unencode52
	MOVLW       4
	SUBWF       HTTP_b64_unencode_i_L0+0, 0 
L__HTTP_b64_unencode52:
	BTFSC       STATUS+0, 0 
	GOTO        L_HTTP_b64_unencode3
	MOVFF       FARG_HTTP_b64_unencode_src+0, FSR0
	MOVFF       FARG_HTTP_b64_unencode_src+1, FSR0H
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_HTTP_b64_unencode3
L__HTTP_b64_unencode44:
;httpUtils.c,108 :: 		v = 0;
	CLRF        HTTP_b64_unencode_v_L0+0 
;httpUtils.c,109 :: 		while(*src && (v == 0))
L_HTTP_b64_unencode7:
	MOVFF       FARG_HTTP_b64_unencode_src+0, FSR0
	MOVFF       FARG_HTTP_b64_unencode_src+1, FSR0H
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_HTTP_b64_unencode8
	MOVF        HTTP_b64_unencode_v_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_HTTP_b64_unencode8
L__HTTP_b64_unencode43:
;httpUtils.c,111 :: 		v = *src++ ;
	MOVFF       FARG_HTTP_b64_unencode_src+0, FSR0
	MOVFF       FARG_HTTP_b64_unencode_src+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       HTTP_b64_unencode_v_L0+0 
	INFSNZ      FARG_HTTP_b64_unencode_src+0, 1 
	INCF        FARG_HTTP_b64_unencode_src+1, 1 
;httpUtils.c,112 :: 		v = ((v < 43 || v > 122) ? 0 : HTTP_b64_reverse[v - 43]) ;
	MOVLW       43
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__HTTP_b64_unencode42
	MOVF        HTTP_b64_unencode_v_L0+0, 0 
	SUBLW       122
	BTFSS       STATUS+0, 0 
	GOTO        L__HTTP_b64_unencode42
	GOTO        L_HTTP_b64_unencode13
L__HTTP_b64_unencode42:
	CLRF        ?FLOC___HTTP_b64_unencodeT48+0 
	GOTO        L_HTTP_b64_unencode14
L_HTTP_b64_unencode13:
	MOVLW       43
	SUBWF       HTTP_b64_unencode_v_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       _HTTP_b64_reverse+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_HTTP_b64_reverse+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_HTTP_b64_reverse+0)
	MOVWF       TBLPTRU 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      TBLPTRU, 1 
	TBLRD*+
	MOVFF       TABLAT+0, ?FLOC___HTTP_b64_unencodeT48+0
L_HTTP_b64_unencode14:
	MOVF        ?FLOC___HTTP_b64_unencodeT48+0, 0 
	MOVWF       HTTP_b64_unencode_v_L0+0 
;httpUtils.c,113 :: 		if(v)
	MOVF        ?FLOC___HTTP_b64_unencodeT48+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_HTTP_b64_unencode15
;httpUtils.c,115 :: 		v = ((v == '$') ? 0 : v - 61) ;
	MOVF        HTTP_b64_unencode_v_L0+0, 0 
	XORLW       36
	BTFSS       STATUS+0, 2 
	GOTO        L_HTTP_b64_unencode16
	CLRF        ?FLOC___HTTP_b64_unencodeT55+0 
	CLRF        ?FLOC___HTTP_b64_unencodeT55+1 
	GOTO        L_HTTP_b64_unencode17
L_HTTP_b64_unencode16:
	MOVLW       61
	SUBWF       HTTP_b64_unencode_v_L0+0, 0 
	MOVWF       ?FLOC___HTTP_b64_unencodeT55+0 
	MOVLW       0
	MOVWF       ?FLOC___HTTP_b64_unencodeT55+1 
L_HTTP_b64_unencode17:
	MOVF        ?FLOC___HTTP_b64_unencodeT55+0, 0 
	MOVWF       HTTP_b64_unencode_v_L0+0 
;httpUtils.c,116 :: 		}
L_HTTP_b64_unencode15:
;httpUtils.c,117 :: 		}
	GOTO        L_HTTP_b64_unencode7
L_HTTP_b64_unencode8:
;httpUtils.c,118 :: 		if(*src)
	MOVFF       FARG_HTTP_b64_unencode_src+0, FSR0
	MOVFF       FARG_HTTP_b64_unencode_src+1, FSR0H
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_HTTP_b64_unencode18
;httpUtils.c,120 :: 		len++;
	INFSNZ      HTTP_b64_unencode_len_L0+0, 1 
	INCF        HTTP_b64_unencode_len_L0+1, 1 
;httpUtils.c,121 :: 		if(v)
	MOVF        HTTP_b64_unencode_v_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_HTTP_b64_unencode19
;httpUtils.c,123 :: 		in[i] = (v - 1) ;
	MOVLW       HTTP_b64_unencode_in_L0+0
	ADDWF       HTTP_b64_unencode_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(HTTP_b64_unencode_in_L0+0)
	ADDWFC      HTTP_b64_unencode_i_L0+1, 0 
	MOVWF       FSR1H 
	DECF        HTTP_b64_unencode_v_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;httpUtils.c,124 :: 		}
L_HTTP_b64_unencode19:
;httpUtils.c,125 :: 		}
	GOTO        L_HTTP_b64_unencode20
L_HTTP_b64_unencode18:
;httpUtils.c,128 :: 		in[i] = 0 ;
	MOVLW       HTTP_b64_unencode_in_L0+0
	ADDWF       HTTP_b64_unencode_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(HTTP_b64_unencode_in_L0+0)
	ADDWFC      HTTP_b64_unencode_i_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;httpUtils.c,129 :: 		}
L_HTTP_b64_unencode20:
;httpUtils.c,106 :: 		for(len = 0, i = 0 ; i < 4 && *src ; i++)
	INFSNZ      HTTP_b64_unencode_i_L0+0, 1 
	INCF        HTTP_b64_unencode_i_L0+1, 1 
;httpUtils.c,130 :: 		}
	GOTO        L_HTTP_b64_unencode2
L_HTTP_b64_unencode3:
;httpUtils.c,132 :: 		if(len)
	MOVF        HTTP_b64_unencode_len_L0+0, 0 
	IORWF       HTTP_b64_unencode_len_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_HTTP_b64_unencode21
;httpUtils.c,134 :: 		HTTP_b64_decode4(in, out) ;
	MOVLW       HTTP_b64_unencode_in_L0+0
	MOVWF       FARG_HTTP_b64_decode4_in+0 
	MOVLW       hi_addr(HTTP_b64_unencode_in_L0+0)
	MOVWF       FARG_HTTP_b64_decode4_in+1 
	MOVLW       HTTP_b64_unencode_out_L0+0
	MOVWF       FARG_HTTP_b64_decode4_out+0 
	MOVLW       hi_addr(HTTP_b64_unencode_out_L0+0)
	MOVWF       FARG_HTTP_b64_decode4_out+1 
	CALL        _HTTP_b64_decode4+0, 0
;httpUtils.c,135 :: 		for(i = 0 ; i < len - 1 ; i++)
	CLRF        HTTP_b64_unencode_i_L0+0 
	CLRF        HTTP_b64_unencode_i_L0+1 
L_HTTP_b64_unencode22:
	MOVLW       1
	SUBWF       HTTP_b64_unencode_len_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      HTTP_b64_unencode_len_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       HTTP_b64_unencode_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__HTTP_b64_unencode53
	MOVF        R1, 0 
	SUBWF       HTTP_b64_unencode_i_L0+0, 0 
L__HTTP_b64_unencode53:
	BTFSC       STATUS+0, 0 
	GOTO        L_HTTP_b64_unencode23
;httpUtils.c,137 :: 		*dst = out[i] ;
	MOVLW       HTTP_b64_unencode_out_L0+0
	ADDWF       HTTP_b64_unencode_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(HTTP_b64_unencode_out_L0+0)
	ADDWFC      HTTP_b64_unencode_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVFF       FARG_HTTP_b64_unencode_dst+0, FSR1
	MOVFF       FARG_HTTP_b64_unencode_dst+1, FSR1H
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;httpUtils.c,138 :: 		dst++ ;
	INFSNZ      FARG_HTTP_b64_unencode_dst+0, 1 
	INCF        FARG_HTTP_b64_unencode_dst+1, 1 
;httpUtils.c,135 :: 		for(i = 0 ; i < len - 1 ; i++)
	INFSNZ      HTTP_b64_unencode_i_L0+0, 1 
	INCF        HTTP_b64_unencode_i_L0+1, 1 
;httpUtils.c,139 :: 		}
	GOTO        L_HTTP_b64_unencode22
L_HTTP_b64_unencode23:
;httpUtils.c,140 :: 		}
L_HTTP_b64_unencode21:
;httpUtils.c,141 :: 		}
	GOTO        L_HTTP_b64_unencode0
L_HTTP_b64_unencode1:
;httpUtils.c,143 :: 		*dst = 0 ;
	MOVFF       FARG_HTTP_b64_unencode_dst+0, FSR1
	MOVFF       FARG_HTTP_b64_unencode_dst+1, FSR1H
	CLRF        POSTINC1+0 
;httpUtils.c,144 :: 		}
L_end_HTTP_b64_unencode:
	RETURN      0
; end of _HTTP_b64_unencode

_HTTP_basicRealm:

;httpUtils.c,159 :: 		unsigned char   HTTP_basicRealm(unsigned int l, unsigned char *passwd)
;httpUtils.c,161 :: 		unsigned int    len = 0 ;       // my reply length
;httpUtils.c,167 :: 		i = 0 ;
	CLRF        HTTP_basicRealm_i_L0+0 
	CLRF        HTTP_basicRealm_i_L0+1 
;httpUtils.c,168 :: 		found = 0 ;
	CLRF        HTTP_basicRealm_found_L0+0 
;httpUtils.c,169 :: 		while(l--)
L_HTTP_basicRealm25:
	MOVF        FARG_HTTP_basicRealm_l+0, 0 
	MOVWF       R0 
	MOVF        FARG_HTTP_basicRealm_l+1, 0 
	MOVWF       R1 
	MOVLW       1
	SUBWF       FARG_HTTP_basicRealm_l+0, 1 
	MOVLW       0
	SUBWFB      FARG_HTTP_basicRealm_l+1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_HTTP_basicRealm26
;httpUtils.c,171 :: 		auth[i] = SPI_Ethernet_getByte() ;
	MOVLW       HTTP_basicRealm_auth_L0+0
	ADDWF       HTTP_basicRealm_i_L0+0, 0 
	MOVWF       FLOC__HTTP_basicRealm+0 
	MOVLW       hi_addr(HTTP_basicRealm_auth_L0+0)
	ADDWFC      HTTP_basicRealm_i_L0+1, 0 
	MOVWF       FLOC__HTTP_basicRealm+1 
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVFF       FLOC__HTTP_basicRealm+0, FSR1
	MOVFF       FLOC__HTTP_basicRealm+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;httpUtils.c,172 :: 		if((auth[i] < 32) || (i == AUTH_STR_MAXLENGTH - 1))
	MOVLW       HTTP_basicRealm_auth_L0+0
	ADDWF       HTTP_basicRealm_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(HTTP_basicRealm_auth_L0+0)
	ADDWFC      HTTP_basicRealm_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVLW       32
	SUBWF       POSTINC0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__HTTP_basicRealm45
	MOVF        HTTP_basicRealm_i_L0+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__HTTP_basicRealm55
	MOVLW       127
	XORWF       HTTP_basicRealm_i_L0+0, 0 
L__HTTP_basicRealm55:
	BTFSC       STATUS+0, 2 
	GOTO        L__HTTP_basicRealm45
	GOTO        L_HTTP_basicRealm29
L__HTTP_basicRealm45:
;httpUtils.c,174 :: 		if(memcmp(auth, AUTH_STRING, sizeof(AUTH_STRING) - 1) == 0)
	MOVLW       HTTP_basicRealm_auth_L0+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(HTTP_basicRealm_auth_L0+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr1_httpUtils+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr1_httpUtils+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       20
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__HTTP_basicRealm56
	MOVLW       0
	XORWF       R0, 0 
L__HTTP_basicRealm56:
	BTFSS       STATUS+0, 2 
	GOTO        L_HTTP_basicRealm30
;httpUtils.c,176 :: 		auth[i] = 0 ;
	MOVLW       HTTP_basicRealm_auth_L0+0
	ADDWF       HTTP_basicRealm_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(HTTP_basicRealm_auth_L0+0)
	ADDWFC      HTTP_basicRealm_i_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;httpUtils.c,177 :: 		HTTP_b64_unencode(auth + sizeof(AUTH_STRING) - 1, login) ;
	MOVLW       HTTP_basicRealm_auth_L0+20
	MOVWF       FARG_HTTP_b64_unencode_src+0 
	MOVLW       hi_addr(HTTP_basicRealm_auth_L0+20)
	MOVWF       FARG_HTTP_b64_unencode_src+1 
	MOVLW       HTTP_basicRealm_login_L0+0
	MOVWF       FARG_HTTP_b64_unencode_dst+0 
	MOVLW       hi_addr(HTTP_basicRealm_login_L0+0)
	MOVWF       FARG_HTTP_b64_unencode_dst+1 
	CALL        _HTTP_b64_unencode+0, 0
;httpUtils.c,178 :: 		if(strcmp(login, passwd) == 0)
	MOVLW       HTTP_basicRealm_login_L0+0
	MOVWF       FARG_strcmp_s1+0 
	MOVLW       hi_addr(HTTP_basicRealm_login_L0+0)
	MOVWF       FARG_strcmp_s1+1 
	MOVF        FARG_HTTP_basicRealm_passwd+0, 0 
	MOVWF       FARG_strcmp_s2+0 
	MOVF        FARG_HTTP_basicRealm_passwd+1, 0 
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__HTTP_basicRealm57
	MOVLW       0
	XORWF       R0, 0 
L__HTTP_basicRealm57:
	BTFSS       STATUS+0, 2 
	GOTO        L_HTTP_basicRealm31
;httpUtils.c,180 :: 		found = 1 ;
	MOVLW       1
	MOVWF       HTTP_basicRealm_found_L0+0 
;httpUtils.c,181 :: 		}
L_HTTP_basicRealm31:
;httpUtils.c,182 :: 		break ;
	GOTO        L_HTTP_basicRealm26
;httpUtils.c,183 :: 		}
L_HTTP_basicRealm30:
;httpUtils.c,184 :: 		i = 0 ;
	CLRF        HTTP_basicRealm_i_L0+0 
	CLRF        HTTP_basicRealm_i_L0+1 
;httpUtils.c,185 :: 		}
	GOTO        L_HTTP_basicRealm32
L_HTTP_basicRealm29:
;httpUtils.c,188 :: 		i++ ;
	INFSNZ      HTTP_basicRealm_i_L0+0, 1 
	INCF        HTTP_basicRealm_i_L0+1, 1 
;httpUtils.c,189 :: 		}
L_HTTP_basicRealm32:
;httpUtils.c,190 :: 		}
	GOTO        L_HTTP_basicRealm25
L_HTTP_basicRealm26:
;httpUtils.c,192 :: 		return(found) ;
	MOVF        HTTP_basicRealm_found_L0+0, 0 
	MOVWF       R0 
;httpUtils.c,193 :: 		}
L_end_HTTP_basicRealm:
	RETURN      0
; end of _HTTP_basicRealm

_HTTP_getRequest:

;httpUtils.c,202 :: 		unsigned char   HTTP_getRequest(unsigned char *buf, unsigned int *len, unsigned int max)
;httpUtils.c,209 :: 		if((SPI_Ethernet_getByte() != 'G')
	CALL        _SPI_Ethernet_getByte+0, 0
;httpUtils.c,210 :: 		|| (SPI_Ethernet_getByte() != 'E')
	MOVF        R0, 0 
	XORLW       71
	BTFSS       STATUS+0, 2 
	GOTO        L__HTTP_getRequest47
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L__HTTP_getRequest47
;httpUtils.c,211 :: 		|| (SPI_Ethernet_getByte() != 'T')
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	XORLW       84
	BTFSS       STATUS+0, 2 
	GOTO        L__HTTP_getRequest47
;httpUtils.c,212 :: 		|| (SPI_Ethernet_getByte() != ' ')
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVF        R0, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L__HTTP_getRequest47
	GOTO        L_HTTP_getRequest35
;httpUtils.c,213 :: 		)
L__HTTP_getRequest47:
;httpUtils.c,215 :: 		return(0) ;
	CLRF        R0 
	GOTO        L_end_HTTP_getRequest
;httpUtils.c,216 :: 		}
L_HTTP_getRequest35:
;httpUtils.c,221 :: 		for(i = 0 ; (i < max) && *len ; i++, buf++)
	CLRF        HTTP_getRequest_i_L0+0 
	CLRF        HTTP_getRequest_i_L0+1 
L_HTTP_getRequest36:
	MOVF        FARG_HTTP_getRequest_max+1, 0 
	SUBWF       HTTP_getRequest_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__HTTP_getRequest59
	MOVF        FARG_HTTP_getRequest_max+0, 0 
	SUBWF       HTTP_getRequest_i_L0+0, 0 
L__HTTP_getRequest59:
	BTFSC       STATUS+0, 0 
	GOTO        L_HTTP_getRequest37
	MOVFF       FARG_HTTP_getRequest_len+0, FSR0
	MOVFF       FARG_HTTP_getRequest_len+1, FSR0H
	MOVF        POSTINC0+0, 0 
	IORWF       POSTINC0+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_HTTP_getRequest37
L__HTTP_getRequest46:
;httpUtils.c,223 :: 		*buf = SPI_Ethernet_getByte() ;
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVFF       FARG_HTTP_getRequest_buf+0, FSR1
	MOVFF       FARG_HTTP_getRequest_buf+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;httpUtils.c,224 :: 		(*len)-- ;
	MOVFF       FARG_HTTP_getRequest_len+0, FSR0
	MOVFF       FARG_HTTP_getRequest_len+1, FSR0H
	MOVLW       1
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       FARG_HTTP_getRequest_len+0, FSR1
	MOVFF       FARG_HTTP_getRequest_len+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;httpUtils.c,225 :: 		if(*buf < 32) break ;
	MOVFF       FARG_HTTP_getRequest_buf+0, FSR0
	MOVFF       FARG_HTTP_getRequest_buf+1, FSR0H
	MOVLW       32
	SUBWF       POSTINC0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_HTTP_getRequest41
	GOTO        L_HTTP_getRequest37
L_HTTP_getRequest41:
;httpUtils.c,221 :: 		for(i = 0 ; (i < max) && *len ; i++, buf++)
	INFSNZ      HTTP_getRequest_i_L0+0, 1 
	INCF        HTTP_getRequest_i_L0+1, 1 
	INFSNZ      FARG_HTTP_getRequest_buf+0, 1 
	INCF        FARG_HTTP_getRequest_buf+1, 1 
;httpUtils.c,226 :: 		}
	GOTO        L_HTTP_getRequest36
L_HTTP_getRequest37:
;httpUtils.c,227 :: 		*(buf) = 0 ;
	MOVFF       FARG_HTTP_getRequest_buf+0, FSR1
	MOVFF       FARG_HTTP_getRequest_buf+1, FSR1H
	CLRF        POSTINC1+0 
;httpUtils.c,229 :: 		return(1) ;
	MOVLW       1
	MOVWF       R0 
;httpUtils.c,230 :: 		}
L_end_HTTP_getRequest:
	RETURN      0
; end of _HTTP_getRequest

_HTTP_accessDenied:

;httpUtils.c,244 :: 		unsigned int    HTTP_accessDenied(const unsigned char *zn, const unsigned char *m)
;httpUtils.c,248 :: 		len = SPI_Ethernet_putConstString(HTTP_Denied) ;
	MOVLW       _HTTP_Denied+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_HTTP_Denied+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_HTTP_Denied+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       HTTP_accessDenied_len_L0+0 
	MOVF        R1, 0 
	MOVWF       HTTP_accessDenied_len_L0+1 
;httpUtils.c,249 :: 		len += SPI_Ethernet_putConstString(zn) ;
	MOVF        FARG_HTTP_accessDenied_zn+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        FARG_HTTP_accessDenied_zn+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        FARG_HTTP_accessDenied_zn+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       HTTP_accessDenied_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      HTTP_accessDenied_len_L0+1, 1 
;httpUtils.c,250 :: 		len += SPI_Ethernet_putConstString("\"\n\n") ;
	MOVLW       ?lstr_2_httpUtils+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_2_httpUtils+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_2_httpUtils+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       HTTP_accessDenied_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      HTTP_accessDenied_len_L0+1, 1 
;httpUtils.c,251 :: 		len += SPI_Ethernet_putConstString(m) ;
	MOVF        FARG_HTTP_accessDenied_m+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        FARG_HTTP_accessDenied_m+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        FARG_HTTP_accessDenied_m+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        HTTP_accessDenied_len_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        HTTP_accessDenied_len_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       HTTP_accessDenied_len_L0+0 
	MOVF        R1, 0 
	MOVWF       HTTP_accessDenied_len_L0+1 
;httpUtils.c,253 :: 		return(len) ;
;httpUtils.c,254 :: 		}
L_end_HTTP_accessDenied:
	RETURN      0
; end of _HTTP_accessDenied

_HTTP_redirect:

;httpUtils.c,260 :: 		unsigned int    HTTP_redirect(unsigned char *url)
;httpUtils.c,264 :: 		len = SPI_Ethernet_putConstString(HTTP_Redir) ;
	MOVLW       _HTTP_Redir+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_HTTP_Redir+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_HTTP_Redir+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       HTTP_redirect_len_L0+0 
	MOVF        R1, 0 
	MOVWF       HTTP_redirect_len_L0+1 
;httpUtils.c,265 :: 		len += SPI_Ethernet_putString(url) ;
	MOVF        FARG_HTTP_redirect_url+0, 0 
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVF        FARG_HTTP_redirect_url+1, 0 
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        R0, 0 
	ADDWF       HTTP_redirect_len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      HTTP_redirect_len_L0+1, 1 
;httpUtils.c,266 :: 		len += SPI_Ethernet_putConstString("\n\n") ;
	MOVLW       ?lstr_3_httpUtils+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(?lstr_3_httpUtils+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(?lstr_3_httpUtils+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        HTTP_redirect_len_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        HTTP_redirect_len_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       HTTP_redirect_len_L0+0 
	MOVF        R1, 0 
	MOVWF       HTTP_redirect_len_L0+1 
;httpUtils.c,268 :: 		return(len) ;
;httpUtils.c,269 :: 		}
L_end_HTTP_redirect:
	RETURN      0
; end of _HTTP_redirect

_HTTP_html:

;httpUtils.c,275 :: 		unsigned int    HTTP_html(const unsigned char *html)
;httpUtils.c,279 :: 		len = SPI_Ethernet_putConstString(HTTP_HeaderHtml) ;
	MOVLW       _HTTP_HeaderHtml+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_HTTP_HeaderHtml+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_HTTP_HeaderHtml+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       HTTP_html_len_L0+0 
	MOVF        R1, 0 
	MOVWF       HTTP_html_len_L0+1 
;httpUtils.c,280 :: 		len += SPI_Ethernet_putConstString(html) ;
	MOVF        FARG_HTTP_html_html+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVF        FARG_HTTP_html_html+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVF        FARG_HTTP_html_html+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        HTTP_html_len_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        HTTP_html_len_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       HTTP_html_len_L0+0 
	MOVF        R1, 0 
	MOVWF       HTTP_html_len_L0+1 
;httpUtils.c,282 :: 		return(len) ;
;httpUtils.c,283 :: 		}
L_end_HTTP_html:
	RETURN      0
; end of _HTTP_html

_HTTP_imageGIF:

;httpUtils.c,289 :: 		unsigned int    HTTP_imageGIF(const unsigned char *img, unsigned int l)
;httpUtils.c,293 :: 		len = SPI_Ethernet_putConstString(HTTP_HeaderGif) ;
	MOVLW       _HTTP_HeaderGif+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_HTTP_HeaderGif+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_HTTP_HeaderGif+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       HTTP_imageGIF_len_L0+0 
	MOVF        R1, 0 
	MOVWF       HTTP_imageGIF_len_L0+1 
;httpUtils.c,294 :: 		SPI_Ethernet_putConstBytes(img, l) ;
	MOVF        FARG_HTTP_imageGIF_img+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstBytes_ptr+0 
	MOVF        FARG_HTTP_imageGIF_img+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstBytes_ptr+1 
	MOVF        FARG_HTTP_imageGIF_img+2, 0 
	MOVWF       FARG_SPI_Ethernet_putConstBytes_ptr+2 
	MOVF        FARG_HTTP_imageGIF_l+0, 0 
	MOVWF       FARG_SPI_Ethernet_putConstBytes_n+0 
	MOVF        FARG_HTTP_imageGIF_l+1, 0 
	MOVWF       FARG_SPI_Ethernet_putConstBytes_n+1 
	CALL        _SPI_Ethernet_putConstBytes+0, 0
;httpUtils.c,295 :: 		len += l;
	MOVF        FARG_HTTP_imageGIF_l+0, 0 
	ADDWF       HTTP_imageGIF_len_L0+0, 0 
	MOVWF       R0 
	MOVF        FARG_HTTP_imageGIF_l+1, 0 
	ADDWFC      HTTP_imageGIF_len_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       HTTP_imageGIF_len_L0+0 
	MOVF        R1, 0 
	MOVWF       HTTP_imageGIF_len_L0+1 
;httpUtils.c,297 :: 		return(len) ;
;httpUtils.c,298 :: 		}
L_end_HTTP_imageGIF:
	RETURN      0
; end of _HTTP_imageGIF

_HTTP_error:

;httpUtils.c,304 :: 		unsigned int    HTTP_error()
;httpUtils.c,308 :: 		len = SPI_Ethernet_putConstString(HTTP_NotFound) ;
	MOVLW       _HTTP_NotFound+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_HTTP_NotFound+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_HTTP_NotFound+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
;httpUtils.c,310 :: 		return(len) ;
;httpUtils.c,311 :: 		}
L_end_HTTP_error:
	RETURN      0
; end of _HTTP_error
