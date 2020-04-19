Option Explicit
Public Sub MostrarRangoPrecedentes_CallBack(ByRef control As IRibbonControl)
    MostrarPrecedentesRango
End Sub
Public Sub OcultarRangoPrecedentes_CallBack(ByRef control As IRibbonControl)
    OcultarPrecedentesRango
End Sub
Public Sub SelectRangoPrecedentes_CallBack(ByRef control As IRibbonControl)
    SelectPrecedentesRango
End Sub
Public Sub MostrarRangoDependientes_CallBack(ByRef control As IRibbonControl)
    MostrarDependientesRango
End Sub
Public Sub OcultarRangoDependientes_CallBack(ByRef control As IRibbonControl)
    OcultarDependientesRango
End Sub
Public Sub SelectRangoDependientes_CallBack(ByRef control As IRibbonControl)
    SelectDependientesRango
End Sub
Public Sub OcultarFlechas_CallBack(ByRef control As IRibbonControl)
    OcultaFlechasPreceYDepende
End Sub

