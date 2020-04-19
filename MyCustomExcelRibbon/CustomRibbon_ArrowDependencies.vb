Sub MostrarPrecedentesRango()
' Según el rango de selección muestra todas las celdas precedentes.

Dim cell As Object

For Each cell In Selection
    cell.ShowPrecedents
Next cell

End Sub
Sub MostrarDependientesRango()
' Según el rango de selección muestra todas las celdas dependientes.

Dim cell As Object

For Each cell In Selection
    cell.ShowDependents
Next cell

End Sub
Sub OcultarPrecedentesRango()
' Según el rango de selección oculta todas las celdas precedentes.

Dim cell As Object

For Each cell In Selection
    cell.ShowPrecedents Remove:=True
Next cell

End Sub
Sub OcultarDependientesRango()
' Según el rango de selección oculta todas las celdas dependientes.

Dim cell As Object

For Each cell In Selection
    cell.ShowDependents Remove:=True
Next cell

End Sub
Sub SelectPrecedentesRango()
' Según el rango de selección selecciona todas las celdas precedentes.

Dim cell As Object
Dim PreceRange As Range
Dim IsExecuted As Boolean

IsExecuted = False
For Each cell In Selection
    If HasPrecedents(cell) Then
        If Not IsExecuted Then
            Set PreceRange = cell.Precedents
            IsExecuted = True
        Else:
            Set PreceRange = Union(PreceRange, cell.Precedents)
        End If
    End If
Next cell

' conditional required for error.
If Not PreceRange Is Nothing Then
    PreceRange.Select
End If

End Sub
Sub SelectDependientesRango()
' Según el rango de selección selecciona todas las celdas dependientes.

Dim cell As Object
Dim DependeRange As Range
Dim IsExecuted As Boolean

IsExecuted = False
For Each cell In Selection
    If HasDependents(cell) Then
        If Not IsExecuted Then
            Set DependeRange = cell.Dependents
            IsExecuted = True
        Else:
            Set DependeRange = Union(DependeRange, cell.Dependents)
        End If
    End If
Next cell

' conditional required for error.
If Not DependeRange Is Nothing Then
    DependeRange.Select
End If

End Sub
Sub OcultaFlechasPreceYDepende()

OcultarPrecedentesRango
OcultarDependientesRango

End Sub

Public Function HasDependents(ByVal target As Excel.Range) As Boolean
' Checks wether target range has dependent cells

On Error Resume Next
HasDependents = target.Dependents.Count

End Function
Public Function HasPrecedents(ByVal target As Excel.Range) As Boolean
' Checks wether target range has precedent cells

On Error Resume Next
HasPrecedents = target.Precedents.Count

End Function

