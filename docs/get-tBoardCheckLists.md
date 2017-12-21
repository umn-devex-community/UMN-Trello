---
external help file: umn-trello-help.xml
Module Name: umn-trello
online version: 
schema: 2.0.0
---

# Get-TBoardCheckLists

## SYNOPSIS
Return list of checkLists on a board

## SYNTAX

```
Get-TBoardCheckLists [-appKey] <String> [-token] <String> [-boardID] <String> [<CommonParameters>]
```

## DESCRIPTION
Usefull to get a list of all checkList data on a board

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$return = Get-TCardCheckLists -appKey 'cb6c8d2993cf5f4432de1224c67' -token $token -boardID $boardID
```

## PARAMETERS

### -appKey
Application key from trello.
Retrieved from trello.com/app-key

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -token
User authentication token.
Retrieved from trello.com/app-key, or call Get-TAuthToken

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -boardID
board ID of a board.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Kyle Weeks

## RELATED LINKS

