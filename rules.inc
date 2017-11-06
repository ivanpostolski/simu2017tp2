#BeginMacro(VieneGasDeArriba)
(-1,-1)!0=4 or (-1,-1)!0=5 or (-1,-1)!0=6 or (-1,-1)!0=7
#EndMacro

#BeginMacro(VieneGasDeArribaRebotandoVieja)
(0,-1)!0=4 or (0,-1)!0=5 or (0,-1)!0=6 or (0,-1)!0=7
#EndMacro

#BeginMacro(VieneGasDeArribaRebotando)
(-1,-1)!0 = 8 and ((0,-1)!0=1 or (0,-1)!0=3 or (0,-1)!0=5 or (0,-1)!0=7)
#EndMacro

#BeginMacro(VieneGasDeAbajo)
(1,-1)!0 = 1 or (1,-1)!0 = 3 or (1,-1)!0 = 5 or (1,-1)!0 = 7 
#EndMacro

#BeginMacro(VieneGasDeAbajoRebotandoVieja)
(0,-1)!0=1 or (0,-1)!0=3 or (0,-1)!0=5 or (0,-1)!0=7 
#EndMacro

#BeginMacro(VieneGasDeAbajoRebotando)
(1,-1)!0 = 16 and ((0,-1)!0=4 or (0,-1)!0=5 or (0,-1)!0=6 or (0,-1)!0=7) 
#EndMacro

#BeginMacro(VieneGasDeIzquierda)
(0,-1)!0=2 or (0,-1)!0=3 or (0,-1)!0=6 or (0,-1)!0=7
#EndMacro

#BeginMacro(NoSoyBorde)
(0,0)!0 !=8 and (0,0)!0 !=16
#EndMacro

#BeginMacro(AdelanteSincronizado)
((-1,0)!0 != 8 and (1,0)!0 != 16 and (-1,0)!1 = (0,1)!1 and (0,1)!1 = (1,0)!1) or ((1,0)!0 = 16 and (-1,0)!1 = (0,1)!1) or ((-1,0)!0 = 8 and (0,1)!1 = (1,0)!1)
#EndMacro

#BeginMacro(AdelanteSincronizadoMasUno)
(0,0)!1 = ((0,1)!1 - 1) AND ((-1,0)!0 != 8 and (1,0)!0 != 16 and (-1,0)!1 = (0,1)!1 and (0,1)!1 = (1,0)!1) or ((1,0)!0 = 16 and (-1,0)!1 = (0,1)!1) or ((-1,0)!0 = 8 and (0,1)!1 = (1,0)!1)
#EndMacro

#BeginMacro(AtrasSincronizadoViejo)
((1,-1)!1 !=-1 and (-1,-1)!1 != -1 and (0,-1)!1 != -1)
 and ((-1,-1)!1=(0,-1)!1 and (0,-1)!1=(1,-1)!1)
  or ((-1,-1)!1=(0,-1)!1 and (1,-1)!1 = -1) 
  or ((0,-1)!1=(1,-1)!1 and (-1,-1)!1 = -1) 
  or ((1,-1)!1=(-1,-1)!1 and (0,-1)!1 = -1)
  or ((-1,-1)!1=-1 and (0,-1)!1 = -1)
  or ((1,-1)!1=-1 and (0,-1)!1 = -1)
  or ((1,-1)!1=-1 and (-1,-1)!1 = -1) 
  or ((1,-1)!0 = 16 and (-1,-1)!1=(0,-1)!1) 
  or ((-1,-1)!0 = 8 and (0,-1)!1=(1,-1)!1)
#EndMacro

#BeginMacro(AtrasSincronizado)
 ((-1,-1)!1=(0,-1)!1 and (0,-1)!1=(1,-1)!1) or (((-1,-1)!1=(0,-1)!1 and (0,-1)!1 != -1 and (1,-1)!1 = -1) or ((0,-1)!1=(1,-1)!1 and (1,-1)!1 != -1 and (-1,-1)!1 = -1) or ((1,-1)!1=(-1,-1)!1 and (-1,-1)!1 != -1 and (0,-1)!1 = -1)) or (((-1,-1)!1=-1 and (0,-1)!1 = -1 and (1,-1)!1 != -1) or ((1,-1)!1=-1 and (0,-1)!1 = -1 and (-1,-1)!1 != -1) or ((1,-1)!1=-1 and (-1,-1)!1 =-1 and (0,-1)!1 != -1)) 
#EndMacro