;+
; NAME:
;	TIME2FLOAT
;
; PURPOSE:
;	To convert time formats in hours in decimal repres.
;
; CATEGORY:
;	PICO
;
; CALLING SEQUENCE:
;	result=TIME2FLOAT(stime)
;
; INPUTS:
;	stime:  a string containing the time
;
; OPTIONAL INPUTS:
;	None
;
; KEYWORD PARAMETERS:
;	None
;
; OUTPUTS:
;	result: A floating point number containing the
;               decimal hour
;
; OPTIONAL OUTPUTS:
;	None
;
; EXAMPLE:
;	PRINT,TIME2FLOAT('20:00:56')
;
;	prints 20.0156
;
; COMMON BLOCKS:
;	None
;
; SIDE EFFECTS:
;	Unknown
;
; RESTRICTIONS:
;	Only formats of PICOHEADER and IDL SYSTIME are accepted.
;
; PROCEDURE:
;
;
; MODIFICATION HISTORY:
;	V1.0 Alexander Epple, MPAe Lindau, 04-JUL-1996
;   V1.1 Guillermo Stenborg, MPAe Lindau, JUL=1998
;          Modified to ignore characters in front of time
;               having in mind that there must not be ":"
;               except for that on time.
;          Modified to allow accepting h or h:m or h:m:s
;-


FUNCTION time2float,kstime, HOUR=hour, MINUTE=minute, SECOND=second
stime=kstime


;h=FLOAT(STRMID(stime,0,STRPOS(stime,':')))

xx = STRPOS(stime,':')
h=FLOAT(STRMID(stime,xx-2,2))  ;GS
stime=STRMID(stime,xx+1,STRLEN(stime))
;print, 'hora:',h
if (xx eq -1) then begin
    result = h
    goto, ende
endif

xx = STRPOS(stime,':')
m=FLOAT(STRMID(stime,0,2))
stime=STRMID(stime,xx+1,STRLEN(stime))
;print, 'minuto:',m
if (xx eq -1) then begin
    result = h+m/60.
    goto, ende
endif

s=FLOAT(stime)

result=h+m/60.+s/3600.
IF KEYWORD_SET(minute) THEN result=60.*result
IF KEYWORD_SET(second) THEN result=3600.*result

if result ge 24.0 and result lt 48 then result=result-24
if result ge 48.0 then result=result-48

ende:
RETURN,result
END



