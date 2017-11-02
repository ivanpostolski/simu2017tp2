#include(rules.inc)

[Top]
components: celdas

[celdas]
type : cell
dim : (10,10)
delay : transport
defaultDelayTime: 0 
border : nowrapped
neighbors : celdas(-1,-1) celdas(-1,0)
neighbors : celdas(0,-1) celdas(0,0) celdas(0,1)
neighbors : celdas(1,-1) celdas(1,0)
initialValue : [0,-1]
initialCellsValue : celdas.val
localTransition : Reglas

[Reglas]
rule : {(0,0)} 0 {(0,0)!0 = 8 or (0,0)!0 = 16}

rule : {[0,(0,0)!1+1]} 1 {#macro(NoSoyBorde) and not #macro(VieneGasDeAbajo) and not #macro(VieneGasDeArriba) and not #macro(VieneGasDeIzquierda) and #macro(AdelanteSincronizadoMasUno) and #macro(AtrasSincronizado)}

rule : {[1,(0,0)!1+1]} 1 {#macro(NoSoyBorde) and #macro(VieneGasDeAbajo) and not #macro(VieneGasDeIzquierda) and not #macro(VieneGasDeArriba) and (#macro(AtrasSincronizado) and (0,0)!1 = (-1)) or (#macro(AtrasSincronizado) and #macro(AdelanteSincronizadoMasUno))}

rule : {[2,(0,0)!1+1]} 1 {#macro(NoSoyBorde) and not #macro(VieneGasDeAbajo) and #macro(VieneGasDeIzquierda) and not #macro(VieneGasDeArriba) and (#macro(AtrasSincronizado) and (0,0)!1=-1) or (#macro(AtrasSincronizado) and #macro(AdelanteSincronizadoMasUno))}

rule : {[3,(0,0)!1+1]} 1 {#macro(NoSoyBorde) and #macro(VieneGasDeAbajo) and #macro(VieneGasDeIzquierda) and not #macro(VieneGasDeArriba) and ( #macro(AtrasSincronizado) and (0,0)!1=-1) or (#macro(AtrasSincronizado) and #macro(AdelanteSincronizadoMasUno))}

rule : {[4,(0,0)!1+1]} 1 {#macro(NoSoyBorde) and not #macro(VieneGasDeAbajo) and not #macro(VieneGasDeIzquierda) and #macro(VieneGasDeArriba) and ( #macro(AtrasSincronizado) and (0,0)!1=-1) or (#macro(AtrasSincronizado) and #macro(AdelanteSincronizadoMasUno))}

rule : {[5,(0,0)!1+1]} 1 {#macro(NoSoyBorde) and #macro(VieneGasDeAbajo) and not #macro(VieneGasDeIzquierda) and #macro(VieneGasDeArriba) and ( #macro(AtrasSincronizado) and (0,0)!1=-1) or (#macro(AtrasSincronizado) and #macro(AdelanteSincronizadoMasUno))}

rule : {[6,(0,0)!1+1]} 1 {#macro(NoSoyBorde) and not #macro(VieneGasDeAbajo) and #macro(VieneGasDeIzquierda) and #macro(VieneGasDeArriba) and ( #macro(AtrasSincronizado) and (0,0)!1=-1) or (#macro(AtrasSincronizado) and #macro(AdelanteSincronizadoMasUno))}

rule : {[7,(0,0)!1+1]} 1 {#macro(NoSoyBorde) and #macro(VieneGasDeAbajo) and #macro(VieneGasDeIzquierda) and #macro(VieneGasDeArriba) and ( #macro(AtrasSincronizado) and (0,0)!1=-1) or (#macro(AtrasSincronizado) and #macro(AdelanteSincronizadoMasUno))}

rule : {[4,(0,0)!1+1]} 1 {#macro(NoSoyBorde) and (-1,-1)!0= 8 and #macro(VieneGasDeArribaRebotando) and not #macro(VieneGasDeAbajo) and ( #macro(AtrasSincronizado) and (0,0)!1=-1) or (#macro(AtrasSincronizado) and #macro(AdelanteSincronizadoMasUno))}

rule : {[5,(0,0)!1+1]} 1 {#macro(NoSoyBorde) and (-1,-1)!0=8 and #macro(VieneGasDeArribaRebotando) and #macro(VieneGasDeAbajo) and ( #macro(AtrasSincronizado) and (0,0)!1=-1) or (#macro(AtrasSincronizado) and #macro(AdelanteSincronizadoMasUno))}

rule : {[1,(0,0)!1+1]} 1 {#macro(NoSoyBorde) and (1,-1)!0=16 and #macro(VieneGasDeAbajoRebotando) and not #macro(VieneGasDeArriba) and ( #macro(AtrasSincronizado) and (0,0)!1=-1) or (#macro(AtrasSincronizado) and #macro(AdelanteSincronizadoMasUno))}

rule : {[5,(0,0)!1+1]} 1 {#macro(NoSoyBorde) and (1,-1)!0=16 and #macro(VieneGasDeAbajoRebotando) and #macro(VieneGasDeArriba) and ( #macro(AtrasSincronizado) and (0,0)!1=-1) or (#macro(AtrasSincronizado) and #macro(AdelanteSincronizadoMasUno))}

rule : {(0,0)} 0 {t}
