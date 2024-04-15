;=================================================================================================================
;	Shock guide
;	Jan, 5, 2015
;
;
readcol,'/home/arturo/Documentos/shocks_M2M/data/OMNI_HRO_1MIN_704899.txt',date, hour, B, Bx, By, Bz, V, Vx, Vy, Vz, Np, Tp, betta,format='a,a,f,f,f,f,f,f,f,f,f,f',/silent, skipline=76


hour_shock=float(23.45)
;hour_ICME_I=float(331.26)
;hour_ICME_F=float(331.77)


new_date = strarr(n_elements(date))
new_hour = strarr(n_elements(date))
doyT = fltarr(n_elements(date))
timeMF = fltarr(n_elements(date))

for i=0L, n_elements(date)-1 do begin
	new_date[i] = strmid(date[i],8,4)+strmid(date[i],3,2)+strmid(date[i],0,2);---------------->agarro yymmdd
	date2doy,new_date[i],doy
	
	doyT[i] = float(doy)

	new_hour[i] = strmid(hour[i],0,2)+':'+strmid(hour[i],3,2)+':'+strmid(hour[i],6,2);---------->agarro hh:mm:ss
	timeMF[i] = time2float(new_hour[i])
endfor
tiempo = double((doyT*24. + timeMF)/24.)

;-------------------------------------------
;index0 = WHERE(B EQ 9999.99, count)  
;IF count NE 0 THEN B[index0] = !VALUES.F_NAN
;-------------------------------------------;-------------------------------------------
;index1 = WHERE(Bx EQ 9999.99, count)  
;IF count NE 0 THEN Bx[index1] = !VALUES.F_NAN
;-------------------------------------------;-------------------------------------------
;index2 = WHERE(By EQ 9999.99, count)  
;IF count NE 0 THEN By[index2] = !VALUES.F_NAN
;-------------------------------------------;-------------------------------------------
;index3 = WHERE(Bz EQ 9999.99, count)  
;IF count NE 0 THEN Bz[index3] = !VALUES.F_NAN
;-------------------------------------------;-------------------------------------------
;index4 = WHERE(V EQ 99999.9, count)  
;IF count NE 0 THEN V[index4] = !VALUES.F_NAN
;-------------------------------------------;-------------------------------------------
index5 = WHERE(Vx EQ 9999.99, count)  
IF count NE 0 THEN Vx[index5] = !VALUES.F_NAN
;-------------------------------------------;-------------------------------------------
index6 = WHERE(Vy EQ 9999.99, count)  
IF count NE 0 THEN Vy[index6] = !VALUES.F_NAN
;-------------------------------------------;-------------------------------------------
index7 = WHERE(Vz EQ 9999.99, count)  
IF count NE 0 THEN Vz[index7] = !VALUES.F_NAN
;-------------------------------------------;-------------------------------------------
;index8 = WHERE(Tp EQ 1.00000E+07, count)  
;IF count NE 0 THEN Tp[index8] = !VALUES.F_NAN
;-------------------------------------------;-------------------------------------------
index9 = WHERE(Np EQ 999.990, count)  
IF count NE 0 THEN Np[index9] = !VALUES.F_NAN
;-------------------------------------------
index10 = WHERE(betta EQ 999.990, count)  
IF count NE 0 THEN betta[index10] = !VALUES.F_NAN
;-------------------------------------------
;

for i=0, n_elements(V)-1 do begin
	IF (V[i] EQ 99999.9 ) then begin
	V[i] = V[i-1]
	ENDIF ELSE BEGIN
	V[i] = V[i]
	ENDELSE
	
	IF (Tp[i] EQ 1.00000E+07 ) then begin
	Tp[i] = Tp[i-1]
	ENDIF ELSE BEGIN
	Tp[i] = Tp[i]
	ENDELSE
	
	IF (B[i] EQ 9999.99 ) then begin
	B[i] = B[i-1]
	ENDIF ELSE BEGIN
	B[i] = B[i]
	ENDELSE
	
	IF (Bx[i] EQ 9999.99 ) then begin
	Bx[i] = Bx[i-1]
	ENDIF ELSE BEGIN
	Bx[i] = Bx[i]
	ENDELSE
	
	IF (By[i] EQ 9999.99 ) then begin
	By[i] = By[i-1]
	ENDIF ELSE BEGIN
	By[i] = By[i]
	ENDELSE
	
	IF (Bz[i] EQ 9999.99 ) then begin
	Bz[i] = Bz[i-1]
	ENDIF ELSE BEGIN
	Bz[i] = Bz[i]
	ENDELSE
		
endfor





; ===============================================================================================
;
page_width = 15.0
page_height = 100.0 
xsize = 24.0
ysize = 30.0 
xoffset = (page_width - xsize) * 0.2
yoffset = (page_height - ysize) * 0.3

psfile='/home/arturo/Documentos/shocks_M2M/plots/shock_plot.eps'
	set_plot,'ps'



		device, /encap
		device, /color, bits=8
		device, /portrait, filename=psfile
		device, xsize=xsize, ysize=ysize 
		entry_device=!d.name 

		!P.FONT =0 
		device,/helvetica;,/bold
		loadct,12

