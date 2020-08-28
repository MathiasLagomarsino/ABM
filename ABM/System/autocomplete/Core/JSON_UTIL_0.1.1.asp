<%
Function QueryToJSON(sql)
    Dim rs, jsa
    Set rs = getADORecordSet(sql)
    Set jsa = jsArray()
    
    While Not (rs.EOF Or rs.BOF)
        Set jsa(Null) = jsObject()

        For Each col In rs.Fields
            jsa(Null)(col.Name) = col.Value
        Next

        rs.MoveNext
    Wend
    
    rs.Close()
    Set rs = Nothing
    
    Set QueryToJSON = jsa
End Function

Function ResultToJSON(rs)
    Dim jsa
    Set jsa = jsArray()
    
    While Not (rs.EOF Or rs.BOF)
        Set jsa(Null) = jsObject()

        For Each col In rs.Fields
            jsa(Null)(col.Name) = col.Value
        Next

        rs.MoveNext
    Wend

    rs.Close()
    Set rs = Nothing
    
    Set ResultToJSON = jsa
End Function

Function QueryToText(sql)
    Dim rs, jsa
    Set rs = getADORecordSet(sql)
    jsa = ""
    
    While Not (rs.EOF Or rs.BOF)
        For Each col In rs.Fields
            jsa = jsa & Server.HTMLEncode(ReplaceHTMLChars(col.Value)) & chr(10)
        Next

        rs.MoveNext
    Wend
    
    rs.Close()
    Set rs = Nothing
    
    QueryToText = jsa
End Function

Function QueryToHTMLText(sql)
    Dim rs, jsa
    Set rs = getADORecordSet(sql)
    jsa = ""
    
    While Not (rs.EOF Or rs.BOF)
        For Each col In rs.Fields
            jsa = jsa & Trim(col.Value) & chr(10)
        Next

        rs.MoveNext
    Wend
    
    rs.Close()
    Set rs = Nothing
    
    QueryToHTMLText = jsa
End Function

Function RecordSetToText(rs)
    Dim jsa
    jsa = ""
    
    While Not (rs.EOF Or rs.BOF)
        For Each col In rs.Fields
            jsa = jsa & col.Value & chr(10)
        Next

        rs.MoveNext
    Wend
    
    rs.Close()
    Set rs = Nothing
    
    RecordSetToText = jsa
End Function



Function RecordSetToJSON(rs)
    Dim jsa
    Set jsa = jsArray()
    
    Set jsa(Null) = jsObject()

    For Each col In rs.Fields
        'col.Value = Replace(col.Value,chr(34),"\\"&chr(34))
        value = Trim(col.Value)
        If ReplaceNullValues(value) <> "0" Then
            value = Replace(value,chr(34),"\"&chr(34))
            value = Replace(value,chr(9),"")
        Else
            value = Trim(col.Value)
        End If

        jsa(Null)(col.Name) = value

    Next

    
    'rs.Close()
    'Set rs = Nothing
    
    Set RecordSetToJSON = jsa
End Function

'RME: 2015.05.27: Creo esta función que devuelve todos los registros del JSON, no como RecordSetToJSON que sólo devolvía el primer registro.
Function AllRecordSetToJSON(rs)
    Dim jsa
    Set jsa = jsArray()

    While Not rs.EOF
        Set jsa(Null) = jsObject()
    For Each col In rs.Fields

        'col.Value = Replace(col.Value,chr(34),"\\"&chr(34))
        value = Trim(col.Value)
        If ReplaceNullValues(value) <> "0" Then
            value = Replace(value,chr(34),"\"&chr(34))
            value = Replace(value,chr(9),"")
        Else
            value = Trim(col.Value)
        End If

        jsa(Null)(col.Name) = ReplaceNullValues(value)

    Next

    rs.MoveNext()
    Wend
    
    'rs.Close()
    'Set rs = Nothing
    
    Set AllRecordSetToJSON = jsa
End Function

'ML 13/07/2016 :: Armo la función para convertir los datos de un array a JSON
Function ArrayToJSON(dataArray1, colName1, dataArray2, colName2)
    
    Dim jsa
    Set jsa = jsArray()

    colName1 = Trim(colName1)
    colName2 = Trim(colName2)

    Set jsa(Null) = jsArray()

    dataArray1Qty = CInt(UBound(dataArray1))
    
    If IsNull(dataArray2) Then
        dataArray2Qty = -1
    Else
        dataArray2Qty = CInt(UBound(dataArray2))
    End If

    If dataArray2Qty >= 0 AND dataArray2Qty = dataArray1Qty Then

        For i = 0 To dataArray1Qty
            value1 = Trim(ReplaceNullValues(dataArray1(i)))
            value2 = Trim(ReplaceNullValues(dataArray2(i)))

            If ReplaceNullValues(value1) <> "0" Then
                value1 = Replace(value1,chr(34),"\"&chr(34))
                value1 = Replace(value1,chr(9),"")
            Else
                value1 = Trim(value1)
            End If

            If ReplaceNullValues(value2) <> "0" Then
                value2 = Replace(value2,chr(34),"\"&chr(34))
                value2 = Replace(value2,chr(9),"")
            Else
                value2 = Trim(value2)
            End If

            Set jsa(Null)(Null) = jsObject()
            jsa(Null)(Null)(colName1) = value1
            jsa(Null)(Null)(colName2) = value2
        Next

    Else
        For Each col In dataArray1
            value = Trim(col)
            If ReplaceNullValues(value) <> "0" Then
                value = Replace(value,chr(34),"\"&chr(34))
                value = Replace(value,chr(9),"")
            Else
                value = Trim(Value)
            End If

            value = Trim(col)
            If ReplaceNullValues(value) <> "0" Then
                value = Replace(value,chr(34),"\"&chr(34))
                value = Replace(value,chr(9),"")
            Else
                value = Trim(Value)
            End If

            Set jsa(Null)(Null) = jsObject()
            jsa(Null)(Null)(colName1) = value
        Next
    End If

    Set ArrayToJSON = jsa

End Function

%>