!x.charsize=1.
!y.charsize=1.
!p.charsize=1.4
!x.thick=2
!y.thick=2

red = GETCOLOR('red', 100)
blue = GETCOLOR('blue', 60)
green = GETCOLOR('green', 20)

!p.multi=[0,1,6]
!P.POSITION=[0.10, 0.82, 0.97, 0.97]
	plot, tiempo, TS_SMOOTH(B, 40), linestyle=0, thick=5, xtickformat="(A1)", $
	title='WIND Magnetic Field & Plasma Data' , ytitle='|B| [nT]',charsize=2.0, $
	yrange=[2,14],$	
	xstyle=1,ystyle=1,xticks=7,xminor=4,yminor=2,yticks=5,YTickFormat='(I3)'
	PlotS, [hour_shock, hour_shock], !Y.CRange, linestyle=2, thick=6, color = cgColor("Dark Red")
	;PlotS, [hour_ICME_I, hour_ICME_I], !Y.CRange, linestyle=0, thick=6,  color = cgColor("Turquoise")
	;PlotS, [hour_ICME_F, hour_ICME_F], !Y.CRange, linestyle=0, thick=6,  color = cgColor("Turquoise")
;-----------------------------------------------------------------------------------------------------------------------------------------
	plot, tiempo, TS_SMOOTH(Bx, 50), linestyle=0, thick=5,xtickformat="(A1)",POS=[0.10, 0.66,  0.97, 0.81], $
	ytitle=textoidl("B_{x,y,z} [nT]"),charsize=2.0,$
	yrange=[-20,20],$
	xstyle=1,ystyle=1,xticks=7,xminor=4,yminor=4,yticks=4,YTickFormat='(I3)'
	
	;oplot, tiempo, TS_SMOOTH(Bx, 40), linestyle=0, thick=0, color=200
	oplot, tiempo, TS_SMOOTH(By, 40), linestyle=0, thick=5, color=9
	oplot, tiempo, TS_SMOOTH(Bz, 40), linestyle=0, thick=2, color=blue
	
	PlotS, [hour_shock, hour_shock], !Y.CRange, linestyle=2, thick=6, color = cgColor("Dark Red")
	oplot, [23.41,23.42], [7,7], thick=2, color=200, linestyle = 0
	PlotS, [26.3,26.4],[10,10],  linestyle=0, thick=15,color=200
;-----------------------------------------------------------------------------------------------------------------------------------------
	plot, tiempo, TS_SMOOTH(V, 10), linestyle=0, thick=5,xtickformat="(A1)",POS=[0.10, 0.50, 0.97, 0.65], $	
	ytitle='|V| [km/s]',charsize=2.0,$
	yrange=[350,600],$
	xstyle=1,ystyle=1,xticks=7,xminor=4,yminor=2,yticks=5
	PlotS, [hour_shock, hour_shock], !Y.CRange, linestyle=2, thick=6, color = cgColor("Dark Red")
;-----------------------------------------------------------------------------------------------------------------------------------------
	unit = textoidl("n[prot/cm^{3}]")
	plot, tiempo, TS_SMOOTH(Np, 50) , linestyle=0, thick=5,xtickformat="(A1)",POS=[0.10, 0.34,  0.97, 0.49], $;POS=[0.10, 0.32,  0.97, 0.47], $
	ytitle=unit, charsize=2.0, $
	;yrange=[0,20],$
	xstyle=1,ystyle=1,xticks=7,xminor=4,yminor=5,yticks=4,YTickFormat='(I3)'
	PlotS, [hour_shock, hour_shock], !Y.CRange, linestyle=2, thick=6, color = cgColor("Dark Red")
;-----------------------------------------------------------------------------------------------------------------------------------------
	plot,tiempo,TS_SMOOTH(Tp, 50), linestyle=0, thick=5,xtickformat="(A1)", POS=[0.10, 0.18, 0.97, 0.33], $;POS=[0.10, 0.16, 0.97, 0.31], $
	ytitle='T [K]', charsize=2.0,$;,/ylog, $
	yrange=[min(Tp),max(Tp)],$
	xstyle=1,ystyle=1,xticks=7,xminor=4,yminor=5,yticks=2,YTickFormat='exponent'
	PlotS, [hour_shock, hour_shock], !Y.CRange, linestyle=2, thick=6, color = cgColor("Dark Red")
;-----------------------------------------------------------------------------------------------------------------------------------------
	plot,tiempo,TS_SMOOTH(betta, 50) , linestyle=0, thick=5,POS=[0.10, 0.02,  0.97, 0.17],$;POS=[0.10, 0.16, 0.97, 0.31], $
	ytitle='betta',xtitle='DOY of 2001', charsize=2.0,$
	yrange=[0,15],$
	xstyle=1,ystyle=1,xticks=7,xminor=4,yminor=5,yticks=3
	PlotS, [hour_shock, hour_shock], !Y.CRange, linestyle=2, thick=6, color = cgColor("Dark Red")
;-----------------------------------------------------------------------------------------------------------------------------------------

!P.MULTI = 0
DEVICE, /CLOSE
	SET_PLOT, 'X'


END
